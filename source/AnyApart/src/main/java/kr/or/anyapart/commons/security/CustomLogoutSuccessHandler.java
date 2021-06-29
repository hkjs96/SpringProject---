/**
 * @author 박지수
 * @since 2021. 3. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 3. 10.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commons.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.commonsweb.controller.BaseController;

public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	/* 
	 * [ 로그아웃 성공 이벤트 ]
	 */
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		HttpSession session = request.getSession();
		String passUpdate = (String) session.getAttribute("passUpdate");
		session.invalidate();
		String location = request.getContextPath()+"/login?status=logout";
		if(StringUtils.equals(passUpdate, "OK")) {
			location = request.getContextPath()+"/login?status=update";
		}
		response.sendRedirect(location);
	}

}
