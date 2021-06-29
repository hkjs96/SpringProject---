/**
 * @author 박정민
 * @since 2021. 1. 27.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 1. 27.       박정민         최초작성
 * Copyright (c) 2021. 1. 27. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.remodelling.service;

import java.util.List;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.remodelling.vo.RemodellingVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;

public interface IRemodelingService {
	/**
	 * 리모델링 신청 목록을 조회하는 메서드
	 * @param searchVO
	 * @return 리모델링 신청 글 목록
	 */
	public List<RemodellingVO> retreiveList(PagingVO<RemodellingVO> pagingVO);
	
	/**
	 * 입주민 사이트 리모델링 신청 글 전체 갯수를 가져오는 메서드
	 * @param pagingVO
	 * @return totalRecord
	 */
	public int reteiveRmdlCountR(PagingVO<RemodellingVO> pagingVO);

	/**
	 * 리모델링 신청 글 전체 갯수를 가져오는 메서드
	 * @param pagingVO
	 * @return totalRecord
	 */
	public int reteiveRmdlCount(PagingVO<RemodellingVO> pagingVO);
	
	/**
	 * 리모델링 신청 글 등록
	 * @param rmdlVO
	 * @return 등록성공 OK, 실패 FAILED
	 */
	public ServiceResult insertRmdl(RemodellingVO rmdlVO);
	
	/**
	 * 리모델링 신청 글 삭제
	 * @param rmdlVO
	 * @param authMember 
	 * @return 삭제성공 OK, 실패 FAILED
	 */
	public ServiceResult deleteRmdl(RemodellingVO rmdlVO, MemberVO authMember);

	/**
	 * 관리자 리모델링 신청 승인
	 * @param rmdlVO
	 * @return
	 */
	public ServiceResult approvalRmdl(RemodellingVO rmdlVO);

	/**
	 * 리모델링 신청 승인 취소
	 * @param rmdlVO
	 * @return
	 */
	public ServiceResult approvalCancelRmdl(ScheduleVO scheduleVO);

	/**
	 * 관리사무소 리모델링 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<RemodellingVO> retreiveListOffice(PagingVO<RemodellingVO> pagingVO);

	/**
	 * @param rmdlVO
	 * @return
	 */
	public ServiceResult approvalCancelRmdlManage(RemodellingVO rmdlVO);

	/**
	 * @return
	 */
	public int retreiveRmdlWaitingCnt(PagingVO<RemodellingVO> pagingVO);
	
	
}
