/**
 * @author 박정민
 * @since 2021. 2. 2.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 2.       박정민         최초작성
 * Copyright (c) 2021. 2. 2. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.document.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commonsweb.service.IAttachService;
import kr.or.anyapart.document.dao.IDocumentDAO;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class DocumentServiceImpl implements IDocumentService{

	@Inject
	private IDocumentDAO dao;
	
	@Inject
	private IAttachService attService;
	
	private Logger logger = LoggerFactory.getLogger(DocumentServiceImpl.class);
	/* (non-Javadoc)
	 * @see kr.or.anyapart.document.service.IDocumentService#retreiveDocumentCount(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public int retreiveDocumentCount(PagingVO<BoardVO> pagingVO) {
		return dao.selectDocumentCount(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.document.service.IDocumentService#retreiveDocumentList(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public List<BoardVO> retreiveDocumentList(PagingVO<BoardVO> pagingVO) {
		return dao.selectDocumentList(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.document.service.IDocumentService#retreiveDocument(kr.or.anyapart.board.vo.BoardVO)
	 */
	@Override
	public BoardVO retreiveDocument(BoardVO boardVO){
		BoardVO board = dao.selectDocument(boardVO);
		//조회수 변경
		board.setBoHit(board.getBoHit()+1);
		dao.updateDocumentHit(board);
		return board;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.document.service.IDocumentService#insertDocument(kr.or.anyapart.board.vo.BoardVO)
	 */
	@Override
	@Transactional
	public int insertDocument(BoardVO boardVO){
		int cnt = dao.insertDocument(boardVO);
		List<AttachVO> attachList = boardVO.getAttachList();
		if(cnt>0) {
			cnt += attService.processAttaches(boardVO);
		}
		return cnt;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.document.service.IDocumentService#updateDocument(kr.or.anyapart.board.vo.BoardVO)
	 */
	@Override
	public int updateDocument(BoardVO board) {
		
		int cnt = dao.updateDocument(board);
		if(cnt>0) {
			attService.processAttaches(board);
			attService.processDeleteAttatch(board);
		}
		return cnt;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.document.service.IDocumentService#deleteDocument(kr.or.anyapart.board.vo.BoardVO)
	 */
	@Override
	public int deleteDocument(BoardVO boardVO, MemberVO authMember) {
		BoardVO boVo = dao.selectDocument(boardVO);
		if(boVo==null) {
			throw new RuntimeException(boardVO.getBoNo() + "번 글이 없음.");
		}
		int cnt = 0;
		if(boVo.getBoWriter().equals(authMember.getMemId())) {
			List<AttachVO> attList = boVo.getAttachList();
			if(attList!=null && attList.size()>0) {
				for(AttachVO attVO : attList) {
					cnt += dao.deleteAttaches(boVo);
				}
			}
			cnt += dao.deleteDocument(boVo);
		}else {
			cnt = -1;
		}
		return cnt;
	}

}
