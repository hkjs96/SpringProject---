/**
 * @author 박지수
 * @since 2021. 2. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 9.      박지수       최초작성
 * 2021. 2. 10.      박지수       아파트 물품 갯수 조회
 * 2021. 2. 12.      박지수       아파트 물품 등록
 * 2021. 2. 20.      박지수       아파트 물품 상세조회
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.prod.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.asset.vo.ProdVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface ProdDAO {
	/**
	 * 아파트 물품 리스트를 가지고 온다.
	 * @return List<ProdVO>
	 */
	public List<ProdVO> retrieveProdList(PagingVO<ProdVO> pagingVO);
	
	/**
	 * 아파트 물품 리스트 카운트 
	 * @param pagingVO
	 * @return 아파트 물품 갯수 반환
	 */
	public int prodCount(PagingVO<ProdVO> pagingVO);
	
	/**
	 * 아파트 물품 등록
	 * @param prodList
	 * @return
	 */
	public int insertProd(List<ProdVO> prodList);
	
	/**
	 * 물품 상세 조회, 아파트 코드와 물품 번호를 이용해서 구한다.
	 * @param prod
	 * @return
	 */
	public ProdVO retrieveProd(ProdVO prod);
}
