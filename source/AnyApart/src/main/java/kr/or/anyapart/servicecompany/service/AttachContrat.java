package kr.or.anyapart.servicecompany.service;

import kr.or.anyapart.servicecompany.vo.ServiceAttachVO;
import kr.or.anyapart.servicecompany.vo.ServiceVO;

public interface AttachContrat {

	int processAttaches(ServiceVO contrat);
	public ServiceAttachVO download(ServiceAttachVO param);
	int processDeleteAttatch(ServiceVO contrat);
}
