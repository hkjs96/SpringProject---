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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.vendornotice.service.VendorNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class VendorNoticeUpdateController extends BaseController {

	@Inject
	private VendorNoticeService service;
	
	@RequestMapping("/vendor/noticeUpdate.do")
	public String vendorNoticeUpdateForm(@ModelAttribute BoardVO param
		, Model model
		){
		
			BoardVO board =service.retrieveBoard(param);
			
			model.addAttribute("board", board);
			return "noticeV/noticeForm";
	}
	
	
	@RequestMapping(value="/vendor/noticeUpdate.do" ,method=RequestMethod.POST)
	public String vendorNoticeUpdateDo(@Validated(UpdateGroup.class)
	@ModelAttribute("board") BoardVO board
	, BindingResult errors
	, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
	, Model model, RedirectAttributes redirectAttributes, @ModelAttribute SearchVO searchVO) {
		String goPage = null;
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
			ServiceResult result = service.modifyBoard(board);
			goPage =  "redirect:/vendor/noticeView.do?boNo="+board.getBoNo();
			if(result == ServiceResult.FAILED) {
				message = UPDATE_SERVER_ERROR_MSG;
			}
			}catch (DataAccessException e) {
				message= UPDATE_SERVER_ERROR_MSG;
				goPage = "vendor/noticeUpdate.do?boNo="+board.getBoNo();
				LOGGER.error("", e);
			}
		}else {
			message= UPDATE_CLIENT_ERROR_MSG;
			goPage = "vendor/noticeUpdate.do?boNo="+board.getBoNo();
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
	}
	
}
