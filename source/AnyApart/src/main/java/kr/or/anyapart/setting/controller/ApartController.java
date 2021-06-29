/**
] * @author 박지수
 * @since 2021. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 06.    박지수           관리사무소에서 조회하고 변경하는 로직 씌우기
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.setting.controller;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.anyapart.apart.service.IApartService;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.setting.service.MemberService;
import kr.or.anyapart.vo.MemberVO;

//@RestController	
@Controller
@RequestMapping("/office/setting")
public class ApartController extends BaseController{
	
	@Inject
	MemberService memberService;
	
	@Inject
	IApartService service;
	
	/*
	 * 아파트 단지 정보, 비밀번호 체크 후 확인 
	 * @return
	 */
	
	@GetMapping("/ApartView.do")
	public String checkPass() {
		return "setting/passForm";
	}
	
	@PostMapping("/ApartView.do")
	public String retrieveApart(
			@AuthenticationPrincipal(expression="realMember") MemberVO member
			, @RequestParam("memPass") String memPass
			,Model model
			) {
		try {
			memberService.checkMemberPassword(member, memPass);
			ApartVO apartVO = service.retrieveApart(member.getAptCode());
			model.addAttribute("apart", apartVO);
			return "setting/apartView";
		}catch (Exception e) {
			model.addAttribute("message", INVALID_PASSWORD_MSG);
			return "setting/passForm";
		}
	}
	
	
	/*
	 * 아파트 단지 정보, 비밀번호 체크 후 변경 폼으로 이동
	 * @return
	 */
	
	@GetMapping("/ApartSetting.do")
	public String checkPass2() {
		return "setting/passForm";
	}
	
	@PostMapping("/ApartSetting.do")
	public String goForm() {
		return "setting/apartSetting";
	}
	
	
	/*
	 * 아파트 정보 변경하기 
	 */
	
	@RequestMapping("/ApartUpdate.do")
	public String updateForm(
			@AuthenticationPrincipal(expression="realMember") MemberVO member
			, Model model
			) {
		ApartVO apartVO = service.retrieveApart(member.getAptCode());
		model.addAttribute("apart", apartVO);
		return "setting/apartUpdateForm";
	}
	
	@RequestMapping(value="/ApartUpdate.do", method=RequestMethod.POST)
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
			return "setting/apartUpdateForm";
		}
//		return "setting/apartView";
		return "redirect:/office/setting/ApartView.do";
	}
	
}
