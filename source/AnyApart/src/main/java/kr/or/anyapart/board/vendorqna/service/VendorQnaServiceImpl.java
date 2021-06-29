/**
 * @author 박지수
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.vendorqna.service;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.transaction.Transactional;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.board.vendorqna.dao.VendorQnaDAO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commonsweb.dao.IAttachDAO;
import kr.or.anyapart.commonsweb.service.IAttachService;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class VendorQnaServiceImpl implements VendorQnaService {
	private static final Logger LOGGER = LoggerFactory.getLogger(VendorQnaServiceImpl.class);

	
	@Inject
	private VendorQnaDAO officeQnaDAO;
	
	@Inject
	private IAttachService attService;
	
	@Inject
	private IAttachDAO attDao;
	
	@Value("#{appInfo['boardFiles']}")
	private File saveFolder;

	@PostConstruct
	public void init() {
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		LOGGER.info("{}", saveFolder.getAbsolutePath());
	}
	
	
	/* 
	 * [문의 게시글 등록]
	 */
	@Transactional
	@Override
	public void createBoard(BoardVO board) {
		try {
			int rowcnt = officeQnaDAO.insertOfficeQna(board);
			if( rowcnt > 0) {
				int attFileCnt = board.getAttachList().size();
				int attInsertCnt = attService.processAttaches(board);
				if(attFileCnt != attInsertCnt) { // 파일갯수만큼 업로드가 잘 되지 않았으면
					throw new RuntimeException("파일 업로드 실패");
				}
			}else {
				throw new RuntimeException("게시글 작성 실패");
			}
		}catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		
		
	}

	/* 
	 * [문의게시글 갯수]
	 */
	@Override
	public int retrieveBoardCount(PagingVO<BoardVO> pagingVO) { 
		return officeQnaDAO.selectOfficeQnaCount(pagingVO);
	}

	/* 
	 * [문의 게시글 리스트 조회] 
	 */
	@Override
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> pagingVO) {
		return officeQnaDAO.selectOfficeQnaList(pagingVO);
	}

	/* 
	 * [게시물 조회]
	 */
	@Override
	public BoardVO retrieveBoard(int boNo) {
		BoardVO board = officeQnaDAO.selectOfficeQna(boNo);
		if(board==null) throw new CustomException(boNo + "에 해당하는 게시글이 없습니다."); // 에러페이지로 못가고있음
		officeQnaDAO.incrementHit(board);
		return board;
	}

	/* 
	 * [게시물 변경]
	 */
	@Override
	public void modifyBoard(BoardVO board) {
		try {
			BoardVO savedBoard = officeQnaDAO.selectOfficeQna(board.getBoNo());
			if(savedBoard==null) throw new CustomException(board.getBoNo() + "에 해당하는 게시물이 존재하지 않습니다.");
			
			int rowcnt = officeQnaDAO.updateOfficeQna(board);
			if( rowcnt > 0) {
				attService.processAttaches(board);
				attService.processDeleteAttatch(board);
			}else {
				throw new RuntimeException("게시글 변경 실패");
			}
		}catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	/* 
	 * [관리사무소 문의 게시글 삭제 처리]
	 */
	@Transactional
	@Override
	public void removeBoard(int boNo, MemberVO authMember) {
		BoardVO board = officeQnaDAO.selectOfficeQna(boNo);
		if (board==null) throw new RuntimeException(boNo+"번 글이 없음");
		if (!StringUtils.equals(board.getBoWriter(), authMember.getMemNick())) throw new RuntimeException("해당 게시물의 작성자가 아님");
		remove(boNo);
	}
	
	/* 
	 * [관리사무소 문의 게시글 삭제 처리]
	 */
	@Transactional
	@Override
	public void removeBoard(int boNo) {
		BoardVO board = officeQnaDAO.selectOfficeQna(boNo);
		if (board==null) throw new RuntimeException(boNo+"번 글이 없음");
		remove(boNo);
	}


	/**
	 * @param boNo 삭제할 게시물번호
	 * @author 박지수
	 * @since 2021 02 09
	 */
	private void remove(int boNo) {
		try {
			// 1. 연관된 게시물을 모두 찾음
			List<BoardVO> boardList = officeQnaDAO.selectDeleteBoard(boNo);
			
			// 2. 파일테이블의 메타데이터 삭제
			String[] saveNames = null;
			for(BoardVO tmp : boardList) {
				List<AttachVO> attachList = tmp.getAttachList();
				int cnt = 0;
				int resultCnt = 0;
				if (attachList != null && attachList.size() > 0) { // 파일이 있으면
					saveNames = new String[attachList.size()];
					for (int i = 0; i < saveNames.length; i++) {
						saveNames[i] = attachList.get(i).getAttSavename();
						cnt+=1;
					}
					resultCnt = attDao.deleteAttatches(tmp);
				}
				if(cnt!=resultCnt) {
					throw new RuntimeException("파일 갯수와 삭제된 갯수가 일치 하지 않음.");
				}
			}
			
			// 3. 게시글 삭제
			int rowcnt = officeQnaDAO.deleteOfficeQna(boNo);
			if(rowcnt!=boardList.size()) {
				throw new RuntimeException("연관된 게시글이 모두 삭제 되지 않음.");
			}
			
			// 4. 첨부파일 2진 데이터 삭제
			if(saveNames!=null) {
				for(String savename : saveNames) {
					FileUtils.deleteQuietly(new File(saveFolder, savename));
				}
			}
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
	}


	/* 
	 * [ 전체, 답변, 미답변 게시물의 갯수를 조회한다. ]
	 */
	@Override
	public void countAnswer(PagingVO<BoardVO> paging, BoardVO searchDetail) {
		BoardVO countBoard = officeQnaDAO.countAnswer(paging);
		searchDetail.setAllNum(countBoard.getAllNum());
		searchDetail.setAnsNum(countBoard.getAnsNum());
		searchDetail.setUnAnsNum(countBoard.getUnAnsNum());
		paging.setSearchDetail(searchDetail);
	}
}
