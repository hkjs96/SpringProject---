package kr.or.anyapart.commonsweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("Index")
public class IndexController{
	
	@RequestMapping("/index.do")
	public String index() {
		return "index";
	}
}
