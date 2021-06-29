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

package kr.or.anyapart.asset.buy.service;

import java.util.List;

import kr.or.anyapart.asset.vo.ProdDetailVO;
import kr.or.anyapart.vo.PagingVO;

public interface ProdDetailService {
	/**
	 * 레코드 수 조회
	 * @param paging
	 * @return
	 */
	public int countDetail(PagingVO<ProdDetailVO> paging);
	
	/**
	 * 구매/사용내역 조회
	 * @param paging
	 * @return 구매/사용내역 리스트 반환
	 */
	public List<ProdDetailVO> retrieveDetailList(PagingVO<ProdDetailVO> paging);
	
	/**
	 * 구매/사용내역 저장
	 * @param prodDetail
	 * @return 실패시 예외 발생
	 */
	public void createDetail(List<ProdDetailVO> detailList);
	
	/**
	 * 구매/사용내역 수정
	 * @param prodDetail
	 * @return 실패시 예외 발생
	 */
	public void modifyDetail(ProdDetailVO prodDetail);
	
	/**
	 * 구매/사용내역 삭제
	 * @param prodDetail
	 * @return 실패시 예외 발생 
	 */
	public void removeDetail(int inNo);
}
