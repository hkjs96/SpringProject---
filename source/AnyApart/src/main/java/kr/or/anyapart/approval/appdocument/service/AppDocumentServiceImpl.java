/**
 * @author 이미정
 * @since 2021. 2. 25.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 25.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.approval.appdocument.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.poi.ss.formula.functions.Now;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.approval.appdocument.dao.AppDocumentDAO;
import kr.or.anyapart.approval.draftatt.dao.DraftAttDAO;
import kr.or.anyapart.approval.draftatt.service.DraftAttService;
import kr.or.anyapart.approval.vo.ApprovalLineVO;
import kr.or.anyapart.approval.vo.ApprovalVO;
import kr.or.anyapart.approval.vo.DraftAttVO;
import kr.or.anyapart.approval.vo.DraftVO;
import kr.or.anyapart.approval.vo.LineDetailVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class AppDocumentServiceImpl implements AppDocumentService{

	@Inject
	private AppDocumentDAO appDAO;
	
	@Inject
	private DraftAttService attService;
	
	@Inject
	private DraftAttDAO attDAO;
	
	@Override
	public int retrieveSendingCount(PagingVO<DraftVO> pagingVO) {
		return appDAO.selectSendingCount(pagingVO);
	}

	@Override
	public List<DraftVO> retrieveSendingList(PagingVO<DraftVO> pagingVO) {
		return appDAO.selectSendingList(pagingVO);
	}

	@Override
	public DraftVO retrieveDraftInfo(DraftVO param) {
		DraftVO draft = appDAO.selectDraftInfo(param);
		if(draft==null) throw new CustomException(param.getDraftId()+"번 글이 없음.");
		return draft;
	}

	@Override
	public int retrieveReceptionCount(PagingVO<DraftVO> pagingVO) {
		return appDAO.selectReceptionCount(pagingVO);
	}

	@Override
	public List<DraftVO> retrieveReceptionList(PagingVO<DraftVO> pagingVO) {
		return appDAO.selectReceptionList(pagingVO);
	}

	@Override
	public int retrieveWholeAppCount(PagingVO<DraftVO> pagingVO) {
		return appDAO.selectWholeAppCount(pagingVO);
	}

	@Override
	public List<DraftVO> retrieveWholeAppList(PagingVO<DraftVO> pagingVO) {
		return appDAO.selectWholeAppList(pagingVO);
	}

	@Override
	public int retrieveAppLineId(DraftVO param) {
		return appDAO.selectAppLineId(param);
	}

	@Override
	public List<LineDetailVO> retrieveLineDatailList(int appLineId) {
		return appDAO.selectLineDatailList(appLineId);
	}

	@Override
	@Transactional
	public ServiceResult approvalSuccess(DraftVO draftVO) {
		DraftVO draft = appDAO.selectDraftInfo(draftVO);
		if(draft==null) throw new CustomException(draftVO.getDraftId()+"번 기안문에 해당하는 내역이 없습니다.");
		
		ServiceResult result = ServiceResult.FAILED;
		//현재 결재선상세번호
		int nowApplideid = draft.getApproval().getApplinedeId();
		
		// 결재선상세리스트 가져오기
		List<LineDetailVO> ldList = appDAO.selectldListForSuccess(nowApplideid);
		
		LineDetailVO nextldVO = null;
		int index = 0;
		int cnt = 0;
		
		//마지막 리스트의 결재선상세번호와 현재결재선 상세번호가 같으면 최종결재
		LineDetailVO lastldVO = ldList.get(ldList.size() - 1);
		if(lastldVO.getApplinedeId()==nowApplideid){
			
			cnt = appDAO.updateToFinalSuccess(lastldVO);
				
		//다르면 다음 결재자에게 결재권이 넘어감
		}else {
			for(int i=0; i<ldList.size(); i++) {
				if(ldList.get(i).getApplinedeId()==nowApplideid) {
					index = i;
					break;
				}
			}
			
			nextldVO = ldList.get(index+1);
			nextldVO.setApplinedeId(nowApplideid);
			
			cnt = appDAO.updateToNextSuccess(nextldVO);
		}
		
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	@Transactional
	public ServiceResult approvalReject(DraftVO draft) {
		DraftVO draftVO = appDAO.selectDraftInfo(draft);
		if(draftVO==null) throw new CustomException(draft.getDraftId()+"번 기안문에 해당하는 내역이 없습니다.");
		
		//현재 결재선상세번호
		int nowApplideid = draftVO.getApproval().getApplinedeId();
				
		// 결재선상세리스트 가져오기
		List<LineDetailVO> ldList = appDAO.selectldListForSuccess(nowApplideid);
		
		ApprovalVO updateVO = new ApprovalVO();
		updateVO.setDraftId(draftVO.getDraftId());
		updateVO.setApplinedeId(ldList.get(0).getApplinedeId());
		
		ServiceResult result = ServiceResult.FAILED;
		
		int cnt = appDAO.approvalReject(updateVO);
		
		if(cnt>0) result = ServiceResult.OK;
			
		return result;
	}

	@Override
	@Transactional
	public ServiceResult modifyDraft(DraftVO draft, LineDetailVO ldVO) {
		DraftVO savedDraft = appDAO.selectDraftInfo(draft);
		if (savedDraft == null)
			throw new RuntimeException(draft.getDraftId() + "번 기안문이 없음.");
		////////////////////////////////////////////////////////////////
		
		//1. 기안문 테이블 수정
		ServiceResult result = ServiceResult.FAILED;
		int cnt = appDAO.updateDraft(draft);
		
		//3. 기안문 첨부파일 테이블 수정
		//int rowcnt = insertAttaches(draftVO); 
		//draft.getDelAttNos();
		if(cnt > 0) {
			attService.processAttaches(draft);
			attService.processDeleteAttatch(draft);
			result = ServiceResult.OK;
		}
		else {
			result = ServiceResult.FAILED;
		}
		
		//입력된 LineDetailVO들 list로 만들기
		List<LineDetailVO> newldList = new ArrayList<>();
		String[] appCodeArr = (ldVO.getAppCode()).split(",");
		String[] lineMemIdArr = (ldVO.getLineMemId()).split(",");
		for(int i = 0; i<appCodeArr.length; i++) {
			LineDetailVO ld = new LineDetailVO();
			ld.setAppCode(appCodeArr[i]);
			ld.setLineMemId(lineMemIdArr[i]);
			newldList.add(i, ld);
		}
		
		//4. 결재 테이블 수정
		//현재 appLineId가져오기
		int appLineId = appDAO.selectAppLineId(draft);
		List<LineDetailVO> beforeldList = appDAO.selectLineDatailList(appLineId);
		int firstApplinedeId = beforeldList.get(0).getApplinedeId();
		String firstAppEmp = newldList.get(0).getLineMemId();
		
		ApprovalVO appVO = new ApprovalVO();
		appVO.setApplinedeId(firstApplinedeId);
		appVO.setAppNowemp(firstAppEmp);
		appVO.setDraftId(draft.getDraftId());
		cnt = appDAO.updateApproval(appVO);
		
		//5. 결재상세선테이블 수정
		
		//1)새로운 결재선 인원수가 이전 결재선 인원수와 같을 경우
		if(beforeldList.size()==newldList.size()) {
			for(int i=0; i<newldList.size();i++) {
				//이전 결재선상세번호를 가져옴
				int beforeApplinedeId = beforeldList.get(i).getApplinedeId();
				//applinedeld 추가해 줌 
				newldList.get(i).setApplinedeId(beforeApplinedeId);
				//LineDetailVO로 가져가서 applinedeId를 조건으로 appCode, lineMemId update
				appDAO.updateLineDetail(newldList.get(i));
			}
		
		//2)새로운 결재선 인원수가 이전 결재선 인원수보다 적은 경우
		}else if(beforeldList.size()>newldList.size()) {
			//삭제해야 할 결재선 수 
			int deleteSize = beforeldList.size()-newldList.size();
			//beforeldList의 끝에서, deleteSize만큼 지우기
			for(int i = 0; i<deleteSize; i++) {
				appDAO.deleteLineDetail(beforeldList.get(beforeldList.size()-(deleteSize-i)));
			}
			
			//applinedeld 추가해 줌
			for(int i=0; i<newldList.size();i++) {
				int beforeApplinedeId = beforeldList.get(i).getApplinedeId();
				//applinedeld추가
				newldList.get(i).setApplinedeId(beforeApplinedeId);
			}
			
			//나머지는 update하기
			//LineDetailVO로 applinedeId를 조건으로 appCode, lineMemId update
			for(int i = 0; i < newldList.size() ; i++) {
				appDAO.updateLineDetail(newldList.get(i));
			}
		
		//3) 새로운 결재선 인원수가 이전 결재선 인원수보다 많은 경우
		}else if(beforeldList.size()<newldList.size()) {
			int addSize = newldList.size()-beforeldList.size();
			
			//applinedeld 추가해 줌
			for(int i=0; i<beforeldList.size();i++) {
				int beforeApplinedeId = beforeldList.get(i).getApplinedeId();
				//applinedeld추가
				newldList.get(i).setApplinedeId(beforeApplinedeId);
			}
			
			//update하기
			for(int i=0; i<beforeldList.size(); i++) {
				appDAO.updateLineDetail(newldList.get(i));
			}
			
			int newOrder = beforeldList.size()+1;
			int lastApplinedeId = appDAO.selectMaxLinedeld();
			
			//추가된 결재선 인원수는 add
			for(int i=0; i<addSize ; i++) {
				newldList.get(newldList.size()-(addSize-i)).setApplinedeId(lastApplinedeId);
				newldList.get(newldList.size()-(addSize-i)).setAppOrder(newOrder);
				newldList.get(newldList.size()-(addSize-i)).setApplineId(appLineId);
				appDAO.addLineDetail(newldList.get(newldList.size()-(addSize-i)));
				newOrder++;
				lastApplinedeId++;
			}
		}
		////////////////////////////////////////////////////////////////

		if(cnt > 0) {
//			attService.processAttaches(boardVO);
//			attService.processDeleteAttatch(boardVO);
			result = ServiceResult.OK;
		}
		else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}

	@Override
	public ServiceResult draftCancel(DraftVO draft) {
		DraftVO draftVO = appDAO.selectDraftInfo(draft);
		if(draftVO==null) throw new CustomException(draft.getDraftId()+"번 기안문에 해당하는 내역이 없습니다.");
		
		ApprovalVO updateVO = new ApprovalVO();

		updateVO.setDraftId(draftVO.getDraftId());
		
		ServiceResult result = ServiceResult.FAILED;
		
		int cnt = appDAO.draftCancel(updateVO);
		
		if(cnt>0) result = ServiceResult.OK;
			
		return result;
		
	}

	@Override
	public ServiceResult draftDelete(DraftVO draftVO) {
		DraftVO savedDraft = appDAO.selectDraftInfo(draftVO);
		if(savedDraft==null) throw new CustomException(draftVO.getDraftId()+"번 기안문에 해당하는 내역이 없습니다.");
		ServiceResult result = ServiceResult.FAILED;
		
		// 비밀번호 암호화 후 인증
		// 첨부파일 메타 삭제
		List<DraftAttVO> attatchList = savedDraft.getDraftAttList();
		String[] saveNames = null;
		int cnt = 0;
		if (attatchList != null && attatchList.size() > 0) {
			saveNames = new String[attatchList.size()];
			for (int i = 0; i < saveNames.length; i++) {
				saveNames[i] = attatchList.get(i).getAttSavename();
			}
			cnt = attDAO.deleteAttatches(draftVO);
		}
		
		cnt += appDAO.draftDelete(draftVO);
		
		if (cnt > 0) {
			result = ServiceResult.OK;
		}else { 
			throw new CustomException("잘못된 접근입니다.");
		}
		return result;
	}

	@Override
	public List<DraftVO> retrieveReceptionWaitList(ApprovalVO appVO) {
		return appDAO.selectReceptionWaitList(appVO);
	}

	@Override
	public ServiceResult modifyReceptionWaitList(LineDetailVO ldVO) {
		
		ServiceResult result = ServiceResult.FAILED;
		
		int cnt = appDAO.updateReceptionWaitList(ldVO);
		
		if(cnt>0) result = ServiceResult.OK;
			
		return result;
		
	}
	
	

}
