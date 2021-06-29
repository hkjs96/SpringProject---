/**
 * @author 작성자명
 * @since 2021. 1. 30.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 30.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.auth.service;

import javax.inject.Inject;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.anyapart.auth.dao.IAuthDAO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.MemberWrapper;

@Service("customUserService")
public class AuthenticateServiceImpl implements UserDetailsService {

	@Inject
	private IAuthDAO dao;
	@Inject
	private MessageSourceAccessor accessor;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO member = dao.authMember(username);
		
		if(member==null) {
			String message = accessor.getMessage("DigestAuthenticationFilter.usernameNotFound", new Object[] {username});
			throw new UsernameNotFoundException(message);
		}
		
		return new MemberWrapper(member);
	}

}
