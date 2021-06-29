/**
 * @author 이경륜
 * @since 2021. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                     수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2.  22.  이경륜		 최초작성
 * 2021. 3.  5.  이경륜		 모델어트리뷰트 페이징vo합치고 if문으로 분기함
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.maintenancecost.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.Resource;
import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.commonsweb.controller.ExcelDownloadViewWithJxls;
import kr.or.anyapart.maintenancecost.service.CostOfficeService;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.resident.service.ResidentService;
import kr.or.anyapart.setting.service.MemberService;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class CostOfficeController extends BaseController {
	
	@Inject
	private WebApplicationContext container;
	
	@Inject
	private CostOfficeService costService;
	
	@Inject
	private ResidentService residentService;
	
	@Inject
	private MemberService memberService;
	
	/**
	 * 부과처리, 세대별조회 기본 검색값
	 */
	@ModelAttribute("pagingVO")
	public PagingVO<CostVO> pagingVO(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,HttpServletRequest request
	) {
		String requestURI = request.getRequestURI();			// /AnyApart/office/cost/...
		
		PagingVO<CostVO> pagingVO = new PagingVO<>();
		
		/*
		 * 1월사용분인 2월달 관리비 부과한다고 가정
		 */
		CostVO costVO = new CostVO();
		costVO.setAptCode(authMember.getAptCode());
		Calendar cal = Calendar.getInstance();
//		 당월검침량 등록 기준: COMMONMETER 테이블에 등록되었는지 확인 
		
		if(cal.get(Calendar.DAY_OF_MONTH) >= 5) { // 관리비 부과일 이후
			cal.add(Calendar.MONTH,-1);
			costVO.setCostMonth(cal.get(Calendar.MONTH)+1);
			costVO.setCostYear(cal.get(Calendar.YEAR));

			MeterCommVO commMeter = costService.retrieveCommMeter(costVO);
			if(requestURI.contains("costIndvList")) {
				// 세대별조회인경우
				if(commMeter == null || "N".equals(commMeter.getCommFlag())) {
					// 부과처리 안됨
					cal.add(Calendar.MONTH,-1); // 한번더 전달로
					costVO.setCostMonth(cal.get(Calendar.MONTH)+1);
					costVO.setCostYear(cal.get(Calendar.YEAR));
				}else {
					// 부과처리 됨
					// 그대로
				}
				
			}else {
				// 부과처리리스트, 부과처리 insert 인경우
				if(commMeter == null) {
					// 공동검침량 등록전
					cal.add(Calendar.MONTH,-1); // 한번더 전달로
					costVO.setCostMonth(cal.get(Calendar.MONTH)+1);
					costVO.setCostYear(cal.get(Calendar.YEAR));
				}else if ("N".equals(commMeter.getCommFlag())) {
					// 공동검침량 등록후 부과전
					// 그대로 
				}else if ("Y".equals(commMeter.getCommFlag())) {
					// 공동검침량 등록후 부과처리됨
					// 그대로
				}
			}
			
			
			
			
			
			
		}else { // 부과날짜 이전 					당월 검침량 등록 전
			cal.add(Calendar.MONTH,-2); // 그 전달 검침량 기준 관리비
			costVO.setCostMonth(cal.get(Calendar.MONTH)+1);
			costVO.setCostYear(cal.get(Calendar.YEAR));
		}
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchAptCode(authMember.getAptCode());
		
		pagingVO.setCurrentPage(1);
		
		pagingVO.setSearchVO(searchVO);
		pagingVO.setSearchDetail(costVO);
		return pagingVO;
	}
	
	/**
	 * [부과관리-부과 처리] 부과기준표 모달
	 * @return
	 */
	@RequestMapping(value="/office/cost/costStandardView.do")
	public String costStandardView() {
		return "office/cost/ajax/costStandardViewModal";
	}
	
	/**
	 * [부과관리-부과 처리]
	 * @author 이경륜
	 */
	@RequestMapping("/office/cost/costStandard.do")
	public String standard(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("pagingVO") PagingVO<CostVO> pagingVO
			,Model model
			) {
		/*
		 * 기준: 1월달 관리비 (12월 사용금액) - db에서 1월관리비없애야함
		 * 공통으로 필요: 총 주거면적과 현재 입주된 면적
		 * 경우의수 : 1. 매달 5일 전에는 전달 관리비 부과내역이 보임 - 부과처리 버튼이 부과완료로 보임
		 * 		   2. 5일 이후에는 당월관리비 부과 예상 내역이 보임 - 부과처리 버튼 누르면 insert
		 */
		
		CostVO costVO = pagingVO.getSearchDetail();
		
		try {
			/*
			 * 0. 입주세대
			 * - 입주 세대 수 / 총 세대수
			 * - 입주면적 / 총 주거면적
			 */
			HouseVO house = costService.retrieveHouseInfoForCost(costVO);
			model.addAttribute("house", house);
			costVO.setAptHeat(house.getAptHeat());
			costVO.setMoveinHouseArea(house.getMoveinHouseArea());
			
			/*
			 * 1. 공용관리비 - List<CostVO>
			 * 1-1. 발생금액
			 * - 일반관리비 (1월 재직중인 인원 총 급여)
			 * - 경비비 (1월에 계약된 경비업체 계약금)
			 * - 청소비 (1월에 계약된 청소업체 계약금)
			 * - 소독비 (1월에 계약된 소독업체 계약금)
			 * - 승강기유지비 (jsp의 frMap에서 따로 꺼내오기)
			 * 
			 * 1-2. m2당 부과금액
			 */
			List<CostVO> costCommList = costService.retrieveCostCommList(costVO);
			model.addAttribute("costCommList",costCommList);
			
			/*
			 * 2. 공동검침량 List<MeterCommVO>
			 * 2-1. 검침량: 2021년 1월 COMMONMETER 검침량
			 * 2-2. 총 발생금액: 계산 로직
			 * 2-3. m2당 부과금액
			 */
			MeterCommVO commMeter = costService.retrieveCommMeterCost(costVO);
			model.addAttribute("commMeter", commMeter);
			
			/*
			 * 3. 세대별 요금 List<CostVO> 혹은 Cost+Meter 합친 VO 필요 -> pagingVO에 담겨야함
			 */
			int totalCnt = costService.retrieveCostListCountByHouse(pagingVO);
			pagingVO.setTotalRecord(totalCnt);
			List<CostVO> costList = costService.retrieveCostListByHouse(pagingVO);
			pagingVO.setDataList(costList);
			model.addAttribute("paginationInfo", new CustomPaginationInfo<CostVO>(pagingVO));
		} catch (DataAccessException e) {
			// 에러페이지로 보내야함
			LOGGER.error("부과처리시 세대별 관리비 조회에서 오류남", e);
		}	
		/* 4. 부과처리
		 * - 부과처리 하기 위해서는 예상발생금액 담은 List(3번에서 구한거)가  세션이든 어디든 있어야함. 그거 insert
		 * - or List는 조회용으로 보여주고 insert칠때 다시 계산하여 insert
		 */
		return "cost/costStandard";
	}

	/**
	 * 부과처리
	 * - 관리자 비밀번호 인증후 서비스에서 계산하여 insert
	 * @author 이경륜
	 */
	@RequestMapping(value="/office/cost/costInsert.do", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String insertCost(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,@ModelAttribute("pagingVO") PagingVO<CostVO> pagingVO
		,@ModelAttribute("member") MemberVO member
		,Model model
	) {
		// 1. 비밀번호 확인 
		ServiceResult pwResult = memberService.checkMemberPassword(member);
		if(pwResult == ServiceResult.OK) {
			// 2. 미납
			try{
				int cnt = costService.createMonthlyCost(pagingVO);
				model.addAttribute("result", ServiceResult.OK.name());
				model.addAttribute("message", OK_MSG);
			}catch (DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				LOGGER.error("부과 처리하다가 오류남", e);
			}
		}else {
			model.addAttribute("message", INVALID_PASSWORD_MSG);
		}
		
		return "jsonView";
	}
	
	
	
	/**
	 * [부과관리-세대별 조회] 리스트 조회
	 * @author 이경륜
	 */
	@RequestMapping("/office/cost/costIndvList.do")
	public String costIndvList(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,@ModelAttribute("pagingVO") PagingVO<CostVO> pagingVO
		, Model model
	) {
		// aptCode는 컨트롤러에서 hidden으로 담아옴
		
		// 연,월 검색조건 초기값 맨 위 메서드에서 셋팅
		HouseVO house = HouseVO.builder().aptCode(getAptCode(authMember)).build();
		try {
			List<HouseVO> dongList = residentService.retrieveDongList(house);
			List<HouseVO> hoList = residentService.retrieveHoList(house);
			pagingVO.getSearchDetail().setDongList(dongList);
			pagingVO.getSearchDetail().setHoList(hoList);
			
			int totalRecord = costService.retrieveCostCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<CostVO> costList = costService.retrieveCostList(pagingVO);
			pagingVO.setDataList(costList);
			model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
			
		} catch (DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("관리비 세대별 조회하다가 예외", e);
		}
		
		return "cost/costIndvList";
	}
	
	
	
	/**
	 * [부과관리-세대별 조회] 당월 관리비 간단내역 다운로드
	 * @author 이경륜
	 */	
	@RequestMapping(value="/office/cost/costIndvList/downloadExcel.do")
	public ExcelDownloadViewWithJxls excelJXLSForCostIndvList(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("pagingVO") PagingVO<CostVO> pagingVO
			,Model model) {
		costIndvList(authMember, pagingVO, model);
		
		model.addAttribute("pagingVO", pagingVO);

		int costYear = pagingVO.getSearchDetail().getCostYear();
		int costMonth = pagingVO.getSearchDetail().getCostMonth();
		
		return new ExcelDownloadViewWithJxls() {
			@Override
			public String getDownloadFileName() {
				return "세대별 "+costYear+"년 "+costMonth+"월 관리비 내역.xlsx";
			}
			
			@Override
			public Resource getJxlsTemplate() throws IOException {
				return container.getResource("/WEB-INF/jxlstmpl/costTemplate.xlsx");
			}
		};
	}
	

}
