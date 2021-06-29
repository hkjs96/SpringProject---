package kr.or.anyapart.car.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.print.DocFlavor.SERVICE_FORMATTED;

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
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class CarOResidentController extends BaseController{
	
	@Inject
	private CarService carservice ;
	@RequestMapping("/office/carO/residentCarList.do")
	public String list(Model model ,@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,EnrollcarVO enVO) {
		enVO.setApartCode(authMember.getAptCode());
		EnrollcarVO carSumNumber = carservice.carAllSumNumber(authMember);
		List<EnrollcarVO> dongList = carservice.dongList(enVO);
		List<String> dongList2 = new ArrayList<String>();
		for(int i=0; i<dongList.size(); i++) {
			if(!dongList2.contains(dongList.get(i).getDong())){
				dongList2.add(dongList.get(i).getDong());
			}
				
		}
		model.addAttribute("dong",dongList2);
		model.addAttribute("carSumNumber",carSumNumber);
		return "carO/residentCarList";
	}
	
	
	/**
	 * 모든 차량 리스트 조회
	 * @param authMember
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/carO/residentCarListAll.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String carList(@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,Model model ,EnrollcarVO enVO) {
		
		enVO.setApartCode(authMember.getAptCode());
		List<EnrollcarVO> carList = carservice.residentCarListALL(enVO);
		
		model.addAttribute("carList",carList);
			
		return "jsonView";
	}
	
	@RequestMapping(value="/office/carO/residentDongHo.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String residentDongCar(Model model,@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,EnrollcarVO enVO) {
		enVO.setApartCode(authMember.getAptCode());
		List<EnrollcarVO> dongList = carservice.dongList(enVO);
		
		model.addAttribute("ho",dongList);
		
		return "jsonView";
	}
	
	/**
	 * 차량 등록폼
	 * @return
	 */
	@RequestMapping(value="/office/carO/residentCarAdd.do")
	public String residentCarAdd(Model model) {
		List<CodeVO> carCodeList = carservice.carCodeList();
		
		model.addAttribute("carCodeList",carCodeList);
		return "/office/carO/modalAjax/residentCarForm";
	}
	
	/** 
	 * 차량 등록 
	 * @param carVO
	 * @param authMember
	 * @param errors
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/carO/residentCarAdd.do" ,method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String registInsert(@Validated(InsertGroup.class)CarVO carVO,
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember,
			Errors errors,Model model) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
				try {
					ServiceResult result = carservice.officeCarAdd(carVO);
//					model.addAttribute("result",result);
					if(result == ServiceResult.FAILED) {
						message = getCustomNoty("해당 차량번호는 이미 등록되어있습니다.");
						model.addAttribute("carVO",carVO);
					}else { // result == ALREADYEXISTS
						message = OK_MSG;
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
		return "jsonView";
	}
	
	@RequestMapping(value="/office/carO/residentInfo.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String residentInfo(@AuthenticationPrincipal(expression="realMember") MemberVO authMember,
			ResidentVO residentVO, Model model) {
		NotyMessageVO message =null;
		residentVO.setAptCode(authMember.getAptCode());
		ResidentVO residentInfo = carservice.residentInfo(residentVO);
		if(residentInfo ==null) {
			message = getCustomNoty("잘못 입력 하였습니다. 동/호수를 확인해주세요.");
		}else {
			model.addAttribute("residentInfo",residentInfo);
			message = OK_MSG;
		}
		model.addAttribute("message",message);
		return "jsonView";
	}
	
	@RequestMapping(value="/office/carO/residentCarDel.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String residentCarDel(@Validated(DeleteGroup.class) CarVO carVO,
			Errors errors, Model model) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result =  carservice.residentCarDelete(carVO);
				if(result == ServiceResult.OK) {
					message = OK_MSG;
				}
				else if(result == ServiceResult.FAILED) {
					message =DELETE_SERVER_ERROR_MSG;
				}else {
					message =DELETE_CLIENT_ERROR_MSG;
				}
			}catch (DataAccessException e) {
				message= DELETE_SERVER_ERROR_MSG;
			}
		}else {
			message = DELETE_CLIENT_ERROR_MSG;
		}
		if(message != null) {
			model.addAttribute("message",message);
		}
		return "jsonView";
	}
}
