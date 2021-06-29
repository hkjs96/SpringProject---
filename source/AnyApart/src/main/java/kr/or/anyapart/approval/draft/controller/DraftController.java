package kr.or.anyapart.approval.draft.controller;

import java.sql.Time;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.dao.DataAccessException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.approval.draft.dao.DraftDAO;
import kr.or.anyapart.approval.draft.service.DraftService;
import kr.or.anyapart.approval.vo.DraftVO;
import kr.or.anyapart.approval.vo.LineDetailVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class DraftController extends BaseController{
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@Inject
	private DraftService draService;
	
	@Inject
	private DraftDAO draDAO;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	public void setSelectList(Model model) {
		model.addAttribute("taskCodeList", draDAO.selectTaskCodeList());
		model.addAttribute("appCodeList" , draDAO.selectAppCodeList());
	}
	
	/**
	 * [관리사무소사이트-전자결재-기안문 작성] 작성페이지 이동
	 */
	@RequestMapping("/office/approval/draftForm.do")
	public String list(
			  @AuthenticationPrincipal(expression="realMember") MemberVO authMember
			  , Model model) {
		String aptCode = authMember.getAptCode();
		EmployeeVO employee = new EmployeeVO();
		employee.setMemId(authMember.getMemId());
		employee.setAptCode(authMember.getAptCode());
		DraftVO draftBasicInfo = draService.retrieveDraftBasicInfo(employee);
		draftBasicInfo.setMemId(authMember.getMemId());
		List<EmployeeVO> appEmpList = draService.retrieveAppEmpList(employee);
		model.addAttribute("appEmpList", appEmpList);
		model.addAttribute("draftBasicInfo", draftBasicInfo);
		model.addAttribute("acctList", draDAO.selectAcctList(aptCode));
		setSelectList(model);
		return "approval/draftForm";
	}
	
	/**
	 * [관리사무소사이트-전자결재-기안문 작성] 기안문 작성
	 */
	@RequestMapping(value="/office/approval/draftInsert.do", method=RequestMethod.POST)
	public String insert( 
			 @AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute DraftVO draftVO
			,@ModelAttribute LineDetailVO ldVO
			,BindingResult errors, Model model) {
		String goPage = null;
		NotyMessageVO message = null;
		
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = draService.createDraft(draftVO, ldVO);
				
				if(result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}
				goPage = "redirect:/office/approval/sendingList.do";
			}catch(DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "approval/draftForm";
				LOGGER.error("", e);
			}
		}else {
			message = INSERT_CLIENT_ERROR_MSG;
			goPage = "website/board/noticeForm";	
		}
		
		if(message!=null) model.addAttribute("message", message);
		return goPage;
	}
}
