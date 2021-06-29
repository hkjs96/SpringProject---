/**
 * @author 박지수
 * @since 2021. 2. 18.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 18.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commonsweb.controller;

import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers. *;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.AuthenticatedMatcher;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
//@RunWith(SpringJUnit4ClassRunner.class)
@ContextHierarchy({ //@ContextConfiguration은 한번에 하나만 쓸 수 있음 -> 컨텍스트간 계층구조 신경써서 설정해야함
	@ContextConfiguration("file:src/main/resources/kr/or/anyapart/spring/context-*.xml") // WAC가 아닌 AC가 만들어짐 
	,@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
})
@WebAppConfiguration // 이제는 만들어주는 구현체가 WAC로 바뀜
@Transactional// 테스트데이터 집어넣어보고 다시롤백해서 트랜잭션 맞춰라
public class LoginControllerTest {

	@Inject
	private WebApplicationContext context;
	
	@Inject
	DaoAuthenticationProvider daoAuthenticationProvider;
	
	MockMvc mockMvc;
	
	@Before
	public void setUp() throws Exception {
		this.mockMvc = MockMvcBuilders
				.webAppContextSetup(context)
				.apply(springSecurity())	
				.build(); 
		
		
//		MemberVO member = MemberVO.builder()
//				.memId("A0001E007")
//				.memRole("ROLD_HEAD")
//				.memNick("이소장")
//				.memPass("aA123")
//				.build();
//		MemberWrapper principal = new MemberWrapper(member);
		
//		this.authentication = SecurityContextHolder.getContext().setAuthentication(this.authentication.getPrincipal());
	}
	/**
	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#loginForm()}.
	 */
	@Test
	public void testLoginForm() throws Exception {
		MultiValueMap<String, String> info = new LinkedMultiValueMap<>();
		
		info.add("username", "A0001E007");
//		info.add("username", "A00111E007");
		info.add("password", "aA123");
		
		mockMvc.perform(get("/login/loginProcess.do")
					.params(info)
				)
				.andExpect(authenticated (). withRoles("ROLE_HEAD"))
//				.andExpect(status().isOk())
//				.andExpect(view().name("redirect:/login"))
//				.andExpect(view().name("office"))
//				.andExpect(model().)
//				.andExpect(view().name("vendor"))
//				.andExpect(view().name("resident"))
//				.andExpect(redirectedUrl("/login"))
//				.andExpect(view().name("indexO"))
				.andDo(log())/*내부적으로 로깅프레임웤 사용됨*/
				.andReturn();
		
		
	}

//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#formId()}.
//	 */
//	@Test
//	public void testFormId() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#FormPass()}.
//	 */
//	@Test
//	public void testFormPass() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#numEmail(kr.or.anyapart.vo.MemberVO, javax.servlet.http.HttpServletRequest)}.
//	 */
//	@Test
//	public void testNumEmail() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#certId(kr.or.anyapart.vo.MemberVO, java.lang.String, org.springframework.ui.Model, javax.servlet.http.HttpServletRequest)}.
//	 */
//	@Test
//	public void testCertId() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#passEmail(kr.or.anyapart.vo.MemberVO, javax.servlet.http.HttpServletRequest)}.
//	 */
//	@Test
//	public void testPassEmail() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#certPass(kr.or.anyapart.vo.MemberVO, java.lang.String, org.springframework.ui.Model, javax.servlet.http.HttpServletRequest)}.
//	 */
//	@Test
//	public void testCertPass() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#passForm(java.lang.String, org.springframework.ui.Model)}.
//	 */
//	@Test
//	public void testPassForm() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.LoginController#modifyPass(java.lang.String, java.lang.String, org.springframework.ui.Model)}.
//	 */
//	@Test
//	public void testModifyPass() {
//		fail("Not yet implemented");
//	}

}
