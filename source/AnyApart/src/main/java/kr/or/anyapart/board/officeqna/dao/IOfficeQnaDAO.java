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
package kr.or.anyapart.board.officeqna.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IOfficeQnaDAO {
	/**
	 * 페이징 처리 카운터 수
	 * @param pagingVO
	 * @return
	 */
	public int selectOfficeQnaBoardCount(PagingVO<BoardVO> pagingVO);

	/**
	 * 입주민 대상 Qna 리스트 조회
	 * @param pagingVO
	 * @author 이미정
	 * @return
	 */
	public List<BoardVO> selectOfficeQnaBoardList(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 입주민 대상 Qna 상세보기
	 * @param boardVO
	 * @return
	 */
	public BoardVO selectOfficeQnaBoard(BoardVO boardVO);
	
	/**
	 * 입주민 대상 Qna 글 작성
	 * @param boardVO
	 * @return
	 */
	public int insertOfficeQnaBoard(BoardVO boardVO);
	
	/**
	 * 입주민 대상 Qna 글 수정
	 * @param boardVO
	 * @return
	 */
	public int updateOfficeQnaBoard(BoardVO boardVO);
	
	/**
	 * 입주민 대상 Qna 글 삭제
	 * @param boNo
	 * @return
	 */
	public int deleteOfficeQnaBoard(int boNo);
	
	/**
	 * 입주민 대상 Qna 조회수 증가
	 * @param bo_no
	 * @return
	 */
	public int incrementHit(int bo_no);

	/**
	 * 해당 글의 답변이 있는지 조회
	 * @param param
	 * @return
	 */
	public BoardVO answerChk(BoardVO param);

	/**
	 * 답변이 없는 질문글 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int selectWaitingQnaCount(PagingVO<BoardVO> pagingVO);

	/**
	 * @param 답변이 없는 질문글 리스트 조회
	 * @return
	 */
	public List<BoardVO> selectWaitingQnaList(PagingVO<BoardVO> pagingVO);
		
}
