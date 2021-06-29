/**
  * @author 박지수
 * @since 2021. 2. 16.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 16.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.buy.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.asset.vo.ProdDetailVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface ProdDetailDAO {
	/**
	 * 레코드 수 조회
	 * @param paging
	 * @return
	 */
	public int countDetail(PagingVO<ProdDetailVO> paging);
	
	/**
	 * 구매/사용내역 조회
	 * @param paging
	 * @return 구매/수리내역 리스트 반환
	 */
	public List<ProdDetailVO> retrieveDetailList(PagingVO<ProdDetailVO> paging);
	
	/**
	 * 구매/사용내역 저장
	 * @param prodDetail
	 * @return
	 */
	public int insertDetail(List<ProdDetailVO> detailList);
	
	/**
	 * 구매/사용내역 수정
	 * @param prodDetail
	 * @return 성공 1, 실패 0, 혹은 DB 관련 예외 DataAccessException
	 */
	public int updateDetail(ProdDetailVO prodDetail);
	
	/**
	 * 구매/사용내역 삭제
	 * @param prodDetail
	 * @return 성공 1, 실패 0, 혹은 DB 관련 예외 DataAccessException 
	 */
	public int deleteDetail(int ioNo);
	
	/**
	 * 구매/사용 내역 등록시 물품의 수량 변경
	 * @param prodDetail
	 * @return
	 */
	public int updateProdQty(ProdDetailVO prodDetail);
	
	/**
	 * 구매/사용 내역 단건 조회
	 * @param prodDetail
	 */
	public ProdDetailVO retrieveDetail(ProdDetailVO prodDetail);
	
	/**
	 * 구매/사용 내역 수정시 기존의 내역으로 인해 변경되었던 물품 수량 원상복귀
	 * @param prodDetail
	 * @return
	 */
	public int rollbackProdQty(ProdDetailVO prodDetail);
}
