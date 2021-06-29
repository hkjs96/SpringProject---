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
package kr.or.anyapart.afterservice.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.afterservice.vo.AfterServiceVO;
import kr.or.anyapart.asset.vo.RepairVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;

@Repository
public interface IAfterServiceDAO {
	public int selectAfterServiceCount(PagingVO<AfterServiceVO> pagingVO);
	public List<AfterServiceVO> selectAfterServiceList(PagingVO<AfterServiceVO> pagingVO);
	public int insertAfterService(AfterServiceVO asVO);
	public AfterServiceVO selectAfterService(AfterServiceVO asVO);
	public AfterServiceVO selectAfterServiceResident(AfterServiceVO asVO);
	public int updateAfterService(AfterServiceVO afterServiceVO);
	public int deleteAfterService(AfterServiceVO asVO);
	/**
	 * @param asVO
	 * @return
	 */
	public int resultAfterService(AfterServiceVO asVO);
	/**
	 * @param asVO
	 * @return
	 */
	public int afterServiceResultUpdate(AfterServiceVO asVO);
	/**
	 * @param memPass
	 * @return
	 */
	public MemberVO selectMember(String memPass);
	/**
	 * @param scheduleVO
	 * @return
	 */
	public int insertAsSchedule(ScheduleVO scheduleVO);
	/**
	 * @param scheduleVO
	 * @return
	 */
	public int deleteCalendar(ScheduleVO scheduleVO);
	/**
	 * @param asVO
	 * @return
	 */
	public int deleteAsResult(AfterServiceVO asVO);
	/**
	 * @return
	 */
	public int selectAsWaitingCnt(PagingVO<AfterServiceVO> pagingVO);
	/**
	 * @param asVO
	 * @return 
	 */
	public ScheduleVO selectAsSchedule(AfterServiceVO asVO);
	/**
	 * @param scheduleVO
	 */
	public void deleteAsSchedule(ScheduleVO scheduleVO);
}
