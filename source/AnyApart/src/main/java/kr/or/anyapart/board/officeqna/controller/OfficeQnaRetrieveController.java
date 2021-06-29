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

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.officeqna.dao.IOfficeQnaDAO;
import kr.or.anyapart.board.officeqna.service.IOfficeQnaService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class OfficeQnaRetrieveController extends BaseController{
	
	@Inject
	private WebApplicationContext container;
	private ServletContext application;

	@Inject
	private IOfficeQnaService service;
	
	@Inject
	private IOfficeQnaDAO dao;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	
	
	/**
	 * [관리사무소사이트-사이트관리-민원관리-문의게시판관리] 리스트 조회
	 */
	@RequestMapping("/office/website/officeQna/officeQnaList.do")
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
			return "website/complaint/qnaList";
			
	}
	
	
	/**
	 * [관리사무소사이트-사이트관리-민원관리-문의게시판관리] 글 상세 조회
	 */
	@RequestMapping("/office/website/officeQna/officeQnaView.do")
   	public String viewForOffice(
   			@ModelAttribute BoardVO param
   			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
   			, SearchVO searchVO
			,Model model,RedirectAttributes redirectAttributes
	) {
		
		BoardVO boardVO= service.retrieveBoard(param);
		
		if("Y".equals(boardVO.getBoDelete())) {
			redirectAttributes.addFlashAttribute("message", DELETED_MSG);
			redirectAttributes.addAttribute("page", currentPage);
			redirectAttributes.addAttribute("searchType", searchVO.getSearchType());
			redirectAttributes.addAttribute("searchWord", searchVO.getSearchWord());
			return "redirect:/office/website/officeQna/officeQnaList.do";
		}else {
			model.addAttribute("board", boardVO);
			return "website/complaint/qnaView";
		}
	}
	
	/**
	 * [관리사무소사이트-대쉬보드-Qna] 글 상세 
	 */
	@RequestMapping(value = "/office/website/officeQna/officeQnaDashView.do"
				  , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String Dashboardview(
			@ModelAttribute BoardVO param
			,Model model,RedirectAttributes redirectAttributes
			) {
		NotyMessageVO message = null;
		BoardVO boardVO = null;
		try {
			boardVO= service.retrieveBoard(param);
			if(boardVO==null) {
				message = SELECT_SERVER_ERROR_MSG;
			}
		}catch(DataAccessException e) {
			message = SELECT_SERVER_ERROR_MSG;
		}
		
		if(message!=null) model.addAttribute("message", message);
		model.addAttribute("board", boardVO);
		
		return "jsonView";
	}
	
	/**
	 * [입주민사이트-입주민공간-문의하기] 리스트 조회
	 */
	@RequestMapping("/resident/officeQna/officeQnaList.do")
	public String listForResident(
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
			return "space/qnaList";
	}
	
	/**
	 * [입주민사이트-입주민공간-문의하기] 글 상세 조회
	 */
	@RequestMapping("/resident/officeQna/officeQnaView.do")
   	public String viewForResident(
   			@ModelAttribute BoardVO param
   			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
   			, SearchVO searchVO
			,Model model,RedirectAttributes redirectAttributes
	) {
		
		BoardVO boardVO= service.retrieveBoard(param);
		
		if("Y".equals(boardVO.getBoDelete())) {
			redirectAttributes.addFlashAttribute("message", DELETED_MSG);
			redirectAttributes.addAttribute("page", currentPage);
			redirectAttributes.addAttribute("searchType", searchVO.getSearchType());
			redirectAttributes.addAttribute("searchWord", searchVO.getSearchWord());
			return "redirect:/resident/space/qnaList.do";
		}else {
			model.addAttribute("board", boardVO);
			return "space/qnaView";
		}
	}
	
	@RequestMapping("/office/website/officeQna/repChk.do")
   	public String replyChk(
   			@ModelAttribute BoardVO param
   			,Model model) {
		BoardVO boardVO = dao.answerChk(param);
		
		if(boardVO!=null) {
			model.addAttribute("answerChk", boardVO);
		}
		
		return "jsonView";
	}
   	
}
