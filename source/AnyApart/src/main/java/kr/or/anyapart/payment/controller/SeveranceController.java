/**
 * @author 이미정
 * @since 2021. 2. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 25.      작성자명       최초작성
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
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.payment.service.PaymentService;
import kr.or.anyapart.payment.service.SeveranceService;
import kr.or.anyapart.payment.vo.PaymentVO;
import kr.or.anyapart.payment.vo.SeveranceVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class SeveranceController extends BaseController{
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@Inject
	IEmployeeDAO empDAO;

	@Inject
	PaymentService payService;
	
	@Inject
	SeveranceService svrcService;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	@RequestMapping("/office/severance/severanceView.do")
	public String view(
			@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
			,Model model) {
		String aptCode = authMember.getAptCode();
		model.addAttribute("empSelectList", empDAO.selectEmployeeList(aptCode));
		return "severance/severanceView";
	}
	
//	//연습용!! 바로 수정할 예정임
	@RequestMapping(value="/office/severance/tmp.do", method=RequestMethod.POST)
	public String insertEvent(@RequestParam(value="htmlVal", required = false ) String htmlVal, RedirectAttributes rttr) {

				rttr.addFlashAttribute("htmlVal", htmlVal);
			
		return "redirect:/office/approval/draftForm.do";
	}
	
	/**
	 * [관리사무소사이트-급여/정산관리-정산관리- 퇴직정산] 퇴직금 예상내역 조회
	 */
	@RequestMapping(value="/office/severance/tmpSvrcView.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public String svrcTmpSum(
		   @ModelAttribute PaymentVO param
		  , BindingResult errors
		  , Model model) {
		List<PaymentVO> paymentList = null;
		SeveranceVO svrc = null;
		try {
			paymentList = (List<PaymentVO>) payService.retriveThreeMonthPayList(param);
			if(paymentList.size()!=0) {
				svrc = payService.retrieveTmpSvrc(param);
			}
			
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		if(paymentList.size()!=0) {
			model.addAttribute("threeMonthList", paymentList);
			model.addAttribute("svrc", svrc);
		}else {
			model.addAttribute("noResult", "noResult");
		}
		
		return "jsonView";
	}
	/**
	 * [관리사무소사이트-급여/정산관리-정산관리- 퇴직정산] 수정을 위한 모달 조회
	 */
	@RequestMapping(value="/office/severance/svrcViewForUpdate.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public String viewForUpdate(
			@ModelAttribute SeveranceVO param
			, BindingResult errors
			, Model model) {
		SeveranceVO svrcVO = null;
		try {
			svrcVO = svrcService.retriveSvrcViewForUpdate(param);
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("svrc", svrcVO);
		
		return "jsonView";
	}
	
	/**
	 * [관리사무소사이트-급여/정산관리-정산관리- 퇴직정산] 수정
	 */
	@RequestMapping(value="/office/severance/svrcUpdate.do", method=RequestMethod.POST )
	public String update(
			@ModelAttribute SeveranceVO param
			, BindingResult errors
			, Model model) {
		NotyMessageVO message = null;
		String goPage = null;
		
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = svrcService.updateSvrc(param);
				
				if(result == ServiceResult.FAILED) {
					message = UPDATE_SERVER_ERROR_MSG;
				}
				goPage = "redirect:/office/severance/severanceList.do";
			}catch(DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				goPage = "severance/severanceList";
			}
		}else {
			message = UPDATE_CLIENT_ERROR_MSG;
			goPage = "severance/severanceList";
		}
		
		if(message!=null) {
			model.addAttribute("message", message);
		}
		return goPage;
	}
	
	/**
	 * [관리사무소사이트-급여/정산관리-정산관리- 퇴직정산] 퇴직내역 등록
	 */
	@RequestMapping(value="/office/severance/svrcInsert.do", method=RequestMethod.POST )
	public String insert(
			@Validated(InsertGroup.class) @ModelAttribute SeveranceVO param
			, BindingResult errors
			, Model model) {
		NotyMessageVO message = null;
		String goPage = null;
		
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = svrcService.createSvrc(param);
				
				if(result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}
				goPage = "redirect:/office/severance/severanceList.do";
			}catch(DataAccessException e) {
				model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
				goPage = "severance/severanceList";
			}
		}else {
			message = INSERT_CLIENT_ERROR_MSG;
			goPage = "severance/severanceList";
		}
		
		if(message!=null) {
			model.addAttribute("message", message);
		}
		return goPage;
	}

	/**
	 * [관리사무소사이트-급여/정산관리-정산관리- 퇴직정산] 퇴직금 내역 리스트 조회
	 */
	@RequestMapping("/office/severance/severanceList.do")
	public String svrcList(@AuthenticationPrincipal(expression = "realMember") MemberVO authMember
			, SearchVO searchVO
			, @ModelAttribute SeveranceVO svrcVO
			, @RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			, Model model) {
		String aptCode = authMember.getAptCode();
		setAptCode(authMember, searchVO);
		
		PagingVO<SeveranceVO> pagingVO = new PagingVO<>();
		
		pagingVO.setSearchDetail(svrcVO);
		pagingVO.setSearchVO(searchVO);

		try {
			int totalRecord = svrcService.retrieveSvrcCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			pagingVO.setCurrentPage(currentPage);
			
			List<SeveranceVO> svrcList = svrcService.retrieveSvrcList(pagingVO);
			pagingVO.setDataList(svrcList);
			
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		model.addAttribute("empSelectList", empDAO.selectEmployeeList(aptCode));
		return "severance/severanceList";
	}
	
	
		@RequestMapping(value="/office/severance/svrcDelete.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String delete(
			@Validated(DeleteGroup.class) @ModelAttribute SeveranceVO param
		  , Errors errors
		  , Model model
		  , RedirectAttributes redirectAttributes ) {
		
		NotyMessageVO message = null;
		String goPage = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = svrcService.removeSvrc(param);
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

}
