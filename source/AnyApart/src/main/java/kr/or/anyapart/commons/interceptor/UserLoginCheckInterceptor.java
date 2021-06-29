/**
 * @author 박지수
 * @since 2021. 2. 2.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 2.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commons.interceptor;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.or.anyapart.auth.dao.IAuthDAO;
import kr.or.anyapart.vo.MemberVO;

public class UserLoginCheckInterceptor extends HandlerInterceptorAdapter {
	@Inject
//	IMemberService service;
	IAuthDAO dao;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UserLoginCheckInterceptor.class);
	
	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.handler.HandlerInterceptorAdapter#preHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object)
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("member");
		
		if (memberVO == null) {
	         response.sendRedirect(request.getContextPath() + "/login");
	         return false;
	      } else {
	         memberVO = dao.authMember(memberVO.getMemId());
	         request.getSession().setAttribute("member", memberVO);
	         LOGGER.debug(memberVO.getMemId() + "사용자가 로그인 되어있음");
	      }
		
		
		return super.preHandle(request, response, handler);
	}
}
