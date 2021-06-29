/**
 * @author 박지수
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 29.      박지수       최초작성
 * 2021. 2. 08.      박지수       하드코딩으로 비교한 것을 Collection의 contains 메서드를 이용하도록 변경 (SimpleGrantedAuthority)
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.commons.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.web.util.WebUtils;

import kr.or.anyapart.auth.dao.IAuthDAO;
import kr.or.anyapart.vo.MemberVO;

public class CustomAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	
	/*
		회원을 한번 조회해서 가져온다.
	*/
	@Inject
	private IAuthDAO dao;
	
	
	@Override
	protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
//		String saveId = request.getParameter("saveId");
		String mem_id = authentication.getName();
		
//		Cookie idCookie = new Cookie("idCookie", mem_id);
//		idCookie.setPath(request.getContextPath());
//		int maxAge = 0;
//		if(StringUtils.isNotBlank(saveId)) {
//			maxAge = 60*60*24*7;
//		}
//		idCookie.setMaxAge(maxAge);
//		response.addCookie(idCookie);
		
		/*
			MEMBERVO 객체를 들고다니는 세션을 하나 만든다.
			쿠키는 쓰지 않는다.
		 */
		MemberVO memberVO = dao.authMember(mem_id);
		
		WebUtils.setSessionAttribute(request, "memId", memberVO.getMemId());
//		request.getSession().setAttribute("member", memberVO);
		
		// 차후 보완 요소 ID 저장에 사용할 것임 담아지기는 하는데 loginForm에서 어떻게 처리해야하나 고민좀
		String tmp = (String) WebUtils.getSessionAttribute(request, "memId");
		
		/*
			이 부분도 접속하려는 페이지로 다시 돌아가게 해줘야한다.
		*/
		
		if(authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_RES"))) {
			setDefaultTargetUrl("/resident");
		}else if(authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			setDefaultTargetUrl("/vendor");
		}else {
			setDefaultTargetUrl("/office");
		}
		
		// 이 권한 관련된 부분 수정해야함. 지금은 그냥 이상한 코딩이 되어 버림. (수정됨)
//		String memRole = authentication.getAuthorities().toString().replace("[", "").replace("]", "");
//		if("ROLE_RES".equals(memRole)) {
//			setDefaultTargetUrl("/resident");
//		}else if("ROLE_ADMIN".equals(memRole)) {
//			setDefaultTargetUrl("/vendor");
//		}else {
//			setDefaultTargetUrl("/office");
//		}
		
		super.handle(request, response, authentication);
	}
}





















