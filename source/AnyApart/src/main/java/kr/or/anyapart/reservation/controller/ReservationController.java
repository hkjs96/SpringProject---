/**
 * @author 박지수
 * @since 2021. 2. 22.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 22.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.reservation.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.anyapart.asset.vo.RepairVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.community.service.CommunityService;
import kr.or.anyapart.community.vo.CommunityVO;
import kr.or.anyapart.reservation.service.ReservationService;
import kr.or.anyapart.reservation.vo.ReservationVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Controller
public class ReservationController extends BaseController {
	
	@Inject
	ReservationService reservationService;
	
	
	/*
	 * 
	 * 
	 * 관리사무소 구간
	 * 
	 * 
	 */
	// 사용 하지 않음, 입주민이 예약 신청하면 알아서 등록되거나 안되거나
//	@RequestMapping("/office/website/reservation/reservationRequest.do")
//	public String requestList() {
//		return "website/reservation/reservationRequest";
//	}
	
	@RequestMapping("/office/website/reservation/reservationList.do")
	public String calendarList(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, Model model
		) {
		CommunityVO community  = CommunityVO.builder()
											.aptCode(member.getAptCode())
											.build();
		
		List<ReservationVO> resvList = reservationService.officeReservationList(community);
		ObjectMapper mapper = new ObjectMapper();
		String reservationList = null;
		try {
			reservationList = mapper.writeValueAsString(resvList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("reservationList", reservationList);
		return "website/reservation/reservationList";
	}
	
	
	
	
	/*
	 * 
	 * 
	 * 입주민 구간
	 * 
	 * 
	*/
	
	@RequestMapping("/resident/community/myReservation.do")
	public String list(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("pagingVO") PagingVO<ReservationVO> pagingVO
		, @ModelAttribute("searchDatail") ReservationVO searchDetail
		, Model model
	) {
		searchDetail.setMemId(member.getMemId());
		pagingVO.setSearchDetail(searchDetail);
		int totalRecord = reservationService.retrieveMemberReservationCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<ReservationVO> detailList = reservationService.retrieveMemberReservationList(pagingVO);
		pagingVO.setDataList(detailList);
		
		ResidentVO resident = reservationService.retrieveResident(member);
		List<CommunityVO> community = reservationService.retrieveCommunityList(member);
		
		model.addAttribute("resident", resident);
		model.addAttribute("communityList",community);
//		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		
		return "community/myReservation";
	}
	
	@RequestMapping("/resident/community/reservationList.do")
	public String calendarList(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @RequestParam("cmntNo") int cmntNo
		, Model model	
		) {
		CommunityVO community  = CommunityVO.builder().aptCode(member.getAptCode()).cmntNo(cmntNo).build();
		List<ReservationVO> reservationList = reservationService.retrieveReservation(community);
		
		model.addAttribute("reservationList", reservationList);
		
		return "jsonView";
//		return "website/reservation/reservationList";
	}
	
	@RequestMapping(value="/resident/community/reservationList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String calendarListAjax(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @RequestParam("cmntNo") int cmntNo
		, Model model	
		) {
		calendarList(member, cmntNo, model);
		return "jsonView";
	}


	// 기존의 일정이 존재하는 예약 페이지를 불러오는 부분
	@RequestMapping("/resident/community/reservation.do")
	public String list(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @ModelAttribute("reservation") ReservationVO reservationVO
		, Model model	
	) {
		ResidentVO resident = reservationService.retrieveResident(member);
		List<CommunityVO> community = reservationService.retrieveCommunityList(member);
		
		model.addAttribute("resident", resident);
		model.addAttribute("communityList",community);
		
		return "community/reservation";
	}
	
	
	@RequestMapping(value="/resident/community/reservationInsert.do", method=RequestMethod.POST)
	public String insertReservation(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @Validated @ModelAttribute("reservation") ReservationVO reservation
		, BindingResult errors
		, Model model
	) {
//		String goPage = "community/reservation";
//		String goPage = "redirect:/resident/community/reservation.do";
		if(!errors.hasErrors()) {
			try {
				reservation.setAptCode(member.getAptCode());
				reservationService.resvation(reservation);
				model.addAttribute("message","OK");
//				return "redirect:/resident/community/reservation.do";
			}catch(Exception e){
				model.addAttribute("message", "예약실패");
			}
		}else {
			model.addAttribute("reservation",reservation);
		}
		return "jsonView";
	}
	
	
	@RequestMapping(value="/resident/community/reservationCancel.do")
	public String cancelReservation(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @RequestParam("resvNo") int resvNo
		, Model model
		) {
		try {
			ReservationVO reservation = ReservationVO.builder().memId(member.getMemId()).resvNo(resvNo).build();
			reservationService.removeReservation(reservation);
			model.addAttribute("message","OK");
		}catch (Exception e) {
			model.addAttribute("message",DELETE_SERVER_ERROR_MSG);
		}
		return "jsonView";
	}
}
