/**
 * @author 박지수
 * @since 2021. 2. 18.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 18.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.repair.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.asset.vo.ProdVO;
import kr.or.anyapart.board.vendorqna.dao.IOptionDAO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class RepairOptionController {
	
	@Inject
	private IOptionDAO dao;
	
	@RequestMapping("/prod/getRepairOption.do")
	public String retrieveOption(
			@AuthenticationPrincipal(expression="realMember") MemberVO member
			, Model model) {
		List<CodeVO> optionList1 = dao.retrieveRepairOption();
		List<ProdVO> optionList2 = dao.retrieveRepairProdId(member);
		List<CodeVO> optionList3 = dao.retrieveProdOption();
		List<ProdVO> optionList4 = dao.retrieveProdId(member);
		
		
		
		model.addAttribute("prodCodeList",optionList1);
		model.addAttribute("prodIdList",optionList2);
		model.addAttribute("prodCodeListInsert",optionList3);
		model.addAttribute("prodIdListInsert",optionList4);
		
		return "jsonView";
	}
}
