/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 03.  박찬      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 **/
package kr.or.anyapart.account.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.vo.BankCodeVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IAccountDAO {

	public List<AccountVO> seleteAccountList (PagingVO<AccountVO> paging);
	
	public int retrieveAccountCount(PagingVO<AccountVO> paging);
	
	public List<BankCodeVO> bankCodeList();
	
	public List<CodeVO> commoncodeList();

	public int insertAccount(AccountVO account);

	public AccountVO seleteAccount(AccountVO param);

	public int updateAccoutn(AccountVO accountVO);
}
