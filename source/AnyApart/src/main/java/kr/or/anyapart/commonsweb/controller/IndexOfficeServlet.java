package kr.or.anyapart.commonsweb.controller;

import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.board.officeqna.service.IOfficeQnaService;
import kr.or.anyapart.board.vendornotice.service.VendorNoticeService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.maintenancecost.service.CostOfficeService;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.service.ResidentService;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller("officeIndex")
public class IndexOfficeServlet extends BaseController{

	@Inject
	private ResidentService residentService;
	
	@Inject
	private VendorNoticeService vendorNoticeService;
	
	@Inject
	private IOfficeQnaService officeQnaService;
	
	@Inject
	private CostOfficeService costOfficeService;
	/**
	 * 대시보드
	 * @param authMember
	 * @param model
	 * @return
	 * @author 이경륜
	 */
	@RequestMapping("/office")
	public String goVendor(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,Model model
	) {
		
		NotyMessageVO message = null;
		
		/*
		 * 벤더공지사항 및 관리사무소 문의글
		 */
		PagingVO<BoardVO> pagingVO = new PagingVO<>();
		pagingVO.setTotalRecord(5);
		pagingVO.setCurrentPage(1);
		List<BoardVO> vendorNoticeList = vendorNoticeService.retrieveBoardList(pagingVO);
		model.addAttribute("vendorNoticeList",vendorNoticeList);
		
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchAptCode(authMember.getAptCode());
		pagingVO.setSearchVO(searchVO);
		
		List<BoardVO> officeQnaList = officeQnaService.retrieveWaitingQnaList(pagingVO);
		model.addAttribute("officeQnaList", officeQnaList);
		
		/*
		 * 입주세대수
		 */
		CostVO cost = new CostVO();
		cost.setAptCode(authMember.getAptCode());
		HouseVO house = costOfficeService.retrieveHouseInfoForCost(cost);
		model.addAttribute("house",house);
		/*
		 * 면적별 입주세대수
		 */
		List<HouseVO> houseInfoList = residentService.retrieveHouseInfoBySpace(cost);
		model.addAttribute("houseInfoList",houseInfoList);
		
		/*
		 * 전입전출  최근 6개월치 추이
		 */
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String endDate = sdf.format(cal.getTime()); // 최근
		cal.add(Calendar.MONTH,-5); // 6개월치
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String startDate = sdf.format(cal.getTime()); // 과거
		
		ResidentVO residentVO = ResidentVO.builder()
									.aptCode(authMember.getAptCode())
									.resMoveinStart(startDate)
									.resMoveoutStart(startDate)
									.resMoveinEnd(endDate)
									.resMoveoutEnd(endDate)
									.build();
		
		try {
			List<ResidentVO> moveinList = residentService.retrieveMoveinCntMonthly(residentVO);
			model.addAttribute("moveinList",moveinList);
			List<ResidentVO> moveoutList = residentService.retrieveMoveoutCntMonthly(residentVO);
			model.addAttribute("moveoutList",moveoutList);
		}catch (DataAccessException e) {
			message = SELECT_SERVER_ERROR_MSG;
			LOGGER.error("대시보드에서 조회하다가 오류남", e);
		}
		
		/*
		 *	관리비 최근 1년치 추이
		 */
		
		Calendar cal2 = Calendar.getInstance();
		cal2.add(Calendar.MONTH, 1); // 2021-04-01
		cal2.set(Calendar.DAY_OF_MONTH, 1);
		String endDateForCost = sdf.format(cal2.getTime());
		
		cal2.add(Calendar.MONTH, -2); // 2021-02-01
		cal2.set(Calendar.DAY_OF_MONTH, 1);
		String endDateForConnect = sdf.format(cal2.getTime()); // 최근
		
		cal2.add(Calendar.MONTH,-11);//1년치
		cal2.set(Calendar.DAY_OF_MONTH, 1); //2020-03-01
		String startDateForCost = sdf.format(cal2.getTime());
		
		CostVO costVO = new CostVO();
		costVO.setCostDuedateEndConnect(endDateForConnect);
		costVO.setCostDuedateStart(startDateForCost); // connect절에도 쓰일 것
		costVO.setCostDuedateEnd(endDateForCost);
		costVO.setAptCode(authMember.getAptCode());
		
		List<CostVO> costMonthlyList = costOfficeService.retrieveCostListYearly(costVO);
		model.addAttribute("costMonthlyList", costMonthlyList);
		
		if(message!=null) model.addAttribute("message", message);
		return "indexO";
		
		
	}
}
