/**
 * @author 박지수
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.or.anyapart.apart.service.IApartService;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class ApartRetrieveController {
	
	private static final Logger logger = LoggerFactory.getLogger(ApartRetrieveController.class);
	
	@Inject
	IApartService apartService;
	
	@RequestMapping("/vendor/apartList.do")
	public String RetrieveList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			@ModelAttribute("searchVO") SearchVO searchVO,
			Model model
			) {
		logger.info("currentPage : {}, searchType: {}, searchWord: {}", currentPage, searchVO.getSearchType(), searchVO.getSearchWord());
		PagingVO<ApartVO> pagingVO = new PagingVO<ApartVO>(5,5);
		pagingVO.setSearchVO(searchVO);
		
		int totalRecord = apartService.apartCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<ApartVO> apartList = apartService.retrieveApartList(pagingVO);
		pagingVO.setDataList(apartList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "apart/apartList";
	}
	
	@RequestMapping("/vendor/apartView.do")
	public String Retrieve(
			@RequestParam(value="aptCode", required=false) String aptCode
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("searchVO") SearchVO searchVO
			, Model model
			) {
		
		ApartVO apartVO = apartService.retrieveApart(aptCode);
		
		PagingVO<ApartVO> pagingVO = new PagingVO<ApartVO>(5,5);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCurrentPage(currentPage);
		
		model.addAttribute("apart", apartVO);
		model.addAttribute("pagingVO", pagingVO);
		
		return "apart/apartView";
	}
	
	@RequestMapping("/vendor/houseForm.do")
	public String setHouse(
		@RequestParam("aptCode") String aptCode
		,  Model model
		) {
		model.addAttribute("aptCode", aptCode);
		return "apart/houseForm";
	}
	
	@RequestMapping("/vendor/houseList.do")
	public String houseList(
			@RequestParam("aptCode") String aptCode
			, Model model
			) {
		List<HouseVO> houseList = apartService.retrieveHouse(aptCode);
		model.addAttribute("houseList", houseList);
		return "jsonView";
	}
	
}
