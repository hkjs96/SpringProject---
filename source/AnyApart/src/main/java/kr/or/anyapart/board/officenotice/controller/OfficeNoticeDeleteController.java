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
 * 2021. 2. 15.      이미정       기존 코드 보완
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.board.officenotice.controller;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.officenotice.service.IOfficeNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyLayout;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;

@Controller
public class OfficeNoticeDeleteController extends BaseController{
	
	@Inject
	private IOfficeNoticeService service;
	
	/**
	 * [관리사무소사이트-사이트관리-일반게시판관리-공지사항] 글 삭제
	 */
	@RequestMapping("/office/website/officeNotice/officeNoticeDelete.do")
	public String removeForOffice(
			@Validated(DeleteGroup.class) @ModelAttribute("board") BoardVO boardVO
			,Errors errors, RedirectAttributes redirectAttributes
			,Model model) {
		String goPage= null;
		NotyMessageVO message = null;
		
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = service.removeBoard(boardVO);
				if(result == ServiceResult.FAILED) {
					message = DELETE_SERVER_ERROR_MSG;
				}
				goPage = "redirect:/office/website/officeNotice/officeNoticeList.do";
			}catch(DataAccessException e) {
				model.addAttribute("message", DELETE_SERVER_ERROR_MSG);
				LOGGER.error("", e);
				goPage = "office/website/officeNotice/officeNoticeView.do/?boNo="+boardVO.getBoNo();
			}
		}else {
			message = DELETE_CLIENT_ERROR_MSG;
			goPage = "office/website/officeNotice/officeNoticeView.do/?boNo="+boardVO.getBoNo();
		}
		if (message!= null)
			redirectAttributes.addFlashAttribute("message", message);
		return goPage;
	}
	
}
