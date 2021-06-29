/**
 * @author 이미정
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.board.officeqna.service;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.board.officeqna.dao.IOfficeQnaDAO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.dao.IAttachDAO;
import kr.or.anyapart.commonsweb.service.IAttachService;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class OfficeQnaServiceImpl implements IOfficeQnaService{
	private static final Logger LOGGER = LoggerFactory.getLogger(OfficeQnaServiceImpl.class);
	
	@Inject
	private IOfficeQnaDAO officeQnaDAO;
	
	@Inject
	private IAttachService attService;
	
	@Inject
	private IAttachDAO attDAO;
	
	@Value("#{appInfo['boardFiles']}")
	private File saveFolder;


	@PostConstruct
	public void init() {
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		LOGGER.info("{}", saveFolder.getAbsolutePath());
	}
	
	@Override
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> pagingVO) {
		return officeQnaDAO.selectOfficeQnaBoardList(pagingVO);
	}

	@Override
	public int retrieveBoardCount(PagingVO<BoardVO> pagingVO) {
		return officeQnaDAO.selectOfficeQnaBoardCount(pagingVO);
	}

	@Override
	public BoardVO retrieveBoard(BoardVO boardVO) {
		BoardVO board =  officeQnaDAO.selectOfficeQnaBoard(boardVO);
		if(boardVO==null) throw new CustomException(board.getBoNo()+"번 글이 없음.");
		officeQnaDAO.incrementHit(board.getBoNo());
		return board;
	}

	@Transactional
	@Override
	public ServiceResult createBoard(BoardVO boardVO) {
		if(boardVO.getBoNo()!=null) {
			BoardVO board = officeQnaDAO.selectOfficeQnaBoard(boardVO);
			int depth = board.getBoDepth();
			int parent = board.getBoNo();
			boardVO.setBoDepth(depth+1);
			boardVO.setBoParent(parent);
		}
		
		int cnt = officeQnaDAO.insertOfficeQnaBoard(boardVO);
		if(cnt>0) {
			cnt+=attService.processAttaches(boardVO);
		}
		ServiceResult result = null;
		if (cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;		
	}

	@Override
	public ServiceResult modifyBoard(BoardVO boardVO) {
		BoardVO savedBoard = officeQnaDAO.selectOfficeQnaBoard(boardVO);
		if (savedBoard == null)
			throw new RuntimeException(boardVO.getBoNo() + "번 글이 없음.");
		boardVO.getDelAttNos();
		ServiceResult result = ServiceResult.FAILED;
		int cnt = officeQnaDAO.updateOfficeQnaBoard(boardVO);
		if(cnt > 0) {
			attService.processAttaches(boardVO);
			attService.processDeleteAttatch(boardVO);
			result = ServiceResult.OK;
		}
		else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeBoard(BoardVO boardVO) {
		// 게시글 존재 여부 확인
		BoardVO savedBoard = officeQnaDAO.selectOfficeQnaBoard(boardVO);
		
		ServiceResult result = ServiceResult.FAILED;
		if (savedBoard == null)
			throw new RuntimeException(boardVO.getBoNo() + "번 글이 없음.");
		
		// 작성자id와 session id가 같은 지 확인 후 삭제 
		if(savedBoard.getBoWriterId().equals(boardVO.getBoWriterId())) {
			// 비밀번호 암호화 후 인증
			// 1. 첨부파일 메타 삭제
			List<AttachVO> attatchList = savedBoard.getAttachList();
			String[] saveNames = null;
			int cnt = 0;
			if (attatchList != null && attatchList.size() > 0) {
				saveNames = new String[attatchList.size()];
				for (int i = 0; i < saveNames.length; i++) {
					saveNames[i] = attatchList.get(i).getAttSavename();
				}
				cnt = attDAO.deleteAttatches(boardVO);
			}
			// 2. 게시글 삭제
			cnt += officeQnaDAO.deleteOfficeQnaBoard(boardVO.getBoNo());
			if (cnt > 0)result = ServiceResult.OK;
		}else { 
			throw new CustomException("잘못된 접근입니다.");
		}
		return result;
	}

	@Override
	public int retrieveWaitingQnaCount(PagingVO<BoardVO> pagingVO) {
		return officeQnaDAO.selectWaitingQnaCount(pagingVO);
	}

	@Override
	public List<BoardVO> retrieveWaitingQnaList(PagingVO<BoardVO> pagingVO) {
		return officeQnaDAO.selectWaitingQnaList(pagingVO);
	}


}
