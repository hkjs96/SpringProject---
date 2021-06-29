/**
 * @author 박정민
 * @since 2021. 2. 5.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                                             수정자                            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 5.       작성자명         최초작성
 * Copyright (c) 2021. 2. 5. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.document.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.document.dao.IDocumentDAO;
import kr.or.anyapart.document.service.IDocumentService;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

/**
 * 관리자페이지 일반문서함 
 * @author 박정민
 */
@Controller
public class documentController extends BaseController{
	@Inject
	private IDocumentService service;
	
	@Inject
	private IDocumentDAO dao;
	
	@ModelAttribute("boardVO")
	public BoardVO boardVO() {
		return new BoardVO();
	}
	
	/**
	 * 일반문서 목록 조회
	 * @return
	 */
	@RequestMapping("/office/document/documentList.do")
	public String list(PagingVO<BoardVO> pagingVO, Model model,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		int totalRecord = 0;
		if(pagingVO.getSearchVO()==null) {
			SearchVO searchVO = new SearchVO();
			searchVO.setSearchAptCode(authMember.getAptCode());
			pagingVO.setSearchVO(searchVO);
		}else {
			pagingVO.getSearchVO().setSearchAptCode((authMember.getAptCode()));
		}
		
		try {
			totalRecord = service.retreiveDocumentCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
		} catch (Exception e) {
			LOGGER.info(""+e);
		}
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "document/documentList";
	}
	
	/**
	 * 일반문서 목록 조회 Ajax
	 * @return
	 */
	@RequestMapping(value="/office/document/documentList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<BoardVO> listAjax(PagingVO<BoardVO> pagingVO, Model model,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		int totalRecord = 0;
		List<BoardVO> dataList = new ArrayList<>();
		if(pagingVO.getSearchVO()==null) {
			SearchVO searchVO = new SearchVO();
			searchVO.setSearchAptCode(authMember.getAptCode());
			pagingVO.setSearchVO(searchVO);
		}else {
			pagingVO.getSearchVO().setSearchAptCode((authMember.getAptCode()));
		}
		try {
			totalRecord = service.retreiveDocumentCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			dataList = service.retreiveDocumentList(pagingVO);
		} catch (Exception e) {
			LOGGER.info(""+e);
		}
		return dataList;
	}
	
	/**
	 * 일반문서 상세조회
	 * @param boardVO
	 * @return
	 */
	@RequestMapping(value="/office/document/documentView.do")
	public String view(BoardVO boardVO, Model model) {
		BoardVO boVO = new BoardVO();
		try {
			boVO = service.retreiveDocument(boardVO);
		} catch (Exception e) {
			LOGGER.info(""+e);
		}
		model.addAttribute("boardVO", boVO);
		return "office/document/ajax/documentViewModal";
	}
	
	/**
	 * 일반문서 등록 폼으로 이동
	 * @param boardVO
	 * @param authMember
	 * @return
	 */
	@RequestMapping("/office/document/documentInsert.do")
	public String goForm(BoardVO boardVO, PagingVO<BoardVO> pagingVO, Model model,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		model.addAttribute("pagingVO", pagingVO);
		return "office/document/ajax/documentForm";
	}
	
	/**
	 * 일반문서 등록
	 * @param boardVO
	 * @return
	 */
	@RequestMapping(value="/office/document/documentInsert.do", method=RequestMethod.POST)
	public String insert(@ModelAttribute("boardVO")BoardVO boardVO, BindingResult errors, 
			RedirectAttributes rttr, Model model, PagingVO<BoardVO> pagingVO) {
		String goPage = "redirect:/office/document/documentList.do";
		String message = "서버오류. 등록실패";
		if(!errors.hasErrors()) {
			try {
				int cnt = service.insertDocument(boardVO);
				if(cnt>0) {
					message = "등록되었습니다.";
					rttr.addFlashAttribute("message", NotyMessageVO.builder(message).type(NotyType.success).build());
					rttr.addAttribute("currentPage", pagingVO.getCurrentPage());
					rttr.addAttribute("searchVO.searchWord", pagingVO.getSearchVO().getSearchWord());
				}
			} catch (Exception e) {
				rttr.addFlashAttribute("message", NotyMessageVO.builder(message).build());
				LOGGER.info(""+e);
			}
		}
		return goPage;
	}
	
