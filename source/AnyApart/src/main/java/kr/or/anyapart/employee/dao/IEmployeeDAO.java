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
package kr.or.anyapart.employee.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.LicenseVO;
import kr.or.anyapart.employee.vo.PositionVO;
import kr.or.anyapart.payment.vo.PaymentVO;
import kr.or.anyapart.vo.BankCodeVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IEmployeeDAO {
	
	/**
	 * 관리사무소 직원 기본인사정보 리스트 조회
	 * @param pagingVO
	 * @return
	 */
	public List<EmployeeVO> selectEmployeeInfoList(PagingVO<EmployeeVO> pagingVO);

	/**
	 * 관리사무소 직원 급여기본정보 리스트 조회
	 * @param pagingVO
	 * @return
	 */
	public List<EmployeeVO> selectPayInfoList(PagingVO<EmployeeVO> pagingVO);
	
	/**
	 * 페이징 처리 카운터 수
	 * @param pagingVO
	 * @return
	 */
	public int selectEmployeeInfoCount(PagingVO<EmployeeVO> pagingVO);

	/**
	 * 관리사무소 직원 상세조회
	 * @param employeeVO
	 * @return
	 */
	public EmployeeVO selectEmployeeInfo(EmployeeVO employeeVO);
	
	/**
	 * MEMBER 테이블에 관리사무소 직원 정보 등록
	 * @param memberVO
	 * @return
	 */
	public int insertEmpWebInfo(MemberVO memberVO);
	
	/**
	 * EMPLOYEE 테이블에 관리사무소 직원 정보 등록
	 * @param employeeVO
	 * @return
	 */
	public int insertEmpOfficeInfo(EmployeeVO employeeVO);
	
	/**
	 * 관리사무소 직원 등록시 아이디 생성
	 * @param aptCode
	 * @return
	 */
	public EmployeeVO getEmployeeMaxId(String aptCode);
	
	/**
	 * MEMBER 테이블에 있는 관리사무소 직원 정보 수정
	 * @param memberVO
	 * @return
	 */
	public int updateEmployeeMemInfo(MemberVO memberVO);

	/**
	 * EMPLOYEE 테이블에 있는 관리사무소 직원 정보 수정
	 * @param employeeVO
	 * @return
	 */
	public int updateEmployeeEmpInfo(EmployeeVO employeeVO);
	
	/**
	 * 관리사무소 직원 퇴사 처리
	 * @param employeeVO
	 * @return
	 */
	public int deleteEmployee(EmployeeVO employeeVO);
	
	/**
	 * 관리사무소 직원 퇴사 처리 취소(재직상태로 변경)
	 * @param employee
	 * @return
	 */
	public int removeEmployeeCancel(EmployeeVO employee);

	/**
	 * 자격증 리스트 조회
	 * @return
	 */
	public List<LicenseVO> selectLicenseList();
	
	/**
	 * 직책 분류 리스트 조회
	 * @return
	 */
	public List<PositionVO> selectPositionList();
	
	/**
	 * 사용자분류 리스트 조회
	 * @return
	 */
	public List<CodeVO> selectRoleList();
	
	/**
	 * 은행 리스트 조회
	 * @return
	 */
	public List<BankCodeVO> selectBankList();

	/**
	 * 관리사무소 입퇴사자 리스트 조회
	 * @param pagingVO
	 * @return
	 */
	public List<EmployeeVO> selectEmployeeChangeList(PagingVO<EmployeeVO> pagingVO);

	/**
	 * 관리사무소 직원 입퇴사자 페이징 처리 카운터 수
	 * @param pagingVO
	 * @return
	 */
	public int selectEmployeeChangeCount(PagingVO<EmployeeVO> pagingVO);

	/**
	 * 관리사무소 직원 전체 리스트  조회
	 * @param aptCode
	 * @return
	 */
	public List<EmployeeVO> selectEmployeeList(String aptCode);

	/**
	 * 관리사무소 직원 자격증 이미지 주소 이름 조회
	 * @param licEmp
	 * @return
	 */
	public LicenseVO selectLicenseImage(LicenseVO licEmp);


	
}
