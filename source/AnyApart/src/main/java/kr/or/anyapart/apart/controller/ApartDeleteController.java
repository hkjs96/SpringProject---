/**
 * @author 박지수
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.      박지수       최초작성
 * 2021. 2. 04.		박지수	단지 삭제 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.anyapart.apart.service.IApartService;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commonsweb.controller.BaseController;

@Controller
public class ApartDeleteController extends BaseController {

	@Inject
	IApartService service;
	
	@RequestMapping("/vendor/apartDelete.do")
	public String chkPass() {
		return "apart/passForm";
	}
	
	@RequestMapping(value="/vendor/apartDelete.do", method=RequestMethod.POST)
	public String insert() {
		return "apart/apartList";
	}
	
	@RequestMapping(value="/vendor/houseDelete.do", method=RequestMethod.POST)
	public @ResponseBody List<HouseVO> deleteHouse(
			@ModelAttribute("house") HouseVO house
			, Model model
			) {
//		String goPage = "/vendor/houseForm.do";
		List<HouseVO> houseList = null;
		boolean result = false;
		try {
			result = service.removeHouse(house.getHouseCode());
			if(!result) {
				model.addAttribute("message", DELETE_CLIENT_ERROR_MSG);
			}else {
				houseList = service.retrieveHouse(house.getAptCode());
//				model.addAttribute("houseList", houseList);
				model.addAttribute("message", DELETED_MSG);
//				goPage = "jsonView";
			}
		}catch (Exception e) {
			model.addAttribute("message", DELETE_SERVER_ERROR_MSG);
		}
		
//		return goPage;
		return houseList;
	}
}
