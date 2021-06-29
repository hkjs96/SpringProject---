/**
 * @author 박지수
 * @since 2021. 2. 14.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 14.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.community.service;

import java.util.List;

import kr.or.anyapart.community.vo.CommunityVO;
import kr.or.anyapart.vo.PagingVO;

public interface CommunityService {
	/**
	 * 커뮤니티 리스트 갯수 조회
	 * @param pagingVO
	 * @return
	 */
	public int countCommunity(PagingVO<CommunityVO> pagingVO);
	
	/**
	 * 시설 상세 조회
	 * @param community
	 * @return CommunityVO
	 */
	public CommunityVO retrieveCommunity(CommunityVO community);
	
	/**
	 * 커뮤니티 리스트 조회
	 * @param pagingVO
	 * @return
	 */
	public List<CommunityVO> retrieveCommunityList(PagingVO<CommunityVO> pagingVO);
	
	/**
	 * 커뮤니티 등록
	 * @return
	 */
	public void createCommunity(CommunityVO community);
	
	/**
	 * 커뮤니티 수정
	 * 아파트 코드와 커뮤니티 등록 번호가 일치해야 수정
	 * @return
	 */
	public void modifyCommunity(CommunityVO community);
	
	/**
	 * 커뮤니티 삭제
	 * 아파트 코드와 커뮤니티 등록 번호가 일치해야 삭제 
	 * @return
	 */
	public int removeCommunity(CommunityVO community);
}
