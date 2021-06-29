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

package kr.or.anyapart.maintenancecost.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface CostOfficeDAO {
	/*
	 * 전출처리시 미납관리비
	 */
	/**
	 * 전출자 등록시 미납 관리비 카운트
	 * @param pagingVO
	 * @return
	 * @author 이경륜
	 */
	public int selectUnpaidCostCount(PagingVO<CostVO> pagingVO);
	/**
	 * 전출자 등록시 미납 관리비 리스트
	 * @param pagingVO
	 * @return
	 * @author 이경륜
	 */
	public List<CostVO> selectUnpaidCostList(PagingVO<CostVO> pagingVO);
	/*
	 * 관리비 세대별 조회
	 */
	/**
	 * 당월 관리비 리스트 조회 카운트
	 * @param pagingVO
	 * @return 
	 * @author 이경륜
	 */
	public int selectCostCount(PagingVO<CostVO> pagingVO);
	/**
	 * 당월 관리비 리스트 조회
	 * @param pagingVO
	 * @return 당월 관리비 리스트
	 * @author 이경륜
	 */
	public List<CostVO> selectCostList(PagingVO<CostVO> pagingVO);
	/*
	 * 부과처리
	 */
	/**
	 * 부과처리메뉴에서 검침량등록되었는지 확인
	 * @param costVO
	 * @return
	 */
	public MeterCommVO selectCommMeter(CostVO costVO);
	/**
	 * house 관련 정보
	 * @return 총세대수,입주세대수, 총면적, 입주면적 담은 HouseVO
	 * @author 이경륜
	 */
	public HouseVO selectHouseInfoForCost(CostVO cost);
	/**
	 * 공용관리비 (인건비+용역비+승강기유지비) 총발생금액, 면적당부과금액 리스트
	 * @param cost
	 * @return
	 */
	public List<CostVO> selectCostCommList(CostVO cost);
	/**
	 * 부과처리시 공용검침량 조회
	 * @param costVO
	 * @return
	 * @author 이경륜
	 */
	public MeterCommVO selectCommMeterByDate(CostVO costVO);
	/**
	 * 세대별 관리비 리스트 카운트
	 * @param 
	 * @return
	 * @author 이경륜
	 */
	public int selectCostListCountByHouse(PagingVO<CostVO> pagingVO);
	/**
	 * 세대별 관리비 리스트
	 * @param cost
	 * @return
	 * @author 이경륜
	 */
	public List<CostVO> selectCostListByHouse(PagingVO<CostVO> pagingVO);
	/**
	 * 세대별 관리비 리스트 페이징 없이 전체조회
	 * @param cost
	 * @return
	 * @author 이경륜
	 */
	public List<CostVO> selectCostListByHouseWithoutPaging(PagingVO<CostVO> pagingVO);
	/**
	 * 부과처리
	 * @author 이경륜
	 */
	public int insertMonthlyCostInsert(List<CostVO> costList);
	/**
	 * 부과처리 후 공동검침 부과 플래그 변경
	 * @param costVO
	 * @return
	 * @author 이경륜
	 */
	public int updateCommMeterFlag(CostVO costVO);
	

	/*
	 * 대시보드용
	 */
	/**
	 * 관리비 최근 1년치 추이
	 * @param costVO
	 * @return
	 * @author 이경륜
	 */
	public List<CostVO> selectCostListYearly(CostVO costVO);
}
