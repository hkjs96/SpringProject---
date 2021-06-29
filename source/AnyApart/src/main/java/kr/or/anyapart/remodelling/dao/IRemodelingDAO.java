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
package kr.or.anyapart.remodelling.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.remodelling.vo.RemodellingVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;

@Repository
public interface IRemodelingDAO {
	public int selectRmdlCount(PagingVO<RemodellingVO> pagingVO);
	public int selectRmdlCountR(PagingVO<RemodellingVO> pagingVO);
	public List<RemodellingVO> selectRmdlList(PagingVO<RemodellingVO> pagingVO);
	
	/**
	 * @param rmdlVO
	 * @return
	 */
	public int insertRmdl(RemodellingVO rmdlVO);
	/**
	 * @param rmdlVO
	 * @return
	 */
	public int deleteRmdl(RemodellingVO rmdlVO);
	/**
	 * @param rmdlVO
	 * @return
	 */
	public RemodellingVO selectRmdl(RemodellingVO rmdlVO);
	/**
	 * @param rmdlVO
	 * @return
	 */
	public int updateRmdlYn(RemodellingVO rmdlVO);
	
	/**
	 * 리모델링 수리승인 후 일정에 등록
	 * @param scheduleVO
	 * @return
	 */
	public int insertRmdlSchedule(ScheduleVO scheduleVO);
	/**
	 * 리모델링 승인 취소
	 * @param rmdlNo
	 * @return
	 */
	public int approvalCancleRmdl(int rmdlNo);
	/**
	 * 리모델링 승인취소시 등록된 일정 삭제
	 * @param scheduleVO
	 * @return
	 */
	public int deleteRmdlSchedule(ScheduleVO scheduleVO);
	/**
	 * @param scheduleVO
	 * @return
	 */
	public ScheduleVO selectRmdlSchedule(ScheduleVO scheduleVO);
	/**
	 * @param pagingVO
	 * @return
	 */
	public List<RemodellingVO> selectRmdlListOffice(PagingVO<RemodellingVO> pagingVO);
	/**
	 * @param rmdlVO
	 * @return
	 */
	public ScheduleVO selectScheduleManage(RemodellingVO rmdlVO);
	/**
	 * @return
	 */
	public int selectRmdlWaitingCnt(PagingVO<RemodellingVO> pagingVO);
}
