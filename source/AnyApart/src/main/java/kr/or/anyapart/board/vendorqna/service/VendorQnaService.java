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
 * 2021. 2. 8.      박지수       반환값 자료형 변경 및 인서트 로직 구현
 * 2021. 2. 8.      박지수       게시글 수정
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.vendorqna.service;

import java.util.List;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

public interface VendorQnaService {
	public void createBoard(BoardVO board);
	public int retrieveBoardCount(PagingVO<BoardVO> paging);
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> paging);
	public BoardVO retrieveBoard(int bo_no);
	
	/**
	 * 문의 게시글 변경
	 * @param board
	 */
	public void modifyBoard(BoardVO board);
	
	
	/*
		관리사무소측 문의 게시글 삭제는 보류, 해당 아파트 정보가 파기 될떄 같이 파기되는걸로
	*/
	 public void removeBoard(int boNo, MemberVO authMember);
	 
	 /*
		벤더 사이트측 문의 게시글 삭제는 보류, 해당 아파트 정보가 파기 될떄 같이 파기되는걸로
	  */
	 public void removeBoard(int boNo);
	 
	 /*
	 	전체, 답변, 미답변 글의 수를 조회하여 반환한다.
	  */
	 public void countAnswer(PagingVO<BoardVO> paging, BoardVO searchDetail);
}
