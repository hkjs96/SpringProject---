/**
 * @author 이미정
 * @since 2021. 2. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 10.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.employee.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface OffDAO {
	public List<OffVO> selectOffList(PagingVO<OffVO> pagingVO);

	public int selectOffCount(PagingVO<OffVO> pagingVO);

	public List<OffVO> selectOffOption();

	public int insertOff(OffVO offVO);
	
	public OffVO selectOff(OffVO offVO);
	
	public int updateOff(OffVO offVO);
	
	public int deleteOff(OffVO offVO);

	public String selectNowOff(OffVO off);

	public int updateEmpOff(OffVO offVO);

	public void updateOffAfterDel(OffVO off);

	public int deleteOff(EmployeeVO employee);

	public void updateOffAfterDel(EmployeeVO employee);
}
