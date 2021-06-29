/**
 * @author 박지수
 * @since 2021. 2. 16.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 16.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.buy.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.asset.vo.ProdVO;
import kr.or.anyapart.board.vendorqna.dao.IOptionDAO;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class ProdIdController {
	
	@Inject
	private IOptionDAO dao;
	
	@RequestMapping("/prod/getProdId.do")
	public String retrieveOption(
			@AuthenticationPrincipal(expression="realMember") MemberVO member
			, Model model) {
		List<ProdVO> optionList = dao.retrieveProdId(member);
		
		model.addAttribute("prodId",optionList);
		
		return "jsonView";
	}
}
