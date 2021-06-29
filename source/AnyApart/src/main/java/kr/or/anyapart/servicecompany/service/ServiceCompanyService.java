package kr.or.anyapart.servicecompany.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.servicecompany.vo.ServiceAttachVO;
import kr.or.anyapart.servicecompany.vo.ServiceVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.PagingVO;

public interface ServiceCompanyService {

	public int retrieveContractCount(PagingVO<ServiceVO> pagingVO);

	public List<ServiceVO> contractList(PagingVO<ServiceVO> pagingVO);

	public ServiceVO selectServiceView(ServiceVO param);

	public List<ServiceAttachVO> selectServiceFile(ServiceVO contrat);

	public int retrieveFileCount(ServiceVO param);

	public List<CodeVO> serviceCodeList();

	public ApartVO selectApart(ServiceVO serviceVo);

	public ServiceResult createContract(ServiceVO serviceVO) throws SQLException;

	public ServiceResult modifyContract(ServiceVO serviceVO);

	public int serviceDelete(ServiceVO serviceVO);

	public ServiceResult createMuitlpleContract(List<ServiceVO> contractList) throws SQLException;

}
