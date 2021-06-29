package kr.or.anyapart.servicecompany.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.servicecompany.vo.ServiceAttachVO;
import kr.or.anyapart.servicecompany.vo.ServiceVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface ServiceCompanyDAO {

	public int retrieveContractCount(PagingVO<ServiceVO> pagingVO);

	public List<ServiceVO> seleteContractList(PagingVO<ServiceVO> pagingVO);

	public ServiceVO seleteServiceView(ServiceVO param);

	public List<ServiceAttachVO> seleteServiceFile(ServiceVO contrat);

	public int retrieveFileCount(ServiceVO pagingVO);

	public List<CodeVO> serviceCodeList();

	public ApartVO apart(ServiceVO serviceVo);

	public int insertContract(ServiceVO serviceVO);

	public int updateContract(ServiceVO serviceVO);

	public int serviceDelete(ServiceVO serviceVO);

	public int updateServicecontract(ServiceVO serviceVO);

}
