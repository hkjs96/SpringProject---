/**
 * @author 작성자명
 * @since 2021. 3. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 3. 3.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */


package kr.or.anyapart.approval.draftatt.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.approval.draftatt.service.DraftAttService;
import kr.or.anyapart.approval.vo.DraftAttVO;
import kr.or.anyapart.commons.enumpkg.Browser;

@Controller
public class DraftAttDownController {
	@Inject
	private DraftAttService service;
	
	@RequestMapping("/draftAttDown.do")
	public String download(
			@ModelAttribute DraftAttVO param
			, @RequestHeader(value="User-Agent", required=false) String agent
			, Model model
		){
			Browser browser = Browser.getBrowserConstant(agent);
			DraftAttVO attatch = service.download(param);
			model.addAttribute("attatch", attatch);
			return "draftAttDownView";
		}
}
