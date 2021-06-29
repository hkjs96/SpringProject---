package kr.or.anyapart.board.vendornotice.service;

import java.util.List;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.PagingVO;

public interface VendorNoticeService{

	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> paging);

	public int retrieveBoardCount(PagingVO<BoardVO> paging);
	
	public BoardVO retrieveBoard(BoardVO boardVO);

	public ServiceResult createNoticeBoard(BoardVO board);

	public ServiceResult removeBoard(BoardVO board);

	public ServiceResult modifyBoard(BoardVO board);


}
