package kr.or.anyapart.commonsweb.dao;

import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vo.AttachVO;

@Repository
public interface IAttachDAO {
	public int insertAttaches(BoardVO board);
	public int deleteAttatches(BoardVO board);
	public AttachVO selectAttach(AttachVO attachVO);
	
}
