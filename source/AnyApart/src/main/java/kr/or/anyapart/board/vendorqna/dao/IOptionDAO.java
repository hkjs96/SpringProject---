/**
 * @author 박지수
 * @since 2021. 1. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 29.      박지수       최초작성
 * 2021. 2. 9.      박지수       물품 분류 옵션 추가
 * 2021. 2. 14.      박지수       커뮤니티 분류 옵션 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.vendorqna.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.asset.vo.ProdVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.community.vo.CommunityVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;

@Repository
public interface IOptionDAO {
	public List<BoardVO> retrieveQnaOption();
	public List<CodeVO> retrieveApartOption();
	public List<CodeVO> retrieveProdOption();
	public List<CodeVO> retrieveCommunityOption();
	public List<ProdVO> retrieveProdId(MemberVO member);
	
	
	public List<ProdVO> retrieveRepairProdId(MemberVO member);
	public List<CodeVO> retrieveRepairOption();
}
