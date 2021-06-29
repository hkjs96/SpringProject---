/**
 * @author 박정민
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 1. 29.       박정민         최초작성
 * Copyright (c) 2021. 1. 29. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.afterservice.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.afterservice.dao.IAfterServiceDAO;
import kr.or.anyapart.afterservice.vo.AfterServiceVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;

@Service
public class AfterServiceServiceImpl implements IAfterServiceService{

	@Inject
	private IAfterServiceDAO dao;
	
	@Inject
	private PasswordEncoder pwEncoder;

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IRepairService#retreiveAfterServiceCount(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public int retreiveAfterServiceCount(PagingVO<AfterServiceVO> pagingVO) {
		String r = "";
		r = "f";
		return dao.selectAfterServiceCount(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IRepairService#retreiveAfterServiceList(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public List<AfterServiceVO> retreiveAfterServiceList(PagingVO<AfterServiceVO> pagingVO) {
		return dao.selectAfterServiceList(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#insertAfterService(kr.or.anyapart.afterservice.vo.AfterServiceVO)
	 */
	@Override
	public ServiceResult insertAfterService(AfterServiceVO asVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertAfterService(asVO);
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#retreiveAfterService(kr.or.anyapart.afterservice.vo.AfterServiceVO)
	 */
	@Override
	public AfterServiceVO retreiveAfterServiceResident(AfterServiceVO asVO) {
		AfterServiceVO afterServiceVO = dao.selectAfterServiceResident(asVO);
		if(afterServiceVO!=null) {
			//익셉션발생.
		}
		return afterServiceVO;
	}
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#retreiveAfterService(kr.or.anyapart.afterservice.vo.AfterServiceVO)
	 */
	@Override
	public AfterServiceVO retreiveAfterService(AfterServiceVO asVO) {
		AfterServiceVO afterServiceVO = dao.selectAfterServiceResident(asVO);
		if(afterServiceVO!=null) {
			//익셉션발생.
		}
		return afterServiceVO;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#updateAfterService(kr.or.anyapart.afterservice.vo.AfterServiceVO)
	 */
	@Override
	public ServiceResult updateAfterService(AfterServiceVO afterServiceVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.updateAfterService(afterServiceVO);
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#deleteAfterService(kr.or.anyapart.afterservice.vo.AfterServiceVO)
	 */
	@Override
	public ServiceResult deleteAfterService(AfterServiceVO afterServiceVO) {
		ServiceResult result = ServiceResult.FAILED;
		AfterServiceVO asVO = dao.selectAfterService(afterServiceVO);
		if(asVO!=null) {
			int cnt = dao.deleteAfterService(asVO);
			if(cnt>0) {
				result = ServiceResult.OK;
			}
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#resultAfterService(kr.or.anyapart.afterservice.vo.AfterServiceVO)
	 */
	@Override
	public ServiceResult resultAfterService(AfterServiceVO asVO) {
		ServiceResult result = ServiceResult.FAILED;
		AfterServiceVO afterServiceVO = dao.selectAfterService(asVO);
		if(afterServiceVO!=null) {
			if("ASHOLD".equals(asVO.getResultStatus())||"ASDONE".equals(asVO.getResultStatus())) {
				asVO.setAsStatus("ASING");
			}else if("ASCANCEL".equals(asVO.getResultStatus())) {
				asVO.setAsStatus("ASHOLD");
				ScheduleVO scheduleVO = dao.selectAsSchedule(asVO);
				if(scheduleVO!=null) {
					dao.deleteAsSchedule(scheduleVO);
				}
			}else {
				asVO.setAsStatus("ASDONE");
			}
			int cnt = dao.resultAfterService(asVO);
			if(cnt>0) {
				result = ServiceResult.OK;
			}
		}
		return result;
	}

	@Override
	@Transactional
	public ServiceResult afterServiceResultUpdate(AfterServiceVO asVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.afterServiceResultUpdate(asVO);
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#chkMemPass(kr.or.anyapart.vo.MemberVO)
	 */
	@Override
	public ServiceResult chkMemPass(AfterServiceVO asVO) {
		ServiceResult result = ServiceResult.FAILED;
		String pass = pwEncoder.encode(asVO.getMemPass());
		MemberVO member = dao.selectMember(pass);
		AfterServiceVO afterServiceVO = dao.selectAfterService(asVO);
		if(member!=null) {
			if(member.getMemId().equals(afterServiceVO.getMemId())) {
				result = ServiceResult.OK;
			}
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#insertAsSchedule(kr.or.anyapart.vo.ScheduleVO)
	 */
	@Override
	public ServiceResult insertAsSchedule(ScheduleVO scheduleVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.insertAsSchedule(scheduleVO);
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#approvalCancel(kr.or.anyapart.vo.ScheduleVO)
	 */
	@Override
	public ServiceResult approvalCancel(ScheduleVO scheduleVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.deleteCalendar(scheduleVO);
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#deleteAsResult(kr.or.anyapart.afterservice.vo.AfterServiceVO)
	 */
	@Override
	public ServiceResult deleteAsResult(AfterServiceVO asVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = dao.deleteAsResult(asVO);
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.afterservice.service.IAfterServiceService#retreiveAsWaintingCnt()
	 */
	@Override
	public int retreiveAsWaintingCnt(PagingVO<AfterServiceVO> pagingVO) {
		return dao.selectAsWaitingCnt(pagingVO);
	}
}
