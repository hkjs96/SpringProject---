/**
 * @author 이미정
 * @since 2021. 1. 25.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 25.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.payment.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.service.IEmployeeService;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.payment.service.PaymentService;
import kr.or.anyapart.payment.vo.PaymentVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class PayBookController extends BaseController{
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@Inject
	private PaymentService payService;

	@Inject
	private IEmployeeService empService;
	
	@Inject
	IEmployeeDAO empDAO;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	@RequestMapping("/office/payment/paymentBookList.do")
	public String list(
			@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
			,@ModelAttribute PaymentVO paymentVO
			,@ModelAttribute EmployeeVO employeeVO
			,@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			, SearchVO searchVO
			,Model model) {
		String aptCode = authMember.getAptCode();
		setAptCode(authMember, searchVO);
		
		PagingVO<PaymentVO> pagingVO = new PagingVO<>();
		
		String name = employeeVO.getEmpName();
		String positionCode = employeeVO.getPositionCode();

		EmployeeVO tmpEmp = new EmployeeVO();
		tmpEmp.setAptCode("TEMPLATE");
		
		if(paymentVO!=null) {
			pagingVO.setSearchDetail(paymentVO);
			paymentVO.setEmployee(tmpEmp);
		}
		
		if(name!=null) {
			paymentVO.getEmployee().setEmpName(name);
		}
		if(positionCode!=null) {
			paymentVO.getEmployee().setPositionCode(positionCode);
		}
		pagingVO.setSearchVO(searchVO);

		int totalRecord = payService.retrievePayForMonthCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<PaymentVO> payList = payService.retrievePayForMonthList(pagingVO);
		pagingVO.setDataList(payList);
		model.addAttribute("empSelectList", empDAO.selectEmployeeList(aptCode));
		model.addAttribute("positions", empDAO.selectPositionList());
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
			
			
		
		
		return "payment/paymentBookList";
	}
	
	@RequestMapping(value="/office/payment/paymentDetailView.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String listDetail(
		@ModelAttribute PaymentVO param
		,Errors errors
		,Model model) {
			NotyMessageVO message = null;
			PaymentVO payment = null;
			EmployeeVO employee = new EmployeeVO();
			employee.setMemId("TEMPLATE");
			if(!errors.hasErrors()) {
				try {
					payment = payService.retrievePayForMonth(param);
					employee.setMemId(payment.getMemId());
					employee = empService.retrieveEmployee(employee);
				}catch(DataAccessException e) {
					message = SELECT_SERVER_ERROR_MSG; 
					LOGGER.error("", e);
				}
			}else {
				message = SELECT_CLIENT_ERROR_MSG;
			}
			model.addAttribute("payDetail", payment);
			model.addAttribute("empDetail", employee);
			if(message!=null) model.addAttribute("message", message);
			return "jsonView";
		
	}
}
