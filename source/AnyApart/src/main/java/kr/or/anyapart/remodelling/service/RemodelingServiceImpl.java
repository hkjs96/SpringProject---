/**
 * @author 박정민
 * @since 2021. 1. 27.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 1. 27.       박정민         최초작성
 * Copyright (c) 2021. 1. 27. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.remodelling.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.remodelling.dao.IRemodelingDAO;
import kr.or.anyapart.remodelling.vo.RemodellingVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;

@Service
public class RemodelingServiceImpl implements IRemodelingService{

	@Inject
	private IRemodelingDAO dao;
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#reteiveRmdlCount(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public int reteiveRmdlCountR(PagingVO<RemodellingVO> pagingVO) {
		return dao.selectRmdlCountR(pagingVO);
	}
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#reteiveRmdlCount(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public int reteiveRmdlCount(PagingVO<RemodellingVO> pagingVO) {
		return dao.selectRmdlCount(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#retreiveList(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public List<RemodellingVO> retreiveList(PagingVO<RemodellingVO> pagingVO) {
		return dao.selectRmdlList(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#insertRmdl(kr.or.anyapart.remodelling.vo.RemodellingVO)
	 */
	@Override
	public ServiceResult insertRmdl(RemodellingVO rmdlVO) {
		int cnt = dao.insertRmdl(rmdlVO);
		ServiceResult result = ServiceResult.FAILED;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#deleteRmdl(kr.or.anyapart.remodelling.vo.RemodellingVO)
	 */
	@Override
	public ServiceResult deleteRmdl(RemodellingVO rmdlVO, MemberVO authMember) {
		RemodellingVO remodellingVO = dao.selectRmdl(rmdlVO);
		//세션 아이디랑 게시글 작성자 아이디랑 같은지 비교해서 지워야됨
		ServiceResult result = ServiceResult.FAILED;
		if(remodellingVO != null) {
			if(remodellingVO.getMemId().equals(authMember.getMemId())) {
				int cnt = dao.deleteRmdl(rmdlVO);
				if(cnt>0) {
					result = ServiceResult.OK;
				}
			}else {
				result = ServiceResult.INVALIDID;
			}
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#approvalRmdl(kr.or.anyapart.remodelling.vo.RemodellingVO)
	 */
	@Transactional
	@Override
	public ServiceResult approvalRmdl(RemodellingVO rmdlVO) {
		ServiceResult result = ServiceResult.FAILED;
		RemodellingVO remodellingVO = dao.selectRmdl(rmdlVO);
		if(remodellingVO!=null) {
			int cnt = dao.updateRmdlYn(rmdlVO);
			if(cnt>0) {
				ScheduleVO scheduleVO = setSchedule(remodellingVO);
				//일정 등록
				cnt += dao.insertRmdlSchedule(scheduleVO);
				if(cnt>1) {
					result = ServiceResult.OK;
				}
			}
		}
		return result;
	}

	/**
	 * 리모델링 신청 정보로 scheduleVO생성
	 * @param rmdlVO
	 * @return
	 */
	private ScheduleVO setSchedule(RemodellingVO rmdlVO) {
		ScheduleVO scheduleVO = ScheduleVO.builder()
										.schdType("S004")
										.schdTitle(rmdlVO.getDong()+"동"+rmdlVO.getHo()+"호 리모델링")
										.schdContent(rmdlVO.getRmdlTitle())
										.schdStart(rmdlVO.getRmdlStart())
										.schdEnd(rmdlVO.getRmdlEnd())
										.aptCode(rmdlVO.getAptCode())
										.applyNo(rmdlVO.getRmdlNo())
										.build();
		return scheduleVO;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#approvalCancleRmdl(kr.or.anyapart.remodelling.vo.RemodellingVO)
	 */
	@Override
	@Transactional
	public ServiceResult approvalCancelRmdl(ScheduleVO scheduleVO) {
		//해당 일정지우고 승인취소해야됨.
		ScheduleVO schdVO = dao.selectRmdlSchedule(scheduleVO); 
		int cnt = dao.deleteRmdlSchedule(scheduleVO);
		ServiceResult result = ServiceResult.FAILED;
		cnt += dao.approvalCancleRmdl(schdVO.getApplyNo());
		if(cnt>1) {
			result = ServiceResult.OK;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#retreiveListOffice(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public List<RemodellingVO> retreiveListOffice(PagingVO<RemodellingVO> pagingVO) {
		return dao.selectRmdlListOffice(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#approvalCancelRmdlManage(kr.or.anyapart.remodelling.vo.RemodellingVO)
	 */
	@Transactional
	@Override
	public ServiceResult approvalCancelRmdlManage(RemodellingVO rmdlVO) {
		ServiceResult result = ServiceResult.FAILED;
		ScheduleVO scheduleVO = dao.selectScheduleManage(rmdlVO);
		if(scheduleVO!=null) {
			int cnt  = dao.deleteRmdlSchedule(scheduleVO);
			if(cnt>0) {
				cnt += dao.approvalCancleRmdl(rmdlVO.getRmdlNo());
				result = ServiceResult.OK;
			}
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.remodelling.service.IRemodelingService#retreiveRmdlWaitingCnt()
	 */
	@Override
	public int retreiveRmdlWaitingCnt(PagingVO<RemodellingVO> pagingVO) {
		return dao.selectRmdlWaitingCnt(pagingVO);
	}


}
