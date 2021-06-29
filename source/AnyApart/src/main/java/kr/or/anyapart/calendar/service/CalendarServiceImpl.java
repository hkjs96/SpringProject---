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

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.anyapart.calendar.dao.ICalendarDAO;
import kr.or.anyapart.vo.ScheduleVO;

@Service
public class CalendarServiceImpl implements ICalendarService{
	private Logger logger = LoggerFactory.getLogger(CalendarServiceImpl.class);
	
	@Inject
	private ICalendarDAO dao;
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.IRmodellingCalendarService#retreiveRemodellingList(kr.or.anyapart.remodelling.vo.RemodellingVO)
	 */
	@Override
	public List<ScheduleVO> retreiveRemodellingList(ScheduleVO scheduleVO) {
		return dao.selectRemodellingList(scheduleVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.IRmodellingCalendarService#retreiveAfterServiceList()
	 */
	@Override
	public List<ScheduleVO> retreiveAfterServiceList(ScheduleVO scheduleVO) {
		return dao.selectAfterServiceList(scheduleVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.ICalendarService#retreiveEventList()
	 */
	@Override
	public List<ScheduleVO> retreiveEventList(ScheduleVO scheduleVO) {
		return dao.selectEventList(scheduleVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.ICalendarService#retreiveCalendarView(kr.or.anyapart.vo.ScheduleVO)
	 */
	@Override
	public ScheduleVO retreiveCalendarView(ScheduleVO scheduleVO) {
		return dao.selectCalendarView(scheduleVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.ICalendarService#removeApartEvent(kr.or.anyapart.vo.ScheduleVO)
	 */
	@Override
	public int removeApartEvent(ScheduleVO scheduleVO) {
		return dao.removeApartEvent(scheduleVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.ICalendarService#insertCalendarEvent(kr.or.anyapart.vo.ScheduleVO)
	 */
	@Override
	public int insertCalendarEvent(ScheduleVO scheduleVO) {
		return dao.insertCalendarEvent(scheduleVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.ICalendarService#updateCalendarEvnet(kr.or.anyapart.vo.ScheduleVO)
	 */
	@Override
	public int updateCalendarEvnet(ScheduleVO scheduleVO) {
		return dao.updateCalendarEvent(scheduleVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.ICalendarService#selectAfterServiceListOffice(kr.or.anyapart.vo.ScheduleVO)
	 */
	@Override
	public List<ScheduleVO> selectAfterServiceListOffice(ScheduleVO scheduleVO) {
		return dao.selectAfterServiceListOffice(scheduleVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.calendar.service.ICalendarService#selectAfterServiceListIndv(kr.or.anyapart.vo.ScheduleVO)
	 */
	@Override
	public List<ScheduleVO> selectAfterServiceListIndv(ScheduleVO scheduleVO) {
		return dao.selectAfterServiceListIndv(scheduleVO);
	}
	
}
