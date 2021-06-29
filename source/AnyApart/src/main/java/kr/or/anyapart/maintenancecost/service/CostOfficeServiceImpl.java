/**
 * @author 이경륜
 * @since 2021. 2. 15.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 15.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.maintenancecost.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.dao.CostOfficeDAO;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class CostOfficeServiceImpl implements CostOfficeService{

	@Inject
	private WebApplicationContext container;
	
	@Inject
	private CostOfficeDAO costOfficeDAO;
	
	@Override
	public int retrieveUnpaidCostCount(PagingVO<CostVO> pagingVO) {
		return costOfficeDAO.selectUnpaidCostCount(pagingVO);
	}

	@Override
	public List<CostVO> retrieveUnpaidCostList(PagingVO<CostVO> pagingVO) {
		return costOfficeDAO.selectUnpaidCostList(pagingVO);
	}

	@Override
	public int retrieveCostCount(PagingVO<CostVO> pagingVO) {
		return costOfficeDAO.selectCostCount(pagingVO);
	}

	@Override
	public List<CostVO> retrieveCostList(PagingVO<CostVO> pagingVO) {
		return costOfficeDAO.selectCostList(pagingVO);
	}

	/*
	 * 부과처리 
	 */

	@Override
	public MeterCommVO retrieveCommMeter(CostVO costVO) {
		return costOfficeDAO.selectCommMeter(costVO);
	}
	
	@Override
	public HouseVO retrieveHouseInfoForCost(CostVO cost) {
		return costOfficeDAO.selectHouseInfoForCost(cost);
	}
	
	@Override
	public List<CostVO> retrieveCostCommList(CostVO cost) {
		List<CostVO> costCommList = costOfficeDAO.selectCostCommList(cost);
		return costCommList; 
	}
	
	@Override
	public MeterCommVO retrieveCommMeterCost(CostVO cost) {
		// 개별 -> 0
		// 중앙 or 지역인지 확인해야함 -> 쿼리에서 frag로 해결 (적용해둠)
		
		MeterCommVO commMeter = costOfficeDAO.selectCommMeterByDate(cost);
		
		return commMeter;
	}

	
	
	
	@Override
	public int retrieveCostListCountByHouse(PagingVO<CostVO> pagingVO) {
		return costOfficeDAO.selectCostListCountByHouse(pagingVO);
	}

	@Override
	public List<CostVO> retrieveCostListByHouse(PagingVO<CostVO> pagingVO) {
		return costOfficeDAO.selectCostListByHouse(pagingVO);
	}

	@Override
	@Transactional
	public int createMonthlyCost(PagingVO<CostVO> pagingVO2) {
		CostVO costVO = pagingVO2.getSearchDetail();
		/*
		 * 1. 하우스 정보
		 */
		HouseVO house = retrieveHouseInfoForCost(costVO);
		costVO.setAptHeat(house.getAptHeat());
		costVO.setMoveinHouseArea(house.getMoveinHouseArea());
		
		/*
		 * 2. 공용관리비
		 */
		List<CostVO> costCommList = retrieveCostCommList(costVO);
		
		/*
		 * 3. 공동검침
		 */
		MeterCommVO commMeter = retrieveCommMeterCost(costVO);
		costVO.setCommNo(commMeter.getCommNo());
		/*
		 * 4. 세대검침
		 */
		List<CostVO> costList = costOfficeDAO.selectCostListByHouseWithoutPaging(pagingVO2);
		for(CostVO costForInsert : costList) {
			int houseArea = Integer.parseInt(costForInsert.getHouseArea());
			
			// 공용관리비 계산
			costForInsert.setCostCommon(houseArea * costCommList.get(0).getCostCommTotalBySpace());
			costForInsert.setCostSecurity(houseArea * costCommList.get(1).getCostCommTotalBySpace());
			costForInsert.setCostDisinfect(houseArea * costCommList.get(2).getCostCommTotalBySpace());
			costForInsert.setCostCleaning(houseArea * costCommList.get(3).getCostCommTotalBySpace());
			costForInsert.setCostElevator(houseArea * costCommList.get(4).getCostCommTotalBySpace());
			
			// 공동검침 계산
			costForInsert.setCostCommElec(houseArea * commMeter.getCommElecCostBySpace());
			costForInsert.setCostCommHeat(houseArea * commMeter.getCommHeatCostBySpace());
			costForInsert.setCostCommHotwater(houseArea * commMeter.getCommHotwaterCostBySpace());
			costForInsert.setCostCommWater(houseArea * commMeter.getCommWaterCostBySpace());
		}
		int cnt = costOfficeDAO.insertMonthlyCostInsert(costList);
		
		if(cnt>0) costOfficeDAO.updateCommMeterFlag(costVO);
		return cnt;
	}

	@Override
	public List<CostVO> retrieveCostListYearly(CostVO costVO) {
		return costOfficeDAO.selectCostListYearly(costVO);
	}


}
