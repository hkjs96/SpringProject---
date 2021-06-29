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

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.anyapart.apart.service.IApartService;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.setting.service.MemberService;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class ApartInsertController extends BaseController{

	@Inject
	MemberService memberService;
	
	@Inject
	IApartService service;
	
	@RequestMapping("/vendor/apartForm.do")
	public String chkPass() {
		return "apart/passForm";
	}
	
	@RequestMapping(value="/vendor/apartForm.do", method=RequestMethod.POST)
	public String Form(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @RequestParam("memPass") String memPass
		, Model model	
		) {
		try {
			memberService.checkMemberPassword(member, memPass);
		}catch (Exception e) {
			model.addAttribute("message", INVALID_PASSWORD_MSG);
			return "apart/passForm";
		}
		return "apart/apartForm";
	}
	
	@RequestMapping(value="/vendor/apartInsert.do", method=RequestMethod.POST)
	public String insert(
			@Validated(InsertGroup.class) @ModelAttribute("apart") ApartVO apart
			, BindingResult errors
			, Model model
			) {
		String goPage = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createApart(apart);
			switch (result) {
			case OK:
//				goPage = "redirect:/vendor/apartList.do";
//				model.addAttribute("apart", apart);
				goPage = "redirect:/vendor/houseForm.do?aptCode="+apart.getAptCode();
				break;
			default :
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				goPage = "apart/apartForm";
				break;
			}
		}else {
			goPage = "apart/apartForm";
		}
		return goPage;
	}
	
	@RequestMapping(value="/vendor/houseInsert.do", method=RequestMethod.POST)
	public String insertHouse(
			@Validated(InsertGroup.class) @ModelAttribute("house") HouseVO house
			
			, Model model
			) {
		
		String goPage = "apart/houseForm";
		
		ServiceResult result = service.createHouse(house);
		switch(result) {
		case OK:
			List<HouseVO> houseList = service.retrieveHouse(house.getAptCode());
			model.addAttribute("houseList", houseList);
			goPage = "jsonView"; 
		default:
			model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
		}
		
		return goPage;
	}
	
}
