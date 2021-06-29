package kr.or.anyapart.car.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.car.service.CarService;
import kr.or.anyapart.car.vo.EnrollcarVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class CarOWholeListController extends BaseController {
	@Inject
	private CarService carservice;
	
	
	@RequestMapping("/office/carO/wholeCarList.do")
	public String list(Model model,@AuthenticationPrincipal(expression="realMember") MemberVO authMember) {
		
		EnrollcarVO carSumNumber = carservice.carSumNumber(authMember);
		model.addAttribute("carSumNumber",carSumNumber);
		return "carO/wholeCarList";
	}
	/**
	 * 모든 차량 리스트 조회
	 * @param authMember
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/carO/wholeCarListAjax.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String carList(@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,Model model ,@RequestParam("type") String type,EnrollcarVO enVO) {
		
		enVO.setApartCode(authMember.getAptCode());
		List<EnrollcarVO> carList = carservice.carAllList(enVO);
		
		model.addAttribute("carList",carList);
			
		return "jsonView";
	}
	@RequestMapping(value="/office/carO/enrollrejectAjax.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String enrollreject(@Validated(UpdateGroup.class) EnrollcarVO enVO
			,Errors errors ,Model model) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) { 
		try {
			 ServiceResult result = carservice.enrollreJect(enVO);
			 model.addAttribute("result",result);
			 message = OK_MSG;
				if(result == ServiceResult.FAILED) {
					message = UPDATE_SERVER_ERROR_MSG;
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				LOGGER.error("", e);
			}
		}else {
			message = UPDATE_CLIENT_ERROR_MSG;
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	
}
