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
package kr.or.anyapart.meter.service;

import java.util.List;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

public interface IMeterCommService {

	/**
	 * 공동검침 전체 레코드수 조회
	 * @param pagingVO
	 * @return
	 */
	int retreiveCommMeterCount(PagingVO<MeterCommVO> pagingVO);
	
	/**
	 * 공통검침 리스트 조회
	 * @param pagingVO
	 * @return
	 */
	List<MeterCommVO> retreiveCommMeterList(PagingVO<MeterCommVO> pagingVO);

	/**
	 * 공동검침 등록
	 * @param cmVO
	 * @return
	 */
	int insertCommMeter(MeterCommVO cmVO);

	/**
	 * 공통검침 단건 조회
	 * @param coMeterVO
	 * @return
	 */
	MeterCommVO retreiveCommMeter(MeterCommVO coMeterVO);

	/**
	 * 공동검침 수정
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
	 * 엑셀 업로드
	 * @param commMeterList
	 * @param authMemberVO 
	 * @return
	 */
	ServiceResult createMuitlpleCommMeter(List<MeterCommVO> commMeterList, MemberVO authMemberVO);

	/**
	 * 공동검침 삭제
	 * @param cmVO
	 * @return
	 */
	int deleteCommMeter(MeterCommVO cmVO);

	/**
	 * @return
	 */
	int retreiveCommMeterTotalCnt(PagingVO<MeterCommVO> pagingVO);


}
