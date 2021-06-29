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
 * 2021. 2. 26.      박지수       본인 예약 리스트 조회
 * 2021. 2. 26.      박지수       본인 예약 취소
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.reservation.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.community.vo.CommunityVO;
import kr.or.anyapart.reservation.dao.ReservationDAO;
import kr.or.anyapart.reservation.vo.ReservationVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Inject
	ReservationDAO reservationDao;
	
	/* 
	 * [시설에 대한 예약 전체 조회]
	 */
	@Override
	public List<ReservationVO> retrieveReservation(CommunityVO community) {
		return reservationDao.retrieveReservation(community);
	}

	/* 
	 * [아파트 시설 목록 조회]
	 */
	@Override
	public List<CommunityVO> retrieveCommunityList(MemberVO member) {
		return reservationDao.retrieveCommunityList(member);
	}

	/* 
	 * [입주민 정보를 가져온다.]
	 */
	@Override
	public ResidentVO retrieveResident(MemberVO member) {
		return reservationDao.retrieveResident(member);
	}

	/* 
	 * [시설에 대한 시간대별 예약 인원 조회]
	 */
	@Override
	public ReservationVO resvCnt(ReservationVO reservation) {
		return reservationDao.resvCnt(reservation);
	}

	/* 
	 * [시설 예약]
	 */
	@Transactional
	@Override
	public void resvation(ReservationVO reservation) {
		try {
			LocalDate nowDate = LocalDate.now();	// 로컬 컴퓨터의 현재 날짜 정보를 저장한 localDate 객체를 리턴
			LocalDate tomorrow = nowDate.plusDays(1);
			LocalDate inputDate = LocalDate.parse(reservation.getResvDate(), DateTimeFormatter.ISO_DATE);
			if(tomorrow.isAfter(inputDate)) {
				// 입력 된 날짜가  현재 날짜보다 작다면 예약 실패하기 만들기
				throw new RuntimeException("하루전 예약");
			}
			
			int result = reservationDao.reservationInsert(reservation);
			result = reservation.getResvNo();
			if(result > 0) {
				reservation.setResvNo(result);
				result = reservationDao.resvDetailInsert(reservation);
				result = reservation.getResultCnt();
				if(result > 0) {	// 예약 실패 시 현재 예약되어 있는 인원수를 반환하는 것
					throw new RuntimeException("예약 실패");
				}
			}else {
				throw new RuntimeException("예약 실패");
			}
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [본인 예약 리스트]
	 */
	@Override
	public List<ReservationVO> retrieveMemberReservationList(PagingVO<ReservationVO> paging) {
		return reservationDao.retrieveMemberReservationList(paging);
	}

	/* 
	 * [본인 예약의 최대 개수]
	 */
	@Override
	public int retrieveMemberReservationCount(PagingVO<ReservationVO> paging) {
		return reservationDao.retrieveMemberReservationCount(paging);
	}

	/* 
	 * [본인 예약 취소]
	 */
	@Transactional
	@Override
	public void removeReservation(ReservationVO reservation) {
		try {
			int rowcnt = reservationDao.deleteResvDetail(reservation);
			if(rowcnt > 0 ) {
				rowcnt = reservationDao.deleteReservation(reservation);
				if(rowcnt > 0 ) {
					return;
				}else {
					throw new RuntimeException("예약 취소 실패");
				}
			}else {
				throw new RuntimeException("예약 취소 실패");
			}
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [관리사무소 - 예약일정 조회하기]
	 */
	@Override
	public List<ReservationVO> officeReservationList(CommunityVO community) {
		return reservationDao.officeReservationList(community);
	}


	

}
