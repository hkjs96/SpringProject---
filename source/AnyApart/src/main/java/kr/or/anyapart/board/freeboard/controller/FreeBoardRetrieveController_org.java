//package kr.or.anyapart.board.freeboard.controller;
//
//import java.util.List;
//
//import javax.inject.Inject;
//
//import org.springframework.http.MediaType;
//import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.security.core.annotation.AuthenticationPrincipal;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import kr.or.anyapart.board.freeboard.service.IFreeBoardService;
//import kr.or.anyapart.board.vo.BoardFormVO;
//import kr.or.anyapart.board.vo.BoardVO;
//import kr.or.anyapart.vo.CustomPaginationInfo;
//import kr.or.anyapart.vo.MemberVO;
//import kr.or.anyapart.vo.PagingVO;
//import kr.or.anyapart.vo.SearchVO;
//import kr.or.anyapart.board.vo.NotyMessageVO;
//import kr.or.anyapart.commonsweb.controller.BaseController;
//
//@Controller
//public class FreeBoardRetrieveController_org extends BaseController{
//	
//	@Inject
//	private IFreeBoardService service;
//	
//	/**
//	 * [입주민사이트-입주민공간-자유게시판] 리스트 조회
//	 */
//	@RequestMapping("/resident/space/boardList.do")
//	public String listForRes(
//		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
//		, @RequestParam(value="page", required=false, defaultValue="1")int currentPage
//		, SearchVO searchVO
//		, Model model
//	) {
//		// mem_id에서 aptCode를 가져와 searchVO의 searchAptCode에 셋팅해주는 함수
//		setAptCode(authMember, searchVO);
//		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		
//		int totalRecord = service.retrieveBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		pagingVO.setCurrentPage(currentPage);
//		
//		List<BoardVO> boardList = service.retrieveBoardList(pagingVO);
//		pagingVO.setDataList(boardList);
//		
//		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
//		
//		return "space/boardList";
//	}
//	
//	/**
//	 * 미완
//	 * [입주민사이트-입주민공간-자유게시판] 리스트 조회 (비동기)
//	 */
//	@RequestMapping(value="/resident/space/boardList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
//	public String listForResAjax(
//			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
//			, @RequestParam(value="page", required=false, defaultValue="1")int currentPage
//			, SearchVO searchVO
//			, Model model
//	) {
//		listForRes(authMember, currentPage, searchVO, model);
//		return "jsonView";
//	}
//	
//	
//	// formVO 사용한 방식
////	@RequestMapping("/resident/space/boardList.do")
////	public String listForRes(
////		@ModelAttribute("boardFormVO") BoardFormVO boardFormVO
////		, Model model
////	) {
////		// 우선 pagingVO 로 매개변수 넘길 수 있도록 셋팅
////		PagingVO<BoardVO> pagingVO = new PagingVO<>();
////		SearchVO searchVO = new SearchVO();
////		searchVO.setSearchType(boardFormVO.getSearchBoardVO().getSearchCondition());
////		searchVO.setSearchWord(boardFormVO.getSearchBoardVO().getSearchKeyword());
////		pagingVO.setSearchVO(searchVO);
////		
////		int totalRecord = service.retrieveBoardCount(pagingVO);
////		pagingVO.setTotalRecord(totalRecord);
////		pagingVO.setCurrentPage(boardFormVO.getSearchBoardVO().getPageIndex());
////		
////		List<BoardVO> boardList = service.retrieveBoardList(pagingVO);
////		pagingVO.setDataList(boardList);
////		
////		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
////		
////		return "space/boardList";
////	}
//	
//	/**
//	 * [입주민사이트-입주민공간-자유게시판] 상세글 조회
//	 */
//	@RequestMapping("/resident/space/boardView.do")
//	public String viewForRes(
//		@ModelAttribute BoardVO param
//		, Model model
//		, RedirectAttributes redirectAttributes
//	) {
//		BoardVO board = service.retrieveBoard(param);
//		
//		// 존재하지 않는 글에 대한 처리 필요!!
//		
//		if("Y".equals(board.getBoDelete())) { // 삭제된글
//			redirectAttributes.addFlashAttribute("message", NotyMessageVO.builder("이미 삭제된 글입니다.").build());
//			return "redirect:/resident/space/boardList.do";
//		}else {
//			model.addAttribute("board", board);
//			return "space/boardView";
//		}
//	}
//	
//	/**
//	 * [관리사무소-사이트관리-자유게시판] 리스트 조회
//	 */
//	@RequestMapping("/office/website/boardList.do")
//	public String listForOffice(
//		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
//		, @RequestParam(value="page", required=false, defaultValue="1")int currentPage
//		, SearchVO searchVO
//		, Model model
//	) {
//		// mem_id에서 aptCode를 가져와 searchVO의 searchAptCode에 셋팅해주는 함수
//		setAptCode(authMember, searchVO);
//		
//		PagingVO<BoardVO> pagingVO = new PagingVO<>();
//		pagingVO.setSearchVO(searchVO);
//		
//		int totalRecord = service.retrieveBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		pagingVO.setCurrentPage(currentPage);
//		
//		List<BoardVO> boardList = service.retrieveBoardList(pagingVO);
//		pagingVO.setDataList(boardList);
//		
//		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
//		
//		return "website/board/boardList";
//	}
//	
//	/**
//	 * [관리사무소-사이트관리-자유게시판] 상세 조회
//	 */
//	@RequestMapping("/office/website/boardView.do")
//	public String viewForOffice(
//		@ModelAttribute BoardVO param
//		, Model model
//		, RedirectAttributes redirectAttributes
//	) {
//		BoardVO board = service.retrieveBoard(param);
//		
//		// 존재하지 않는 글에 대한 처리 필요!!
//		
//		if("Y".equals(board.getBoDelete())) { // 삭제된글
//			redirectAttributes.addFlashAttribute("message", NotyMessageVO.builder("이미 삭제된 글입니다.").build());
//			return "redirect:/resident/space/boardList.do";
//		}else {
//			model.addAttribute("board", board);
//			return "website/board/boardView";
//		}
//	}
//	
//}
