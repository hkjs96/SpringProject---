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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.freeboard.service.IFreeBoardService;
import kr.or.anyapart.board.vo.BoardFormVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;

@Controller
@RequestMapping("/resident/space/boardUpdate.do")
public class FreeBoardUpdateController extends BaseController{
	
	@Inject
	private IFreeBoardService service;
	
	@GetMapping
	public String form(
		@ModelAttribute BoardVO paramBoard
		,Model model
	) {
		BoardVO board = service.retrieveBoard(paramBoard);
		model.addAttribute("board", board);
		return "space/boardForm";
	}
	
	@PostMapping
	public String update(
		@Validated(UpdateGroup.class) @ModelAttribute("board") BoardVO board
		, BindingResult errors
		, Model model
	) {
		String goPage = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyBoard(board);
			switch (result) {
			case OK:
				goPage = "redirect:/resident/space/boardView.do?boNo="+board.getBoNo();
				break;
			default:
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				goPage = "space/boardForm";
				break;
			}
		}else { // 실패
			model.addAttribute("message", UPDATE_CLIENT_ERROR_MSG);
			goPage = "space/boardForm";
		}
		return goPage;
	}
	
	
}
