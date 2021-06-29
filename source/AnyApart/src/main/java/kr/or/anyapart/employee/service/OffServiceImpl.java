/**
 * @author 이미정
 * @since 2021. 2. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 10.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.employee.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.dao.OffDAO;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class OffServiceImpl implements OffService{

	@Inject
	private OffDAO offDAO;
	
	@Override
	public List<OffVO> retrieveOffList(PagingVO<OffVO> pagingVO) {
		return offDAO.selectOffList(pagingVO);
	}

	@Override
	public int retrieveOffCount(PagingVO<OffVO> pagingVO) {
		return offDAO.selectOffCount(pagingVO);
	}

	@Transactional
	@Override
	public ServiceResult createOff(OffVO offVO) {
		int insertCnt = offDAO.insertOff(offVO);
		
		int updateCnt = 0;
		
		ServiceResult result= ServiceResult.FAILED;
		
		if(insertCnt>0) {
			if(offVO.getOffCode()!="UNPAYOFF") {
				updateCnt = offDAO.updateEmpOff(offVO);
				if(updateCnt>0) {
					result = ServiceResult.OK;
				}
			}else {
				result = ServiceResult.OK;
			}
		}
		return result;
	}


	@Override
	public OffVO retrieveOff(OffVO offVO) {
		return offDAO.selectOff(offVO);
	}

	@Override
	@Transactional
	public ServiceResult modifyOff(OffVO offVO) {
		OffVO off = offDAO.selectOff(offVO);
		if(off==null) throw new CustomException(offVO.getOffNo()+"에 해당하는 내역이 없습니다.");
			
		ServiceResult result = ServiceResult.FAILED;
		int listUp = offDAO.updateOff(offVO);
		if(listUp>0) {
			result = ServiceResult.OK;
			offDAO.updateEmpOff(offVO);
		}
		return result;
	}

	@Override
	@Transactional
	public ServiceResult removeOff(OffVO offVO) {
		OffVO off = offDAO.selectOff(offVO);
		if(off==null) throw new CustomException(offVO.getOffNo()+"에 해당하는 내역이 없습니다.");
		
		String nowEmp = offDAO.selectNowOff(off);
		
		EmployeeVO employee = new EmployeeVO();
		
		employee.setMemId(off.getMemId());
		employee.setEmpOff(Float.toString(Float.parseFloat(nowEmp)+Float.parseFloat(off.getOffUse())));
		int cnt = offDAO.deleteOff(off);
		
		ServiceResult result = ServiceResult.FAILED;
		
		if(cnt>0) {
			result = ServiceResult.OK;
			offDAO.updateOffAfterDel(employee);
		}
		return result;
	}

	@Override
	public String retrieveNowOff(OffVO param) {
		return offDAO.selectNowOff(param);
	}


}
