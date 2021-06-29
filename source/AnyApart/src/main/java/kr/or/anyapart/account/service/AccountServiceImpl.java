/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 03.  박찬      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 **/
package kr.or.anyapart.account.service;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kr.or.anyapart.account.dao.IAccountDAO;
import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.BankCodeVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class AccountServiceImpl implements IAccountService{
	@Inject
	private IAccountDAO accDAO;
	
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService idGen;
	
	@Override
	public List<AccountVO> accountList(PagingVO<AccountVO> paging) {
		return accDAO.seleteAccountList(paging);
	}


	@Override
	public int retrieveAccountCount(PagingVO<AccountVO> pagingVO) {
		return accDAO.retrieveAccountCount(pagingVO);
	}


	@Override
	public List<CodeVO> codeList() {
		return accDAO.commoncodeList();
	}


	@Override
	public List<BankCodeVO> bankCodeList() {
		return accDAO.bankCodeList();
	}

	@Transactional
	@Override
	public ServiceResult createAccount(AccountVO account) throws Exception {
		
		int cnt = accDAO.insertAccount(account);
		
		ServiceResult result = null;
		if(cnt >0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}


	@Override
	public AccountVO retriveAccount(AccountVO param) throws Exception {
	
		return accDAO.seleteAccount(param);
	}


	@Override
	public ServiceResult modifyaccount(AccountVO accountVO) {
		
		int cnt = accDAO.updateAccoutn(accountVO);
			
			ServiceResult result = null;
			if(cnt >0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
		}
		return result;
	}

	
}
