/**
 * @author 이미정
 * @since 2021. 3. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 3. 3.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.approval.draftatt.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.anyapart.approval.draftatt.dao.DraftAttDAO;
import kr.or.anyapart.approval.vo.DraftAttVO;
import kr.or.anyapart.approval.vo.DraftVO;

@Service
public class DraftAttServiceImpl implements DraftAttService{
	@Inject
	private DraftAttDAO attDAO;
	
	@Value("#{appInfo['boardFiles']}")
	private File saveFolder;
	
	@Override
	public int processAttaches(DraftVO draft) {
		List<DraftAttVO> attatchList = draft.getDraftAttList();
		int cnt = 0;
		if(attatchList != null && !attatchList.isEmpty() ) {
			cnt += attDAO.insertAttaches(draft);
			try {
				for(DraftAttVO attatch : attatchList) {
					attatch.saveTo(saveFolder);
				}	
			}catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
		return cnt;
	}

	@Override
	public DraftAttVO download(DraftAttVO attachVO) {
		DraftAttVO attatch = attDAO.selectAttach(attachVO);
		if(attatch==null) throw new RuntimeException(attachVO+" 파일이 없음.");
		return attatch;
	}

	@Override
	public int processDeleteAttatch(DraftVO draft) {
		int cnt = 0;
		int[] delAttNos = draft.getDelAttNos();
		if(delAttNos!=null && delAttNos.length>0) {
			String[] saveNames = new String[delAttNos.length];
			for(int i = 0; i<delAttNos.length; i++) {
				DraftAttVO paramVO = new DraftAttVO();
				paramVO.setAttSn(delAttNos[i]);
				paramVO.setDraftId(draft.getDraftId());
				
				saveNames[i] = attDAO.selectAttach(paramVO).getAttSavename();
			}
			cnt = attDAO.deleteAttatches(draft);
			if(cnt == saveNames.length) {
				for(String savename : saveNames) {
					FileUtils.deleteQuietly(new File(saveFolder, savename));
				}
			}
		}
		return cnt;
	}
	
}
