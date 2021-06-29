/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 03.  박찬      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 **/
package kr.or.anyapart.account.service;

import java.util.List;

import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.BankCodeVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.PagingVO;

public interface IAccountService {
	public List<AccountVO> accountList(PagingVO<AccountVO> paging);

	public int retrieveAccountCount(PagingVO<AccountVO> pagingVO);
	
	
	public List<CodeVO> codeList();
	
	public List<BankCodeVO> bankCodeList();

	public ServiceResult createAccount(AccountVO account)throws Exception;

	public AccountVO retriveAccount(AccountVO param) throws Exception;

	public ServiceResult modifyaccount(AccountVO accountVO);
}
