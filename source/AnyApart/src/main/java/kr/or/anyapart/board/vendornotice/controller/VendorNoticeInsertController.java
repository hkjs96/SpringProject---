package kr.or.anyapart.board.vendornotice.controller;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.board.vendornotice.service.VendorNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;

/**
 * 
 * 벤더가 작성한  공지사항 등록 폼
 * @author 박찬
 *
 */
@Controller
@RequestMapping("/vendor/noticeForm.do")
public class VendorNoticeInsertController extends BaseController{

	@Inject
	private VendorNoticeService service;
	
	@GetMapping
	public String form() {
		return "noticeV/noticeForm";
	}
	
	@PostMapping
	public String insertForm(@Validated(InsertGroup.class)@ModelAttribute("board") BoardVO board
	,BindingResult errors
	,Model model) {
		String goPage = null;
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
			ServiceResult result = service.createNoticeBoard(board);
			if(result == ServiceResult.FAILED) {
				message = INSERT_SERVER_ERROR_MSG;
			}
			goPage =  "redirect:/vendor/noticeView.do?boNo="+board.getBoNo();
			}catch(DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "noticeV/noticeForm";
				LOGGER.error("",e);
			}
		}else {
			message = INSERT_CLIENT_ERROR_MSG;
			goPage = "noticeV/noticeForm";
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
		
	}
	
}
