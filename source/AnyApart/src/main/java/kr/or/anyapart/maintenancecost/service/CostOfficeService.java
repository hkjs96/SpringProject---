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

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.vo.PagingVO;

public interface CostOfficeService {
	/*
	 * 전출처리시 미납관리비
	 */
	/**
	 * 전출자 등록시 미납 관리비 카운트
	 * @param pagingVO
	 * @return
	 * @author 이경륜
	 */
	public int retrieveUnpaidCostCount(PagingVO<CostVO> pagingVO);
	/**
	 * 전출자 등록시 미납 관리비 리스트
	 * @param pagingVO
	 * @return
	 * @author 이경륜
	 */
	public List<CostVO> retrieveUnpaidCostList(PagingVO<CostVO> pagingVO);
	/*
	 * 관리비 세대별 조회
	 */
	/**
	 * 당월 관리비 리스트 조회 카운트
	 * @param pagingVO
	 * @return 
	 * @author 이경륜
	 */
	public int retrieveCostCount(PagingVO<CostVO> pagingVO);
	/**
	 * 당월 관리비 리스트 조회
	 * @param pagingVO
	 * @return 당월 관리비 리스트
	 * @author 이경륜
	 */
	public List<CostVO> retrieveCostList(PagingVO<CostVO> pagingVO);
	/*
	 * 부과처리
	 */
	/**
	 * 부과처리메뉴에서 검침량등록되었는지 확인
	 * @param costVO
	 * @return
	 */
	public MeterCommVO retrieveCommMeter(CostVO costVO);
	/**
	 * house 관련 정보
	 * @return 총세대수,입주세대수, 총면적, 입주면적 담은 HouseVO
	 * @author 이경륜
	 */
	public HouseVO retrieveHouseInfoForCost(CostVO cost);
	/**
	 * 공용관리비(인건비,용역비,승강비) 발생금액, 면적당 부과금액 리스트
	 * @return 
	 * @author 이경륜
	 */
	public List<CostVO> retrieveCostCommList(CostVO cost);
	/**
	 * 공동검침량에 해당하는 관리비 발생금액 및 면적당 부과금액
	 * @param cost
	 * @return
	 */
	public MeterCommVO retrieveCommMeterCost(CostVO cost);
	
	/**
	 * 부과처리
	 * @param cost
	 * @return
	 */
	public int createMonthlyCost(PagingVO<CostVO> pagingVO2);
	
	/**
	 * 세대별 관리비 리스트 카운트
	 * @param 
	 * @return
	 */
	public int retrieveCostListCountByHouse(PagingVO<CostVO> pagingVO);
	/**
	 * 세대별 관리비 리스트
	 * @param cost
	 * @return
	 */
	public List<CostVO> retrieveCostListByHouse(PagingVO<CostVO> pagingVO);
	
	/*
	 * 대시보드용
	 */
	/**
	 * 관리비 최근 1년치 추이
	 * @param costVO
	 * @return
	 * @author 이경륜
	 */
	public List<CostVO> retrieveCostListYearly(CostVO costVO);
}
