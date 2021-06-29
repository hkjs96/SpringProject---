/**
 * @author 박지수
 * @since 2021.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 			     박지수       최초작성
 * 2021. 2. 18.      박지수       비밀번호 변경시 정규식 체크하기
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.setting.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.setting.service.MemberService;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class PassUpdateController extends BaseController{
	
	@Inject
	private MemberService service;
	
	
	@RequestMapping("/office/setting/passUpdate.do")
	public String form() {
		return "setting/passSetting";
	}

	@RequestMapping(value="/office/setting/passUpdate.do", method=RequestMethod.POST)
	public String updatePass(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @Validated(UpdateGroup.class) @ModelAttribute("member") MemberVO member , BindingResult errors
			, @RequestParam("currentPass") String currentPass
			, Model model
		) {
		String goPage = "setting/passSetting";
		if(!errors.hasErrors()) {
			try {
				String updatePass = member.getMemPass();
				member.setMemPass(currentPass);
				service.modifyMember(member, updatePass);
	//			String pass = (String) SecurityContextHolder.getContext().getAuthentication().getCredentials();
	//			LOGGER.debug("변경된 녀석은 이것이다 >> {}", pass);
				goPage = "indexO";
			}catch (Exception e) {
				model.addAttribute("message", FAILED_UPDATE_PASSWORD_MSG + " 관리자에게 문의하세요.");
			}
		}else {
			model.addAttribute("message", FAILED_UPDATE_PASSWORD_MSG);
		}
		return goPage;
	}
	
	@RequestMapping(value="/resident/mypage/passUpdate.do", method=RequestMethod.POST)
	public String updateResPass(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @Validated(UpdateGroup.class) @ModelAttribute("member") MemberVO member , BindingResult errors
			, @RequestParam("currentPass") String currentPass
			, RedirectAttributes redirectAttributes
			, HttpServletRequest request
		) {
		String goPage = "redirect:/resident/mypage/view.do";

		if(!errors.hasErrors()) {
			try {
				String updatePass = member.getMemPass();
				member.setMemPass(currentPass);
				service.modifyMember(member, updatePass);
				HttpSession session = request.getSession();
				session.setAttribute("passUpdate", "OK");
//				redirectAttributes.addFlashAttribute("message", OK_MSG);
				goPage = "redirect:/login/logout.do";
			}catch (Exception e) {
				redirectAttributes.addFlashAttribute("message", FAILED_UPDATE_PASSWORD_MSG + " 관리자에게 문의하세요.");
			}
		}else {
			redirectAttributes.addFlashAttribute("message", FAILED_UPDATE_PASSWORD_MSG);
		}
		return goPage;
	}
}
