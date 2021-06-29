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
 * 2021. 3. 01.      박지수       본인확인 
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.controller;

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
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.setting.service.MemberService;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class ApartUpdateController extends BaseController {
	
	@Inject
	MemberService memberService;
	
	@Inject
	IApartService service;
	
	@RequestMapping("/vendor/apartUpdateForm.do")
	public String chkPass() {
		return "apart/passForm";
	}
	
	@RequestMapping(value="/vendor/apartUpdateForm.do", method=RequestMethod.POST)
	public String insert(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @RequestParam("aptCode") String aptCode
		, @RequestParam("memPass") String memPass
		, Model model
		) {
		try {
			memberService.checkMemberPassword(member, memPass);
			ApartVO apartVO = service.retrieveApart(aptCode);
			model.addAttribute("apart", apartVO);
			return "apart/apartUpdateForm";
		}catch (Exception e) {
			model.addAttribute("message", INVALID_PASSWORD_MSG);
			return "apart/passForm";
		}

	}
	
	@RequestMapping(value="/vendor/apartUpdate.do", method=RequestMethod.POST)
	public String update(
		@Validated(UpdateGroup.class) @ModelAttribute("apart") ApartVO apart
		, BindingResult errors
		, Model model 
	) {
		if(!errors.hasErrors()) {
			try {
				service.modifyApart(apart);
			}catch(Exception e){
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				model.addAttribute("apart", apart);
				return "jsonview";
			}
		}else {
			return "apart/apartUpdateForm";
		}
		return "redirect:/vendor/apartView.do?aptCode="+apart.getAptCode();
//		return "apart/passForm";
	}
	
}
