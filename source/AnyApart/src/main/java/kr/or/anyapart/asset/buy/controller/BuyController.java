/**
 * @author 박지수
 * @since 2021. 2. 16.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 16.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.buy.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.asset.buy.service.ProdDetailService;
import kr.or.anyapart.asset.vo.ProdDetailListVO;
import kr.or.anyapart.asset.vo.ProdDetailVO;
import kr.or.anyapart.asset.vo.ProdListVO;
import kr.or.anyapart.asset.vo.ProdVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class BuyController extends BaseController {
	
	@Inject
	private ProdDetailService service;
	
	@RequestMapping("/office/asset/buy/buyList.do")
	public String list(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("searchDetail") ProdDetailVO searchDetail
			, @ModelAttribute("searchVO") SearchVO searchVO
			, @RequestParam(value="screenSize", required=false, defaultValue="10") int screenSize
			, Model model
			, RedirectAttributes redirectAttributes
		) {
		LOGGER.info("currentPage : {}, searchType: {}, searchWord: {}", currentPage, searchVO.getSearchType(), searchVO.getSearchWord());
		
		try {
			searchDetail.checkDay();
		}catch (Exception e) {
			searchDetail.setStartDay("");
			searchDetail.setEndDay("");
			LOGGER.debug("날짜별 데이터 조회 실패");
		}
		searchVO.setSearchAptCode(authMember.getAptCode());
		PagingVO<ProdDetailVO> pagingVO = new PagingVO<ProdDetailVO>(screenSize, 5);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(searchDetail);

		int totalRecord = service.countDetail(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<ProdDetailVO> detailList = service.retrieveDetailList(pagingVO);
		pagingVO.setDataList(detailList);

		if(redirectAttributes.getFlashAttributes() != null) {
			Map<String, String> redirectAttributesMap = (Map<String, String>) redirectAttributes.getFlashAttributes();
			model.addAttribute("message", redirectAttributesMap.get("massage"));
		}
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "asset/buyList";
	}
	
	@RequestMapping(value="/office/asset/buy/buyInsert.do", method=RequestMethod.POST)
	public String prodCreate(
			@Validated(InsertGroup.class) @ModelAttribute("detailList") ProdDetailListVO detailList
			, BindingResult errors
			, Model model 
			) {
		if(!errors.hasErrors()) {
			try {
				service.createDetail(detailList.getDetailList());
				model.addAttribute("check", "OK");
			}catch (Exception e) {
				model.addAttribute("message",INSERT_SERVER_ERROR_MSG);
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		
		return "jsonView";
	}
	
	@RequestMapping(value="/office/asset/buy/buyUpdate.do", method=RequestMethod.POST)
	public String prodModify(
			@ModelAttribute("prodDetail") ProdDetailVO prodDetail
			, BindingResult errors
			, Model model 
			) {
		if(!errors.hasErrors()) {
			try {
				service.modifyDetail(prodDetail);
				model.addAttribute("message",OK_MSG);
			}catch (Exception e) {
				model.addAttribute("message",INSERT_SERVER_ERROR_MSG);
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		
		return "jsonView";
	}
	
	@RequestMapping(value="/office/asset/buy/buyRemove.do", method=RequestMethod.POST)
	public String detailRemove(
//			@ModelAttribute("prodDetail") ProdDetailVO prodDetail
			@RequestParam("ioNo") int ioNo
//			, BindingResult errors
			, Model model
			, RedirectAttributes redirectAttributes
			) {
		try {
			service.removeDetail(ioNo);
			redirectAttributes.addFlashAttribute("message", DELETED_MSG);
		}catch (Exception e) {
			model.addAttribute("message",INSERT_SERVER_ERROR_MSG);
			return "asset/buyList";
		}
		return "redirect:/office/asset/buy/buyList.do";
	}
}
