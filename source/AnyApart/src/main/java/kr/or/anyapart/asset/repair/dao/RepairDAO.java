/**
 * @author 박지수
 * @since 2021. 2. 17.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 17.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.repair.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.asset.vo.RepairVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface RepairDAO {
	/**
	 * 레코드 수 조회
	 * @param paging
	 * @return
	 */
	public int countRepair(PagingVO<RepairVO> paging);
	
	/**
	 * 구매/수리내역 조회
	 * @param paging
	 * @return 구매/수리내역 리스트 반환
	 */
	public List<RepairVO> retrieveRepairList(PagingVO<RepairVO> paging);
	
	/**
	 * 구매/수리내역 저장
	 * @param prodRepair
	 * @return
	 */
	public int insertRepair(RepairVO Repair);
	
	/**
	 * 구매/수리이력 수정
	 * @param prodRepair
	 * @return 성공 1, 실패 0, 혹은 DB 관련 예외 DataAccessException
	 */
	public int updateRepair(RepairVO prodRepair);
	
	/**
	 * 구매/수리이력 삭제
	 * @param prodRepair
	 * @return 성공 1, 실패 0, 혹은 DB 관련 예외 DataAccessException 
	 */
	public int deleteRepair(int repairNo);
	
	/** 
	 * 구매/수리 이력 삭제시 해당 관리사무소 소속 계정의 사람인지 체크하기
	 * @param member
	 * @return
	 */
	public int deleteCheck(RepairVO repair);
}
