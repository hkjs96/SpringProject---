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

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.board.vendorqna.dao.IOptionDAO;
import kr.or.anyapart.board.vo.BoardVO;

@Controller
public class QnaOptionController {
	
	@Inject
	private IOptionDAO dao;
	
	@RequestMapping("/board/getOption.do")
	public String retrieveOption(Model model) {
		List<BoardVO> optionList = dao.retrieveQnaOption();
		
		model.addAttribute("option",optionList);
		
		return "jsonView";
	}
}
