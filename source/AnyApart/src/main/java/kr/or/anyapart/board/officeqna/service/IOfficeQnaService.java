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
package kr.or.anyapart.board.officeqna.service;

import java.util.List;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.PagingVO;

public interface IOfficeQnaService{

	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> pagingVO);
	
	public BoardVO retrieveBoard(BoardVO boardVO);

	public int retrieveBoardCount(PagingVO<BoardVO> pagingVO);
	
	public ServiceResult createBoard(BoardVO boardVO);

	public ServiceResult modifyBoard(BoardVO boardVO);
	
	public ServiceResult removeBoard(BoardVO boardVO);

	public int retrieveWaitingQnaCount(PagingVO<BoardVO> pagingVO);

	public List<BoardVO> retrieveWaitingQnaList(PagingVO<BoardVO> pagingVO);
}
