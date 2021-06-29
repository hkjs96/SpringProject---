package kr.or.anyapart.board.vendorqna.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.vendorqna.service.VendorQnaService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class VendorQnaRetrieveController extends BaseController{
	
	@Inject
	private VendorQnaService service;
	
	/*
		관리사무소 
	*/
	@RequestMapping("/office/qna/qnaView.do")
	public String officeRetrieve(
			@RequestParam(value="boNo", required=false) int boNo
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("searchDetail") BoardVO searchDetail
			, @ModelAttribute("searchVO") SearchVO searchVO
			, Model model
			) {
		PagingVO<BoardVO> pagingVO = new PagingVO<BoardVO>(10, 5);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setCurrentPage(currentPage);
		
		BoardVO board = service.retrieveBoard(boNo);
		model.addAttribute("board", board);
		model.addAttribute("pagingVO", pagingVO);
		
		return "vendorO/qnaView";
	}
	
	@RequestMapping("/office/qna/qnaList.do")
	public String officeRetrieveList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
			@ModelAttribute("searchDetail") BoardVO searchDetail,
			@ModelAttribute("searchVO") SearchVO searchVO,
			@AuthenticationPrincipal(expression="realMember") MemberVO member,
			Model model
	) {
		LOGGER.info("currentPage : {}, searchType: {}, searchWord: {}", currentPage, searchVO.getSearchType(), searchVO.getSearchWord());
		
		searchDetail.setAptCode(member.getAptCode());
		
		PagingVO<BoardVO> pagingVO = new PagingVO<BoardVO>(10, 5);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(searchDetail);

		int totalRecord = service.retrieveBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<BoardVO> boardList = service.retrieveBoardList(pagingVO);
		pagingVO.setDataList(boardList);

		model.addAttribute("pagingVO", pagingVO);

		return "vendorO/qnaList";
	}
	
	@RequestMapping("/office/qna/qnaUpdate.do")
	public String officeform(
			@AuthenticationPrincipal(expression="realMember") MemberVO member
			, @RequestParam("boNo") int boNo
			, Model model
		){
		BoardVO board = service.retrieveBoard(boNo);
		model.addAttribute("board", board);
		return "vendorO/qnaForm";
	}
	
	@RequestMapping(value="/office/qna/qnaUpdate.do", method=RequestMethod.POST)
	public String officeUpdate(
			@Validated @ModelAttribute("board") BoardVO board
			, BindingResult errors
			, Model model
		){
		String goPage = "vendorO/qnaForm";
		try {
			service.modifyBoard(board);
			model.addAttribute("board", board);
			goPage="redirect:/office/qna/qnaView.do?boNo="+board.getBoNo();
		}catch (Exception e) {
			model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);  
		}finally {
			return goPage;
		}
	}
	
	@RequestMapping("/office/qna/qnaDelete.do")
	public String officeDelete(
		@RequestParam("boNo") int boNo
		, @AuthenticationPrincipal(expression="realMember") MemberVO authMember
		, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @RequestParam("boType") String boType
		, @ModelAttribute("searchType") String searchType 
		, @ModelAttribute("searchWord") String searchWord 
		, RedirectAttributes redirectAttributes
	) {
		String goPage = "redirect:/office/qna/qnaList.do";
		try {
			service.removeBoard(boNo);
		}catch (Exception e) {
			goPage = "redirect:vendor/qna/qnaView.do";
			redirectAttributes.addAttribute("boNo", boNo);
		}
		redirectAttributes.addAttribute("page", currentPage);
		redirectAttributes.addAttribute("boType", boType);
		redirectAttributes.addAttribute("searchType", searchType);
		redirectAttributes.addAttribute("searchWord", searchWord);
		return goPage;
	}
	
	
	
	/*
		벤더 사이트 쪽 
	 */
	@RequestMapping("/vendor/qna/qnaList.do")
	public String vendorRetrieveList(
		@RequestParam(value="page", required=false, defaultValue="1") int currentPage,
		@ModelAttribute("searchDetail") BoardVO searchDetail,
		@ModelAttribute("searchVO") SearchVO searchVO,
		Model model
			) {
		LOGGER.info("currentPage : {}, searchType: {}, searchWord: {}", currentPage, searchVO.getSearchType(), searchVO.getSearchWord());

		PagingVO<BoardVO> pagingVO = new PagingVO<BoardVO>(10, 5);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(searchDetail);

		int totalRecord = service.retrieveBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);

		List<BoardVO> boardList = service.retrieveBoardList(pagingVO);
		pagingVO.setDataList(boardList);
		
		service.countAnswer(pagingVO, searchDetail);
		
		model.addAttribute("pagingVO", pagingVO);
		return "qna/qnaList";
	}
	
	@RequestMapping("/vendor/qna/qnaView.do")
	public String vendorRetrieve(
		@RequestParam(value="boNo", required=false) int boNo
		, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("searchDetail") BoardVO searchDetail
		, @ModelAttribute("searchVO") SearchVO searchVO
		, Model model
		) {
		PagingVO<BoardVO> pagingVO = new PagingVO<BoardVO>(10, 5);
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setCurrentPage(currentPage);
		
		BoardVO board = service.retrieveBoard(boNo);
		model.addAttribute("board", board);
		model.addAttribute("pagingVO", pagingVO);
		return "qna/qnaView";
	}
	
	@RequestMapping("vendor/qna/qnaInsert.do")
	public String vendorInsertForm(
		@RequestParam(value="boNo", required=false) int boNo
		, Model model
		, @AuthenticationPrincipal(expression="realMember") MemberVO member
		, @ModelAttribute("board") BoardVO board
		) {
		BoardVO question = service.retrieveBoard(boNo);
		if(question == null) {
			model.addAttribute("message", boNo+" 해당 게시물은 존재 하지 않습니다.");
			return "qna/qnaList.do";
		}
		// 이미 존재하는 상위글인지 게시물을 확인하고 존재할경우 넘기고 없다면 예외페이지?
		// 또는 존재하지 않는 글이라면서 창을 띄워주어야한다.
		board.setBoParent(boNo);
		board.setBoType(question.getBoType());
		board.setBoWriter(member.getMemId());
		model.addAttribute("question", question);
		return "qna/qnaForm";
	}
	
	@RequestMapping(value="vendor/qna/qnaInsert.do", method=RequestMethod.POST)
	public String vendorInsert(
			@Validated(InsertGroup.class) @ModelAttribute("board") BoardVO board
			, BindingResult errors
			, Model model
	) {
		String goPage = "vendor/qna/qnaForm";
		if(!errors.hasErrors()) {
			try {
				service.createBoard(board);
				goPage = "redirect:/vendor/qna/qnaView.do?boNo="+board.getBoNo();
			}catch(Exception e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		return goPage;
	}
	
//	@AuthenticationPrincipal
	
	
	@RequestMapping("/vendor/qna/qnaUpdate.do")
	public String vendorUpdateForm(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			, @RequestParam("boNo") int boNo
			, Model model
			, HttpServletRequest request
		){
//		String referer = request.getHeader("Referer");
//	    return "redirect:"+ referer;
//		String goPage = "redirect:" + request.getHeader("Referer");
		String goPage = "/vendor/qna/qnaList.do";
		BoardVO board = service.retrieveBoard(boNo);
		if(board!=null) {
			model.addAttribute("board", board);
			goPage = "qna/qnaForm";
		}else {
			model.addAttribute("message", String.valueOf(boNo)+NOT_FIND_MSG);
		}
		return goPage;
	}
	
	
	@RequestMapping(value="/vendor/qna/qnaUpdate.do",method=RequestMethod.POST)
	public String vendorUpdate(
			@Validated(UpdateGroup.class) @ModelAttribute("board") BoardVO board
			, BindingResult errors
			, Model model
	) {
		String goPage = "qna/qnaForm";
		if(!errors.hasErrors()) {
			try {
				service.modifyBoard(board);
				goPage = "redirect:/vendor/qna/qnaView.do?boNo="+board.getBoNo();
			}catch(Exception e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		return goPage;
	}
	
	
	@RequestMapping("/vendor/qna/qnaDelete.do")
	public String vendorDelete(
		@RequestParam("boNo") int boNo
		, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @RequestParam("boType") String boType
		, @ModelAttribute("searchType") String searchType 
		, @ModelAttribute("searchWord") String searchWord 
		, RedirectAttributes redirectAttributes
	) {
		String goPage = "redirect:/vendor/qna/qnaList.do";
		
		try {
			service.removeBoard(boNo);
		}catch (Exception e) {
			goPage = "redirect:vendor/qna/qnaView.do";
			redirectAttributes.addAttribute("boNo", boNo);
		}
		redirectAttributes.addAttribute("page", currentPage);
		redirectAttributes.addAttribute("boType", boType);
		redirectAttributes.addAttribute("searchType", searchType);
		redirectAttributes.addAttribute("searchWord", searchWord);
		return goPage;
	}
}
