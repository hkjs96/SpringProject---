package kr.or.anyapart.commonsweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.anyapart.vo.LoginVO;

@Controller
public class ResidentLoginController {
	@RequestMapping("/residentLogin.do")
	public String login() {
		return "/resident/loginR";
	}
	
	/**
	 * @author 박정민
	 * 로그인 정보 확인 후 입주민사이트로 이동
	 */
	@RequestMapping(value="/residentLogin.do", method=RequestMethod.POST)
	public String gosite(@ModelAttribute("loginVO") LoginVO loginVO) {
		String goPage="/resident/loginR";
		if(loginVO.getMem_id().equals("admin") && loginVO.getMem_pass().equals("admin")) {
			goPage = "forward:/resident";
		}
		return goPage;
	}
}
