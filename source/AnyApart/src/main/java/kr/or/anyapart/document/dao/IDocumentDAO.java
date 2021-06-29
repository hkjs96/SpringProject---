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
package kr.or.anyapart.document.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IDocumentDAO {
	/**
	 * @param pagingVO
	 * @return
	 */
	public int selectDocumentCount(PagingVO<BoardVO> pagingVO);
	/**
	 * @param pagingVO
	 * @return
	 */
	public List<BoardVO> selectDocumentList(PagingVO<BoardVO> pagingVO);
	/**
	 * @param boardVO
	 * @return
	 */
	public BoardVO selectDocument(BoardVO boardVO);
	/**
	 * @param boardVO
	 * @return
	 */
	public int insertDocument(BoardVO boardVO);
	/**
	 * @param boardVO
	 */
	public void updateDocumentHit(BoardVO boardVO);
	/**
	 * @param board
	 * @return
	 */
	public int updateDocument(BoardVO board);
	/**
	 * @param boardVO
	 * @return
	 */
	public int deleteDocument(BoardVO boardVO);
	/**
	 * @param boardVO
	 * @return
	 */
	public int deleteAttaches(BoardVO boardVO);
}
