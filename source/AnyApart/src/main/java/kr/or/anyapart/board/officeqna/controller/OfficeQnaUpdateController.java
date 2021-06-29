/**
 * @author 이미정
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.      이미정       최초작성
 * 2021. 2. 15.      이미정       기존 코드 수정
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.board.officeqna.controller;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.officeqna.service.IOfficeQnaService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class OfficeQnaUpdateController extends BaseController{

	@Inject
	private IOfficeQnaService service;
	
	/**
	 * [관리사무소사이트-사이트관리-민원관리-문의게시판관리] 글 수정을 위한 폼
	 */
	@RequestMapping("/office/website/officeQna/officeQnaUpdate.do")
	public String formForOffice(
		 @ModelAttribute BoardVO param
			,SearchVO searchVO, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			,Model model) {
		try {
			BoardVO board = service.retrieveBoard(param);
			model.addAttribute("board", board);
			model.addAttribute("page", currentPage);
			model.addAttribute("searchWord", searchVO.getSearchWord());
			model.addAttribute("searchType", searchVO.getSearchType());
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("전체조회", e);
		}
		return "website/complaint/qnaForm";
	}
	
	/**
	 * [관리사무소사이트-사이트관리-민원관리-문의게시판관리] 글 수정
	 */
	@RequestMapping(value="/office/website/officeQna/officeQnaUpdate.do", method=RequestMethod.POST)
	public String updateForOffice(
			@Validated(UpdateGroup.class) @ModelAttribute("board") BoardVO board
			, BindingResult errors
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, Model model, RedirectAttributes redirectAttributes, @ModelAttribute SearchVO searchVO) {
		String goPage = null;
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = service.modifyBoard(board);
				redirectAttributes.addAttribute("page", currentPage);
				redirectAttributes.addAttribute("searchType", searchVO.getSearchType());
				redirectAttributes.addAttribute("searchWord", searchVO.getSearchWord());
				goPage = "redirect:/office/website/officeQna/officeQnaView.do?boNo="+board.getBoNo();
				if(result == ServiceResult.FAILED) {
					message = UPDATE_SERVER_ERROR_MSG;
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				goPage = "office/website/officeQna/officeQnaUpdate.do?boNo="+board.getBoNo();
				LOGGER.error("", e);
			}
		}else {
			model.addAttribute("message", UPDATE_CLIENT_ERROR_MSG);
			goPage = "office/website/officeQna/officeQnaUpdate.do?boNo="+board.getBoNo();
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
	}
	
	/**
	 * [입주민사이트-입주민공간-문의하기] 글 수정을 위한 폼
	 */
	@RequestMapping("/resident/officeQna/officeQnaUpdate.do")
	public String formForResident(
			@ModelAttribute BoardVO param
			,SearchVO searchVO, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			,Model model) {
		try {
			BoardVO board = service.retrieveBoard(param);
			model.addAttribute("board", board);
			model.addAttribute("page", currentPage);
			model.addAttribute("searchWord", searchVO.getSearchWord());
			model.addAttribute("searchType", searchVO.getSearchType());
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("전체조회", e);
		}
		return "space/qnaForm";	
	}

	/**
	 * [입주민사이트-입주민공간-문의하기] 글 수정
	 */
	@RequestMapping(value="/resident/officeQna/officeQnaUpdate.do", method=RequestMethod.POST)
	public String updateForResident(
			@Validated(UpdateGroup.class) @ModelAttribute("board") BoardVO board
			, BindingResult errors
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, Model model, RedirectAttributes redirectAttributes, @ModelAttribute SearchVO searchVO) {
		String goPage = null;
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = service.modifyBoard(board);
				redirectAttributes.addAttribute("page", currentPage);
				redirectAttributes.addAttribute("searchType", searchVO.getSearchType());
				redirectAttributes.addAttribute("searchWord", searchVO.getSearchWord());
				goPage = "redirect:/resident/officeQna/officeQnaView.do?boNo="+board.getBoNo();
				if(result == ServiceResult.FAILED) {
					message = UPDATE_SERVER_ERROR_MSG;
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				goPage = "resident/officeQna/officeQnaUpdate.do?boNo="+board.getBoNo();
				LOGGER.error("", e);
			}
		}else {
			model.addAttribute("message", UPDATE_CLIENT_ERROR_MSG);
			goPage = "resident/officeQna/officeQnaUpdate.do?boNo="+board.getBoNo();
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;	
	}
}
