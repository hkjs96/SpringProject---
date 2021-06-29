/**
 * @author 박지수
 * @since 2021. 2. 2.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 2.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.board.vendorqna.dao.IOptionDAO;
import kr.or.anyapart.vo.CodeVO;

@Controller
public class ApartOptionController {
	
	@Inject
	private IOptionDAO dao;
	
	@RequestMapping("/vendor/apartOption.do")
	public String retrieveOption(Model model) {
		List<CodeVO> optionList = dao.retrieveApartOption();
		
		model.addAttribute("option",optionList);
		
		return "jsonView";
	}
	
	@RequestMapping("/office/setting/apartOption.do")
	public String Option(Model model) {
		List<CodeVO> optionList = dao.retrieveApartOption();
		
		model.addAttribute("option",optionList);
		
		return "jsonView";
	}
}
