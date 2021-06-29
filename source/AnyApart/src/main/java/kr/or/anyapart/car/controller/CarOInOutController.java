package kr.or.anyapart.car.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.car.service.CarService;
import kr.or.anyapart.car.vo.CarIOVO;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class CarOInOutController {
	@Inject
	private CarService service;
	@RequestMapping("/office/carO/carInOutList.do")
	public String list() {
		
		return "carO/apartCarInOutView";
	}
	
	@RequestMapping(value="/office/carO/carInOutListTable.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String carIOList(CarIOVO carVO,Model model,@AuthenticationPrincipal(expression="realMember") MemberVO authMember) {
		
		carVO.setAptCode(authMember.getAptCode());
		List<CarIOVO> carIOList = service.carIOList(carVO);
		model.addAttribute("carIOList" ,carIOList);
		return "jsonView";
	}
	
	@RequestMapping(value="/office/carO/carNewCount.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String carCountNewCarNumber(@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,Model model) {
		int carCount = service.inCarCount(authMember);
		String newCarNumber = service.necarNumber();
		model.addAttribute("newCarNumber",newCarNumber);
		model.addAttribute("carCount",carCount);
		return "jsonView";
	}
}
