package kr.or.anyapart.board.vendornotice.service;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.impl.EgovSequenceIdGnrServiceImpl;
import kr.or.anyapart.board.vendornotice.dao.VendorNotcieDAO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.dao.IAttachDAO;
import kr.or.anyapart.commonsweb.service.IAttachService;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class VendorNoticeServiceImpl implements VendorNoticeService{
	private static final Logger LOGGER = LoggerFactory.getLogger(VendorNoticeServiceImpl.class);

	@Inject
	private VendorNotcieDAO vendorNoticeDAO;

	@Inject
	private IAttachService attService;

	@Inject
	private IAttachDAO attDAO;

	@Override
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> paging) {

		return vendorNoticeDAO.selectvendorNoticeBoardList(paging);
	}

	@Override
	public int retrieveBoardCount(PagingVO<BoardVO> paging) {
		return vendorNoticeDAO.selectvendorNoticeBoardCount(paging);
	}

	@Override
	public BoardVO retrieveBoard(BoardVO boardVO) {
		return vendorNoticeDAO.selectvendorNoticeBoard(boardVO);
	}

	@Resource(name = "egovSequenceBoardNOService")
	private EgovSequenceIdGnrServiceImpl idGen;

	@Value("#{appInfo['boardFiles']}")
	private File saveFolder;

	@PostConstruct
	public void init() {
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		LOGGER.info("{}", saveFolder.getAbsolutePath());
	}

	@Transactional
	@Override
	public ServiceResult createNoticeBoard(BoardVO board) {
		try {
//			EgovIdGenerator
			int boNo = idGen.getNextIntegerId();
			board.setBoNo(boNo);

			int cnt = vendorNoticeDAO.insertvendorNoticeBoard(board);
			if (cnt > 0) {
				cnt += attService.processAttaches(board);
			}
			ServiceResult result = null;
			if (cnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
			return result;
		} catch (FdlException e) {
			throw new RuntimeException(e);
		}
	}

	@Transactional
	@Override
	public ServiceResult removeBoard(BoardVO board) {
		// 게시글 존재 여부 확인
		BoardVO savedBoard = vendorNoticeDAO.selectvendorNoticeBoard(board);
		ServiceResult result = ServiceResult.FAILED;
		if (savedBoard == null)
			throw new RuntimeException(board.getBoNo() + "번 글이 없음.");
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
			cnt = attDAO.deleteAttatches(board);
		}
		// 2. 게시글 삭제
		cnt += vendorNoticeDAO.deletevendorNoticeBoard(board.getBoNo());
		if (cnt > 0)result = ServiceResult.OK;
		
		return result;
	}

	@Override
	public ServiceResult modifyBoard(BoardVO board) {
		BoardVO savedBoard = vendorNoticeDAO.selectvendorNoticeBoard(board);
		if (savedBoard == null)
			throw new RuntimeException(board.getBoNo() + "번 글이 없음.");
		board.getDelAttNos();
		ServiceResult result = ServiceResult.FAILED;
		int cnt = vendorNoticeDAO.updatevendorNoticeBoard(board);
		if(cnt > 0) {
			// 신규 등록 첨부 파일
			attService.processAttaches(board);
			attService.processDeleteAttatch(board);
			
			result = ServiceResult.OK;
		}
		else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		
		return result;
	}


}
