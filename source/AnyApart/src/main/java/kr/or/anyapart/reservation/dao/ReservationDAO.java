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
 * 2021. 2. 26.      박지수       본인 예약 리스트
 * 2021. 2. 26.      박지수       본인 예약 취소
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.reservation.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.community.vo.CommunityVO;
import kr.or.anyapart.reservation.vo.ReservationVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface ReservationDAO {
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
	 * @return 성공시 예약 번호 반환, 실패시 -1 반환
	 */
	public int reservationInsert(ReservationVO reservation);
	
	/**
	 * 시설 예약 상세 등록
	 * @param reservation
	 * @return 성공시 -1 반환, 현재 예약된 인원 수 반환
	 */
	public int resvDetailInsert(ReservationVO reservation);
	
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
	 * 예약 상세 삭제
	 * @param reservation
	 * @return 삭제된 row 수
	 */
	public int deleteResvDetail(ReservationVO reservation);
	
	/**
	 * 예약 취소 처리
	 * @param reservation
	 * @return 삭제된 row 수
	 */
	public int deleteReservation(ReservationVO reservation);
	
	/**
	 * 관리사무소, 예약 일정 조회하기
	 * @param community
	 * @return
	 */
	public List<ReservationVO> officeReservationList(CommunityVO community);
}
