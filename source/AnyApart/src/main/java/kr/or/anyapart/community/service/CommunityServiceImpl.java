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

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.community.dao.CommunityDAO;
import kr.or.anyapart.community.vo.CommunityVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Inject
	private CommunityDAO dao;
	
	/* 
	 * [페이징을 위한 조회]
	 */
	@Override
	public int countCommunity(PagingVO<CommunityVO> pagingVO) {
		return dao.countCommunity(pagingVO);
	}

	/* 
	 * [시설 상세 조회]
	 */
	@Override
	public CommunityVO retrieveCommunity(CommunityVO community) {
		return dao.retrieveCommunity(community);
	}

	/* 
	 * [시설 리스트 조회]
	 */
	@Override
	public List<CommunityVO> retrieveCommunityList(PagingVO<CommunityVO> pagingVO) {
		return dao.retrieveCommunityList(pagingVO);
	}

	/* 
	 * [시설 등록]
	 */
	@Override
	public void createCommunity(CommunityVO community) {
		try {
			int rowcnt = dao.insertCommunity(community);
			if( rowcnt == 0 ) throw new CustomException("시설 등록에 실패함");
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [시설 수정]
	 */
	@Override
	public void modifyCommunity(CommunityVO community) {
		try {
			if(dao.retrieveCommunity(community) != null){
				int rowcnt = dao.updateCommunity(community);
				if(rowcnt == 0) {
					throw new RuntimeException("변경 실패");
				}
			}else {
				throw new RuntimeException("존재하지 않음");
			}
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [시설 삭제]
	 */
	@Override
	public int removeCommunity(CommunityVO community) {
		// TODO Auto-generated method stub
		return 0;
	}

}
