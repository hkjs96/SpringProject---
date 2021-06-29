/**
 * @author 박정민
 * @since 2021. 2. 2.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 2.       박정민         최초작성
 * Copyright (c) 2021. 2. 2. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.document.service;

import java.util.List;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

public interface IDocumentService {

	/**
	 * 전체 일반문서 수 조회
	 * @param pagingVO
	 * @return
	 */
	int retreiveDocumentCount(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 일반문서 목록 조회
	 * @param pagingVO
	 * @return
	 */
	List<BoardVO> retreiveDocumentList(PagingVO<BoardVO> pagingVO);

	/**
	 * 일반문서 상세조회
	 * @param boardVO
	 * @return
	 */
	BoardVO retreiveDocument(BoardVO boardVO);

	/**
	 * 일반문서 등록
	 * @param boardVO
	 */
	int insertDocument(BoardVO boardVO);

	/**
	 * 일반문서 수정
	 * @param board
	 * @return
	 */
	int updateDocument(BoardVO board);

	/**
	 * 일반문서 삭제
	 * @param boardVO
	 * @param authMember 
	 * @return
	 */
	int deleteDocument(BoardVO boardVO, MemberVO authMember);
}
