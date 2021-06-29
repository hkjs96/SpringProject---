package kr.or.anyapart.commonsweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.anyapart.vo.LoginVO;

@Controller
public class VendorLoginController {
	@RequestMapping("/vendorLogin.do")
	public String login() {
		return "/vendor/loginV";
	}
	
	/**
	 * @author 박정민
	 * 로그인 정보 확인 후 벤더사이트로 이동
	 */
	@RequestMapping(value="/vendorLogin.do", method=RequestMethod.POST)
	public String gosite(@ModelAttribute("loginVO") LoginVO loginVO) {
		String goPage="/vendor/loginV";
		if(loginVO.getMem_id().equals("admin") && loginVO.getMem_pass().equals("admin")) {
			goPage = "forward:/vendor";
		}
		return goPage;
	}
}
