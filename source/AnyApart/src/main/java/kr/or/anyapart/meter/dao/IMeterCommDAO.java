/**
 * @author 박정민
 * @since 2021. 2. 17.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 17.       박정민         최초작성
 * Copyright (c) 2021. 2. 17. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.meter.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IMeterCommDAO {

	/**
	 * @param pagingVO
	 * @return
	 */
	List<MeterCommVO> selectCommMeterList(PagingVO<MeterCommVO> pagingVO);

	/**
	 * @param pagingVO
	 * @return
	 */
	int selectCommMeterCount(PagingVO<MeterCommVO> pagingVO);

	/**
	 * @param cmVO
	 * @return
	 */
	int insertCommMeter(MeterCommVO cmVO);

	/**
	 * @param coMeterVO
	 * @return
	 */
	MeterCommVO selectCommMeter(MeterCommVO coMeterVO);

	/**
	 * @param cmVO
	 * @return
	 */
	int updateCommMeter(MeterCommVO cmVO);

	/**
	 * @param authMemberVO
	 * @return
	 */
	ApartVO selectApart(MemberVO authMemberVO);

	/**
	 * @param cmVO
	 * @return
	 */
	int deleteCommMeter(MeterCommVO cmVO);

	/**
	 * 엑셀업로드 - 이미 등록되있는 데이터가 아닌지 체크
	 * @param cmVO
	 * @return
	 */
	MeterCommVO selectExcelCommMeter(MeterCommVO cmVO);

	/**
	 * @param commYear
	 * @return
	 */
	List<MeterCommVO> retreiceMeterCommThisYear(String commYear);

	/**
	 * @param thisMonthVO
	 * @return
	 */
	List<MeterCommVO> selectMeterCommThisYear(MeterCommVO thisMonthVO);

	/**
	 * @return
	 */
	int selectCommMeterTotalCnt(PagingVO<MeterCommVO> pagingVO);

}
