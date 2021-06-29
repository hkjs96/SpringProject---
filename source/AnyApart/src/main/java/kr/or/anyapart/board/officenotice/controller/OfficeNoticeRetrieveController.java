/**
 * @author 이미정
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.    이미정           최초작성
 * 2021. 2. 15.    이미정           기존 코드 보완
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.officenotice.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.dao.DataAccessException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.officenotice.service.IOfficeNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class OfficeNoticeRetrieveController extends BaseController{
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@Inject
	private IOfficeNoticeService service;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	/**
	 * [관리사무소사이트-사이트관리-일반게시판관리-공지사항] 리스트 조회
	 */
	@RequestMapping("/office/website/officeNotice/officeNoticeList.do")
	public String listForOffice(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,@RequestParam(value="page", required=false, defaultValue="1") int currentPage
		,SearchVO searchVO 
		,Model model) {
		
		setAptCode(authMember, searchVO);
		
		PagingVO<BoardVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		try {
			int totalRecord = service.retrieveBoardCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			pagingVO.setCurrentPage(currentPage);
			
			List<BoardVO> boardList = service.retrieveBoardList(pagingVO);
			pagingVO.setDataList(boardList);
			
		}catch(DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "website/board/noticeList";
	}
	
	/**
	 * [관리사무소사이트-사이트관리-일반게시판관리-공지사항] 글 상세 조회
	 */
	@RequestMapping("/office/website/officeNotice/officeNoticeView.do")
   	public String viewForOffice(
   			@ModelAttribute BoardVO param
   			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
   			, SearchVO searchVO
			,Model model,RedirectAttributes redirectAttributes
	) {
		BoardVO boardVO = null;
		
		try {
			boardVO= service.retrieveBoard(param);
		}catch (DataAccessException e ) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("글 상세조회 에러", e);
		} catch (NullPointerException e) {
			model.addAttribute("message", getCustomNoty("해당하는 정보가 없습니다."));
			LOGGER.error("글 상세조회 에러", e);
		}
		
		if("Y".equals(boardVO.getBoDelete())) {
			redirectAttributes.addFlashAttribute("message", DELETED_MSG);
			redirectAttributes.addAttribute("page", currentPage);
			redirectAttributes.addAttribute("searchType", searchVO.getSearchType());
			redirectAttributes.addAttribute("searchWord", searchVO.getSearchWord());
			return "redirect:/office/website/officeNotice/officeNoticeList.do";
		}else {
			model.addAttribute("board", boardVO);
			return "website/board/noticeView";
		}
		
	}
	
	/**
	 * [입주민 사이트-알림마당-공지사항] 리스트 조회 
	 */
	@RequestMapping("/resident/notice/noticeList.do")
	public String listResident(@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			,SearchVO searchVO ,Model model) {
			
			setAptCode(authMember, searchVO);
			
			PagingVO<BoardVO> pagingVO = new PagingVO<>();
			pagingVO.setSearchVO(searchVO);
		try {	
			int totalRecord = service.retrieveBoardCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			pagingVO.setCurrentPage(currentPage);
			
			List<BoardVO> boardList = service.retrieveBoardList(pagingVO);
			pagingVO.setDataList(boardList);
		}catch(DataAccessException e){
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
			model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
			return "notice/noticeList";
	}
	
	/**
	 * [입주민 사이트-알림마당-공지사항] 글 상세 조회 
	 */
	@RequestMapping("/resident/officeNotice/officeNoticeView.do")
	public String view(@ModelAttribute BoardVO param
		, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, SearchVO searchVO
		,Model model,RedirectAttributes redirectAttributes
	) {
		BoardVO boardVO = null;
		
		try {
			boardVO= service.retrieveBoard(param);
		}catch (DataAccessException e ) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("글 상세조회 에러", e);
		} catch (NullPointerException e) {
			model.addAttribute("message", getCustomNoty("해당하는 정보가 없습니다."));
			LOGGER.error("글 상세조회 에러", e);
		}
		
		if("Y".equals(boardVO.getBoDelete())) {
			redirectAttributes.addFlashAttribute("message", DELETED_MSG);
			redirectAttributes.addAttribute("page", currentPage);
			redirectAttributes.addAttribute("searchType", searchVO.getSearchType());
			redirectAttributes.addAttribute("searchWord", searchVO.getSearchWord());
			return "redirect:/office/website/officeNotice/officeNoticeList.do";
		}else {
			model.addAttribute("board", boardVO);
			return "notice/noticeView";
		}
	
	}
}
