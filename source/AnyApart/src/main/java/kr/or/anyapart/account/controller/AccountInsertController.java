/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 03.  박찬      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 **/
package kr.or.anyapart.account.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springmodules.validation.commons.DefaultBeanValidator;

import kr.or.anyapart.account.service.IAccountService;
import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.BankCodeVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class AccountInsertController extends BaseController {
	@Inject
	private IAccountService service;
	
	@Resource
	protected DefaultBeanValidator beanValidator;
	/**
	 * 카드등록 폼 이동
	 * @param model
	 * @return
	 * @author 박찬
	 */
	@RequestMapping(value = "/office/account/accountForm.do",method= RequestMethod.GET)
	public String form(Model model) {
		
		List<CodeVO> codeList = service.codeList();
		List<BankCodeVO> bankCodeList = service.bankCodeList();
	
		model.addAttribute("codeList",codeList);
		model.addAttribute("bankCodeList",bankCodeList);
		
		return "account/accountForm";
	}
	/**
	 * 계좌번호 등록 계좌번호 아이디는 아파트코드를 포함하여 등록한다.
	 * @param authMember
	 * @param model
	 * @param accountVO
	 * @param errors
	 * @return
	 * @throws Exception
	 * @author 박찬
	 */
	@RequestMapping(value = "/office/account/accountForm.do",method= RequestMethod.POST)
	public String accountInsert(
			@Validated(InsertGroup.class)
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,Model model ,AccountVO accountVO ,BindingResult errors) throws Exception {
		
		String goPage = null;
		NotyMessageVO message = null;
		String aptCode = authMember.getMemId().substring(0, 5);
		accountVO.setApartType(aptCode);
		
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = service.createAccount(accountVO);
				if(result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}
				goPage = "redirect:accountList.do";
			}catch (DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "accountForm";
			}
		}else {
			message = INSERT_CLIENT_ERROR_MSG;
			goPage = "accountForm";
		}
		if(message!=null) model.addAttribute("message", message);
		return goPage;
			
	}
	/**
	 * 체크버튼을 클릭하여 수정할 항목을 선택하여 수정한다. 
	 * @param model
	 * @param param
	 * @param errors
	 * @return
	 * @throws Exception
	 * @author 박찬
	 */
	@RequestMapping(value="/office/account/accountUpdate.do",method=RequestMethod.GET)
	public String accountUpdateForm(Model model, AccountVO param,BindingResult errors) throws Exception {
		System.out.println(param);
		AccountVO account = service.retriveAccount(param);
		List<CodeVO> codeList = service.codeList();
		List<BankCodeVO> bankCodeList = service.bankCodeList();
		System.out.println(account);
		
		model.addAttribute("codeList",codeList);
		model.addAttribute("bankCodeList",bankCodeList);
		model.addAttribute("accountVO",account);
		
		
		return "account/accountForm";
	}
	
	/**
	 * 체크버튼을 클릭한 카드를 수정
	 * @param model
	 * @param accountVO
	 * @param errors
	 * @return
	 * @throws Exception
	 * @author 박찬
	 */
	@RequestMapping(value="/office/account/accountUpdate.do",method=RequestMethod.POST)
	public String accountUpdate(Model model ,AccountVO accountVO ,BindingResult errors)throws Exception {
		String goPage = null;
		beanValidator.validate(accountVO, errors);
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyaccount(accountVO);
			switch (result) {
			case OK:
				goPage = "redirect:accountList.do";
				break;

			default:
				goPage = "/office/account/accountUpdate.do?acctId="+accountVO.getAcctId();
				break;
			}
		}else {
			goPage = "/office/account/accountUpdate.do?acctId="+accountVO.getAcctId();
		}
		return goPage;
	}
	
	
}
