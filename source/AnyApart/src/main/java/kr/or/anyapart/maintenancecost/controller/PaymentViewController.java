package kr.or.anyapart.maintenancecost.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.maintenancecost.service.CostResidentService;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class PaymentViewController {
	@Inject
	private CostResidentService service;
	
	@RequestMapping("/resident/maintenanceCost/feePayment.do")
	public String pay(@AuthenticationPrincipal(expression="realMember") MemberVO authMember , 
			CostVO costVO, Model model,
			@RequestParam(value="day",required=false, defaultValue="0" )int day) {
		String goPage = null;
		costVO.setMemId(authMember.getMemId());
		List<CostVO> costYear = service.costYearList(costVO);
		ResidentVO userComent = service.userComent(authMember);
		if(costYear.isEmpty()) {
			CostVO defalutVO = new CostVO();
			model.addAttribute("affter",defalutVO);
			goPage = "forward:/resident/maintenanceCost/paymentView.do";
		}else{
			if(day >= costYear.size()) {
				day = 0;
			}
			costVO.setCostNo(costYear.get(day).getCostNo());
			String unpaidYN = service.unpaidYN(costVO);
			if(unpaidYN.equals("N")) {
			CostVO affterRetriveExpense = service.retriveExpenses(costVO);
			
			List<CostVO> unpaidMaintenancecost = service.unpaidMaintenancecost(affterRetriveExpense);
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
			model.addAttribute("user",userComent);
			model.addAttribute("unpaid",unpaidMaintenancecost);
			goPage="maintenanceCost/feePayment";
			
			}
			else {
				goPage= "forward:/resident/maintenanceCost/paymentView.do";
			}
		}
		return goPage;
	}
	
	@RequestMapping("/resident/mainenanceCost/kakaopay.do")
	public String kakaopay(@AuthenticationPrincipal(expression="realMember") MemberVO authMember,Model model
		,CostVO costVO) {
		ResidentVO userComent = service.userComent(authMember);
		ApartVO apart = service.apart(authMember);
		costVO.setMemId(authMember.getMemId());
		CostVO thisCost = service.thisCost(costVO);
		
	
		model.addAttribute("user",userComent);
		model.addAttribute("apart",apart);
		model.addAttribute("thisCost",thisCost);
		
		return"resident/maintenanceCost/kakaopay/kakopay";
	}
	
	@RequestMapping("/resident/maintenanceCost/paymentView.do")
	public String view(@AuthenticationPrincipal(expression="realMember") MemberVO authMember,Model model) {
		
		List<CostVO> receiptList = service.receiptList(authMember);
		model.addAttribute("receiptList",receiptList);
		return "maintenanceCost/paymentView";
	}
	
	
	@RequestMapping("/resident/maintenanceCost/pay.do")
	public String paySuccess(CostVO costVO,Model model) {
		int cnt = service.allPayCost(costVO);
		
		return "forward:/resident/maintenanceCost/paymentView.do";
	}
}
