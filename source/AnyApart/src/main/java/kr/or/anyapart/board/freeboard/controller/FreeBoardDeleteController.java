/**
 * @author 이경륜
 * @since 2021. 1. 28.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.freeboard.controller;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.freeboard.service.IFreeBoardService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyLayout;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class FreeBoardDeleteController extends BaseController {
	
	@Inject
	private IFreeBoardService service;
	
	/**
	 * [입주민사이트-자유게시판-상세글] 삭제
	 */
	@RequestMapping(value="/resident/space/boardDelete.do", method=RequestMethod.POST)
	public String deleteOnRes(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@Validated(DeleteGroup.class) @ModelAttribute("board") BoardVO paramBoard
			, Errors errors
			, RedirectAttributes redirectAttributes
	) {
		String goPage = "redirect:/resident/space/boardView.do?boNo="+paramBoard.getBoNo();
		NotyMessageVO message = null;
		
		if(!errors.hasErrors()) {
			paramBoard.setBoWriter(authMember.getMemId()); // service단에서 작성자명과 세션id 같은지 확인하기위해
			ServiceResult result = service.removeBoard(paramBoard);
			switch (result) {
			case OK:
				goPage = "redirect:/resident/space/boardList.do";
				break;

			default: // FAILED
				message = DELETE_SERVER_ERROR_MSG;
				break;
			}
		}else {
			message = DELETE_CLIENT_ERROR_MSG;
		}
		if(message!=null) redirectAttributes.addFlashAttribute("message",message);
		return goPage;
	}
	
	/**
	 * [관리사무소-사이트관리-자유게시판] 삭제
	 */
	@RequestMapping(value="/office/website/boardDelete.do", method=RequestMethod.POST)
	public String deleteOnOffice(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@Validated(DeleteGroup.class) @ModelAttribute("board") BoardVO paramBoard
			, Errors errors
			, RedirectAttributes redirectAttributes
			 /* 시작:검색조건 유지테스트 위해 추가됨 */
			, @RequestParam(value="page", required=false, defaultValue="1")int currentPage
			, SearchVO searchVO
			 /* 끝:검색조건 유지테스트 위해 추가됨 */
			) {
		String goPage = "redirect:/office/website/boardView.do?boNo="+paramBoard.getBoNo();
		NotyMessageVO message = null;
		
		if(!errors.hasErrors()) {
			paramBoard.setBoWriter(authMember.getMemId()); // service단에서 작성자명과 세션id 같은지 확인하기위해
			ServiceResult result = service.removeBoard(paramBoard);
			switch (result) {
			case OK:
				goPage = "redirect:/office/website/boardList.do";
				redirectAttributes.addAttribute("page", currentPage);
				redirectAttributes.addAttribute("searchType", searchVO.getSearchType());
				redirectAttributes.addAttribute("searchWord", searchVO.getSearchWord());
				break;
			default: // FAILED
				message = DELETE_SERVER_ERROR_MSG;
				break;
			}
		}else {
			message = DELETE_CLIENT_ERROR_MSG;
		}
		if(message!=null) redirectAttributes.addFlashAttribute("message",message);
		return goPage;
	}
	
	
}
