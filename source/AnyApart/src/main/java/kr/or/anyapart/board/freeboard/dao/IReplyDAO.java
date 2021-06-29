package kr.or.anyapart.board.freeboard.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.board.vo.ReplyVO;

@Repository
public interface IReplyDAO {
	public int insertReply(ReplyVO reply);
	public int selectReplyCount(PagingVO<ReplyVO> pagingVO);
	public List<ReplyVO> selectReplyList(PagingVO<ReplyVO> pagingVO);
	public int updateReply(ReplyVO reply);
	public int deleteReply(ReplyVO reply);
}
