package kr.or.anyapart.commonsweb.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.anyapart.commons.enumpkg.Browser;
import kr.or.anyapart.commonsweb.service.IAttachService;
import kr.or.anyapart.vo.AttachVO;

/**
 * 파일 다운로드 컨트롤러 
 * 다운로드 필요하면 url 지정할url/download.do 사용하기
 * @author 박찬
 * */
@Controller
public class DownloadController {
	
	@Inject
	private IAttachService service;
	
	@RequestMapping("**/download.do")
	public String download(
			@ModelAttribute AttachVO param
			, @RequestHeader(value="User-Agent", required=false) String agent
			, Model model
		){
			Browser browser = Browser.getBrowserConstant(agent);
			AttachVO attatch = service.download(param);
			model.addAttribute("attatch", attatch);
			return "downloadView";
		}

}
