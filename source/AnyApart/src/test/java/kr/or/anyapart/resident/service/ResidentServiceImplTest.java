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

package kr.or.anyapart.resident.service;

import static org.junit.Assert.*;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.resident.vo.ResidentVO;

@RunWith(SpringJUnit4ClassRunner.class) // 그동안 혼자 동작했던 junit이 spring과 같이 cowork -> meta annotation이 될수없음
@ContextHierarchy({ //@ContextConfiguration은 한번에 하나만 쓸 수 있음 -> 컨텍스트간 계층구조 신경써서 설정해야함
	@ContextConfiguration("file:src/main/resources/kr/or/anyapart/spring/context-*.xml") // WAC가 아닌 AC가 만들어짐 
	,@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
})
@WebAppConfiguration // 이제는 만들어주는 구현체가 WAC로 바뀜
@Transactional// 테스트데이터 집어넣어보고 다시롤백해서 트랜잭션 맞춰라
public class ResidentServiceImplTest {

	@Inject
	ResidentService service;
	
	@Test
	public void testRetrieveResidentByHouseCode() {
		ResidentVO residentParam = ResidentVO.builder().houseCode("A0001D1401H0501").build();
		ResidentVO residentResult = service.retrieveResidentByHouseCode(residentParam);
		assertNotNull(residentResult);
	}
	
	
//	@Test
//	public void testRetrieveResidentCount() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testRetrieveResidentList() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testRetrieveDongList() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testRetrieveHoList() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testCreateResident() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testModifyResident() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testCreateMuitlpleResident() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testRetrieveMoveoutResidentCount() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testRetrieveMoveoutResidentList() {
//		fail("Not yet implemented");
//	}
//
//	@Test
//	public void testRetrieveMoveoutResident() {
//		fail("Not yet implemented");
//	}



}
