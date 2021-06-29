package kr.or.anyapart.board.vendornotice.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface VendorNotcieDAO {
	/**
	 * 벤더가 관리사무소에게 보내는 공지사항  리스트 조회
	 * @param paging
	 * @author 박찬
	 * @return
	 */
	public List<BoardVO> selectvendorNoticeBoardList(PagingVO<BoardVO> paging);
	
	/**
	 * 페이징 처리 카운터 수
	 * @param paging
	 * @author 박찬s
	 * @return
	 */
	public int selectvendorNoticeBoardCount(PagingVO<BoardVO> paging);
	
	/**
	 * 벤더 공지사항 상세보기 
	 * @param boardVO
	 * @return
	 * @author 박찬
	 */
	public BoardVO selectvendorNoticeBoard(BoardVO boardVO);

	/**
	 * 벤더 공지 올리기
	 * @param board
	 * @return
	 * @author 박찬
	 */
	public int insertvendorNoticeBoard(BoardVO board);

	public int deletevendorNoticeBoard(Integer boNo);

	public int updatevendorNoticeBoard(BoardVO board);

}
