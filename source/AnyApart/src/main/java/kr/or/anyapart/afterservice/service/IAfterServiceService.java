/**
 * @author 박정민
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 1. 29.       박정민         최초작성
 * Copyright (c) 2021. 1. 29. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.afterservice.service;

import java.util.List;

import kr.or.anyapart.afterservice.vo.AfterServiceVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;

public interface IAfterServiceService {
	/**
	 * totalrecord 조회
	 * @param pagingVO
	 * @return
	 */
	public int retreiveAfterServiceCount(PagingVO<AfterServiceVO> pagingVO);
	
	/**
	 * 수리 신청글 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<AfterServiceVO> retreiveAfterServiceList(PagingVO<AfterServiceVO> pagingVO);
	
	/**
	 * 수리 신청 등록
	 * @param asVO
	 * @return
	 */
	public ServiceResult insertAfterService(AfterServiceVO asVO);

	/**
	 * 입주민 사이트 수리 신청 상세조회
	 * @param asVO
	 * @return
	 */
	public AfterServiceVO retreiveAfterServiceResident(AfterServiceVO asVO);
	
	/**
	 * 관리사무소 수리 신청 상세조회
	 * @param asVO
	 * @return
	 */
	public AfterServiceVO retreiveAfterService(AfterServiceVO asVO);

	/**
	 * 수리신청 수정
	 * @param afterServiceVO
	 * @return
	 */
	public ServiceResult updateAfterService(AfterServiceVO afterServiceVO);

	/**
	 * 수리신청 삭제
	 * @param afterServiceVO
	 * @return
	 */
	public ServiceResult deleteAfterService(AfterServiceVO afterServiceVO);

	/**
	 * 수리처리 완료
	 * @param asVO
	 * @return
	 */
	public ServiceResult resultAfterService(AfterServiceVO asVO);

	/**
	 * 수리처리내역 등록 및 수정
	 * @param asVO
	 * @return
	 */
	public ServiceResult afterServiceResultUpdate(AfterServiceVO asVO);

	/**
	 * 입주민 수리글 상세조회 타인글 비밀번호 확인
	 * @param asVO
	 * @return
	 */
	public ServiceResult chkMemPass(AfterServiceVO asVO);

	/**
	 * 관리사무소 수리 일정등록
	 * @param scheduleVO
	 * @return
	 */
	public ServiceResult insertAsSchedule(ScheduleVO scheduleVO);

	/**
	 * 관리사무소 수리 일정 삭제, 승인취소
	 * @param scheduleVO
	 * @return
	 */
	public ServiceResult approvalCancel(ScheduleVO scheduleVO);

	/**
	 * 수리 처리내역 삭제
	 * @param asVO
	 * @return
	 */
	public ServiceResult deleteAsResult(AfterServiceVO asVO);

	/**
	 * @return
	 */
	public int retreiveAsWaintingCnt(PagingVO<AfterServiceVO> pagingVO);


}
