/**
 * @author 박정민
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                   수정자                수정내용
 * --------     --------   -----------------------
 * 2021. 1. 26.   박정민         최초작성
 * Copyright (c) 2021. 1. 26. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.afterservice.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.afterservice.service.IAfterServiceService;
import kr.or.anyapart.afterservice.vo.AfterServiceVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup2;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;
import kr.or.anyapart.vo.SearchVO;

/**
 * 관리사무소 수리관리
 * @author 박정민
 */
@Controller
public class AfterServiceOfficeControlloer {
	@Inject
	private IAfterServiceService service;
	
	/**
	 * 수리내역 목록 조회화면으로 이동
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/construction/afterServiceList.do")
	public String requestList(PagingVO<AfterServiceVO> pagingVO, Model model,
			@RequestParam(value="asCode", required=false)String asCode, 
			@RequestParam(value="asStatus", required=false)String asStatus, 
			@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		if(asCode!=null || asStatus!=null) {
			AfterServiceVO searchDetail = new AfterServiceVO();
			searchDetail.setAsCode(asCode);
			searchDetail.setAsStatus(asStatus);
			pagingVO.setSearchDetail(searchDetail);
		}
		if(pagingVO.getSearchVO()==null) {
			SearchVO searchVO = new SearchVO();
			searchVO.setSearchAptCode(authMemberVO.getAptCode());
			pagingVO.setSearchVO(searchVO);
		}else {
			pagingVO.getSearchVO().setSearchAptCode(authMemberVO.getAptCode());
		}
		int totalRecord = service.retreiveAfterServiceCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<AfterServiceVO> dataList = service.retreiveAfterServiceList(pagingVO);
		pagingVO.setDataList(dataList);
		AfterServiceVO asVO = new AfterServiceVO();
		asVO.setWaitingCnt(service.retreiveAsWaintingCnt(pagingVO));
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		model.addAttribute("asVO", asVO);
		return "construction/afterServiceList";
	}
	
	/**
	 * 수리내역 목록 조회 ajax
	 * @param pagingVO
	 * @param model
	 * @return
	 */
//	@RequestMapping(value="/office/construction/afterServiceList.do", 
//			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public List<AfterServiceVO> requestListAjax(PagingVO<AfterServiceVO> pagingVO, Model model,
//			@RequestParam(value="asCode", required=false)String asCode, 
//			@RequestParam(value="asStatus", required=false)String asStatus) {
//		if(pagingVO.getCurrentPage()==0) {
//			pagingVO.setCurrentPage(1);
//		}
//		if(asCode!=null || asStatus!=null) {
//			AfterServiceVO searchDetail = new AfterServiceVO();
//			searchDetail.setAsCode(asCode);
//			searchDetail.setAsStatus(asStatus);
//			pagingVO.setSearchDetail(searchDetail);
//		}
//		int totalRecord = service.retreiveAfterServiceCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		List<AfterServiceVO> dataList = service.retreiveAfterServiceList(pagingVO);
//		return dataList;
//	}
	
	/**
	 * 수리내역 상세조회 모달 load
	 * @param asVO
	 * @return
	 */
	@RequestMapping(value="/office/construction/afterServiceView.do")
	public String view(AfterServiceVO asVO, Model model) {
		AfterServiceVO afterServiceVO = service.retreiveAfterService(asVO);
		model.addAttribute("afterServiceVO", afterServiceVO);
		return "office/construction/ajax/asViewModal";
	}
	
	/**
	 * 수리내역 상세조회 모달 load
	 * @param asVO
	 * @return
	 */
	@RequestMapping(value="/office/construction/afterServiceResultForm.do")
	public String resultForm(AfterServiceVO asVO, Model model) {
		AfterServiceVO afterServiceVO = service.retreiveAfterService(asVO);
		model.addAttribute("afterServiceVO", afterServiceVO);
		return "office/construction/ajax/asResultViewModal";
	}
	
	/**
	 * 수리내역 상세조회 ajax로 한것
	 * @param asVO
	 * @return
	 */
//	@RequestMapping(value="/office/construction/afterServiceViewAjax.do", 
//			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public AfterServiceVO viewAjax(AfterServiceVO asVO, Model model) {
//		AfterServiceVO afterServiceVO = service.retreiveAfterService(asVO);
//		model.addAttribute("afterServiceVO", afterServiceVO);
//		return afterServiceVO;
//	}
	
