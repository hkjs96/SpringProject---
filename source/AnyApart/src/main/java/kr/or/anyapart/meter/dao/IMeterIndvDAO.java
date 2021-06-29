/**
 * @author 박정민
 * @since 2021. 2. 23.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 23.       박정민         최초작성
 * Copyright (c) 2021. 2. 23. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.meter.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.meter.vo.MeterIndvListVO;
import kr.or.anyapart.meter.vo.MeterIndvVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IMeterIndvDAO {

	/**
	 * @param pagingVO
	 * @return
	 */
	int selectMeterIndvCount(PagingVO<MeterIndvVO> pagingVO);

	/**
	 * @param pagingVO
	 * @return
	 */
	List<MeterIndvVO> selectMeterIndvList(PagingVO<MeterIndvVO> pagingVO);

	/**
	 * @param indvList
	 * @return
	 */
	int insertAllIndvMeter(MeterIndvListVO indvList);

	/**
	 * @param miVO
	 * @return
	 */
	int deleteMeterIndv(MeterIndvVO miVO);

	/**
	 * @param miVO
	 * @return
	 */
	int updateMeterIndv(MeterIndvVO miVO);

	/**
	 * @param meterIndvVO
	 * @return
	 */
	MeterIndvVO selectMeterIndv(MeterIndvVO meterIndvVO);

	/**
	 * @param miVO
	 * @return
	 */
	ResidentVO selectResident(MeterIndvVO miVO);

	/**
	 * @param miVO
	 * @return
	 */
	MeterIndvVO selectExcelMeterIndv(MeterIndvVO miVO);

	/**
	 * @param miVO
	 * @return
	 */
	List<MeterIndvVO> selectMeterAllList(MeterIndvVO miVO);

	/**
	 * @param miVO
	 * @return
	 */
	List<MeterIndvVO> selectMeterIndvEnergyList(MeterIndvVO miVO);

	/**
	 * @param miVO
	 * @return
	 */
	int insertIndvMeter(MeterIndvVO miVO);

	/**
	 * @return
	 */
	int selectIndvMeterTotalCnt(PagingVO<MeterIndvVO> pagingVO);

}
