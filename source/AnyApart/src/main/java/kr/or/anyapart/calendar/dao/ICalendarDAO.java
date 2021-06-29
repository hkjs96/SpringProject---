/**
 * @author 박정민
 * @since 2021. 2. 5.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 5.       박정민         최초작성
 * Copyright (c) 2021. 2. 5. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.calendar.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.afterservice.vo.AfterServiceVO;
import kr.or.anyapart.remodelling.vo.RemodellingVO;
import kr.or.anyapart.vo.ScheduleVO;

@Repository
public interface ICalendarDAO {
	public List<ScheduleVO> selectRemodellingList(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	public RemodellingVO retreiveRemodelling(ScheduleVO scheduleVO);

	/**
	 * @return
	 */
	public List<ScheduleVO> selectAfterServiceList(ScheduleVO scheduleVO);

	/**
	 * @return
	 */
	public List<ScheduleVO> selectEventList(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	public ScheduleVO selectCalendarView(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	public int removeApartEvent(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	public int insertCalendarEvent(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	public int updateCalendarEvent(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	public List<ScheduleVO> selectAfterServiceListOffice(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	public List<ScheduleVO> selectAfterServiceListIndv(ScheduleVO scheduleVO);
}