	/**
	 * 수리관리 처리상태변경
	 * @param asVO
	 * @return 처리결과 메시지
	 */
	@RequestMapping(value="/office/construction/afterServiceChange.do", 
			produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String changeBtn(AfterServiceVO asVO, Model model) {
		String message = "서버오류. 처리실패";
		ServiceResult result = service.resultAfterService(asVO);
		switch (result) {
		case OK:
			message = "변경되었습니다.";
			break;
		default:
			break;
		}
		return message;
	}
	
	/**
	 * 수리처리내역 등록 및 수정
	 * @param asVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/construction/afterServiceUpdateResult.do", 
			method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String resultUpdate(@Validated(InsertGroup2.class)AfterServiceVO asVO, BindingResult errors, Model model) {
		String message = "서버오류. 처리실패";
		if(!errors.hasErrors()) {
			ServiceResult result = service.afterServiceResultUpdate(asVO);
			switch (result) {
			case OK:
				message = "변경되었습니다.";
				break;
			default:
				break;
			}
		}else {
			message = "날짜는 필수입니다.";
		}
		model.addAttribute("message", message);
		return "jsonView";
	}
	
	/**
	 * 수리관리 일정등록 폼 이동
	 * @param afterServiceVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/construction/registAsSchedule.do")
	public String goInsertSchd(AfterServiceVO afterServiceVO, Model model, 
			PagingVO<AfterServiceVO> pagingVO, @AuthenticationPrincipal(expression="realMember") MemberVO authMember) {
		AfterServiceVO asVO = service.retreiveAfterService(afterServiceVO);
		model.addAttribute("asVO", asVO);
		model.addAttribute("authMember", authMember);
		return "construction/asScheduleForm";
	}
	
	/**
	 * 수리관리 일정등록 
	 * @param scheduleVO
	 * @param model
	 * @param rttr
	 * @return
	 */
	@RequestMapping(value="/office/construction/registAsSchedule.do", method=RequestMethod.POST)
	public String insertSchd(@Validated(InsertGroup.class)ScheduleVO scheduleVO, Model model, RedirectAttributes rttr,
			PagingVO<AfterServiceVO> pagingVO) {
		String goPage = "construction/asScheduleForm";
		ServiceResult result = service.insertAsSchedule(scheduleVO);
		if(result==ServiceResult.OK) {
			goPage = "redirect:/office/construction/afterServiceList.do";
			rttr.addFlashAttribute("message", NotyMessageVO.builder("일정이 등록되었습니다.").type(NotyType.success).build());
			rttr.addAttribute("currentPage", pagingVO.getCurrentPage());
			rttr.addAttribute("searchVO.searchWord", pagingVO.getSearchVO().getSearchWord());
		}
		return goPage;
	}
	
	/**
	 * 수리 승인 취소 - 일정관리 
	 * @param rmdlVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/construction/asApprovalCancel.do")
	public String approvalCancle(ScheduleVO scheduleVO, Model model, RedirectAttributes rttr) {
		String goPage = "redirect:/office/calendar/wholeCalendar.do";
		String message = "서버오류. 삭제 실패";
		ServiceResult result = service.approvalCancel(scheduleVO);
		if(result==ServiceResult.OK) {
			rttr.addFlashAttribute("message", NotyMessageVO.builder("정상적으로 처리되었습니다.").type(NotyType.success).build());
		}else {
			rttr.addFlashAttribute("message", NotyMessageVO.builder(message).build());
		}
		return goPage;
	}
	
	/**
	 * 수리 처리 내역 삭제 
	 * @param rmdlVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/construction/deleteResult.do")
	public String deleteResult(AfterServiceVO asVO, Model model, RedirectAttributes rttr) {
		String goPage = "redirect:/office/construction/afterServiceList.do";
		ServiceResult result = service.deleteAsResult(asVO);
		if(result == ServiceResult.OK) {
			rttr.addFlashAttribute("message", NotyMessageVO.builder("삭제 성공").type(NotyType.success).build());
		}else {
			rttr.addFlashAttribute("message", NotyMessageVO.builder("서버오류. 실패").build());
		}
		return goPage;
	}
}
