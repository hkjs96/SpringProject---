/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021.			       박지수      최초 작성
* 2021. 2. 13.      박지수	비밀번호 업데이트 관련 벨리데이션 체크 추가      
* Copyright (c) 2021 by DDIT All right reserved
*/
package kr.or.anyapart.commonsweb.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.xmlbeans.impl.jam.visitor.MVisitor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.anyapart.auth.service.AuthService;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class LoginController extends BaseController{
	
	@Inject
	AuthService service;
	
	@RequestMapping("/login")
	public String loginForm(
		@RequestParam(value="status", required=false) String status
		, Model model
		) {
		if(StringUtils.equals(status, "logout")) {
			model.addAttribute("message", LOGOUT_MSG);
		}
		else if(StringUtils.equals(status, "update")) {
			model.addAttribute("message", UPDATE_PASSWORD_MSG);
		}
		
		return "login/loginForm";
	}
	
	@RequestMapping("/login/findId")
	public String formId() {
		return "login/findId";
	}
	
	@RequestMapping("/login/findPass")
	public String FormPass() {
		return "login/findPassword";
	}
	
	@RequestMapping(value="/login/findId/checkMember", method=RequestMethod.POST)
	public String numEmail(
			@ModelAttribute("member") MemberVO member
			, HttpServletRequest req
			, Model model
			) {
		// 인증번호를 발송했습니다.
		// 인증 번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.출력
		String certNum = service.retrieveMember(member);
		if(StringUtils.isNotBlank(certNum)) {
			req.getSession().setAttribute("certNum", certNum);
		}else {
			LOGGER.debug("인증번호가 생성되지 않음");
		}
		model.addAttribute("message", "인증번호를 발송했습니다.\n인증 번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.");
		return "jsonView";
	}
	
	@RequestMapping(value="/login/findId/checkCert", method=RequestMethod.POST)
	public String certId(
			@ModelAttribute("member") MemberVO member
			, @RequestParam("certNum") String cert
			, Model model
			, HttpServletRequest req
		) {
		String certNum = (String) req.getSession().getAttribute("certNum");
		if(StringUtils.equals(cert, certNum)) {
			member = service.retrieveId(member);
			model.addAttribute("member",member);
			req.getSession().removeAttribute("certNum");
		}else {
			model.addAttribute("message", "틀렸습니다.");
		}
		return "jsonView";
	}

	@RequestMapping(value="/login/findPassword/checkMember", method=RequestMethod.POST)
	public String passEmail(
			@ModelAttribute("member") MemberVO member
			, HttpServletRequest req
			, Model model
			) {
		// 인증번호를 발송했습니다.
		// 인증 번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.출력
		String certNum = service.retrieveMember(member);
		if(StringUtils.isNotBlank(certNum)) {
			req.getSession().setAttribute("certNum", certNum);
		}else {
			LOGGER.debug("인증번호가 생성되지 않음");
		}
		model.addAttribute("message", "인증번호를 발송했습니다.\n인증 번호가 오지 않으면 입력하신 정보가 회원정보와 일치하는지 확인해 주세요.");
		return "jsonView";
	}
	
	@RequestMapping(value="/login/findPassword/checkCert", method=RequestMethod.POST)
	public String certPass(
			@ModelAttribute("member") MemberVO member
			, @RequestParam("certNum") String cert
			, Model model
			, HttpServletRequest req
		) {
		String certNum = (String) req.getSession().getAttribute("certNum");
		if(StringUtils.equals(cert, certNum)) {
			try {
				String memId = URLEncoder.encode(member.getMemId(), "UTF-8");
				LOGGER.info("{}",memId);
				String site = "https://localhost"+req.getContextPath()+"/login/modifyPass?member=";
				site = site+memId; 
				String chk = service.passSite(member, site);
				req.getSession().removeAttribute("certNum");
				model.addAttribute("cert",chk);
			}catch (Exception e) {
				model.addAttribute("message", "메일로 전송되지 않았습니다.");
			}
		}else {
			model.addAttribute("message", "틀렸습니다.");
		}
		return "jsonView";
	}
	
	@RequestMapping("/login/modifyPass")
	public String passForm(
			@RequestParam("member") String memId
			, Model model
			) {
		try {
			memId = URLDecoder.decode(memId, "UTF-8");
			model.addAttribute("memId", memId);
		}catch (UnsupportedEncodingException e) {
			LOGGER.debug("디코딩 실패");
		}
		return "login/passForm";
	}
	
	@RequestMapping(value="/login/modifyPass", method=RequestMethod.POST)
	public String modifyPass(
			@RequestParam("memId") String memId
			, @RequestParam("memPass") String memPass
			, Model model
		) {
		try {
			MemberVO member = new MemberVO();
			member.setMemId(memId);
			member.setMemPass(memPass);
			service.modifyPass(member);
		}catch (Exception e) {
			model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
		}
		return "jsonView";
	}
	
}
