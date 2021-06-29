package kr.or.anyapart.commonsweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("residentIndex")
public class IndexResidentServlet {
	
	@RequestMapping("/resident")
	public String goVendor() {
		return "indexR";
	}
}
