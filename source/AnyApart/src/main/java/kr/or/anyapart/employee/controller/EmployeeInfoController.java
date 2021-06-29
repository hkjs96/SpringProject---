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

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
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

import kr.or.anyapart.apart.service.IApartService;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.service.IEmployeeService;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.LicenseVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class EmployeeInfoController extends BaseController{
	
	@Inject
	private IApartService aptService;
	
	@Inject
	private PasswordEncoder pwEncoder;
	
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
	 * [관리사무소사이트-인사/근태관리-인사관리-직원조회] 리스트 조회
	 */
	@RequestMapping("/office/employee/employeeList.do")
	public String infolist(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		  , SearchVO searchVO
		  , @ModelAttribute  EmployeeVO employeeVO
		  , @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		  , Model model) {
		
		setAptCode(authMember, searchVO);
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(employeeVO);
		pagingVO.setSearchVO(searchVO);
		
		try {
			int totalRecord = service.retrieveEmployeeCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			pagingVO.setCurrentPage(currentPage);
			
			List<EmployeeVO> employeeList = service.retrieveEmployeeList(pagingVO);
			setSelectList(model);
			pagingVO.setDataList(employeeList);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "employee/employeeList";
	}
	
	/**
	 * [관리사무소사이트-인사/근태관리-인사관리-직원조회] 직원 상세 조회
	 */
	@RequestMapping("/office/employee/employeeInfoView.do")
	public String infoView(
			@ModelAttribute EmployeeVO param
		   ,@RequestParam(value="changeFlag", required=false) String changeFlag 
		   , Model model
		   , RedirectAttributes redirectAttributes) {
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>();
		if(param!=null) {
			pagingVO.setSearchDetail(param);
		}
		EmployeeVO employee = null;
		try {
			employee = service.retrieveEmployee(param);
		}catch (DataAccessException e ) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("직원 상세조회 에러", e);
		} catch (NullPointerException e) {
			model.addAttribute("message", getCustomNoty("해당하는 정보가 없습니다."));
			LOGGER.error("직원 상세조회 에러", e);
		}
		
		model.addAttribute("employee", employee);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("changeFlag", changeFlag);
		return "employee/employeeView";
	}

	/**
	 * [관리사무소사이트-인사/근태관리-인사관리-인사기본정보 등록] 직원 등록 페이지 이동
	 */
	@RequestMapping("/office/employee/employeeForm.do")
	public String registerForm(@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, Model model) {
		EmployeeVO employeeVO = new EmployeeVO();
		String aptCode = authMember.getAptCode();
		try {
			employeeVO = service.getEmployeeMaxId(aptCode);
			setSelectList(model);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		model.addAttribute("employee", employeeVO);
		return "employee/employeeForm";
	}
	
	/**
	 * [관리사무소사이트-인사/근태관리-인사관리-인사기본정보 등록] 직원 등록
	 */
	@RequestMapping(value="/office/employee/employeeForm.do", method=RequestMethod.POST)
	public String register( @ModelAttribute("member")MemberVO memberVO, 
			@ModelAttribute("employee") EmployeeVO employeeVO, 
			BindingResult errors, Model model) {
		String goPage = null;
		NotyMessageVO message = null;
		
		if(!errors.hasErrors()) {
			try {
				memberVO.setMemPass(employeeVO.getEmpHp());
				pwEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
				memberVO.setMemPass(pwEncoder.encode(memberVO.getMemPass()));
				ServiceResult result = service.createEmployee(memberVO, employeeVO);
				
				if(result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}
				goPage = "redirect:/office/employee/employeeInfoView.do?memId="+memberVO.getMemId();
			}catch(DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "employee/employeeForm";
				LOGGER.error("", e);
			}
		}else {
			message = INSERT_CLIENT_ERROR_MSG;
			goPage = "employee/employeeForm";	
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
	}	
	
	/**
	 * [관리사무소사이트-인사/근태관리-인사관리-직원 조회] 직원 정보 수정 페이지 이동
	 */
	@RequestMapping(value="/office/employee/employeeUpdate.do")
	public String updateForm(
			@ModelAttribute EmployeeVO param
		  , Model model) {
		EmployeeVO employee = null;
		
		try {
			setSelectList(model);
			employee = service.retrieveEmployee(param);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("employee", employee);
		return "employee/employeeForm";
	}
		
	/**
	 * [관리사무소사이트-인사/근태관리-인사관리-직원 조회] 직원 정보 수정
	 */
	@RequestMapping(value="/office/employee/employeeUpdate.do", method=RequestMethod.POST)
	public String update(
			@ModelAttribute EmployeeVO employee
		  , @ModelAttribute MemberVO member
		  , Errors errors
		  , Model model) {
		String goPage = null;
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = service.modifyEmployee(employee, member);
				goPage = "redirect:/office/employee/employeeInfoView.do?memId="+employee.getMemId();
			}catch (DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				goPage = "office/employee/employeeUpdate.do?memId="+employee.getMemId();
				LOGGER.error("", e);
			}
		}else {
			model.addAttribute("message", UPDATE_CLIENT_ERROR_MSG);
			goPage = "redirect:/office/employee/employeeInfoView.do?memId="+employee.getMemId();
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
	}
		
	/**
	 * [관리사무소사이트] footer 아파트 정보 조회
	 */
	@RequestMapping(value="/office/employee/setting/apartView.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String officeApartView(
			@RequestParam("aptCode") String aptCode
		   , Model model) {
		ApartVO apartVO = aptService.retrieveApart(aptCode);
		
		model.addAttribute("apart", apartVO);
		
		return "jsonView";
	}
	
	/**
	 * [입주민사이트] footer 아파트 정보 조회
	 */
	@RequestMapping(value="/resident/employee/setting/apartView.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String residentAptView(
			@RequestParam("aptCode") String aptCode
			, Model model) {
		ApartVO apartVO = aptService.retrieveApart(aptCode);
		
		model.addAttribute("apart", apartVO);
		
		return "jsonView";
	}
	
	/**
	 * [관리사무소사이트] 직원 자격증 조회
	 */
	@RequestMapping(value="/office/employee/licenseImage.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String licenseImage(@RequestParam("memId") String memId, @RequestParam("licCode") String licCode
			  , Model model) throws IOException {
		LicenseVO licEmp = LicenseVO.builder()
									.memId(memId)
									.licCode(licCode)
									.build();
		LicenseVO license = service.retrieveLicenseImage(licEmp);
		model.addAttribute("license", license);
		
		return "jsonView";
	}
	
}
