package kr.or.anyapart.maintenancecost.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.anyapart.maintenancecost.service.CostResidentService;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.vo.MemberVO;

@Controller
@RequestMapping("/resident/maintenanceCost")
public class FeeViewController {
	
	@Inject
	private CostResidentService service;
	/**
	 * 관리비 조회 
	 * [1. costYearList : 해당 회원의 등록되어있는 관리비 날짜 조회  (샐랙트 박스 이용)]
	 * [2. retriveExpenses :해당 회원의 최근 나온 관리비 상세 조회 ]
	 * [2. retriveExpenses(2번째): 전달 이번달 나누기 위함 ]
	 * @param authMember
	 * @param costVO
	 * @param model
	 * @return feeView.jsp
	 * @author 박찬
	 */
	@RequestMapping("feeView.do")
	public String view(@AuthenticationPrincipal(expression="realMember") MemberVO authMember , 
			CostVO costVO, Model model,
			@RequestParam(value="day",required=false, defaultValue="0" )int day) {
		costVO.setMemId(authMember.getMemId());
		List<CostVO> costYear = service.costYearList(costVO);
		if(costYear.isEmpty()) {
			CostVO defalutVO = new CostVO();
			model.addAttribute("affter",defalutVO);
			model.addAttribute("before",defalutVO);
		}else{
			if(day >= costYear.size()) {
				day = 0;
			}
			costVO.setCostNo(costYear.get(day).getCostNo());
			CostVO affterRetriveExpense = service.retriveExpenses(costVO);
			if(costYear.size()-1 > day) {
				costVO.setCostNo(costYear.get(day+1).getCostNo());
				CostVO beforeRetriveExpense = service.retriveExpenses(costVO);
				model.addAttribute("before",beforeRetriveExpense);
			}else {
				CostVO defalutVO = new CostVO();
				model.addAttribute("before",defalutVO);
			}
			
			model.addAttribute("costDay",costYear);
			model.addAttribute("affter",affterRetriveExpense);
		}
		return "maintenanceCost/feeView";
	}
	@RequestMapping("maintenaceView.do")
	public String maintenaceView(@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,CostVO costVO, Model model) {
		String memId = authMember.getMemId();
		costVO.setMemId(memId);
		costVO.setApartCode(authMember.getAptCode());
		
		List<CostVO> costTypeList = service.costTypeList(costVO);
		List<CostVO> costSameAreaList = service.costSameAreaList(costVO);
		
		model.addAttribute("costTypeList",costTypeList);
		model.addAttribute("costSameAreaList", costSameAreaList);
		return"resident/maintenanceCost/feeViewAjax/maintenaceChartJSView";
		
	}
}
