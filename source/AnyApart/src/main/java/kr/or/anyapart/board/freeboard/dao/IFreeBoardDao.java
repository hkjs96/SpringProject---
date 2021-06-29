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

package kr.or.anyapart.board.freeboard.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IFreeBoardDao {
	public int insertBoard(BoardVO board);
	public int selectBoardCount(PagingVO<BoardVO> paging);
	public List<BoardVO> selectBoardList(PagingVO<BoardVO> paging);
	public BoardVO selectBoard(BoardVO board);
	public int incrementHit(BoardVO board);
	public int updateBoard(BoardVO board);
	public int deleteBoard(BoardVO board);
	/**
	 * 자식글 삭제 전, 부모글이 삭제되었는지 확인하는 메서드
	 * @param board
	 * @return int 삭제되었으면 0보다 큼
	 */
	public int selectBoParentIsDeleted(BoardVO board);
	/**
	 * 자식글 삭제 후, 이미 삭제된 부모글이 다른 자식을 가지고 있는지 확인하는 메서드
	 * @return int 존재하는 자식글 수
	 */
	public int selectBoChildCount(BoardVO board);
}
