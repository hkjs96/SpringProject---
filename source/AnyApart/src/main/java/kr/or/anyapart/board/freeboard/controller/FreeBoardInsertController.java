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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.board.freeboard.service.IFreeBoardService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;

@Controller
@RequestMapping("/resident/space/boardInsert.do")
public class FreeBoardInsertController extends BaseController{
	
	@Inject
	private IFreeBoardService service;
	
	@ModelAttribute("board")
	public BoardVO board() {
		return new BoardVO();
	}
	
	/**
	 * [입주민사이트-입주민공간-자유게시판] 게시글 등록  폼 화면
	 */
	@GetMapping
	public String form() {
		return "space/boardForm";
	}
	
	/**
	 * [입주민사이트-입주민공간-자유게시판] 게시글 등록 
	 */
	@PostMapping
	public String insert(
		@Validated(InsertGroup.class) @ModelAttribute("board") BoardVO board
		,BindingResult errors
		,Model model
	) {
		String goPage = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createBoard(board);
			switch (result) {
			case OK:
				goPage = "redirect:/resident/space/boardView.do?boNo="+board.getBoNo();
				break;
			default:
				model.addAttribute("message", DELETED_MSG);
				goPage = "space/boardList";
				break;
			}
		}else { // 실패
			goPage = "space/boardForm";
		}
		return goPage;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * FormVO 방식으로 할 경우
	 */
//	@Inject
//	private IFreeBoardService service;
	
//	@ModelAttribute("boardFormVO")
//	public BoardFormVO boardForm() {
//		return new BoardFormVO();
//	}
	
//	/**
//	 * [입주민사이트-입주민공간-자유게시판] 게시글 등록  폼 화면
//	 */
//	@GetMapping
//	public String form() {
//		return "space/boardForm";
//	}
//	
//	/**
//	 * [입주민사이트-입주민공간-자유게시판] 게시글 등록 
//	 */
//	@PostMapping
//	public String insert(
//		@Validated(InsertGroup.class) @ModelAttribute("boardFormVO") BoardFormVO boardFormVO
//		,BindingResult errors
//		,Model model
//	) {
//		String goPage = null;
//		
//		if(!errors.hasErrors()) {
//			ServiceResult result = service.createBoard(boardFormVO.getBoardVO());
//			switch (result) {
//			case OK:
//				goPage = "redirect:/resident/space/boardView.do?boNo="+boardFormVO.getBoardVO().getBoNo();
//				break;
//			default:
//				model.addAttribute("message", NotyMessageVO.builder("서버 오류로 글 등록에 실패했습니다.").build());
//				goPage = "space/boardList";
//				break;
//			}
//		}else { // 실패
//			goPage = "space/boardForm";
//		}
//		return goPage;
//	}
}
