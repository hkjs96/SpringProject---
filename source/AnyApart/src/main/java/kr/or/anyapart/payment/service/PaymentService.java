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
package kr.or.anyapart.payment.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.payment.vo.PaymentVO;
import kr.or.anyapart.payment.vo.SeveranceVO;
import kr.or.anyapart.vo.PagingVO;

public interface PaymentService {
	public ServiceResult modifyPayInfo(EmployeeVO employeeVO); 
	
	public List<PaymentVO> retrievePayForMonthList(PagingVO<PaymentVO> pagingVO);
	
	public int retrievePayForMonthCount(PagingVO<PaymentVO> pagingVO);
	
	public ServiceResult createPayForMonth(PaymentVO paymentVO) throws SQLException;

	public ServiceResult removePayForMonth(PaymentVO paymentVO);

	public PaymentVO retrievePayForMonth(PaymentVO paymentVO);
	
	public ServiceResult modifyPayForMonth(PaymentVO paymentVO);

	public PaymentVO retrievePaySum(PaymentVO paymentVO);

	public List<PaymentVO> retriveThreeMonthPayList(PaymentVO param);

	public SeveranceVO retrieveTmpSvrc(PaymentVO param);



}
