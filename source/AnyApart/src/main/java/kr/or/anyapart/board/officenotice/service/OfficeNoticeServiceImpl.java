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
 * 2021. 2. 15.      이미정       기존 코드 보완
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.board.officenotice.service;

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
import kr.or.anyapart.board.officenotice.dao.IOfficeNoticeDAO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.dao.IAttachDAO;
import kr.or.anyapart.commonsweb.service.IAttachService;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class OfficeNoticeServiceImpl implements IOfficeNoticeService{
	private static final Logger LOGGER = LoggerFactory.getLogger(OfficeNoticeServiceImpl.class);
	
	@Inject
	private IOfficeNoticeDAO officeNoticeDAO;
	
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
		return officeNoticeDAO.selectOfficeNoticeBoardList(pagingVO);
	}

	@Override
	public int retrieveBoardCount(PagingVO<BoardVO> pagingVO) {
		return officeNoticeDAO.selectOfficeNoticeBoardCount(pagingVO);
	}

	@Override
	public BoardVO retrieveBoard(BoardVO boardVO) {
		BoardVO board = officeNoticeDAO.selectOfficeNoticeBoard(boardVO);
		if(board==null) throw new CustomException(board.getBoNo()+"번 글이 없음.");
		officeNoticeDAO.incrementHit(board.getBoNo());
		return board;
	}

	@Transactional
	@Override
	public ServiceResult createBoard(BoardVO boardVO) {
		int cnt = officeNoticeDAO.insertOfficeNoticeBoard(boardVO);
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
		BoardVO savedBoard = officeNoticeDAO.selectOfficeNoticeBoard(boardVO);
		if (savedBoard == null)
			throw new RuntimeException(boardVO.getBoNo() + "번 글이 없음.");
		boardVO.getDelAttNos();
		ServiceResult result = ServiceResult.FAILED;
		int cnt = officeNoticeDAO.updateOfficeNoticeBoard(boardVO);
		if(cnt > 0) {
			attService.processAttaches(boardVO);
			attService.processDeleteAttatch(boardVO);
			result = ServiceResult.OK;
		}
		else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Transactional
	@Override
	public ServiceResult removeBoard(BoardVO boardVO) {
		// 게시글 존재 여부 확인
		BoardVO savedBoard = officeNoticeDAO.selectOfficeNoticeBoard(boardVO);
		ServiceResult result = ServiceResult.FAILED;
		if (savedBoard == null)
			throw new RuntimeException(boardVO.getBoNo() + "번 글이 없음.");
		
		// 작성자id와 session id가 같은 지 확인 후 삭제 
		if(savedBoard.getBoWriterId().equals(boardVO.getBoWriterId())) {
			
			// 비밀번호 암호화 후 인증
			// 첨부파일 메타 삭제
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
			// 게시글 삭제
			cnt += officeNoticeDAO.deleteOfficeNoticeBoard(boardVO.getBoNo());
			if (cnt > 0) {
				result = ServiceResult.OK;
			}else { 
				throw new CustomException("잘못된 접근입니다.");
			}
		}
		
		return result;
	}

}
