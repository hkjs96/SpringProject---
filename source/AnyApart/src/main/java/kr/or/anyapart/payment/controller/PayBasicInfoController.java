/**
 * @author 이미정
 * @since 2021. 1. 25.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 5.      이미정       최초작성
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
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.service.IEmployeeService;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.payment.dao.PaymentDAO;
import kr.or.anyapart.payment.service.PaymentService;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class PayBasicInfoController extends BaseController{
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@Inject
	private IEmployeeService empService;
	
	@Inject
	private IEmployeeDAO empDao;
	
	@Inject
	private PaymentService payService;
	
	@Inject
	private PaymentDAO payDao;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	
	/**
	 * [관리사무소페이지-급여/정산관리-급여관리-급여기본정보] 리스트 조회
	 */
	@RequestMapping("/office/payment/paymentBasicInfoList.do")
	public String list(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,SearchVO searchVO
			, @ModelAttribute  EmployeeVO employeeVO
			,@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			,Model model ) {
		
		setAptCode(authMember, searchVO);
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(employeeVO);
		pagingVO.setSearchVO(searchVO);
		
		try {
			int totalRecord = empService.retrieveEmployeeCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			pagingVO.setCurrentPage(currentPage);
			
			List<EmployeeVO> payInfoList = empService.retrievePayInfoList(pagingVO);
			pagingVO.setDataList(payInfoList);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
			
		model.addAttribute("banks", empDao.selectBankList());
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("positions", empDao.selectPositionList());
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		
		return "payment/paymentBasicInfoList";
	}
	
	/**
	 * [관리사무소페이지-급여/정산관리-급여관리-급여기본정보] 수정
	 */
	@RequestMapping(value="/office/payment/paymentBasicInfoUpdate.do", method=RequestMethod.POST
			,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String update(
			    @ModelAttribute EmployeeVO employee
			  , BindingResult errors
			  , Model model) {
			NotyMessageVO message = null;
			
			if (!errors.hasErrors()) {
				try {
					ServiceResult result = payService.modifyPayInfo(employee);
				}catch(DataAccessException e) {
					message = UPDATE_SERVER_ERROR_MSG; 
					LOGGER.error("", e);
				}
			}else {
				message = UPDATE_CLIENT_ERROR_MSG;
			}
			if(message!=null) model.addAttribute("message", message);
			return "jsonView";
	}
}
