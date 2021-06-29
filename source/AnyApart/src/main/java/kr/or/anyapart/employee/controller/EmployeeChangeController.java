/**
 * @author 이미정
 * @since 2021. 1. 22.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 22.      이미정       최초작성
 * 2021. 2. 19.      이미정       주석 수정, 검색 유지
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.employee.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.service.IEmployeeService;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class EmployeeChangeController extends BaseController{
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@Inject
	private IEmployeeService service;
	
	@Inject
	private IEmployeeDAO dao;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	public void setSelectList(Model model) {
		model.addAttribute("licenses", dao.selectLicenseList());
		model.addAttribute("positions", dao.selectPositionList());
		model.addAttribute("roles", dao.selectRoleList());
		model.addAttribute("banks", dao.selectBankList());
	}
	
	/**
	 * 관리사무소 직원 입퇴사자 목록 조회
	 */
	@RequestMapping("/office/employee/employeeChangeList.do")
	public String list(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @ModelAttribute  EmployeeVO employeeVO
			, SearchVO searchVO
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, Model model) {
		
		setAptCode(authMember, searchVO);	
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(employeeVO);
		pagingVO.setSearchVO(searchVO);
		
		try {
			int totalRecord = service.retrieveEmployeeChangeCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			pagingVO.setCurrentPage(currentPage);
			
			List<EmployeeVO> employeeList = service.retrieveEmployeeChangeList(pagingVO);
			pagingVO.setDataList(employeeList);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "employee/employeeChangeList";
	}
	
	/**
	 * [관리사무소사이트-인사/근태관리-인사관리-입/퇴사자 조회] 직원 퇴직 처리
	 */
	@RequestMapping(value="/office/employee/employeeDelete.do", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String removeEmployee(
			@Validated(DeleteGroup.class) @ModelAttribute EmployeeVO employee
			,Errors errors
			,Model model) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = service.removeEmployee(employee);
			}catch(DataAccessException e) {
				message = DELETE_SERVER_ERROR_MSG; 
				LOGGER.error("", e);
			}
		}else {
			message = DELETE_CLIENT_ERROR_MSG;
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	
	/**
	 * [관리사무소사이트-인사/근태관리-인사관리-입/퇴사자 조회] 직원 퇴직 처리 취소
	 */
	@RequestMapping(value="/office/employee/employeeDeleteCancel.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String removeEmployeeCancel(
			@Validated(DeleteGroup.class) @ModelAttribute EmployeeVO employee
			,Errors errors
			,Model model) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = service.removeEmployeeCancel(employee);
			}catch(DataAccessException e) {
				message = UPDATE_SERVER_ERROR_MSG; 
			}
		}else {
			message = UPDATE_CLIENT_ERROR_MSG;
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	
	
}
