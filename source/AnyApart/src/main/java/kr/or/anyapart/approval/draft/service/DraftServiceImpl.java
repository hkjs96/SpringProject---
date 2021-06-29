/**
 * @author 이미정
 * @since 2021. 2. 24.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 24.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.approval.draft.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.approval.draft.dao.DraftDAO;
import kr.or.anyapart.approval.draftatt.service.DraftAttService;
import kr.or.anyapart.approval.vo.ApprovalLineVO;
import kr.or.anyapart.approval.vo.ApprovalVO;
import kr.or.anyapart.approval.vo.DraftAttVO;
import kr.or.anyapart.approval.vo.DraftVO;
import kr.or.anyapart.approval.vo.LineDetailVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.vo.EmployeeVO;

@Service
public class DraftServiceImpl implements DraftService{

	@Inject
	private DraftDAO draDAO;
	
	@Inject
	private DraftAttService attService;
	
	@Override
	public DraftVO retrieveDraftBasicInfo(EmployeeVO employee) {
		return draDAO.selectDraftBasicInfo(employee);
	}

	@Override
	public List<EmployeeVO> retrieveAppEmpList(EmployeeVO employee) {
		return draDAO.selectAppEmpList(employee);
	}

	@Override
	@Transactional
	public ServiceResult createDraft(DraftVO draftVO, LineDetailVO ldVO) {
		List<LineDetailVO> ldList = new ArrayList<>();
		String[] appCodeArr = (ldVO.getAppCode()).split(",");
		String[] lineMemIdArr = (ldVO.getLineMemId()).split(",");
		for(int i = 0; i<appCodeArr.length; i++) {
			LineDetailVO ld = new LineDetailVO();
			ld.setAppCode(appCodeArr[i]);
			ld.setLineMemId(lineMemIdArr[i]);
			ldList.add(i, ld);
		}
		
		//1. 결재선 테이블
		int cnt1 = draDAO.insertAppovalLine(draftVO); //memId
		
		//2. 기안문 테이블
		//방금 넣은 결재선번호 가져오기 
		int applineId = draDAO.selectLastAppLineId(); //max값
		
		draftVO.setApplineId(applineId);
		int cnt2 = draDAO.insertDraft(draftVO);
		
		//3. 기안문 첨부파일 테이블
		if(cnt2>0) {
			cnt2+=attService.processAttaches(draftVO);
		}
		//int rowcnt = insertAttaches(draftVO); 
		
		//4. 결재선상세 테이블
		//앞에서 생성된 applineId 여기에 넣기 !
		ApprovalLineVO alVO = new ApprovalLineVO();
		alVO.setApplineId(applineId);
		alVO.setLineDetailList(ldList);
		int cnt3 = draDAO.insertLineDetail(alVO);
		
		//5. 결재 테이블 
		//결재--앞에서 생성된 draftId, appIinedeld 여기에 넣기 !(appIinedeId: List appLineId중 여기서 제일 작은 번호)
		LineDetailVO minLdVO = draDAO.selectMinLineDeId(draftVO);//#{applineId}
		ApprovalVO appVO = new ApprovalVO();
		appVO.setApplinedeId(minLdVO.getApplinedeId());
		appVO.setAppNowemp(minLdVO.getMemId());
		appVO.setDraftId(draftVO.getDraftId());
		int cnt4 = draDAO.insertApproval(appVO);
		
		ServiceResult result = ServiceResult.OK;
		
		return result;
	}



}
