/**
 * @author 이경륜
 * @since 2021. 2. 4.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 4.         이경륜            최초작성
 * 2021. 2. 5.         이경륜            입주민등록관련
 * 2021. 2. 8.         이경륜            입주민정보수정
 * 2021. 2. 11.		   이경륜	     전출자리스트조회	
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.resident.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface ResidentDAO {
	/*
	 * 입주민관리 공통
	 */
	
	/**
	 * 검색조건 셀렉트 박스용 동 조회
	 * @param house
	 * @return 해당 아파트의 동 전체 리스트
	 * @throws Exception
	 * @author 이경륜
	 */
	public List<HouseVO> selectDongList(HouseVO house);
	
	/**
	 * 검색조건 셀렉트 박스용 호 조회
	 * @param house
	 * @return 해당 아파트의 해당 동의 호 리스트
	 * @throws Exception
	 * @author 이경륜
	 */
	public List<HouseVO> selectHoList(HouseVO house);
	
	/*
	 * 입주관리
	 */
	
	/**
	 * 조건에 따른 입주민 수 카운트
	 * @param 조건을 담은 pagingVO
	 * @return 레코드 수
	 * @author 이경륜
	 */
	public int selectResidentCount(PagingVO<ResidentVO> pagingVO);
	
	/**
	 * 조건에 따른 입주민 리스트
	 * @param 조건을 담은 pagingVO
	 * @return 입주민리스트
	 * @author 이경륜
	 */
	public List<ResidentVO> selectResidentList(PagingVO<ResidentVO> pagingVO);
	
	
	/**
	 * 해당 호실 입주여부 확인
	 * @param residentVO
	 * @return Y 입주 N 미입주
	 * @author 이경륜
	 */
	public String selectHouseMoveYn(ResidentVO residentVO);
	/**
	 * 멤버테이블에 인서트
	 * @param member
	 * @return 성공시 &gt; 0
	 * @throws SQLException
	 */
	public int insertMember(MemberVO member);
	/**
	 * 입주민 단건등록
	 * @param residentVO
	 * @return 성공시 &gt; 0
	 * @throws SQLException
	 * @author 이경륜
	 */
	public int insertResident(ResidentVO residentVO);
	/**
	 * 입주여부 업데이트
	 * @param residentVO
	 * @return 성공시 &gt; 0
	 * @throws SQLException
	 * @author 이경륜
	 */
	public int updateHouseMoveYn(ResidentVO residentVO);
	/**
	 * 입주민 정보 수정
	 * @param residentVO
	 * @return 성공시 &gt; 0
	 * @throws SQLException
	 * @author 이경륜
	 */
	public int updateResident(ResidentVO residentVO);
	
	/**
	 * 하우스코드로 입주민 단건조회
	 * @param residentVO
	 * @return
	 */
	public ResidentVO selectResidentByHouseCode(ResidentVO residentVO);
	
	/*
	 * 전출관리
	 */
	/**
	 * 조건에 따른 전출자 수
	 * @param 조건을 담은 pagingVO
	 * @return 전출자 레코드 수
	 * @author 이경륜
	 */
	public int selectMoveoutResidentCount(PagingVO<ResidentVO> pagingVO);
	
	/**
	 * 조건에 따른 전출자 리스트
	 * @param 조건을 담은 pagingVO
	 * @return 전출자리스트
	 * @author 이경륜
	 */
	public List<ResidentVO> selectMoveoutResidentList(PagingVO<ResidentVO> pagingVO);

	/**
	 * 전출자 상세조회
	 * @param residentVO
	 * @return 전출자 정보
	 * @author 이경륜
	 */
	public ResidentVO selectMoveoutResident(ResidentVO residentVO);
	
	/**
	 * 전출처리
	 * @param residentVO (memId)
	 * @return
	 * @author 이경륜
	 */
	public void deleteResident(ResidentVO residentVO);
	
	/**
	 * 전출처리 취소
	 * @param residentVO (memId, houseCode)
	 * @return 없음
	 * @throws 프로시져 진행중 예외발생시 자등으로 throw됨
	 * @author 이경륜
	 */
	public void cancelResidentMoveout(ResidentVO residentVO);
	
	/*
	 * 오피스 대시보드
	 */
	/**
	 * 관리자 대시보드용 전입 추이
	 * @param residentVO
	 * @return 날짜와 카운트담은 리스트
	 * @author 이경륜
	 */
	public List<ResidentVO> selectMoveinCntMonthly(ResidentVO residentVO);
	/**
	 * 관리자 대시보드용 전출 추이
	 * @param residentVO
	 * @return  날짜와 카운트담은 리스트
	 * @author 이경륜
	 */
	public List<ResidentVO> selectMoveoutCntMonthly(ResidentVO residentVO);
	/**
	 * 관리자 대시보드용 면적별 입주세대
	 * @param costVO
	 * @return  면적, 입주 카운트
	 * @author 이경륜
	 */
	public List<HouseVO> selectHouseInfoBySpace(CostVO cost);
}
