/**
 * @author 이경륜
 * @since 2021. 2. 15.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 15.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.maintenancecost.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@RunWith(SpringJUnit4ClassRunner.class) // 그동안 혼자 동작했던 junit이 spring과 같이 cowork -> meta annotation이 될수없음
@ContextHierarchy({ //@ContextConfiguration은 한번에 하나만 쓸 수 있음 -> 컨텍스트간 계층구조 신경써서 설정해야함
	@ContextConfiguration("file:src/main/resources/kr/or/anyapart/spring/context-*.xml") // WAC가 아닌 AC가 만들어짐 
	,@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
})
@WebAppConfiguration // 이제는 만들어주는 구현체가 WAC로 바뀜
@Transactional// 테스트데이터 집어넣어보고 다시롤백해서 트랜잭션 맞춰라
public class CostOfficeDAOTest {

	@Inject
	CostOfficeDAO costOfficeDAO; // 테스트 스텁
	
	@Test
	public void testselectSelectCostList() {
		PagingVO<CostVO> pagingVO = new PagingVO<CostVO>(10,10);
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchAptCode("A0001");
		
		CostVO searchDetail = new CostVO();
		searchDetail.setCostYear(2021);
		searchDetail.setCostMonth(1);
		pagingVO.setCurrentPage(1);
		
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(searchDetail);
		
		List<CostVO> costList = costOfficeDAO.selectCostList(pagingVO);
		assertNotNull(costList);
	}

}
