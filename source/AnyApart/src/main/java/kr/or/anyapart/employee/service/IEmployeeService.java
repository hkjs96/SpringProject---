/**
 * @author 이미정
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 1.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.employee.service;

import java.util.List;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.LicenseVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

public interface IEmployeeService {

	public List<EmployeeVO> retrieveEmployeeList(PagingVO<EmployeeVO> pagingVO);
	
	public List<EmployeeVO> retrievePayInfoList(PagingVO<EmployeeVO> pagingVO);

	public int retrieveEmployeeCount(PagingVO<EmployeeVO> pagingVO);
	
	public EmployeeVO retrieveEmployee(EmployeeVO employeeVO);
	
	public EmployeeVO getEmployeeMaxId(String aptCode);
	
	public ServiceResult createEmployee(MemberVO memberVO, EmployeeVO employeeVO);
	
	public ServiceResult removeEmployee(EmployeeVO employeeVO);
	
	public ServiceResult modifyEmployee(EmployeeVO employeeVO, MemberVO memberVO);

	public ServiceResult removeEmployeeCancel(EmployeeVO employee);

	public int retrieveEmployeeChangeCount(PagingVO<EmployeeVO> pagingVO);

	public List<EmployeeVO> retrieveEmployeeChangeList(PagingVO<EmployeeVO> pagingVO);

	public LicenseVO retrieveLicenseImage(LicenseVO licEmp);


}
