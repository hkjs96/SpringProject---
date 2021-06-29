package kr.or.anyapart.receipt.controller;

import java.lang.ProcessBuilder.Redirect;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.binding.BindingException;
import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.apart.service.IApartService;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.meter.service.IMeterCommService;
import kr.or.anyapart.receipt.service.ReceiptService;
import kr.or.anyapart.receipt.vo.ReceiptListVO;
import kr.or.anyapart.receipt.vo.ReceiptVO;
import kr.or.anyapart.setting.service.MemberService;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class ReceiptOfficeController extends BaseController{

	@Inject
	private ReceiptService receiptService;
	
	@Inject
	private IApartService apartService;

	@Inject
	private MemberService memberService;
	
	/**
	 * [수납관리-전체 통계]
	 * @author 이경륜
	 */
	@RequestMapping("/office/receipt/receiptChart.do")
	public String costChart() {
		return "receipt/receiptChart";
	}
	
	
	
	/*
	 * [수납관리-수납 조회] 리스트로 가기 전 기본 초기값설정
	 */
	@ModelAttribute("pagingVO")
	public PagingVO<ReceiptVO> pagingVO(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
	) {
		PagingVO<ReceiptVO> pagingVO = new PagingVO<>();
		
		// 검색 초기값 설정
		ReceiptVO receiptVO = new ReceiptVO();
//		Calendar cal = Calendar.getInstance();
//		if(cal.get(Calendar.DAY_OF_MONTH) < 5) { // 직전월 관리비 부과 전
//			cal.add(Calendar.MONTH,-2); // 전전월 관리비
//			receiptVO.setCostMonth(cal.get(Calendar.MONTH)+1);
//			
//		}else { // 직전월 관리비 부과 후
//			cal.add(Calendar.MONTH,-1); // 직전월 관리비
//			receiptVO.setCostMonth(cal.get(Calendar.MONTH)+1);
//		}
//		receiptVO.setCostYear(cal.get(Calendar.YEAR));
		
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchAptCode(authMember.getAptCode());
		
		pagingVO.setCurrentPage(1);
		
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(receiptVO);
		return pagingVO;
	}
	
	/**
	 * [수납관리-수납 조회]
	 */
	@RequestMapping("/office/receipt/paidReceiptList.do")
	public String paidReceiptList(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,@ModelAttribute("pagingVO") PagingVO<ReceiptVO> pagingVO
		, Model model
			) {
		try {
			int totalRecord = receiptService.retrievePaidReceiptCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<ReceiptVO> receiptList = receiptService.retrievePaidReceiptList(pagingVO);
			pagingVO.setDataList(receiptList);
			model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
			
		} catch (DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("수납내역 조회하다가 예외", e);
		}
		
		return "receipt/paidReceiptList";
	}
	
	@ModelAttribute("receiptSearchVO")
	public ReceiptVO receiptSearchVO(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
	) {
		ReceiptVO receiptSearchVO = new ReceiptVO();
		return receiptSearchVO;
	}
	
	/**
	 * [수납관리-미납 조회]
	 */
	@RequestMapping("/office/receipt/unpaidReceiptList.do")
	public String unpaidReceiptList(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,@ModelAttribute("receiptSearchVO") ReceiptVO receiptVO
		,Model model
	) {
		String aptCode = authMember.getAptCode();
		receiptVO.setAptCode(aptCode);
		
		ApartVO apartVO = apartService.retrieveApart(aptCode);
		model.addAttribute("apart", apartVO);

		List<CostVO> unpaidList = receiptService.retrieveUnpaidReceiptList(receiptVO);
		model.addAttribute("unpaidList", unpaidList);

		List<AccountVO> billAcctList = receiptService.retrieveBillingAccountList(receiptVO);
		model.addAttribute("billAcctList", billAcctList);
		
		return "receipt/unpaidReceiptList";
	}
	
	/**
	 * [수납관리-미납 조회] 미납내역 즉시수납처리
	 * 	=============예외처리필요함
	 * @author 이경륜
	 * @return
	 */
	@RequestMapping(value="/office/receipt/insertUnpaidReceipt.do", method=RequestMethod.POST)
	public String unpaidInsert(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,@ModelAttribute("member") MemberVO member
		,@Validated(InsertGroup.class) @ModelAttribute("receiptList") ReceiptListVO receiptList
		,BindingResult errors
		,Model model
		,RedirectAttributes rttr
		) {
		
		String goPage = "redirect:/office/receipt/unpaidReceiptList.do";
		
		if(!errors.hasErrors()) {
			// 0. 아이디, 비번 인증을 위해 셋팅
			member.setMemId(authMember.getMemId());
			
			// 1. 비밀번호 확인 
			ServiceResult pwResult = memberService.checkMemberPassword(member);
			if(pwResult == ServiceResult.OK) {
				// 2. 미납내역 여러건 수납처리
				try{
					ServiceResult result = receiptService.createUnpaidReceipt(receiptList.getReceiptList());
					
					if(result == ServiceResult.OK) {
//						model.addAttribute("result", result.name()); // 리다이렉트어트리뷰트에 메시지 담아줘야함
						rttr.addFlashAttribute("message", OK_MSG);
					}else {
						rttr.addFlashAttribute("message", INSERT_SERVER_ERROR_MSG); // 서버에서 실패함
					}
					
				}catch (DataAccessException | BindingException e) {
					rttr.addFlashAttribute("message", INSERT_SERVER_ERROR_MSG);
					LOGGER.error("미납 여러건 수납처리에서 오류남", e);
				}
			}else {
				rttr.addFlashAttribute("message", INVALID_PASSWORD_MSG);
			}
		}else {
			rttr.addFlashAttribute("message", INSERT_CLIENT_ERROR_MSG);
		}
		return goPage;
	}
}
