package kr.or.anyapart.board.vendornotice.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.vendornotice.service.VendorNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class VendorNoticeRetrieveController {
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	
	@Inject
	private VendorNoticeService service;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	/**
	 * 벤더 사이트에서 관리사무소 공지사항 리스트 조회
	 * @param currentPage
	 * @param model
	 * @return
	 * @author 박찬
	 */
	@RequestMapping("/vendor/noticeList.do")
	public String vendorNoticelistV(@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			 ,@ModelAttribute("searchVO")  SearchVO searchVO, Model model) {
		PagingVO<BoardVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		
		int totalRecord = service.retrieveBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<BoardVO> BoardList = service.retrieveBoardList(pagingVO);
		
		pagingVO.setDataList(BoardList);
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("paginationInfo", new CustomPaginationInfo<BoardVO>(pagingVO));
		
		return "noticeV/noticeList";
	}
	
	/**
	 * 관리사무소에서 벤더 공지사항 글 리스트 조회
	 * @return
	 * @author 박찬
	 */
	@RequestMapping("/office/notice/noticeList.do")
	public String vendorNoticelistO(@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			 ,@ModelAttribute("searchVO")  SearchVO searchVO, Model model) {
		PagingVO<BoardVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		
		int totalRecord = service.retrieveBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<BoardVO> BoardList = service.retrieveBoardList(pagingVO);
		
		pagingVO.setDataList(BoardList);
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("paginationInfo", new CustomPaginationInfo<BoardVO>(pagingVO));
		
		return "vendorO/noticeList";
	}
	
	/**
	 * 벤더 공지사항 상세보기
	 * @return
	 * @author 박찬
	 */
	@RequestMapping("/vendor/noticeView.do")
	public String vendorNoticeView(@ModelAttribute BoardVO param
			,Model model,RedirectAttributes redirectAttributes) {
		
		BoardVO boardVO= service.retrieveBoard(param);
		if("Y".equals(boardVO.getBoDelete())) {
			redirectAttributes.addFlashAttribute("message", NotyMessageVO.builder("이미 삭제된 글임.").build());
			return "redirect:/vendor/noticeList.do";
		}else {
			model.addAttribute("board", boardVO);
			return "noticeV/noticeView";
		}
	}
	
	
	/** 
	 * 관리사무소에서 벤더 공지사항 상세보기
	 * 
	 */
	@RequestMapping("/office/notice/noticeView.do")
	public String vendorNoticeViewO(@ModelAttribute BoardVO param
			,Model model,RedirectAttributes redirectAttributes) {
		
		BoardVO boardVO= service.retrieveBoard(param);
		if("Y".equals(boardVO.getBoDelete())) {
			redirectAttributes.addFlashAttribute("message", NotyMessageVO.builder("이미 삭제된 글임.").build());
			return "redirect:/vendor/noticeList.do";
		}else {
			model.addAttribute("board", boardVO);
			return "vendorO/noticeView";
		}
	}
}
