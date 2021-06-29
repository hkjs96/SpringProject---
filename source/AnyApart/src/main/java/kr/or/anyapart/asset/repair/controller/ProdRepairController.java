/**
 * @author 이경륜
 * @since 2021. 1. 28.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.         이경륜            최초작성
 * 2021. 2. 17.         박지수            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.repair.controller;

import java.util.List;

import javax.inject.Inject;

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

import kr.or.anyapart.asset.repair.service.RepairService;
import kr.or.anyapart.asset.vo.RepairVO;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;



@Controller
public class ProdRepairController extends BaseController{
	
	@Inject
	private RepairService service;
	
	@RequestMapping("/office/asset/repair/repairList.do")
	public String list(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("repair") RepairVO repair
		, @ModelAttribute("searchDetail") RepairVO searchDetail
		, @ModelAttribute("searchVO") SearchVO searchVO
		, @ModelAttribute("pagingVO") PagingVO<RepairVO> pagingVO
		, Model model
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
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(searchDetail);

		int totalRecord = service.countRepair(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<RepairVO> detailList = service.retrieveRepairList(pagingVO);
		pagingVO.setDataList(detailList);

		model.addAttribute("pagingVO", pagingVO);
		return "asset/repairList";
	}
	
	@RequestMapping(value="/office/asset/repair/repairList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String listAjax(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("repair") RepairVO repair
		, @ModelAttribute("searchDetail") RepairVO searchDetail
		, @ModelAttribute("searchVO") SearchVO searchVO
		, @ModelAttribute("pagingVO") PagingVO<RepairVO> pagingVO
		, Model model
	) {
		list(authMember, currentPage, repair, searchDetail, searchVO, pagingVO, model);
		return "jsonView";
	}
	
	
	
	@RequestMapping(value="/office/asset/repair/repairInsert.do", method=RequestMethod.POST)
	public String repairCreate(
			@Validated(InsertGroup.class) @ModelAttribute("repair") RepairVO repair
			, BindingResult errors
			, Model model
	) {
		if(!errors.hasErrors()) {
			try {
				service.createRepair(repair);
				model.addAttribute("message",OK_MSG);
			}catch (Exception e) {
				model.addAttribute("message",INSERT_SERVER_ERROR_MSG);
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		
		return "jsonView";
	}
	
	
	
	@RequestMapping(value="/office/asset/repair/repairUpdate.do", method=RequestMethod.POST)
	public String repairModify(
			@Validated(UpdateGroup.class) @ModelAttribute("repair") RepairVO repair
			, BindingResult errors
			, Model model 
			) {
		if(!errors.hasErrors()) {
			try {
				service.modifyRepair(repair);
				model.addAttribute("message",OK_MSG);
			}catch (Exception e) {
				model.addAttribute("message",INSERT_SERVER_ERROR_MSG);
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		
		return "jsonView";
	}
	
	
	@RequestMapping(value="/office/asset/repair/repairRemove.do", method=RequestMethod.POST)
	public String detailRemove(
			@RequestParam("repairNo") int repairNo
			, @AuthenticationPrincipal(expression="realMember") MemberVO member
//			, BindingResult errors
			, Model model 
			) {
		try {
			RepairVO repair = RepairVO.builder().repairNo(repairNo).member(member).build();
			service.removeRepair(repair);
			model.addAttribute("message", DELETED_MSG);
		}catch (Exception e) {
			model.addAttribute("message",INSERT_SERVER_ERROR_MSG);
			return "asset/buyList";
		}
		return "redirect:/office/asset/buy/buyList.do";
	}
	
}

