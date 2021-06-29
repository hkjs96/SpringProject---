/**
 * @author 이경륜
 * @since 2021. 2. 16.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 16.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.resident.controller;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.resident.vo.ResidentVO;

@RunWith(SpringRunner.class) // SpringJUnit4ClassRunner.class 넣어도됨
@ContextHierarchy({ //@ContextConfiguration은 한번에 하나만 쓸 수 있음 -> 컨텍스트간 계층구조 신경써서 설정해야함
	@ContextConfiguration("file:src/main/resources/kr/or/anyapart/spring/context-*.xml") // WAC가 아닌 AC가 만들어짐 
	,@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
})
@WebAppConfiguration // 이제는 만들어주는 구현체가 WAC로 바뀜
@Transactional// 테스트데이터 집어넣어보고 다시롤백해서 트랜잭션 맞춰라
public class ResidentControllerTest {

	@Inject
	private WebApplicationContext context;
	
	MockMvc mockMvc; // 서버돌리지않는상황에서 서버돌리는것처럼.. 요청이 없으니 디스패처도 안돌고 핸들러매핑 등등 아무것도 안돌아서 가짜로 해주기

	@Before
	public void setUp() throws Exception {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(context).build(); // 가짜환경 셋업 - 다른 컨트롤러도 테스트할 수 는 있으나 클래스명 따라 지키기

		
//		this.mockMvc = MockMvcBuilders.standaloneSetup(new BoardRetrieveController()).build(); // 혹은 하나의 컨트롤러를 특정해서 테스트할 수 있음
	}
	
	@Test
	public void testMoveoutViewResidentVOModel() throws Exception { // 컨트롤러단에서 적극적으로 처리하지않은 예외가 여기까지 넘어와서 junit에서 처리하게됨
		mockMvc.perform(get("/office/resident/moveoutView.do").param("memId", "A0001R00052"))/*가짜 리퀘스트 객체 넣었으니 핸들러가 실행될 것*/
			   .andExpect(model().attributeExists("resident"))
			   .andExpect(view().name("office/resident/ajax/moveoutViewModal"))
			   .andDo(log())/*내부적으로 로깅프레임웤 사용됨*/
			   .andReturn();
	}
	
	
	
//	@Test
//	public void testResident() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveinList() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveinListAjax() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveinInsert() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveinUpdate() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testExcelJXLS() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testDownloadTmpl() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testUploadJXLS() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveoutList() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveoutListAjax() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testCheckOut() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveoutViewReceiptVOPagingVOOfReceiptVOModel() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveoutForm() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testMoveoutFormAjax() {
//		fail("Not yet implemented");
//	}

}