	/**
	 * 일반문서 수정 폼으로 이동전에 본인글인지 아이디 체크
	 * @param boardVO
	 * @param authMember
	 * @return
	 */
	@RequestMapping(value="/office/document/chkUpdateId.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
	public String chkUpdateId(BoardVO board, Model model,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		BoardVO boardVO = new BoardVO();
		try {
			boardVO = dao.selectDocument(board);
			if(boardVO.getBoWriter().equals(authMember.getMemId())) {
				model.addAttribute("message", "동일");
			}else {
				model.addAttribute("message", "다름");
			}
		} catch (Exception e) {
			LOGGER.info(""+e);
		}
		return "jsonView";
	}
	
	/**
	 * 일반문서 수정 폼으로 이동
	 * @param boardVO
	 * @param authMember
	 * @return
	 */
	@RequestMapping("/office/document/documentUpdate.do")
	public String goFormUpdate(BoardVO board, Model model, PagingVO<BoardVO> pagingVO,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember,
			RedirectAttributes rttr) {
		String goPage = "office/document/ajax/documentForm";
		BoardVO boardVO = new BoardVO();
		try {
			boardVO = service.retreiveDocument(board);
		} catch (Exception e) {
			LOGGER.info(""+e);
		}
		model.addAttribute("command", "MODIFY");
		model.addAttribute("boardVO", boardVO);
		return goPage;
	}
	
	/**
	 * 일반문서 수정 
	 * @param boardVO
	 * @param authMember
	 * @return
	 */
	@RequestMapping(value="/office/document/documentUpdate.do", method=RequestMethod.POST)
	public String update(BoardVO board, Model model, 
			RedirectAttributes rttr, PagingVO<BoardVO> pagingVO,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		String goPage = "document/documentForm";
		String message = "서버오류.수정 실패";
		int cnt = 0;
		try {
			cnt = service.updateDocument(board);
			if(cnt>0) {
				goPage = "redirect:/office/document/documentList.do";
				rttr.addFlashAttribute("message", NotyMessageVO.builder("수정되었습니다.").type(NotyType.success).build());
				rttr.addAttribute("currentPage", pagingVO.getCurrentPage());
				rttr.addAttribute("searchVO.searchWord", pagingVO.getSearchVO().getSearchWord());
			}else {
				model.addAttribute("command", "MODIFY");
				model.addAttribute("message", NotyMessageVO.builder(message).build());
			}
		} catch (Exception e) {
			LOGGER.info(""+e);
		}
		return goPage;
	}

	/**
	 * 일반문서 삭제
	 * @param boardVO
	 * @param authMember
	 * @return
	 */
	@RequestMapping("/office/document/documentDelete.do")
	public String remove(BoardVO boardVO, Model model, RedirectAttributes rttr, 
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		String message = "서버오류. 실패";
		int cnt;
		try {
			cnt = service.deleteDocument(boardVO, authMember);
			if(cnt>0) {
				rttr.addFlashAttribute("message", NotyMessageVO.builder("삭제되었습니다.").type(NotyType.success).build());
			}else if(cnt==-1){
				rttr.addFlashAttribute("message", NotyMessageVO.builder("본인이 작성한 글만 삭제할 수 있습니다.").build());
			}else {
				rttr.addFlashAttribute("message", NotyMessageVO.builder(message).build());
			}
		} catch (Exception e) {
			LOGGER.info(""+e);
		}
		return "redirect:/office/document/documentList.do";
	}

}
