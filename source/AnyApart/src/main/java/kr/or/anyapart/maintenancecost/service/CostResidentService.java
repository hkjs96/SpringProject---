package kr.or.anyapart.maintenancecost.service;

import java.util.List;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;

public interface CostResidentService {

	public CostVO retriveExpenses(CostVO costVO);

	public List<CostVO> costYearList(CostVO costVO);

	public List<CostVO> costMonthList(CostVO costVO);

	public List<CostVO> costTypeList(CostVO costVO);

	public List<CostVO> costSameAreaList(CostVO costVO);

	public ResidentVO userComent(MemberVO authMember);

	public ApartVO apart(MemberVO authMember);

	public CostVO thisCost(CostVO costVO);

	public List<CostVO> unpaidMaintenancecost(CostVO costVO);

	public int allPayCost(CostVO costVO);

	public String unpaidYN(CostVO costVO);

	public List<CostVO> receiptList(MemberVO authMember);

}
