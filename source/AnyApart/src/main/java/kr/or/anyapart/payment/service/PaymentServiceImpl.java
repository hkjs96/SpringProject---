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

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.payment.dao.PaymentDAO;
import kr.or.anyapart.payment.vo.PaymentVO;
import kr.or.anyapart.payment.vo.SeveranceVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class PaymentServiceImpl implements PaymentService{

	@Inject
	private PaymentDAO payDAO;
	
	@Transactional
	@Override
	public ServiceResult modifyPayInfo(EmployeeVO employeeVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = payDAO.updatePayInfo(employeeVO);
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public List<PaymentVO> retrievePayForMonthList(PagingVO<PaymentVO> pagingVO) {
		return payDAO.selectPayForMonthList(pagingVO);
	}

	@Override
	public int retrievePayForMonthCount(PagingVO<PaymentVO> pagingVO) {
		return payDAO.selectPayForMonthCount(pagingVO);
	}

	@Transactional
	@Override
	public ServiceResult createPayForMonth(PaymentVO paymentVO) throws SQLException{
		int cnt = payDAO.insertPayForMonth(paymentVO);
		ServiceResult result= ServiceResult.FAILED;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult removePayForMonth(PaymentVO paymentVO) {
		int cnt = payDAO.deletePayForMonth(paymentVO);
		ServiceResult result = ServiceResult.FAILED;
		
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public PaymentVO retrievePayForMonth(PaymentVO paymentVO) {
		PaymentVO payment = payDAO.selectPayForMonth(paymentVO);
		if(payment==null) throw new CustomException(paymentVO.getPayNo()+"에 해당하는 내역이 없습니다.");
		return payment;
	}
	
	@Transactional
	@Override
	public ServiceResult modifyPayForMonth(PaymentVO paymentVO) {
		PaymentVO payment = payDAO.selectPayForMonth(paymentVO);
		if(payment==null) throw new CustomException(payment.getPayNo()+"에 해당하는 내역이 없습니다.");
		
		ServiceResult result = ServiceResult.FAILED;
		int cnt = payDAO.updatePayForMonth(paymentVO);
		
		if(cnt>0) {
			result=ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public PaymentVO retrievePaySum(PaymentVO paymentVO) {
		PaymentVO payment = payDAO.selectPaySum(paymentVO);
		if(payment==null) throw new CustomException(paymentVO.getPayNo()+"에 해당하는 내역이 없습니다.");
		return payment;
	}

	@Override
	public List<PaymentVO> retriveThreeMonthPayList(PaymentVO param) {
		List<PaymentVO> payment = payDAO.selectThreeMonthPayList(param);
		if(payment==null) throw new CustomException(param.getPayNo()+"님의 해당 급여 내역이 없습니다.");
		return payment;
	}

	@Override
	public SeveranceVO retrieveTmpSvrc(PaymentVO param) {
		SeveranceVO svrc = payDAO.selectTmpSvrc(param);
		if(svrc==null) throw new CustomException(param.getMemId()+"님의 해당 정산 내역이 없습니다.");
		return svrc;
	}
	


}
