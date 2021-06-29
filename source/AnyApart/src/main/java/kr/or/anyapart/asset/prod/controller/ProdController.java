package kr.or.anyapart.asset.prod.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
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

import kr.or.anyapart.asset.prod.service.ProdService;
import kr.or.anyapart.asset.vo.ProdListVO;
import kr.or.anyapart.asset.vo.ProdVO;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class ProdController extends BaseController {
	
	@Inject
	ProdService service;
	
	@RequestMapping("/office/asset/prod/prodList.do")
	public String prodList(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("searchDetail") ProdVO searchDetail
			, @ModelAttribute("searchVO") SearchVO searchVO
			, @RequestParam(value="screenSize", required=false, defaultValue="10") int screenSize
			, Model model
		) {
		LOGGER.info("currentPage : {}, searchType: {}, searchWord: {}", currentPage, searchVO.getSearchType(), searchVO.getSearchWord());
		
		searchVO.setSearchAptCode(authMember.getAptCode());
		PagingVO<ProdVO> pagingVO = new PagingVO<ProdVO>(screenSize, 5);
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setSearchVO(searchVO);
		
		int totalRecord = service.prodCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<ProdVO> prodList = service.retrieveProdList(pagingVO);
		pagingVO.setDataList(prodList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "asset/prodList";
	}
	
	@RequestMapping(value="/office/asset/prod/prodList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String prodListAjax(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("searchDetail") ProdVO searchDetail
			, @ModelAttribute("searchVO") SearchVO searchVO
			, @RequestParam(value="screenSize", required=false, defaultValue="10") int screenSize
			, Model model
			) throws ServletException, IOException {
		prodList(authMember, currentPage, searchDetail, searchVO, screenSize, model);
		return "jsonView";
	}
	
//	@RequestMapping("/office/prodList.do")
//	public String prodlist(
//			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
//			, Model model
//		) {
//		List<ProdVO> prodList = service.retrieveProdList(authMember.getAptCode());
//		model.addAttribute("data", prodList);
//		return "jsonView";
//	}
	
	
	@RequestMapping(value="/office/asset/prod/prodInsert.do", method=RequestMethod.POST)
	public String prodCreate(
			@AuthenticationPrincipal(expression="realMember") MemberVO member
			, @Validated(InsertGroup.class) @ModelAttribute("prodList") ProdListVO prodList
			, BindingResult errors
			, Model model 
			) {
		if(!errors.hasErrors()) {
			try {
				for (ProdVO prod : prodList.getProdList()) {
					prod.setAptCode(member.getAptCode());
				}
				service.createProd(prodList.getProdList());
				model.addAttribute("message",OK_MSG);
			}catch (Exception e) {
				model.addAttribute("message",INSERT_SERVER_ERROR_MSG);
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		
		return "jsonView";
	}
	
	@RequestMapping(value="/office/asset/prod/prodView.do", method=RequestMethod.GET)
	public String prodView (
			@RequestParam("prodId") String prodId
			, @AuthenticationPrincipal(expression="realMember") MemberVO member
//			@ModelAttribute("prod") ProdVO prod
			, Model model
		) {
		ProdVO prod = ProdVO.builder().aptCode(member.getAptCode()).prodId(prodId).build();
		prod = service.retrieveProd(prod);
		model.addAttribute("prod", prod);
		return "asset/prodView";
	}
	
	@RequestMapping(value="/office/asset/prod/prodView.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String prodViewAjax (
			@RequestParam("prodId") String prodId
			, @AuthenticationPrincipal(expression="realMember") MemberVO member
//			@ModelAttribute("prod") ProdVO prod
			, Model model
		) {
		prodView(prodId, member, model);
//		prodView(prod, model);
		return "jsonView";
	}
}
