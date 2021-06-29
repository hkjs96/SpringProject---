package kr.or.anyapart.servicecompany.service;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.exception.FdlException;
import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.dao.IAttachDAO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.servicecompany.dao.AttachServiceDAO;
import kr.or.anyapart.servicecompany.dao.ServiceCompanyDAO;
import kr.or.anyapart.servicecompany.vo.ServiceAttachVO;
import kr.or.anyapart.servicecompany.vo.ServiceVO;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class ServiceCompanyServiceImpl implements ServiceCompanyService{

	@Inject
	private AttachContrat attService;
	
	@Inject 
	private ServiceCompanyDAO companyDAO;
	
	@Override
	public int retrieveContractCount(PagingVO<ServiceVO> pagingVO) {
		
		return companyDAO.retrieveContractCount(pagingVO);
	}

	@Override
	public List<ServiceVO> contractList(PagingVO<ServiceVO> pagingVO) {
		
		return companyDAO.seleteContractList(pagingVO);
	}


	@Override
	public ServiceVO selectServiceView(ServiceVO param) {
		
		
		return companyDAO.seleteServiceView(param);
	}

	@Override
	public List<ServiceAttachVO> selectServiceFile(ServiceVO contrat) {
		return companyDAO.seleteServiceFile(contrat);
	}

	@Override
	public int retrieveFileCount(ServiceVO pagingVO) {
		
		return companyDAO.retrieveFileCount(pagingVO);
	}

	@Override
	public List<CodeVO> serviceCodeList() {
		return companyDAO.serviceCodeList();
	}
	@Override
	public ApartVO selectApart(ServiceVO serviceVo) {

		return companyDAO.apart(serviceVo);
	}
	
	@Transactional
	@Override
	public ServiceResult createContract(ServiceVO serviceVO) throws SQLException {
		
		int cnt = companyDAO.insertContract(serviceVO);
		
		if(cnt >0) {
			cnt+= attService.processAttaches(serviceVO);
		}
		ServiceResult result = null;
		if (cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult modifyContract(ServiceVO serviceVO) {
		
		ServiceVO savedBoard = companyDAO.seleteServiceView(serviceVO);
		if (savedBoard == null)
			throw new RuntimeException(serviceVO.getSvcId() + "에 해당하는 글이 업음");
		serviceVO.getDelAttNos();
		ServiceResult result = ServiceResult.FAILED;
		int cnt = companyDAO.updateContract(serviceVO);
		if(cnt > 0) {
			// 신규 등록 첨부 파일
			int updataCnt = companyDAO.updateServicecontract(serviceVO);
			attService.processAttaches(serviceVO);
			attService.processDeleteAttatch(serviceVO);
			result = ServiceResult.OK;
		}
		else {
			result = ServiceResult.INVALIDPASSWORD;
		}
		
		return result;
	}

	@Override
	public int serviceDelete(ServiceVO serviceVO) {
		int cnt = companyDAO.serviceDelete(serviceVO);
		return cnt;
	}

	@Override
	public ServiceResult createMuitlpleContract(List<ServiceVO> contractList)throws SQLException {
		ServiceResult result = ServiceResult.FAILED;
		int listCnt = contractList.size();
		if(listCnt == 0) { // 파일의 데이터를 읽어들이지 못했을때
			return result;
		}
		int insertCnt = 0;
		
		for(ServiceVO serviceVO :contractList) {
			String startDate = serviceVO.getSvcStart();
			
			ServiceResult singleResult = createContract(serviceVO);
			
			
			if(singleResult == ServiceResult.OK) {
				insertCnt++;
			}else if(singleResult == ServiceResult.ALREADYEXIST ){// 
				result = singleResult;
				return result;
			}
		}
		if(listCnt == insertCnt) result = ServiceResult.OK;
		
		return result;
	}
}
