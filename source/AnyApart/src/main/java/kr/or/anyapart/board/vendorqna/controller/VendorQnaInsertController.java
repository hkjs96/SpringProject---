/**
 * @author 박지수
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 29.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.vendorqna.controller;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.board.vendorqna.service.VendorQnaService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.validate.groups.InsertGroup2;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;

@Controller
@RequestMapping("/office/qna/qnaBoardInsert.do")
public class VendorQnaInsertController extends BaseController {

	@Inject
	private VendorQnaService service;

	@GetMapping
	public String form(@AuthenticationPrincipal(expression = "realMember") MemberVO member,
			@ModelAttribute("board") BoardVO board) {
		board.setBoWriter(member.getMemId());
		return "vendorO/qnaForm";
	}

	@PostMapping
	public String insert(@Validated(InsertGroup2.class) @ModelAttribute("board") BoardVO board, BindingResult errors,
			Model model) {
		String goPage = "vendorO/qnaForm";
		if (!errors.hasErrors()) {
			try {
				service.createBoard(board);
				return "redirect:/office/qna/qnaView.do?boNo=" + board.getBoNo();
			} catch (Exception e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
			}
		} else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		return goPage;
//		return "redirect://office/qna/qnaView.do?what"+board.getBo_no();

//		return "vendorO/qnaList";
	}

}
