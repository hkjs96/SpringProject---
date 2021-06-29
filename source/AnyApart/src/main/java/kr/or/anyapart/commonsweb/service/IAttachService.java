package kr.or.anyapart.commonsweb.service;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.AttachVO;

public interface IAttachService {

	int processAttaches(BoardVO board);
	public AttachVO download(AttachVO param);
	int processDeleteAttatch(BoardVO board);
}
