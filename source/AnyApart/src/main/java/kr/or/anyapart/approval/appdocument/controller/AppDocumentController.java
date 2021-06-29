package kr.or.anyapart.approval.appdocument.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.apart.service.IApartService;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.approval.appdocument.dao.AppDocumentDAO;
import kr.or.anyapart.approval.appdocument.service.AppDocumentService;
import kr.or.anyapart.approval.draft.dao.DraftDAO;
import kr.or.anyapart.approval.draft.service.DraftService;
import kr.or.anyapart.approval.vo.ApprovalVO;
import kr.or.anyapart.approval.vo.DraftVO;
import kr.or.anyapart.approval.vo.LineDetailVO;
import kr.or.anyapart.board.officenotice.service.IOfficeNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class AppDocumentController extends BaseController{
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@Inject
	private DraftService draService;
	
	@Inject
	private AppDocumentService appService;
	
	@Inject
	private IApartService aptService;
	
	@Inject
	private AppDocumentDAO appdao;
	
	@Inject
	private DraftDAO draDAO;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	@RequestMapping("/office/approval/sendingList.do")
	public String sendingList(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			,DraftVO draftVO
			,SearchVO searchVO 
			,Model model) {

			PagingVO<DraftVO> pagingVO = new PagingVO<>();
			pagingVO.setSearchDetail(draftVO);
			pagingVO.setSearchVO(searchVO);
			searchVO.setSearchWord(authMember.getMemId());
			try {
				int totalRecord = appService.retrieveSendingCount(pagingVO);
				pagingVO.setTotalRecord(totalRecord);
				pagingVO.setCurrentPage(currentPage);
				
				List<DraftVO> sendingList = appService.retrieveSendingList(pagingVO);
				pagingVO.setDataList(sendingList);
				
			}catch(DataAccessException e) {
				model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			}
			
			model.addAttribute("taskCodes", draDAO.selectTaskCodeList());
			model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
			return "approval/sendingList";
	}
	
	@RequestMapping("/office/approval/draftView.do")
	public String sendingView(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute DraftVO param
			,@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			,@RequestParam(value="flag", required=false, defaultValue="whole") String flag
			,SearchVO searchVO 
			,Model model,RedirectAttributes redirectAttributes
	) {
		DraftVO draftVO = null;
		ApartVO apartVO = null;
		try {
			draftVO= appService.retrieveDraftInfo(param);
			apartVO= aptService.retrieveApart(authMember.getAptCode());
			int appLineId = appService.retrieveAppLineId(param);
			List<LineDetailVO> ldList = (List<LineDetailVO>) appService.retrieveLineDatailList(appLineId);
			model.addAttribute("ldList", ldList);
		}catch (DataAccessException e ) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("문서 상세조회 에러", e);
		} catch (NullPointerException e) {
			model.addAttribute("message", getCustomNoty("해당하는 정보가 없습니다."));
			LOGGER.error("문서 상세조회 에러", e);
		}
			model.addAttribute("apart", apartVO);
			model.addAttribute("draft", draftVO);
			model.addAttribute("flag", flag);
			
			return "approval/draftView";
	}
	
	@RequestMapping("/office/approval/receptionList.do")
	public String receptionList(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			,DraftVO draftVO
			,SearchVO searchVO 
			,Model model) {
	
			setAptCode(authMember, searchVO);
			PagingVO<DraftVO> pagingVO = new PagingVO<>();
			pagingVO.setSearchDetail(draftVO);
			pagingVO.setSearchVO(searchVO);
			searchVO.setSearchWord(authMember.getMemId());
			try {
				int totalRecord = appService.retrieveReceptionCount(pagingVO);
				pagingVO.setTotalRecord(totalRecord);
				pagingVO.setCurrentPage(currentPage);
				
				List<DraftVO> receptionList = appService.retrieveReceptionList(pagingVO);
				pagingVO.setDataList(receptionList);
				
			}catch(DataAccessException e) {
				model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			}
			
			model.addAttribute("taskCodes", draDAO.selectTaskCodeList());
			model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
			return "approval/receptionList";
	}
	
	@RequestMapping("/office/approval/wholeApprovalList.do")
	public String wholeList(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			,DraftVO draftVO
			,SearchVO searchVO 
			,Model model) {
		
		setAptCode(authMember, searchVO);
		PagingVO<DraftVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchDetail(draftVO);
		pagingVO.setSearchVO(searchVO);
		searchVO.setSearchWord(authMember.getMemId());
		try {
			int totalRecord = appService.retrieveWholeAppCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			pagingVO.setCurrentPage(currentPage);
			
			List<DraftVO> wholeList = appService.retrieveWholeAppList(pagingVO);
			pagingVO.setDataList(wholeList);
			
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("taskCodes", draDAO.selectTaskCodeList());
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "approval/wholeList";
	}
	
	@RequestMapping(value="/office/approval/approvalSuccess.do" 
			, method = RequestMethod.POST
			,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String approval(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute DraftVO draftVO
		    , Model model) {
		
		NotyMessageVO message = null;
		try {
			ServiceResult result = appService.approvalSuccess(draftVO);
		}catch(DataAccessException e) {
			message = UPDATE_SERVER_ERROR_MSG; 
			LOGGER.error("", e);
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	
	@RequestMapping(value="/office/approval/approvalReject.do" 
			, method = RequestMethod.POST 
			,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String reject(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute DraftVO draftVO
			, Model model) {
		
		NotyMessageVO message = null;
		try {
			ServiceResult result = appService.approvalReject(draftVO);
		}catch(DataAccessException e) {
			message = UPDATE_SERVER_ERROR_MSG; 
			LOGGER.error(" ", e);
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	
	@RequestMapping(value="/office/approval/draftCancel.do" 
			, method = RequestMethod.POST 
			,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String draftCancel(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute DraftVO draftVO
			, Model model) {
		
		NotyMessageVO message = null;
		try {
			ServiceResult result = appService.draftCancel(draftVO);
		}catch(DataAccessException e) {
			message = UPDATE_SERVER_ERROR_MSG; 
			LOGGER.error(" ", e);
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	

	
	public void setSelectList(Model model) {
		model.addAttribute("taskCodeList", draDAO.selectTaskCodeList());
		model.addAttribute("appCodeList" , draDAO.selectAppCodeList());
	}
	
	/**
	 * [관리사무소사이트-전자결재-결재함-상신함] 글 수정을 위한 폼
	 */
	@RequestMapping("/office/approval/draftUpdate.do")
	public String updateForm(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,@ModelAttribute DraftVO param
		,SearchVO searchVO, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		,Model model) {
			String aptCode = authMember.getAptCode();
			try {
				
				DraftVO draft = appService.retrieveDraftInfo(param);
				
				EmployeeVO employee = new EmployeeVO();
				employee.setMemId(authMember.getMemId());
				employee.setAptCode(authMember.getAptCode());
				DraftVO draftBasicInfo = draService.retrieveDraftBasicInfo(employee);
				draftBasicInfo.setMemId(authMember.getMemId());
				List<EmployeeVO> appEmpList = draService.retrieveAppEmpList(employee);
				
				setSelectList(model);
				model.addAttribute("acctList", draDAO.selectAcctList(aptCode));
				model.addAttribute("appEmpList", appEmpList);
				model.addAttribute("draftBasicInfo", draft);
				model.addAttribute("page", currentPage);
				model.addAttribute("updateFlag", "Y");
			}catch(DataAccessException e) {
				model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
				LOGGER.error("기안문 수정", e);
			}
			return "approval/draftForm";
	}
	
	/**
	 * [관리사무소사이트-전자결재-결재함-상신함] 글 수정
	 */
	@RequestMapping(value="/office/approval/draftUpdate.do", method=RequestMethod.POST)
	public String update(
			@Validated(UpdateGroup.class) @ModelAttribute("draft") DraftVO draft
			, BindingResult errors
			,@ModelAttribute LineDetailVO ldVO
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, Model model, RedirectAttributes redirectAttributes, @ModelAttribute SearchVO searchVO) {
		String goPage = null;
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = appService.modifyDraft(draft, ldVO);
				redirectAttributes.addAttribute("page", currentPage);
//				redirectAttributes.addAttribute("searchType", searchVO.getSearchType());
//				redirectAttributes.addAttribute("searchWord", searchVO.getSearchWord());
				goPage = "redirect:/office/approval/draftView.do?draftId="+draft.getDraftId();
				if(result == ServiceResult.FAILED) {
					message = UPDATE_SERVER_ERROR_MSG;
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				goPage = "office/approval/draftView.do?draftId="+draft.getDraftId();
				LOGGER.error("", e);
			}
		}else {
			model.addAttribute("message", UPDATE_CLIENT_ERROR_MSG);
			goPage = "approval/draftForm";
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
		}
	
	/**
	 * [관리사무소사이트-전자결재-결재함-상신함] 글 삭제를 위한 폼
	 */
	@RequestMapping(value="/office/approval/draftDelete.do" 
			, method = RequestMethod.POST 
			,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String draftDelete(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute DraftVO draftVO
			, Model model) {
		
		NotyMessageVO message = null;
		try {
			ServiceResult result = appService.draftDelete(draftVO);
			if(result == ServiceResult.FAILED) {
				message = UPDATE_SERVER_ERROR_MSG;
			}
		}catch(DataAccessException e) {
			message = UPDATE_SERVER_ERROR_MSG; 
			LOGGER.error(" ", e);
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	
	/**
	 * [관리사무소사이트-전자결재] 결재대기문서 리스트 조회
	 */
	@RequestMapping(value="/office/approval/receptionWaitListView.do" 
			, method = RequestMethod.POST 
			,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String receptionWaitListView(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute ApprovalVO appVO
			, Model model) {
		NotyMessageVO message = null;
		List<DraftVO> draftList = null;
		try {
			draftList = appService.retrieveReceptionWaitList(appVO);
		}catch(DataAccessException e) {
			message = UPDATE_SERVER_ERROR_MSG; 
			LOGGER.error(" ", e);
		}
		if(message!=null) model.addAttribute("message", message);
		model.addAttribute("draftList", draftList);
		return "jsonView";
	}
	
	/**
	 * [관리사무소사이트-전자결재-결재함-수신함] 대기리스트 수신여부 Y로 변경
	 */
	@RequestMapping(value="/office/approval/receptionWaitListUpdate.do", method=RequestMethod.POST)
	public String receptionWaitListUpdate(
			@ModelAttribute LineDetailVO ldVO
			, Model model) {
		NotyMessageVO message = null;
			try {
				ServiceResult result = appService.modifyReceptionWaitList(ldVO);
				if(result == ServiceResult.FAILED) {
					message = UPDATE_SERVER_ERROR_MSG;
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				LOGGER.error("", e);
			}
			if(message!=null) model.addAttribute("message", message);
			return "jsonView";
	}
}
	

