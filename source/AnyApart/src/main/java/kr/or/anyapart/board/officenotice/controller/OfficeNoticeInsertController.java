/**
 * @author 이미정
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.     이미정       최초작성
 * 2021. 2. 15.     이미정       기존 코드 보완
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.board.officenotice.controller;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.anyapart.board.officenotice.service.IOfficeNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;


@Controller
public class OfficeNoticeInsertController extends BaseController{
	
	@Inject
	private IOfficeNoticeService service;

	/**
	 * [관리사무소사이트-사이트관리-일반게시판관리-공지사항] 글 등록  폼
	 */
	@RequestMapping("/office/website/officeNotice/officeNoticeForm.do")
	public String insertForm() {
		return "website/board/noticeForm";
	}
	
	/**
	 * [관리사무소사이트-사이트관리-일반게시판관리-공지사항] 글 등록
	 */
	@RequestMapping(value="/office/website/officeNotice/officeNoticeForm.do", method=RequestMethod.POST)
	public String insert(@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @Validated(InsertGroup.class)@ModelAttribute("board") BoardVO boardVO
			, BindingResult errors, Model model){
		String goPage = null;
		NotyMessageVO message = null;
		if(boardVO!=null) {
			boardVO.setBoWriter(authMember.getMemId());
		}
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = service.createBoard(boardVO);
				if(result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}
				goPage = "redirect:/office/website/officeNotice/officeNoticeView.do?boNo="+boardVO.getBoNo();
			}catch(DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "website/board/noticeForm";
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
