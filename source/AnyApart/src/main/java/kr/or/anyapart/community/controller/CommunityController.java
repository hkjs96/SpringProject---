package kr.or.anyapart.community.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.asset.vo.ProdVO;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.community.service.CommunityService;
import kr.or.anyapart.community.vo.CommunityVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
@RequestMapping("/office/community")
public class CommunityController extends BaseController{
	
	@Inject
	private CommunityService service;
	
	@RequestMapping("/communityList.do")
	public String communityList(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("searchDetail") CommunityVO searchDetail
		, @ModelAttribute("searchVO") SearchVO searchVO
		, Model model
	) {
		LOGGER.info("currentPage : {}, searchType: {}, searchWord: {}", currentPage, searchVO.getSearchType(), searchVO.getSearchWord());
		
		searchVO.setSearchAptCode(authMember.getAptCode());
		PagingVO<CommunityVO> pagingVO = new PagingVO<>(5, 5);
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setSearchVO(searchVO);
		
		int totalRecord = service.countCommunity(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<CommunityVO> communityList = service.retrieveCommunityList(pagingVO);
		pagingVO.setDataList(communityList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "asset/communityList";
	}
	
	@RequestMapping(value="/communityList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String communityListAjax(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("searchDetail") CommunityVO searchDetail
			, @ModelAttribute("searchVO") SearchVO searchVO
			, Model model
			) throws ServletException, IOException {
		communityList(authMember, currentPage, searchDetail, searchVO, model);
		return "jsonView";
	}
	
	
	@RequestMapping(value="/communityView.do", method=RequestMethod.GET)
	public String retrieve(
		@RequestParam("cmntNo") String cmntNo
//		@ModelAttribute("community") CommunityVO community
//		, @RequestParam(value="page", required=false, defaultValue="1")int currentPage
//		, SearchVO searchVO
//		, @ModelAttribute("community") CommunityVO searchDetail 
//			, RedirectAttributes redirectAttributes
		, @AuthenticationPrincipal(expression="realMember") MemberVO member
		, Model model
		) {
		CommunityVO community = new CommunityVO();
		community.setAptCode(member.getAptCode());
		community.setCmntNo(Integer.valueOf(cmntNo));
		community = service.retrieveCommunity(community);
		model.addAttribute("community", community);
//		return "asset/communityView";
		return "office/asset/ajax/communityView";
	}
	
	@RequestMapping("/communityForm.do")
	public String form(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, Model model
		) {
		CommunityVO community = new CommunityVO();
		community.setAptCode(member.getAptCode());
		model.addAttribute("community", community);
//		return "asset/communityForm";
		return "office/asset/ajax/communityForm";
	}
	
	@RequestMapping(value="/communityForm.do", method=RequestMethod.POST)
	public String create(
		@Validated @ModelAttribute("community") CommunityVO community
		, BindingResult errors
		, Model model
		) {
//		String goPage = "asset/communityForm";
		String goPage = "redirect:/office/community/communityList.do";;
		if(!errors.hasErrors()) {
			try {
				service.createCommunity(community);
				return "redirect:/office/community/communityList.do";
			}catch (Exception e) {
				model.addAttribute("message",INSERT_SERVER_ERROR_MSG);
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		
		return goPage;
	}
	
	@RequestMapping("/communityUpdateForm.do")
	public String updateform(
		Model model
		, @ModelAttribute() CommunityVO com
		) {
		CommunityVO community = service.retrieveCommunity(com);
		model.addAttribute("community", community);
//		return "asset/communityUpdateForm";
		return "office/asset/ajax/communityUpdateForm";
	}
	
	@RequestMapping(value="/communityUpdateForm.do", method=RequestMethod.POST)
	public String update(
			@Validated @ModelAttribute("community") CommunityVO community
			, BindingResult errors
			, Model model
		) {
//		String goPage = "asset/communityUpdateForm";
		String goPage = "redirect:/office/community/communityList.do";
		
		try {
			if(!errors.hasErrors()) {
				service.modifyCommunity(community);
//				goPage="redirect:/office/community/communityView.do?cmntNo="+community.getCmntNo();
			}else {
				model.addAttribute("message", UPDATE_CLIENT_ERROR_MSG);
			}
		}catch (Exception e) {
			model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
		}
		return goPage;
	}
}
