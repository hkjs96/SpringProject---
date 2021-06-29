/**
 * @author 이미정
 * @since 2021. 2. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 10.      이미정             최초작성
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
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.dao.OffDAO;
import kr.or.anyapart.employee.service.OffService;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class OffController extends BaseController {
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@Inject
	private OffService offService;

	@Inject
	private OffDAO offDao;
	
	@Inject
	private IEmployeeDAO empDao;

	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}

	
	/**
	 * [관리사무소사이트-인사/근태관리-근태관리-휴가일수 계산] 리스트 조회
	 */
	@RequestMapping("/office/off/offList.do")
	public String infolist(@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
			, SearchVO searchVO
			, @ModelAttribute OffVO offVO 
			, @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			, Model model) {
		String aptCode = authMember.getAptCode();
		setAptCode(authMember, searchVO);
		
		PagingVO<OffVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(offVO);
		pagingVO.setSearchVO(searchVO);

		try {
			int totalRecord = offService.retrieveOffCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			pagingVO.setCurrentPage(currentPage);
			
			List<OffVO> offList = offService.retrieveOffList(pagingVO);
			pagingVO.setDataList(offList);
			
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("offSelectList", offDao.selectOffOption());
		model.addAttribute("empSelectList", empDao.selectEmployeeList(aptCode));
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		
		return "off/offList";
	}
	
	/**
	 * [관리사무소사이트-인사/근태관리-근태관리-휴가일수 계산] 직원 휴가신청내역 등록
	 */
	@RequestMapping(value="/office/off/offInsert.do", method=RequestMethod.POST)
	public String register(
			@Validated(InsertGroup.class) @ModelAttribute OffVO offVO
		  , BindingResult errors
		  , EmployeeVO employeeVO
		  , Model model) {
		String goPage = null;
		NotyMessageVO message = null;
		if (!errors.hasErrors()) {
			try {
			ServiceResult result = offService.createOff(offVO);
			
			if(result == ServiceResult.FAILED) {
				message = INSERT_SERVER_ERROR_MSG;
			}
			goPage = "redirect:/office/off/offList.do";
			}catch(DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "redirect:/office/off/offList.do";
				LOGGER.error("", e);
			}
		}else {
			message = INSERT_CLIENT_ERROR_MSG;
			goPage = "redirect:/office/off/offList.do";	
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
	}
	
	/**
	 * [관리사무소사이트-인사/근태관리-근태관리-휴가일수 계산] 직원 휴가신청내역 수정을 위한 모달 조회
	 */ 
	@RequestMapping("/office/off/offView.do")
	public String view(
			@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
		  , @ModelAttribute OffVO param
		  , BindingResult errors
		  , Model model) {
		OffVO offVO = null;
		String aptCode = authMember.getAptCode();
		try {
			offVO = offService.retrieveOff(param);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("off", offVO);
		model.addAttribute("offSelectList", offDao.selectOffOption());
		model.addAttribute("empSelectList", empDao.selectEmployeeList(aptCode));
		return "jsonView";
	}

	/**
	 * [관리사무소사이트-인사/근태관리-근태관리-휴가일수 계산] 직원 휴가신청내역수정
	 */
	@RequestMapping(value="/office/off/offUpdate.do", method=RequestMethod.POST
			,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String update(
			@Validated(UpdateGroup.class) @ModelAttribute OffVO offVO
		  , BindingResult errors
		  , Model model) {
		NotyMessageVO message = null;
		if (!errors.hasErrors()) {
			try {
				ServiceResult result = offService.modifyOff(offVO);
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
	
	/**
	 * [관리사무소사이트-인사/근태관리-근태관리-휴가일수 계산] 직원 휴가신청내역 삭제
	 */
	@RequestMapping(value="/office/off/offDelete.do",method=RequestMethod.POST
			,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String delete(
			@Validated(DeleteGroup.class) @ModelAttribute OffVO offVO
		  , Errors errors
		  , Model model
		  , RedirectAttributes redirectAttributes ) {
		
		NotyMessageVO message = null;
		String goPage = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = offService.removeOff(offVO);
			}catch(DataAccessException e) {
				message = DELETE_SERVER_ERROR_MSG; 
				LOGGER.error("", e);
			}
		}else {
			message = DELETE_CLIENT_ERROR_MSG;
		}
		if(message!=null) redirectAttributes.addFlashAttribute("message",message);
		return "jsonView";
	}
	
	/**
	 * [관리사무소사이트-인사/근태관리-근태관리-휴가일수 계산] 직원 휴가신청내역 모달 조회
	 */ 
	@RequestMapping("/office/off/nowOffView.do")
	public String myOffView(
			@ModelAttribute OffVO param
		  , BindingResult errors
		  , Model model) {
		String nowOff = null;
		try {
			nowOff = offService.retrieveNowOff(param);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("nowOff", nowOff);
		return "jsonView";
	}

}
