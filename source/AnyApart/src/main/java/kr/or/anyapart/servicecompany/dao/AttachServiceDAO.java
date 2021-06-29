package kr.or.anyapart.servicecompany.dao;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.servicecompany.vo.ServiceAttachVO;
import kr.or.anyapart.servicecompany.vo.ServiceVO;

@Repository
public interface AttachServiceDAO {

	public int deleteAttatches(ServiceVO contrat);
	public ServiceAttachVO selectAttach(ServiceAttachVO attachVO);
	public int insertAttaches(ServiceVO contrat);
}
