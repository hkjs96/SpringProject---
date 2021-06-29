package kr.or.anyapart.board.freeboard.service;

import java.util.List;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.board.vo.ReplyVO;

public interface IReplyService {
	public ServiceResult createReply(ReplyVO reply);
	public int retrieveReplyCount(PagingVO<ReplyVO> pagingVO);
	public List<ReplyVO> retrieveReplyList(PagingVO<ReplyVO> pagingVO);
	public ServiceResult modifyReply(ReplyVO reply);
	public ServiceResult removeReply(ReplyVO reply);
}
