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
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.officenotice.service.IOfficeNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class OfficeNoticeUpdateController extends BaseController{
	
	@Inject
	private IOfficeNoticeService service;
	
	/**
	 * [관리사무소사이트-사이트관리-일반게시판관리-공지사항] 글 수정을 위한 폼
	 */
	@RequestMapping("/office/website/officeNotice/officeNoticeUpdate.do")
	public String officeNoticeUpdateForm(
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
			return "website/board/noticeForm";
	}
	
	/**
	 * [관리사무소사이트-사이트관리-일반게시판관리-공지사항] 글 수정
	 */
	@RequestMapping(value="/office/website/officeNotice/officeNoticeUpdate.do", method=RequestMethod.POST)
	public String officeNoticeUpdate(
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
				goPage = "redirect:/office/website/officeNotice/officeNoticeView.do?boNo="+board.getBoNo();
				if(result == ServiceResult.FAILED) {
					message = UPDATE_SERVER_ERROR_MSG;
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				goPage = "office/website/officeNotice/officeNoticeUpdate.do?boNo="+board.getBoNo();
				LOGGER.error("", e);
			}
		}else {
			model.addAttribute("message", UPDATE_CLIENT_ERROR_MSG);
			goPage = "website/board/noticeForm";
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
		}
}
