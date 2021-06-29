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
package kr.or.anyapart.calendar.service;

import java.util.List;

import kr.or.anyapart.vo.ScheduleVO;

public interface ICalendarService {

	/**
	 * 리모델링 일정 조회
	 * @return
	 */
	List<ScheduleVO> retreiveRemodellingList(ScheduleVO scheduleVO);

	/**
	 * 수리 일정 조회
	 * @return
	 */
	List<ScheduleVO> retreiveAfterServiceList(ScheduleVO scheduleVO);

	/**
	 * 아파트 행사 일정 조회
	 * @return
	 */
	List<ScheduleVO> retreiveEventList(ScheduleVO scheduleVO);

	/**
	 * 일정 상세조회
	 * @param scheduleVO
	 * @return
	 */
	ScheduleVO retreiveCalendarView(ScheduleVO scheduleVO);

	/**
	 * 관리사무소 아파트행사 일정 삭제
	 * @param scheduleVO
	 * @return
	 */
	int removeApartEvent(ScheduleVO scheduleVO);

	/**
	 * 관리사무소 아파트 행사 일정 등록
	 * @param scheduleVO
	 * @return
	 */
	int insertCalendarEvent(ScheduleVO scheduleVO);

	/**
	 * 관리사무소 일정 수정
	 * @param scheduleVO
	 * @return
	 */
	int updateCalendarEvnet(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	List<ScheduleVO> selectAfterServiceListOffice(ScheduleVO scheduleVO);

	/**
	 * @param scheduleVO
	 * @return
	 */
	List<ScheduleVO> selectAfterServiceListIndv(ScheduleVO scheduleVO);


}
