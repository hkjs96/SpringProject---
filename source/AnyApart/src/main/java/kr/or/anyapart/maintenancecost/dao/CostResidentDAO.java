package kr.or.anyapart.maintenancecost.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;

@Repository
public interface CostResidentDAO {
	
	/**
	 * 관리비 조회 
	 * 
	 * @param costVO
	 * @return CostVO
	 */
	public CostVO seleteExpenses(CostVO costVO);

	public List<CostVO> seleteCostYear(CostVO costVO);
	/**
	 * 해당 날짜의 평균 관리비 
	 * @param costVO
	 * @return
	 */
	public double costAvg(CostVO costVO);

	public double sameAreaAvg(CostVO costVO);

	public double sameEngAreaAvg(CostVO costVO);

	public List<CostVO> seleteCostMonth(CostVO costVO);

	public List<CostVO> seleteCostTypeList(CostVO costVO);

	public List<CostVO> seleteCostSameAreaList(CostVO costVO);

	public ResidentVO seleteUserResidence(MemberVO authMember);

	public ApartVO apart(MemberVO authMember);

	public CostVO costSum(CostVO costVO);

	public List<CostVO> unpaidMaintenancecost(CostVO costVO);

	public List<CostVO> allCostPay(CostVO costVO);

	public int insertReceipt(CostVO costVO);

	public String unpaidYN(CostVO costVO);

	public List<CostVO> receiptList(MemberVO authMember);
	
}
