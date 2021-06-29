/**
 * @author 박지수
 * @since 2021. 2. 17.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 17.      박지수       구매/사용 내역 조회 테스트
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.buy.controller;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.asset.vo.ProdDetailVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.MemberWrapper;
import kr.or.anyapart.vo.SearchVO;

//@RunWith(SpringRunner.class)
@RunWith(SpringJUnit4ClassRunner.class)
@ContextHierarchy({ //@ContextConfiguration은 한번에 하나만 쓸 수 있음 -> 컨텍스트간 계층구조 신경써서 설정해야함
	@ContextConfiguration("file:src/main/resources/kr/or/anyapart/spring/context-*.xml") // WAC가 아닌 AC가 만들어짐 
	,@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
})
@WebAppConfiguration // 이제는 만들어주는 구현체가 WAC로 바뀜
@Transactional// 테스트데이터 집어넣어보고 다시롤백해서 트랜잭션 맞춰라
public class BuyControllerTest {

	@Inject
	private WebApplicationContext context;
	
	MockMvc mockMvc; // 서버돌리지않는상황에서 서버돌리는것처럼.. 요청이 없으니 디스패처도 안돌고 핸들러매핑 등등 아무것도 안돌아서 가짜로 해주기
	
	Authentication authentication;
	
	@Before
	public void setUp() throws Exception {
		this.mockMvc = MockMvcBuilders
				.webAppContextSetup(context)
				.apply(springSecurity())	// 가짜로 스프링 시큐리티를 사용할 수 있게 해준다.
						// "springSecurityFilterChain" as a Filter. 필터에 스프링 필터를 가짜로 넣어줌
				.build(); // 가짜환경 셋업 - 다른 컨트롤러도 테스트할 수 는 있으나 클래스명 따라 지키기
		
//		MemberVO member = MemberVO.builder()
//				.memId("A0001E007")
//				.memRole("ROLD_HEAD")
//				.memNick("이소장")
//				.memPass("aA123")
//				.build();
//		MemberWrapper principal = new MemberWrapper(member);
		
//		this.authentication = SecurityContextHolder.getContext().setAuthentication(this.authentication.getPrincipal());
	}
	
	@After
	public void cleanup() {
		SecurityContextHolder.clearContext();
	}
	
	/**
	 * Test method for {@link kr.or.anyapart.asset.buy.controller.BuyController#list(kr.or.anyapart.vo.MemberVO, int, kr.or.anyapart.asset.vo.ProdDetailVO, kr.or.anyapart.vo.SearchVO, org.springframework.ui.Model)}.
	 */
	@Test
	@WithMockUser
//	@WithMockUser (roles = "ROLE_HEAD")
//	@WithMockUser (authorities = "ROLE_HEAD")
	public void testList() throws Exception {
		
		MemberVO member = MemberVO.builder()
				.memId("A0001E007")
				.memRole("ROLE_HEAD")
				.memNick("이소장")
				.memPass("aA123")
				.build();
		UserDetails userDetails = new MemberWrapper(member);
		
		String currentPage = "1";
		ProdDetailVO searchDetail = ProdDetailVO.builder().build();
		SearchVO searchVO = new SearchVO();
		
//		디테일 이린거도하나하나 만들어 줘야하나> ㅠ
		Map<String, Object> init = new HashMap<>();
		init.put("searchDetail", searchDetail);
		init.put("searchVO", searchVO);
		
		mockMvc.perform(get("/office/asset/buy/buyList.do")
					.param("page",currentPage)
					.requestAttr("searchDetail", searchDetail)
					.requestAttr("searchVO", searchVO)
//					.with(user( "admin" ).password( "pass" ).roles ( "USER" , "ADMIN" ))
					.with(user(userDetails))
					)
				.andExpect(model().attributeExists("searchDetail"))
				.andExpect(model().attributeExists("searchVO"))
				.andExpect(view().name("asset/buyList"))
				.andDo(log())/*내부적으로 로깅프레임웤 사용됨*/
				.andReturn();
	}

//	/**
//	 * Test method for {@link kr.or.anyapart.asset.buy.controller.BuyController#prodCreate(kr.or.anyapart.asset.vo.ProdDetailListVO, org.springframework.validation.BindingResult, org.springframework.ui.Model)}.
//	 */
//	@Test
//	public void testProdCreate() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.asset.buy.controller.BuyController#prodModify(kr.or.anyapart.asset.vo.ProdDetailVO, org.springframework.validation.BindingResult, org.springframework.ui.Model)}.
//	 */
//	@Test
//	public void testProdModify() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.BaseController#setAptCode(kr.or.anyapart.vo.MemberVO, kr.or.anyapart.vo.SearchVO)}.
//	 */
//	@Test
//	public void testSetAptCode() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.BaseController#getAptCode(kr.or.anyapart.vo.MemberVO)}.
//	 */
//	@Test
//	public void testGetAptCode() {
//		fail("Not yet implemented");
//	}
//
//	/**
//	 * Test method for {@link kr.or.anyapart.commonsweb.controller.BaseController#getCustomNoty(java.lang.String)}.
//	 */
//	@Test
//	public void testGetCustomNoty() {
//		fail("Not yet implemented");
//	}

}
