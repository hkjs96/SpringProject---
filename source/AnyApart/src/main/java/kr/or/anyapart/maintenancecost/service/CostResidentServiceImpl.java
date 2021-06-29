package kr.or.anyapart.maintenancecost.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;


import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.maintenancecost.dao.CostResidentDAO;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;

@Service
public class CostResidentServiceImpl implements CostResidentService{
	
	@Inject
	private CostResidentDAO costResidentDAO;
	
	@Override
	public CostVO retriveExpenses(CostVO costVO) {
		CostVO seleteExpenses=costResidentDAO.seleteExpenses(costVO);
		double costAvg = 0;
		double sameAreaAvg=0;
		double sameEngAreaAvg=0;
		long costSum = 0;
		if(seleteExpenses != null) {
			costVO.setCostDuedate(seleteExpenses.getCostDuedate());
			costVO.setApartCode(seleteExpenses.getMemId().substring(0,5));
			costAvg = (double)costResidentDAO.costAvg(costVO);
			sameAreaAvg=(double)costResidentDAO.sameAreaAvg(costVO);
			sameEngAreaAvg=(double)costResidentDAO.sameEngAreaAvg(costVO);
		}
		seleteExpenses.setCostAvg(costAvg);
		seleteExpenses.setSameAreaAvg(sameAreaAvg);
		seleteExpenses.setSameEngAreaAvg(sameEngAreaAvg);
		return seleteExpenses;
	}

	@Override
	public List<CostVO> costYearList(CostVO costVO) {
		
		return costResidentDAO.seleteCostYear(costVO);
	}

	@Override
	public List<CostVO> costMonthList(CostVO costVO) {
		return costResidentDAO.seleteCostMonth(costVO);
	}

	@Override
	public List<CostVO> costTypeList(CostVO costVO) {
		return costResidentDAO.seleteCostTypeList(costVO);
	}

	@Override
	public List<CostVO> costSameAreaList(CostVO costVO) {
		return costResidentDAO.seleteCostSameAreaList(costVO);
	}

	@Override
	public ResidentVO userComent(MemberVO authMember) {
		return costResidentDAO.seleteUserResidence(authMember);
	}

	@Override
	public ApartVO apart(MemberVO authMember) {
		return costResidentDAO.apart(authMember);
	}

	@Override
	public CostVO thisCost(CostVO costVO) {
		CostVO costSum = costResidentDAO.costSum(costVO);
		List<CostVO> unpaidMaintenancecost = costResidentDAO.unpaidMaintenancecost(costSum);
		int unpaidCost = 0;
		int costSumTotal =costSum.getCostTotal();
		//미납 요금 찾아서 지난 일수에 비래하여 미납 요금 정산 
		for(int i=0; i<unpaidMaintenancecost.size() ; i++) {
			if(unpaidMaintenancecost.get(i).getReceiptYn().equals("N")) {
				int costTotal = unpaidMaintenancecost.get(i).getCostTotal();
				int count = unpaidMaintenancecost.get(i).getCount();
				int lateFee = (int) (costTotal + Math.round(costTotal*0.15 *count/365));
				
				unpaidCost += lateFee;
			}
		}
		//마지막 부과받은 관리비 부과 날짜 지났는지 여부 확인후 여부가 지났다면 추가비용 더하기( 총금액 *15% * 밀린날짜 수 / 365)
		int newDateCoutn = unpaidMaintenancecost.get(0).getNewcount();
		
		if(newDateCoutn >0) {
			int cost = (int)(Math.round(costSumTotal*0.15*newDateCoutn/365));
			costSum.setCostTotal((int)(unpaidCost+costSumTotal+Math.round(costSumTotal*0.15*newDateCoutn/365)));
		}else {
			costSum.setCostTotal(unpaidCost+costSumTotal);
		}
		return costSum;
	}

	@Override
	public List<CostVO> unpaidMaintenancecost(CostVO costVO) {
		List<CostVO> unpaidMaintenancecost = costResidentDAO.unpaidMaintenancecost(costVO);
		for(int i=0; i<unpaidMaintenancecost.size() ; i++) {
			if(unpaidMaintenancecost.get(i).getReceiptYn().equals("N")) {
				int costTotal = unpaidMaintenancecost.get(i).getCostTotal();
				int count = unpaidMaintenancecost.get(i).getCount();
				int lateFee = (int) (costTotal + Math.round(costTotal*0.15 *count/365));
				unpaidMaintenancecost.get(i).setLateFee(lateFee);
				
			}
		}
		
		
		return unpaidMaintenancecost;
	}

	@Override
	public int allPayCost(CostVO costVO) {
		int cnt = 0;
		List<CostVO> unpaidMaintenacecostList = costResidentDAO.allCostPay(costVO);
		
		for(int i=0; i<unpaidMaintenacecostList.size(); i++) {
			if(unpaidMaintenacecostList.get(i).getReceiptYn().equals("N")) {
				int costTotal = unpaidMaintenacecostList.get(i).getCostTotal();
				int count = unpaidMaintenacecostList.get(i).getCount();
				int lateFee = (int) (costTotal + Math.round(costTotal*0.15 *count/365));
				unpaidMaintenacecostList.get(i).setLateFee(lateFee);
				cnt += costResidentDAO.insertReceipt(unpaidMaintenacecostList.get(i));
			}
	
	}
		return cnt;
	}

	@Override
	public String unpaidYN(CostVO costVO) {
		return costResidentDAO.unpaidYN(costVO);
	}

	@Override
	public List<CostVO> receiptList(MemberVO authMember) {
		
		return costResidentDAO.receiptList(authMember);
	}
}

