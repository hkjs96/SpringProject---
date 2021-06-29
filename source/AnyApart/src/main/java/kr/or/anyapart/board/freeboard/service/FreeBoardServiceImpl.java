/**
 * @author 이경륜
 * @since 2021. 1. 28.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.freeboard.service;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.transaction.Transactional;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.cmmn.exception.FdlException;
import kr.or.anyapart.CustomException;
import kr.or.anyapart.board.freeboard.dao.IFreeBoardDao;
import kr.or.anyapart.board.vendornotice.service.VendorNoticeServiceImpl;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.dao.IAttachDAO;
import kr.or.anyapart.commonsweb.service.IAttachService;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class FreeBoardServiceImpl implements IFreeBoardService {
	private static final Logger LOGGER = LoggerFactory.getLogger(FreeBoardServiceImpl.class);

	@Inject
	private IFreeBoardDao boardDao;
	
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
	
	/**
	 * 글 등록 전 부모글이 있으면 depth를 체크하여 등록할 depth값을 돌려주는 메서드
	 * @param param
	 * @return insert할 depth 값
	 */
	public void getBoDepth(BoardVO param) {
		Object boParentParam = param.getBoParent();
		if(boParentParam != null) { // depth 체크하기 위함
			BoardVO depthParamVO = new BoardVO();
			depthParamVO.setBoNo( (int) boParentParam );
			BoardVO depthResultVO = boardDao.selectBoard(depthParamVO);
			param.setBoDepth(depthResultVO.getBoDepth()+1);
		}
	}
	
	@Transactional
	@Override
	public ServiceResult createBoard(BoardVO param) {
		getBoDepth(param);
		int cnt = boardDao.insertBoard(param);
		
		ServiceResult result = ServiceResult.OK;
		
		if(cnt>0) {
			int attFileCnt = param.getAttachList().size();
			int attInsertCnt = attService.processAttaches(param);
			if(attFileCnt != attInsertCnt) { // 파일갯수만큼 업로드가 잘 되지 않았으면
				result = ServiceResult.FAILED;
			}
		}
		
		return result;
	}

	@Override
	public int retrieveBoardCount(PagingVO<BoardVO> paging) {
		return boardDao.selectBoardCount(paging);
	}

	@Override
	public List<BoardVO> retrieveBoardList(PagingVO<BoardVO> paging) {
		return boardDao.selectBoardList(paging);
	}

	@Override
	public BoardVO retrieveBoard(BoardVO param) {
		BoardVO board = boardDao.selectBoard(param);
		if(board==null) throw new CustomException(param.getBoNo() + "에 해당하는 게시글이 없습니다."); // 에러페이지로 못가고있음
		boardDao.incrementHit(board);
		return board;
	}

	@Transactional
	@Override
	public ServiceResult modifyBoard(BoardVO board) {
		BoardVO savedBoard = boardDao.selectBoard(board);
		if(savedBoard==null) throw new CustomException(board.getBoNo() + "에 해당하는 게시글이 없습니다."); // 에러페이지로 못가고있음
		
		ServiceResult result = ServiceResult.FAILED;
		int cnt = boardDao.updateBoard(board);
		
		if(cnt > 0) {
			attService.processAttaches(board);
			attService.processDeleteAttatch(board);
			
			result=ServiceResult.OK;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult removeBoard(BoardVO paramBoard) {
		BoardVO savedBoard = boardDao.selectBoard(paramBoard);
		ServiceResult result = ServiceResult.FAILED;
		if (savedBoard == null) throw new CustomException(paramBoard.getBoNo() + "번 글이 없음.");
		
		// 0. 작성자id와 session id가 같은 지 확인 후 삭제 (전차장님 조언)
		if (savedBoard.getBoWriterId().equals(paramBoard.getBoWriter()) 
				|| paramBoard.getBoWriter().contains("E")) { // 직원이면 삭제가능
			
			// 1. 파일테이블의 메타데이터 삭제
			List<AttachVO> attachList = savedBoard.getAttachList();
			String[] saveNames = null;
			int cnt = 0;
			if (attachList != null && attachList.size() > 0) { // 파일이 있으면
				saveNames = new String[attachList.size()];
				for (int i = 0; i < saveNames.length; i++) {
					saveNames[i] = attachList.get(i).getAttSavename();
				}
				cnt = attDao.deleteAttatches(paramBoard);
			}
			// 2. 게시글 삭제
			// 2-1. 부모글, 자식글에 관계 없이 삭제
			cnt += boardDao.deleteBoard(savedBoard);
			
			// 자식글인 경우, 삭제후 다른 자식글이 없으면 삭제된 부모글 삭제 필요
			if(savedBoard.getBoParent()!=null) {
				int deletedCnt = boardDao.selectBoParentIsDeleted(savedBoard);
				// 부모글이 삭제된 경우
				if (deletedCnt > 0) {
					int boChildCnt = boardDao.selectBoChildCount(savedBoard);
					if (boChildCnt == 0) { // 부모글이 삭제되었고, 딸린 자식글이 없는 경우
						// 부모글 삭제
						boardDao.deleteBoard(BoardVO.builder().boNo(savedBoard.getBoParent()).build());
					}
				}
			}
			
			// 3. 첨부파일 2진 데이터 삭제
			if(saveNames!=null) {
				for(String savename : saveNames) {
					FileUtils.deleteQuietly(new File(saveFolder, savename));
				}
			}
			
			// 4. 리플 삭제 (ON DELETE CASCADE로 처리)
			
			if (cnt > 0)result = ServiceResult.OK;
		}else { // 작성자도 아니고 직원도 아니면 예외발생 => 처리 필요
			throw new CustomException("잘못된 접근입니다.");
		}
		
		return result;
	}

	
}
