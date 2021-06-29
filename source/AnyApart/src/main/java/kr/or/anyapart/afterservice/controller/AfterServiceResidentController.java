/**
 * @author 박정민
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                                             수정자                            수정내용
 * --------     --------   -----------------------
 * 2021. 1. 26.       작성자명         최초작성
 * Copyright (c) 2021. 1. 26. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.afterservice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.afterservice.service.IAfterServiceService;
import kr.or.anyapart.afterservice.vo.AfterServiceVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ResidentMenuVO;
import kr.or.anyapart.vo.SearchVO;

/**
 * 입주민 수리신청
 * @author 박정민
 */
@Controller
public class AfterServiceResidentController {
	
	@Inject
	private IAfterServiceService service;
	
	/**
	 * 수리 신청 목록 조회
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@RequestMapping("/resident/support/afterServiceList.do")
	public String list(PagingVO<AfterServiceVO> pagingVO, Model model, 
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		if(pagingVO.getSearchVO()==null) {
			SearchVO searchVO = new SearchVO();
			searchVO.setSearchAptCode(authMember.getAptCode());
			pagingVO.setSearchVO(searchVO);
		}else {
			pagingVO.getSearchVO().setSearchAptCode(authMember.getAptCode());
		}
		int totalRecord = service.retreiveAfterServiceCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<AfterServiceVO> list = service.retreiveAfterServiceList(pagingVO);
		pagingVO.setDataList(list);
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "support/afterServiceList";
	}
	
	/**
	 * 비밀글 비밀번호 체크
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/resident/support/chkPass.do", produces = "text/plain")
	@ResponseBody
	public String chkPass(AfterServiceVO asVO) {
		ServiceResult result = service.chkMemPass(asVO);
		String chkMsg = "false";
		if(result==ServiceResult.OK) {
			chkMsg = "true";
		}
		return chkMsg;
	}
	
	/**
	 * 수리 신청 등록 폼으로 이동
	 * @param model
	 * @return
	 */
	@RequestMapping("/resident/support/insertAfterService.do")
	public String form(Model model, @AuthenticationPrincipal(expression="realMember")MemberVO authMember,
			PagingVO<AfterServiceVO> pagingVO) {
		ResidentMenuVO menuVO = new ResidentMenuVO();
		menuVO.setTitle("생활지원");
		menuVO.setSubTitle("수리신청");
		model.addAttribute("menuVO", menuVO);
		model.addAttribute("asVO", new AfterServiceVO());
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "support/afterServiceForm";
	}
	
	/**
	 * 수리 신청 등록
	 * @param model
	 * @param asVO
	 * @param errors
	 * @param rab
	 * @return
	 */
	@RequestMapping(value="/resident/support/insertAfterService.do", method=RequestMethod.POST)
	public String regist(Model model, @Validated(InsertGroup.class) @ModelAttribute("asVO") AfterServiceVO asVO, BindingResult errors, 
			RedirectAttributes rttr, PagingVO<AfterServiceVO> pagingVO) {
		String goPage = "support/afterServiceForm";
		String message = "등록 실패";
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.insertAfterService(asVO);
			switch (result) {
			case OK:
				message = "신청이 완료되었습니다.";
				goPage = "redirect:/resident/support/afterServiceList.do";
				rttr.addFlashAttribute("message", NotyMessageVO.builder(message).type(NotyType.success).build());
				rttr.addAttribute("currentPage", pagingVO.getCurrentPage());
				rttr.addAttribute("searchVO.searchWord", pagingVO.getSearchVO().getSearchWord());
				break;
			default:
				break;
			}
		}
		model.addAttribute("pagingVO", pagingVO);
		return goPage;
	}
	
	/**
	 * 수리 신청 상세조회
	 * @param model
	 * @param asVO
	 * @return
	 */
	@RequestMapping("/resident/support/afterServiceView.do")
	public String view(Model model, AfterServiceVO asVO, @ModelAttribute("pagingVO")PagingVO<AfterServiceVO> pagingVO, 
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		AfterServiceVO afterServiceVO = service.retreiveAfterServiceResident(asVO);
		ResidentMenuVO menuVO = new ResidentMenuVO();
		menuVO.setTitle("생활지원");
		menuVO.setSubTitle("수리신청");
		model.addAttribute("asVO", afterServiceVO);
		model.addAttribute("menuVO", menuVO);
		return "support/afterServiceView";
	}
	
	/**
	 * 수리 신청 수정 폼으로 이동
	 * @param model
	 * @return
	 */
	@RequestMapping("/resident/support/updateAfterService.do")
	public String uform(Model model, AfterServiceVO asVO, PagingVO<AfterServiceVO> pagingVO,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		AfterServiceVO afterServiceVO = service.retreiveAfterServiceResident(asVO);
		model.addAttribute("asVO", afterServiceVO);
		return "support/afterServiceForm";
	}
	
	/**
	 * 수리 신청 수정 
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/resident/support/updateAfterService.do", method=RequestMethod.POST)
	public String update(@Validated(UpdateGroup.class) AfterServiceVO afterServiceVO, BindingResult errors, 
			PagingVO<AfterServiceVO> pagingVO, RedirectAttributes rttr, Model model) {
		String goPage = "support/afterServiceForm";
		String message = "수정 실패";
		if(!errors.hasErrors()) {
			ServiceResult result = service.updateAfterService(afterServiceVO);
			goPage = resultChk(result, "수정되었습니다.", rttr);
			rttr.addAttribute("currentPage", pagingVO.getCurrentPage());
			rttr.addAttribute("searchVO.searchWord", pagingVO.getSearchVO().getSearchWord());
		}else {
			model.addAttribute("asVO", afterServiceVO);
			model.addAttribute("error", errors);
		}
		return goPage;
	}
	
	/**
	 * 수리 신청 삭제
	 * @param model
	 * @return
	 */
	@RequestMapping("/resident/support/deleteAfterService.do")
	public String delete(Model model, AfterServiceVO afterServiceVO, 
			PagingVO<AfterServiceVO> pagingVO, RedirectAttributes rttr) {
		String goPage = "support/afterServiceForm";
		String message = "삭제 실패";
		ServiceResult result = service.deleteAfterService(afterServiceVO);
		
		goPage = resultChk(result, "삭제되었습니다.", rttr);
		rttr.addAttribute("currentPage", pagingVO.getCurrentPage());
		rttr.addAttribute("searchVO.searchWord", pagingVO.getSearchVO().getSearchWord());
		return goPage;
	}
	
	public String resultChk(ServiceResult result, String okMessage, RedirectAttributes rttr) {
		Map<String, String> resultSwitch = new HashMap<>();
		String goPage = null;
		switch (result) {
		case OK:
			goPage = "redirect:/resident/support/afterServiceList.do";
			rttr.addFlashAttribute("message", NotyMessageVO.builder(okMessage).type(NotyType.success).build());
			break;
		default:
			rttr.addFlashAttribute("message", NotyMessageVO.builder("서버오류. 작업을 완료할 수 없습니다.").build());
			break;
		}
		
		return goPage;
	}
}
