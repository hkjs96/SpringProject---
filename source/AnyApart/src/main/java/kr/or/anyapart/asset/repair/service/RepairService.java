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

package kr.or.anyapart.asset.repair.service;

import java.util.List;

import kr.or.anyapart.asset.vo.RepairVO;
import kr.or.anyapart.vo.PagingVO;

public interface RepairService {
	/**
	 * 레코드 수 조회
	 * @param paging
	 * @return
	 */
	public int countRepair(PagingVO<RepairVO> paging);
	
	/**
	 * 수리이력 조회
	 * @param paging
	 * @return 수리내역 리스트 반환
	 */
	public List<RepairVO> retrieveRepairList(PagingVO<RepairVO> paging);
	
	/**
	 * 수리이력 저장
	 * @param repair
	 * @return 실패시 예외 발생
	 */
	public void createRepair(RepairVO repair);
	
	/**
	 * 수리이력 수정
	 * @param prodRepair
	 * @return 실패시 예외 발생
	 */
	public void modifyRepair(RepairVO prodRepair);
	
	/**
	 * 수리이력 삭제
	 * @param prodRepair
	 * @return 실패시 예외 발생 
	 */
//	public void removeRepair(int inNo);
	public void removeRepair(RepairVO repair);
}
