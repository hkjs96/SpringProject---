/**
 * @author 박정민
 * @since 2021. 2. 5.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                                             수정자                            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 5.       작성자명         최초작성
 * Copyright (c) 2021. 2. 5. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.calendar.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.calendar.service.ICalendarService;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.ScheduleVO;

/**
 * 캘린더 관련 컨트롤러
 * @author 박정민
 */
@Controller
public class CalendarController extends BaseController{
	@Inject
	private ICalendarService service;
	
	/**
	 * 입주민 아파트소식 캘린더 조회
	 * @param rmdlVO
	 * @return
	 * @throws JsonProcessingException 
	 */
	@RequestMapping("/resident/notice/apartNewsList.do")
	public String apartNewsCal(@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO,
			Model model) throws JsonProcessingException {
		ScheduleVO scheduleVO = new ScheduleVO();
		scheduleVO.setAptCode(authMemberVO.getAptCode());
		List<ScheduleVO> dataListR = service.retreiveRemodellingList(scheduleVO);
		List<ScheduleVO> dataListA = service.retreiveAfterServiceList(scheduleVO);
		List<ScheduleVO> dataListE = service.retreiveEventList(scheduleVO);
		
		ObjectMapper mapper = new ObjectMapper();
		String rmdlList = mapper.writeValueAsString(dataListR);
		model.addAttribute("rmdlList", rmdlList);
		String asList = mapper.writeValueAsString(dataListA);
		model.addAttribute("asList", asList);
		String eventList = mapper.writeValueAsString(dataListE);
		model.addAttribute("eventList", eventList);
		return "notice/apartNewsList";
	}
	
	/**
	 * 입주민 아파트소식 일정 상세조회 
	 * @param rmdlVO
	 * @return
	 */
	@RequestMapping(value="/resident/notice/apartNewsView.do")
	public String apartNewsCalView(ScheduleVO scheduleVO, Model model) {
		ScheduleVO schdVO = service.retreiveCalendarView(scheduleVO);
		model.addAttribute("schdVO", schdVO);
		return "resident/notice/ajax/viewModal";
	}
	
	/**
	 * 관리사무소 일정관리 일정 전체조회
	 * @param model
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping("/office/calendar/wholeCalendar.do")
	public String calendar(@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO,
			Model model) throws JsonProcessingException {
		ScheduleVO scheduleVO = new ScheduleVO();
		scheduleVO.setAptCode(authMemberVO.getAptCode());
		List<ScheduleVO> dataListR = service.retreiveRemodellingList(scheduleVO);
		List<ScheduleVO> dataListA = service.retreiveAfterServiceList(scheduleVO);  //아파트수선
		List<ScheduleVO> dataListAi = service.selectAfterServiceListIndv(scheduleVO);  //세대수선
		List<ScheduleVO> dataListE = service.retreiveEventList(scheduleVO);
		
		ObjectMapper mapper = new ObjectMapper();
		String rmdlList = mapper.writeValueAsString(dataListR);
		model.addAttribute("rmdlList", rmdlList);
		String asList = mapper.writeValueAsString(dataListA);
		model.addAttribute("asList", asList);
		String asIndvList = mapper.writeValueAsString(dataListAi);
		model.addAttribute("asIndvList", asIndvList);
		String eventList = mapper.writeValueAsString(dataListE);
		model.addAttribute("eventList", eventList);
		return "construction/wholeCalendar";
	}
	
	/**
	 * 관리사무소 일정관리 일정 상세조회 모달
	 * @param scheduleVO
	 * @return
	 */
	@RequestMapping(value="/office/construction/remodellingCalendarView.do")
	public String rmdlCalView(ScheduleVO scheduleVO, Model model) {
		ScheduleVO schdVO = service.retreiveCalendarView(scheduleVO);
		model.addAttribute("schdVO", schdVO);
		return "office/construction/ajax/calendarViewModal";
	}
	
	/**
	 * 관리사무소 일정관리 아파트행사 일정등록 폼 이동
	 * @param rmdlVO
	 * @return
	 */
	@RequestMapping("/office/construction/registSchedule.do")
	public String registSchedule(Model model, @AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		model.addAttribute("schdVO", new ScheduleVO());
		model.addAttribute("authMember",authMember);
		return "office/construction/ajax/calendarForm";
	}
	
	/**
	 * 관리사무소 일정관리 아파트행사 일정등록
	 * @param scheduleVO
	 * @return
	 */
	@RequestMapping(value="/office/construction/registSchedule.do", method=RequestMethod.POST)
	public String insertEvent(ScheduleVO scheduleVO, BindingResult errors, 
			Model model, RedirectAttributes rttr) {
		String message = "서버오류. 등록실패";
		if(!errors.hasErrors()) {
			int cnt = service.insertCalendarEvent(scheduleVO);
			if(cnt>0) {
				rttr.addFlashAttribute("message", NotyMessageVO.builder("정상적으로 처리되었습니다.").type(NotyType.success).build());
			}else {
				rttr.addFlashAttribute("message", NotyMessageVO.builder(message).build());
			}
		}
		return "redirect:/office/calendar/wholeCalendar.do";
	}
	
	/**
	 * 관리사무소 일정관리 아파트행사 일정수정 폼 이동
	 * @param scheduleVO
	 * @return
	 */
	@RequestMapping(value="/office/construction/updateCalendarEvent.do")
	public String goUpdateEvent(ScheduleVO scheduleVO, Model model) {
		ScheduleVO schdVO = service.retreiveCalendarView(scheduleVO);
		model.addAttribute("modify", "modify");
		model.addAttribute("schdVO", schdVO);
		return "office/construction/ajax/calendarForm";
	}
	
	/**
	 * 관리사무소 일정관리 아파트행사 일정수정 
	 * @param scheduleVO
	 * @return
	 */
	@RequestMapping(value="/office/construction/updateCalendarEvent.do", method=RequestMethod.POST)
	public String updateEvent(ScheduleVO scheduleVO, RedirectAttributes rttr) {
		String message = "서버오류. 수정실패";
		int cnt = service.updateCalendarEvnet(scheduleVO);
		if(cnt>0) {
			rttr.addFlashAttribute("message", NotyMessageVO.builder("정상적으로 처리되었습니다.").type(NotyType.success).build());
		}else {
			rttr.addFlashAttribute("message", NotyMessageVO.builder(message).type(NotyType.success).build());
		}
		return "redirect:/office/calendar/wholeCalendar.do";
	}
	
	/**
	 * 관리사무소 일정관리 아파트 행사 일정 삭제
	 * @param scheduleVO
	 * @return
	 */
	@RequestMapping(value="/office/construction/removeApartEvent.do")
	public String removeEvent(ScheduleVO scheduleVO, Model model, RedirectAttributes rttr) {
		String goPage = "construction/wholeCalendar";
		int cnt = service.removeApartEvent(scheduleVO);
		if(cnt>0) {
			goPage = "redirect:/office/calendar/wholeCalendar.do";
			rttr.addFlashAttribute("message", NotyMessageVO.builder("정상적으로 처리되었습니다.").type(NotyType.success).build());
		}
		return goPage;
	}
	
	
}