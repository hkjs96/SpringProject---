/**
 * @author 이경륜
 * @since 2021. 1. 28.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.freeboard.service;

import java.util.List;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.PagingVO;

public interface IFreeBoardService {
	/**
	 * 자유게시판 글 등록
	 * @param param
	 * @return OK, FAILED
	 */
	public ServiceResult createBoard(BoardVO param);
	/**
	 * 자유게시판 글 갯수 조회
	 * @param paging
	 * @return 
	 */
	public int retrieveBoardCount(PagingVO<BoardVO> paging);
	/**
	 * 자유게시판 전체 글 조회
	 * @param paging
	 * @return
	 */
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> paging);
	/**
	 * 자유게시판 글 상세조회
	 * @param param
	 * @return 존재하지 않으면 custom exception
	 */
	public BoardVO retrieveBoard(BoardVO param);
	/**
	 * 자유게시판 글 수정
	 * @param param
	 * @return
	 */
	public ServiceResult modifyBoard(BoardVO param);
	/**
	 * 자유게시판 글 삭제
	 * @param param
	 * @return
	 */
	public ServiceResult removeBoard(BoardVO param);
	
}
