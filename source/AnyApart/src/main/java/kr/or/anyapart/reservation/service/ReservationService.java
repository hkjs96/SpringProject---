/**
 * @author 박지수
 * @since 2021. 2. 22.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 22.      박지수       최초작성
 * 2021. 2. 25.      박지수       시설 예약
 * 2021. 2. 26.      박지수       본인의 예약 리스트
 * 2021. 2. 26.      박지수       본인 예약 취소
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.reservation.service;

import java.util.List;

import kr.or.anyapart.community.vo.CommunityVO;
import kr.or.anyapart.reservation.vo.ReservationVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

public interface ReservationService {
	/**
	 * 해당 커뮤니티 시설의 예약 리스트를 조회한다.
	 * @return 예약 리스트
	 */
	public List<ReservationVO> retrieveReservation(CommunityVO community);
	
	/**
	 * 아파트의 커뮤니티 시설 리스트 조회
	 * @param member
	 * @return
	 */
	public List<CommunityVO> retrieveCommunityList(MemberVO member);
	
	/**
	 * 입주민 정보를 가져온다.
	 * @param member
	 * @return
	 */
	public ResidentVO retrieveResident(MemberVO member);
	
	/**
	 * 시설에 대한 시간대 예약인원을 조회한다.
	 * @param reservation
	 * @return
	 */
	public ReservationVO resvCnt(ReservationVO reservation);
	
	/**
	 * 시설 예약하기
	 * @param reservation
	 * @return
	 */
	public void resvation(ReservationVO reservation);
	
	/**
	 * 해당 회원의 예약 정보 리스트를 가져온다.
	 * @param PagingVO<ReservationVO> paging
	 * @return List<ReservationVO>
	 */
	public List<ReservationVO> retrieveMemberReservationList(PagingVO<ReservationVO> paging);
	
	/**
	 * 해당 회원의 예약 정보 갯수를 파악한다.
	 * @param PagingVO<ReservationVO> paging
	 * @return List<ReservationVO>
	 */
	public int retrieveMemberReservationCount(PagingVO<ReservationVO> paging);
	
	/**
	 * 예약 취소 처리
	 * @param reservation
	 */
	public void removeReservation(ReservationVO reservation);
	
	/**
	 * 관리사무소, 예약 일정 조회하기
	 * @param community
	 * @return
	 */
	public List<ReservationVO> officeReservationList(CommunityVO community);
}
