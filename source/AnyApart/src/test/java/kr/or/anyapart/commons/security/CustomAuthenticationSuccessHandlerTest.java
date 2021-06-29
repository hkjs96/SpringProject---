/**
 * @author 박지수
 * @since 2021. 2. 18.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          박지수               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 18.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commons.security;

import static org.junit.Assert.assertTrue;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.auth.dao.IAuthDAO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.MemberWrapper;

@RunWith(SpringRunner.class)
@ContextHierarchy({ //@ContextConfiguration은 한번에 하나만 쓸 수 있음 -> 컨텍스트간 계층구조 신경써서 설정해야함
	@ContextConfiguration("file:src/main/resources/kr/or/anyapart/spring/context-*.xml") // WAC가 아닌 AC가 만들어짐 
	,@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
})
@WebAppConfiguration // 이제는 만들어주는 구현체가 WAC로 바뀜
@Transactional// 테스트데이터 집어넣어보고 다시롤백해서 트랜잭션 맞춰라
public class CustomAuthenticationSuccessHandlerTest {

	@Inject
	private IAuthDAO dao;
	
	@Inject
	private WebApplicationContext context;
	
	MockMvc mockMvc;
	
	@Before
	public void setUp() throws Exception {
		this.mockMvc = MockMvcBuilders
				.webAppContextSetup(context)
				.apply(springSecurity())	
				.build(); 
	}
	
	
	/**
	 * Test method for {@link kr.or.anyapart.commons.security.CustomAuthenticationSuccessHandler#handle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.springframework.security.core.Authentication)}.
	 */
	@Test
	public void testHandleHttpServletRequestHttpServletResponseAuthentication() throws Exception{
		MemberVO member = MemberVO.builder()
				.memId("A0001E007")
				.memRole("ROLD_HEAD")
				.memNick("이소장")
				.memPass("aA123")
				.build();
//		MemberWrapper principal = new MemberWrapper(member);
		
		Authentication authentication = new UsernamePasswordAuthenticationToken(member.getMemId(), member.getMemPass());
		
		MemberVO memberVO = dao.authMember(member.getMemId());
		
		if(authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_RES"))) {
			assertTrue("입주민",false);
//			setDefaultTargetUrl("/resident");
		}else if(authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			assertTrue("벤더",false);
//			setDefaultTargetUrl("/vendor");
		}else {
			assertTrue("관리사무소",true);
//			setDefaultTargetUrl("/office");
		}
	}

}
