package kr.or.anyapart.car.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.car.service.CarService;
import kr.or.anyapart.car.vo.CarVO;
import kr.or.anyapart.car.vo.EnrollcarVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.maintenancecost.service.CostResidentService;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.BaseVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.ResidentMenuVO;


@Controller
public class ResidentCarController extends BaseController {
	@Inject
	private CostResidentService user;
	@Inject
	private CarService carservice;
	
	@RequestMapping("/resident/car/residentCar.do")
	public String view() {
		return "car/residentCar";
	}
	@RequestMapping(value="/resident/car/residentCarList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String carList(@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,Model model) {
			List<CarVO> userInpossessionCarList = carservice.userInpossessionCarList(authMember);
			ResidentVO userVO =user.userComent(authMember);
			List<EnrollcarVO> enrollList = carservice.enrollList(authMember);
			model.addAttribute("enrollList",enrollList);
			model.addAttribute("userInfo",userVO);
			model.addAttribute("inPoCarList",userInpossessionCarList);
		return "jsonView";
	}
	
	
	/**
	 * 입주민 차량 등록 폼
	 * @param authMember
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/resident/car/registRCar.do", method=RequestMethod.GET)
	public String regist(@AuthenticationPrincipal(expression="realMember") MemberVO authMember,Model
			model) {
		ResidentVO userVO =user.userComent(authMember);
		List<CodeVO> carCodeList = carservice.carCodeList();
		ResidentMenuVO menuVO = new ResidentMenuVO();
		menuVO.setTitle("차량관리");
		menuVO.setSubTitle("내 차량 관리");
		model.addAttribute("menuVO", menuVO);
		model.addAttribute("carCode",carCodeList);
		model.addAttribute("userVO", userVO);
		return "car/registRCar";
	}
	/**
	 * 입주민 차량 등록 
	 * @param carVO
	 * @param authMember
	 * @param errors
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/resident/car/registRCar.do" ,method=RequestMethod.POST)
	public String registInsert(@Validated(InsertGroup.class)CarVO carVO,
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember,
			Errors errors,Model model) {
		String goPage = "";
		NotyMessageVO message = null;

		if(!errors.hasErrors()) {
				try {
					carVO.setCarCode("CR");
					carVO.setMemId(authMember.getMemId());
					ServiceResult result = carservice.residentCarAdd(carVO);
//					model.addAttribute("result",result);
					goPage= "redirect:/resident/car/residentCar.do";
					if(result == ServiceResult.FAILED) {
						message = getCustomNoty("해당 차량번호는 이미 등록되어있습니다.");
						goPage= "car/registRCar";
						ResidentVO userVO =user.userComent(authMember);
						model.addAttribute("userVO",userVO);
						model.addAttribute("carVO",carVO);
					}else { // result == ALREADYEXISTS
						message = getCustomNoty("차량신청을 성공하였습니다.");
						goPage= "car/residentCar";
					}
				} catch (DataAccessException e) {
					model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
					LOGGER.error("", e);
					}
			}else {
				message = INSERT_CLIENT_ERROR_MSG;
			}
				//등록전 차량 확인 후 없으면 등록 처리
		if(message!=null) model.addAttribute("message", message);
		return goPage;
	}
}
