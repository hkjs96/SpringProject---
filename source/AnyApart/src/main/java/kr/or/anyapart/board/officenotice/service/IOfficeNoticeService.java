/**
 * @author 이미정
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.      이미정      최초작성
 * 2021. 2. 15.      이미정      기존 코드 보완
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.board.officenotice.service;

import java.util.List;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.PagingVO;

public interface IOfficeNoticeService {
	/**
	 * 공지사항 글 등록
	 * @param boardVO
	 * @return OK, FAILED
	 */
	public ServiceResult createBoard(BoardVO boardVO);

	/**
	 * 공지사항 전체 글 조회
	 * @param pagingVO
	 * @return
	 */
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 공지사항 글 상세조회
	 * @param boardVO
	 * @return 존재하지 않으면 custom Exception
	 */
	public BoardVO retrieveBoard(BoardVO boardVO);

	/**
	 * 공지사항 전체 글 조회
	 * @param pagingVO
	 * @return
	 */
	public int retrieveBoardCount(PagingVO<BoardVO> pagingVO);
	
	/**
	 * 공지사항 글 수정
	 * @param boardVO
	 * @return
	 */
	public ServiceResult modifyBoard(BoardVO boardVO);
	
	/**
	 * 공지사항 글 삭제
	 * @param boardVO
	 * @return
	 */
	public ServiceResult removeBoard(BoardVO boardVO);
	
	
}
