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

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.setting.service.MemberService;
import kr.or.anyapart.vo.MemberVO;

@Controller
@RequestMapping("/resident/mypage")
public class ResidentMypageController extends BaseController{
	
	@Inject
	private MemberService service;
	
	
	@RequestMapping("/view.do")
	public String view(
		@AuthenticationPrincipal(expression="realMember") MemberVO member
		, @RequestParam(value="message", required=false) String message
		, Model model
		) {
		
		ResidentVO resident= service.retrieveResident(member);
		
		model.addAttribute("member", member);
		model.addAttribute("resident", resident);
		if(message != null) {
			model.addAttribute("message", message);
		}
	
		return "mypage/mypageView";
	}

}
