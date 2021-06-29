/**
 * @author 이미정
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.board.officenotice.dao;

/**
 * @author 이미정
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IOfficeNoticeDAO {
	
	
	/**
	 * 페이징 처리 카운터 수
	 * @param pagingVO
	 * @return
	 */
	public int selectOfficeNoticeBoardCount(PagingVO<BoardVO> pagingVO);

	/**
	 * 관리사무소가 입주민에게 보내는 공지사항  리스트 조회
	 * @param pagingVO
	 * @author 이미정
	 * @return
	 */
	public List<BoardVO> selectOfficeNoticeBoardList(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 관리사무소 공지사항 상세보기
	 * @param boardVO
	 * @return
	 */
	public BoardVO selectOfficeNoticeBoard(BoardVO boardVO);
	
	/**
	 * 관리사무소 공지사항 글 작성
	 * @param boardVO
	 * @return
	 */
	public int insertOfficeNoticeBoard(BoardVO boardVO);
	
	/**
	 * 관리사무소 공지사항 글 수정
	 * @param boardVO
	 * @return
	 */
	public int updateOfficeNoticeBoard(BoardVO boardVO);
	
	/**
	 * 관리사무소 공지사항 글 삭제
	 * @param boNo
	 * @return
	 */
	public int deleteOfficeNoticeBoard(int boNo);
	
	/**
	 * 관리사무소 공지사항 조회수 증가
	 * @param bo_no
	 * @return
	 */
	public int incrementHit(int bo_no);

}
