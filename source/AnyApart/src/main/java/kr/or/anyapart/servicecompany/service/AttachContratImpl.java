package kr.or.anyapart.servicecompany.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.anyapart.servicecompany.dao.AttachServiceDAO;
import kr.or.anyapart.servicecompany.vo.ServiceAttachVO;
import kr.or.anyapart.servicecompany.vo.ServiceVO;

@Service
public class AttachContratImpl implements AttachContrat {

	@Inject
	private AttachServiceDAO attDAO;
	
	@Value("#{appInfo['contratFiles']}")
	private File saveFolder;
	
	@Override
	public int processAttaches(ServiceVO contrat) {
		List<ServiceAttachVO> attatchList = contrat.getAttachList();
		
		
		int cnt = 0;
		if(attatchList != null && !attatchList.isEmpty() ) {
			cnt += attDAO.insertAttaches(contrat);
			try {
				for(ServiceAttachVO attatch : attatchList) {
					attatch.saveTo(saveFolder);
				}	
			}catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
		return cnt;
	}

	@Override
	public ServiceAttachVO download(ServiceAttachVO contrat) {
		ServiceAttachVO attatchs = attDAO.selectAttach(contrat);
		if(attatchs==null) throw new RuntimeException(contrat+" 파일이 없음.");
		return attatchs;
	}

	
	@Override
	public int processDeleteAttatch(ServiceVO contrat) {
		int cnt = 0;
		int[] delAttNos = contrat.getDelAttNos();
		if(delAttNos!=null && delAttNos.length>0) {
			String[] saveNames = new String[delAttNos.length];
			for(int i = 0; i<delAttNos.length; i++) {
				ServiceAttachVO paramVO = new ServiceAttachVO();
				paramVO.setSvcFileNo(delAttNos[i]);
				paramVO.setSvcId(contrat.getSvcId());
				
				saveNames[i] = attDAO.selectAttach(paramVO).getSvcFile();
			}
			cnt = attDAO.deleteAttatches(contrat);
			if(cnt == saveNames.length) {
				for(String savename : saveNames) {
					FileUtils.deleteQuietly(new File(saveFolder, savename));
				}
			}
		}
		return cnt;
	}
	


}
