package kr.or.anyapart.commonsweb.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commonsweb.dao.IAttachDAO;
import kr.or.anyapart.vo.AttachVO;

@Service
public class AttachServiceImpl implements IAttachService {
	
	@Inject
	private IAttachDAO attDAO;
	
	@Value("#{appInfo['boardFiles']}")
	private File saveFolder;

	@Override
	public int processAttaches(BoardVO board) {
		List<AttachVO> attatchList = board.getAttachList();
		int cnt = 0;
		if(attatchList != null && !attatchList.isEmpty() ) {
			cnt += attDAO.insertAttaches(board);
			try {
				for(AttachVO attatch : attatchList) {
					attatch.saveTo(saveFolder);
				}	
			}catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
		return cnt;
	}

	@Override
	public AttachVO download(AttachVO attachVO) {
		AttachVO attatch = attDAO.selectAttach(attachVO);
		if(attatch==null) throw new RuntimeException(attachVO+" 파일이 없음.");
		return attatch;
	}

	@Override
	public int processDeleteAttatch(BoardVO board) {
		int cnt = 0;
		int[] delAttNos = board.getDelAttNos();
		if(delAttNos!=null && delAttNos.length>0) {
			String[] saveNames = new String[delAttNos.length];
			for(int i = 0; i<delAttNos.length; i++) {
				AttachVO paramVO = new AttachVO();
				paramVO.setAttSn(delAttNos[i]);
				paramVO.setBoNo(board.getBoNo());
				
				saveNames[i] = attDAO.selectAttach(paramVO).getAttSavename();
			}
			cnt = attDAO.deleteAttatches(board);
			if(cnt == saveNames.length) {
				for(String savename : saveNames) {
					FileUtils.deleteQuietly(new File(saveFolder, savename));
				}
			}
		}
		return cnt;
	}
	
}
