/**
 * @author 이경륜
 * @since 2021. 3. 2.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 3. 2.         이경륜            최초작성
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

import kr.or.anyapart.commonsweb.dao.RequestLogDAO;
import kr.or.anyapart.vo.RequestLogVO;

public class RequestLogCollectInterceptor extends HandlerInterceptorAdapter  {
	
	@Inject
	RequestLogDAO dao;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RequestLogCollectInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String requestURI = request.getRequestURI();			// /AnyApart/office/resident/...
		String cPath = request.getContextPath();				// /AnyApart
		String reqUrl = requestURI.substring(cPath.length());	// /office/...
		int idx = reqUrl.indexOf("/", 1); 						// 2번째 /
		String reqUser, reqUrlWithoutUser;
		if(idx < 0) { // 인덱스페이지일 경우
			reqUser = reqUrl.replace("/", "").toUpperCase();
			reqUrlWithoutUser = "/";
		}else { // 일반 페이지
			reqUser = reqUrl.substring(1,idx).toUpperCase();	// OFFICE
			reqUrlWithoutUser = reqUrl.substring(idx);		// /resident/moveinList.do
		}
		
		RequestLogVO requestLogVO = RequestLogVO.builder().reqUser(reqUser).reqUrl(reqUrlWithoutUser).build();
		
		dao.insertRequestLog(requestLogVO);
		
		return super.preHandle(request, response, handler);
	}
}
