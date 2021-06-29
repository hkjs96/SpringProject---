/**
 * @author 이미정
 * @since 2021. 2. 6.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 6.      이미정       최초작성
 * 2021. 2. 13. 	이미정	월별 급여자료 수정, 삭제 기능
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.payment.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.payment.vo.PaymentVO;
import kr.or.anyapart.payment.vo.SeveranceVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface PaymentDAO {
	public int updatePayInfo(EmployeeVO employeeVO);
	
	public List<PaymentVO> selectPayForMonthList(PagingVO<PaymentVO> pagingVO);

	public int selectPayForMonthCount(PagingVO<PaymentVO> pagingVO);

	public int insertPayForMonth(PaymentVO paymentVO) throws SQLException;
	
	public int deletePayForMonth(PaymentVO paymentVO);
	
	public PaymentVO selectPayForMonth(PaymentVO paymentVO);
	
	public int updatePayForMonth(PaymentVO paymentVO);

	public PaymentVO selectPaySum(PaymentVO paymentVO);

	public List<PaymentVO> selectThreeMonthPayList(PaymentVO param);

	public SeveranceVO selectTmpSvrc(PaymentVO param);
}
