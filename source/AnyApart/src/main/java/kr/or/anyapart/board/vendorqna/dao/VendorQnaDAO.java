/**
 * @author 박지수
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.      박지수       최초작성
 * 2021. 2. 08.      박지수       인서트 되는지 확인, 수정
 * 2021. 2. 09.      박지수       게시물 조회수 증가, 삭제
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.vendorqna.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface VendorQnaDAO {
	
	/**
	 * 관리사무소 벤더 사이트간의 문의 사항 으로 부터 받는 질문과 작성한 답변을 조회
	 * @param paging
	 * @return List<BoardVO> 조회한 녀석들
	 */
	public List<BoardVO> selectOfficeQnaList(PagingVO<BoardVO> paging);
	
	/**
	 * 페이징 처리를 위한 항목 수 조회
	 * @param pagingVO
	 * @return int 조회수
	 */
	public int selectOfficeQnaCount(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 질문 문의 게시판 상세 보기
	 * @param pagingVO
	 * @return
	 */
	public BoardVO selectOfficeQna(int boNo);
	
	/**
	 * 질문 또는 답변 달기
	 * @param board
	 * @return
	 */
	public int insertOfficeQna(BoardVO board) throws SQLException;
	
	/**
	 * 해당 게시물 삭제하기
	 * @param bo_no
	 * @return 성공시 1 반환 실패시 0 반환 또는 SQLException 
	 */
	public int deleteOfficeQna(Integer bo_no);
	
	/**
	 * 벤더사이트 문의하기 업데이트
	 * @param board
	 * @return 성공시 1반환 실패시 0 반환 또는 SQLException
	 * @throws SQLException
	 */
	public int updateOfficeQna(BoardVO board) throws SQLException;
	
	/**
	 * 게시글의 조회수를 올린다.
	 * @param board
	 * @return
	 */
	public int incrementHit(BoardVO board);
	
	
	/**
	 * 삭제할 문의 게시판의 글과 연관된 글을 같이 조회해온다.
	 * @param boNo
	 * @return List<BoardVO>
	 */
	public List<BoardVO> selectDeleteBoard(int boNo);
	
	
	/**
	 * 전체 글, 답변 글, 미 답변글 수를 조회 반환한다.
	 * @param paging
	 * @return
	 */
	public BoardVO countAnswer(PagingVO<BoardVO> paging);
}
