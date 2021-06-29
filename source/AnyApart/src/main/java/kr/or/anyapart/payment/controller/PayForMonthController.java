/**
 * @author 이미정
 * @since 2021. 1. 25.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 8.     이미정       최초작성
 * 2021. 2. 13.    이미정       월별 급여자료 수정, 삭제 기능
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.payment.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.officenotice.service.IOfficeNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyLayout;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.payment.service.PaymentService;
import kr.or.anyapart.payment.vo.PaymentVO;
import kr.or.anyapart.remodelling.vo.RemodellingVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class PayForMonthController extends BaseController {
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@Inject
	private PaymentService payService;

	@Inject
	IEmployeeDAO empDAO;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	/**
	 * [관리사무소페이지-급여/정산관리-급여관리-급여계산] 리스트 조회
	 */
	@RequestMapping("/office/payment/paymentForMonthList.do")
	public String list(
			@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
			,@RequestParam(value="flag", required=false, defaultValue="N") String flag
			,@ModelAttribute PaymentVO paymentVO
			,@ModelAttribute EmployeeVO employeeVO
			,@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			, SearchVO searchVO
			,Model model) {
		Map<String, Float> frMap = (Map<String, Float>) application.getAttribute("frMap");
		
		setAptCode(authMember, searchVO);
		
		PagingVO<PaymentVO> pagingVO = new PagingVO<>(5,5);
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

		String aptCode = authMember.getAptCode();
		List<EmployeeVO> empSelectList = empDAO.selectEmployeeList(aptCode);
		
		List<PaymentVO> payList = payService.retrievePayForMonthList(pagingVO);
		pagingVO.setDataList(payList);
		model.addAttribute("empSelectList", empSelectList);
		model.addAttribute("positions", empDAO.selectPositionList());
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		model.addAttribute("flag", flag);
		model.addAttribute("frMap", frMap);
		
		return "payment/paymentForMonthList";
	}

	/**
	 * [관리사무소페이지-급여/정산관리-급여관리-급여계산] 예상 급여액 구하기
	 */
	@RequestMapping(value="/office/payment/paySum.do", method=RequestMethod.POST,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String paySum(
			@ModelAttribute PaymentVO paymentVO
		  , BindingResult errors
		  , Model model) {
		PaymentVO payment = null;
		try {
			payment = payService.retrievePaySum(paymentVO);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("payment", payment);
		return "jsonView";
	}
	
	
	/**
	 * [관리사무소페이지-급여/정산관리-급여관리-급여계산] 급여자료 등록
	 */
	@RequestMapping("/office/payment/payForMonthInsert.do")
	public String insert(@Validated(InsertGroup.class) @ModelAttribute PaymentVO paymentVO, BindingResult errors,
			Model model) {
		NotyMessageVO message = null;
		if (!errors.hasErrors()) {
			try {
				ServiceResult result = payService.createPayForMonth(paymentVO);
				model.addAttribute("result", result);
				if (result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				} 
			} catch (SQLException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				LOGGER.error(this.getClass().getName() + " " + e.getMessage());
			}
		} else {
			message = INSERT_CLIENT_ERROR_MSG;
		}
		if (message != null) {
			model.addAttribute("message", message);
		}
		return "jsonView";
	}
	
	/**
	 * [관리사무소페이지-급여/정산관리-급여관리-급여계산] 급여자료 수정을 위한 조회
	 */
	@RequestMapping("/office/payment/payForMonthView.do")
	public String view(@ModelAttribute PaymentVO param, 
			BindingResult errors,
			Model model
	) {
		PaymentVO paymentVO = payService.retrievePayForMonth(param);
		model.addAttribute("pay", paymentVO);
		return "jsonView";
	}
	
	/**
	 * [관리사무소페이지-급여/정산관리-급여관리-급여계산] 급여자료 수정
	 */
	@RequestMapping(value="/office/payment/payForMonthUpdate.do", method=RequestMethod.POST,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String update(@ModelAttribute PaymentVO paymentVO
			,BindingResult errors
			,Model model
	) {
		if(!errors.hasErrors()) {
			ServiceResult result = payService.modifyPayForMonth(paymentVO);
		}
		return "jsonView";
	}
	
	/**
	 * [관리사무소페이지-급여/정산관리-급여관리-급여계산] 급여자료삭제
	 */
	@RequestMapping("/office/payment/payForMonthDelete.do")
	public String delete(
			@Validated(DeleteGroup.class) @ModelAttribute PaymentVO paymentVO
			, Errors errors
			, RedirectAttributes redirectAttributes
	) {
		String goPage = "redirect:/office/payment/paymentForMonthList.do";
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = payService.removePayForMonth(paymentVO);
			switch (result) {
			case OK:
				goPage = "redirect:/office/payment/paymentForMonthList.do";
				break;
			default: // FAILED
				message = DELETE_SERVER_ERROR_MSG;
				break;
			}
		}else {
			message = DELETE_CLIENT_ERROR_MSG;
		}
		if(message!=null) redirectAttributes.addFlashAttribute("message",message);
		return goPage;
	}
	
	
	
	
	
}
