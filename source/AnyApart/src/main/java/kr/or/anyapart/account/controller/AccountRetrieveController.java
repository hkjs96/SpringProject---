/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 03.  박찬      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 **/
package kr.or.anyapart.account.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.account.service.IAccountService;
import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
@RequestMapping("/office/account")
public class AccountRetrieveController extends BaseController{
	@Inject
	private WebApplicationContext container;
	private ServletContext application;
	
	@Inject
	private IAccountService service;
	
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	@RequestMapping("accountList.do")
	public String list(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember,
			@RequestParam(value="page",required=false, defaultValue="1" )int currentPage
			,@ModelAttribute("searchVO") SearchVO searchVO, Model model) {
		
		setAptCode(authMember, searchVO);
		
		PagingVO<AccountVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		
		int totalRecord = service.retrieveAccountCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<AccountVO> accountList = service.accountList(pagingVO);
		pagingVO.setDataList(accountList);
		
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("paginationInfo", new CustomPaginationInfo<AccountVO>(pagingVO));

		
		return "account/accountList";
	}
}
