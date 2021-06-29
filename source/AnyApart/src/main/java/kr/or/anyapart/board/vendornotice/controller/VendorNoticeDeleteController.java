package kr.or.anyapart.board.vendornotice.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.vendornotice.service.VendorNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyLayout;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;

@Controller
public class VendorNoticeDeleteController {

	@Inject
	private VendorNoticeService service;

	@RequestMapping("/vendor/noticeDelete.do")
	public String delete(@Validated(DeleteGroup.class) @ModelAttribute("board") BoardVO board, Errors errors,
			RedirectAttributes redirectAttributes) {
		String goPage = "redirect:/vendor/" + board.getBoNo();
		NotyMessageVO message = null;

		if (!errors.hasErrors()) {
			ServiceResult result = service.removeBoard(board);
			switch (result) {
			case OK:
				goPage = "redirect:/vendor/noticeList.do";
				break;
			default:
				message = NotyMessageVO.builder("서버 오류").type(NotyType.error).layout(NotyLayout.topCenter).timeout(3000)
						.build();
				goPage = "redirect:/vendor/noticeList.do";
				break;
			}
		}
		if (message != null)
			redirectAttributes.addFlashAttribute("message", message);
		return goPage;
	}
}
