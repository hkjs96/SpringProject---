package kr.or.anyapart.commonsweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.anyapart.vo.LoginVO;


/**
 * index화면에서 관리사무소 로그인 선택했을때 처리하는 controller
 * @author 박정민
 */
@Controller
public class OfficeLoginController {
	
	@RequestMapping("/officeLogin.do")
	public String login() {
		return "/office/loginO";
	}
	
	/**
	 * 로그인 정보 확인 후 관리자사이트로 이동
	 * @author 박정민
	 */
	@RequestMapping(value="/officeLogin.do", method=RequestMethod.POST)
	public String gosite(@ModelAttribute("loginVO") LoginVO loginVO) {
		String goPage="/office/loginO";
		if(loginVO.getMem_id().equals("admin") && loginVO.getMem_pass().equals("admin")) {
			goPage = "forward:/office";
		}
		return goPage;
	}
}
