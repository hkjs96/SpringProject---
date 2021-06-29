/**
 * @author 이미정
 * @since 2021. 2. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 3.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.employee.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.LicenseVO;

@Repository
public interface LicenseDAO {
	public int insertLicenses(EmployeeVO employeeVO);
	public int deleteLicenses(EmployeeVO employeeVO);
	public LicenseVO selectLicense(LicenseVO licAlba);
	public int selectMaxLicenseNo();
	public int deleteAllLicense(EmployeeVO employeeVO);
	public List<LicenseVO> selectEmpLicenseList(EmployeeVO employeeVO);
	public LicenseVO selectLicenseImage(LicenseVO licEmp);
}