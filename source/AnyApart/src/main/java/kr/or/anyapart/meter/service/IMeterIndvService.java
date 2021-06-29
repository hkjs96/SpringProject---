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
package kr.or.anyapart.meter.service;

import java.util.List;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.meter.vo.MeterIndvListVO;
import kr.or.anyapart.meter.vo.MeterIndvVO;
import kr.or.anyapart.vo.PagingVO;

public interface IMeterIndvService {

	/**
	 * 전체 레코드 조회
	 * @param pagingVO
	 * @return
	 */
	int retreiveMeterIndvCount(PagingVO<MeterIndvVO> pagingVO);

	/**
	 * 세대검침 목록 조회
	 * @param pagingVO
	 * @return
	 */
	List<MeterIndvVO> retreiveMeterIndvList(PagingVO<MeterIndvVO> pagingVO);

	/**
	 * 엑셀 업로드
	 * @param meterIndvList
	 * @return
	 */
	ServiceResult createMuitlpleIndvMeter(List<MeterIndvVO> meterIndvList);

	/**
	 * 세대검침 삭제
	 * @param miVO
	 * @return
	 */
	int deleteMeterIndv(MeterIndvVO miVO);

	/**
	 * 세대검침 수정
	 * @param miVO
	 * @return
	 */
	ServiceResult updateMeterIndv(MeterIndvVO miVO);

	/**
	 * 세대검침 상세조회
	 * @param meterIndvVO
	 * @return
	 */
	MeterIndvVO retreiveMeterIndv(MeterIndvVO meterIndvVO);

	/**
	 * 세대검침 단건등록
	 * @param indvList
	 * @return
	 */
	int insertMeterIndv(MeterIndvListVO indvList);

	/**
	 * @return
	 */
	int retreiveIndvMeterTotalCnt(PagingVO<MeterIndvVO> pagingVO);

}
