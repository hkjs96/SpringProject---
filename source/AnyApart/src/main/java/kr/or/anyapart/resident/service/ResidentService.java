/**
 * @author 이경륜
 * @since 2021. 2. 4.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                     수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 4.    이경륜            최초작성
 * 2021. 2. 6. 	   이경륜		입주민 단건등록
 * 2022. 2. 8. 	   이경륜		입주민 정보 수정
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.resident.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.PagingVO;

// ServiceResult를 쓸것이냐..
public interface ResidentService {
	
	/**
	 * 검색조건 셀렉트 박스용 동 조회
	 * @param house
	 * @return 해당 아파트의 동 전체 리스트
	 * @throws Exception
	 * @author 이경륜
	 */
	public List<HouseVO> retrieveDongList(HouseVO house);
	
	/**
	 * 검색조건 셀렉트 박스용 호 조회
	 * @param house
	 * @return 해당 아파트의 해당 동의 호 리스트
	 * @author 이경륜
	 */
	public List<HouseVO> retrieveHoList(HouseVO house);
	
	/**
	 * 조건에 따른 입주민 수 카운트
	 * @param pagingVO
	 * @return 레코드 수
	 * @author 이경륜
	 */
	public int retrieveResidentCount(PagingVO<ResidentVO> pagingVO);
	
	/**
	 * 조건에 따른 입주민 리스트
	 * @param pagingVO
	 * @return 입주민리스트
	 * @author 이경륜
	 */
	public List<ResidentVO> retrieveResidentList(PagingVO<ResidentVO> pagingVO);
	
	/**
	 * 입주민 단건등록
	 * @param residentVO
	 * @return 성공시 ok, 실패시 예외발생
	 * @author 이경륜
	 */
	public ServiceResult createResident(ResidentVO residentVO);

	/**
	 * 입주민 엑셀일괄등록
	 * @param residentList 엑셀에서 읽어온 데이터 list
	 * @return 성공시 ok, db에서 실패시 예외발생, 기타예외 ServiceResult
	 * @author 이경륜
	 */
	public ServiceResult createMuitlpleResident(List<ResidentVO> residentList);
	
	/**
	 * 입주민 정보 수정
	 * @param residentVO
	 * @return 성공시 ok, 실패시 예외발생
	 * @author 이경륜
	 */
	public ServiceResult modifyResident(ResidentVO residentVO);
	
	/**
	 * 조건에 따른 전출자 수
	 * @param 조건을 담은 pagingVO
	 * @return 전출자 레코드 수
	 * @author 이경륜
	 */
	public int retrieveMoveoutResidentCount(PagingVO<ResidentVO> pagingVO);
	
	/**
	 * 조건에 따른 전출자 리스트
	 * @param 조건을 담은 pagingVO
	 * @return 전출자리스트
	 * @author 이경륜
	 */
	public List<ResidentVO> retrieveMoveoutResidentList(PagingVO<ResidentVO> pagingVO);
	
	/**
	 * 전출자 상세조회
	 * @param residentVO
	 * @return 전출자 정보
	 * @author 이경륜
	 */
	public ResidentVO retrieveMoveoutResident(ResidentVO residentVO);
	
	/**
	 * 하우스코드로 입주민 단건조회
	 * @param residentVO
	 * @return
	 * @author 이경륜
	 */
	public ResidentVO retrieveResidentByHouseCode(ResidentVO residentVO);
	
	/**
	 * 전출처리
	 * @param residentVO (memId)
	 * @return 없음
	 * @throws 프로시져 진행중 예외발생시 자등으로 throw됨
	 * @author 이경륜
	 */
	public void removeResident(ResidentVO residentVO);

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
	public List<ResidentVO> retrieveMoveinCntMonthly(ResidentVO residentVO);
	/**
	 * 관리자 대시보드용 전출 추이
	 * @param residentVO
	 * @return  날짜와 카운트담은 리스트
	 * @author 이경륜
	 */
	public List<ResidentVO> retrieveMoveoutCntMonthly(ResidentVO residentVO);
	/**
	 * 관리자 대시보드용 면적별 입주세대
	 * @param costVO
	 * @return  면적, 입주 카운트
	 * @author 이경륜
	 */
	public List<HouseVO> retrieveHouseInfoBySpace(CostVO cost);
}
