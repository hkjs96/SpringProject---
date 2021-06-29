package kr.or.anyapart.board.freeboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.anyapart.board.freeboard.dao.IReplyDAO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.ReplyVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.PagingVO;

@Service
public class ReplyServiceImpl implements IReplyService{

	@Inject
	private IReplyDAO replyDAO;

	/**
	 * 글 등록 전 부모댓글이 있으면 depth를 체크하여 등록할 depth값을 돌려주는 메서드
	 * @param paramReply
	 * @return insert할 depth 값
	 */
	public void getRepDepth(ReplyVO paramReply) {
		Object repParentParam = paramReply.getRepParent();
		if(repParentParam != null) { // depth 체크하기 위함
			paramReply.setRepDepth(2);
		}
	}
	
	@Override
	public ServiceResult createReply(ReplyVO reply) {
		getRepDepth(reply);
		
		int rowcnt = replyDAO.insertReply(reply);
		ServiceResult result = ServiceResult.FAILED;
		if(rowcnt>0) result = ServiceResult.OK;
		return result;
	}

	@Override
	public int retrieveReplyCount(PagingVO<ReplyVO> pagingVO) {
		return replyDAO.selectReplyCount(pagingVO);
	}

	@Override
	public List<ReplyVO> retrieveReplyList(PagingVO<ReplyVO> pagingVO) {
		return replyDAO.selectReplyList(pagingVO);
	}

	@Override
	public ServiceResult modifyReply(ReplyVO reply) {
		int rowcnt = replyDAO.updateReply(reply);
		ServiceResult result = ServiceResult.FAILED;
		if(rowcnt>0) result = ServiceResult.OK;
		return result;
	}

	@Override
	public ServiceResult removeReply(ReplyVO reply) {
		int rowcnt = replyDAO.deleteReply(reply);
		ServiceResult result = ServiceResult.FAILED;
		if(rowcnt>0) result = ServiceResult.OK;
		return result;
	}
	
	
}
