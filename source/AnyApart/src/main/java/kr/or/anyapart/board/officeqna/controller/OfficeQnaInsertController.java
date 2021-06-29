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
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.anyapart.board.officeqna.service.IOfficeQnaService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class OfficeQnaInsertController extends BaseController {

	@Inject
	private IOfficeQnaService service;

	/**
	 * [관리사무소사이트-사이트관리-민원관리-문의게시판관리] 답변 등록 폼
	 */
	@RequestMapping("/office/website/officeQna/officeQnaAnswer.do")
	public String formForOffice(
			@ModelAttribute("board") BoardVO boardVO
		    ,Model model) {
		BoardVO questionVO = service.retrieveBoard(boardVO);
		
		try{
			if(questionVO != null) {
			model.addAttribute("question", questionVO);
			}
		}catch(DataAccessException e) {
			model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
		}
		model.addAttribute("board", boardVO);
		return "website/complaint/qnaForm";
	}

	/**
	 * [관리사무소사이트-사이트관리-민원관리-문의게시판관리] 답변 등록
	 */
	@RequestMapping(value = "/office/website/officeQna/officeQnaAnswer.do", method = RequestMethod.POST)
	public String insertForOffice(@AuthenticationPrincipal(expression = "realMember") MemberVO authMember,
			@Validated(InsertGroup.class) @ModelAttribute("board") BoardVO boardVO, BindingResult errors, Model model) {
		String goPage = null;
		NotyMessageVO message = null;
		if (boardVO != null) {
			boardVO.setBoWriter(authMember.getMemId());
		}
		if (!errors.hasErrors()) {
			try {
				ServiceResult result = service.createBoard(boardVO);
				if (result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}
				goPage = "redirect:/office/website/officeQna/officeQnaView.do?boNo=" + boardVO.getBoNo();
			} catch (DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "website/complaint/qnaForm";
				LOGGER.error("", e);
			}
		} else {
			message = INSERT_CLIENT_ERROR_MSG;
			goPage = "website/complaint/qnaForm";
		}
		if (message != null)
			model.addAttribute("message", message);
		return goPage;
	}
	
	/**
	 * [관리사무소사이트-대쉬보드-문의글] 답변 등록
	 */
	@RequestMapping(value = "/office/website/officeQna/officeQnaDashInsert.do", method = RequestMethod.POST)
	public String DashAnswerInsert(@AuthenticationPrincipal(expression = "realMember") MemberVO authMember,
			@Validated(InsertGroup.class) @ModelAttribute("board") BoardVO boardVO, BindingResult errors, Model model) {
		NotyMessageVO message = null;
		if (!errors.hasErrors()) {
			try {
				ServiceResult result = service.createBoard(boardVO);
				if (result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
			}
		} else {
			message = INSERT_CLIENT_ERROR_MSG;
		}
		if (message != null)
			model.addAttribute("message", message);
		return "jsonView";
	}
	

	/**
	 * [입주민사이트-입주민공간-문의하기] 글 등록 폼
	 */
	@RequestMapping("/resident/officeQna/officeQnaForm.do")
	public String formForResident() {
		return "space/qnaForm";
	}

	/**
	 * [입주민사이트-입주민공간-문의하기] 글 등록
	 */
	@RequestMapping(value = "/resident/officeQna/officeQnaForm.do", method = RequestMethod.POST)
	public String insertForResident(@AuthenticationPrincipal(expression = "realMember") MemberVO authMember,
			@Validated(InsertGroup.class) @ModelAttribute("board") BoardVO boardVO, BindingResult errors, Model model) {
		String goPage = null;
		NotyMessageVO message = null;
		if (boardVO != null) {
			boardVO.setBoWriter(authMember.getMemId());
		}
		if (!errors.hasErrors()) {
			try {
				ServiceResult result = service.createBoard(boardVO);
				if (result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}
				goPage = "redirect:/resident/officeQna/officeQnaView.do?boNo=" + boardVO.getBoNo();
			} catch (DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "space/qnaForm";
				LOGGER.error("", e);
			}
		} else {
			message = INSERT_CLIENT_ERROR_MSG;
			goPage = "space/qnaForm";
		}
		if (message != null)
			model.addAttribute("message", message);
		return goPage;
	}
}
