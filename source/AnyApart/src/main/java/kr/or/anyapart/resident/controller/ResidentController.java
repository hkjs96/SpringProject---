/**
 * @author 이경륜
 * @since 2021. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                     수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 27.   이경륜            최초작성
 * 2021. 2.  6.   이경륜		 입주민 등록
 * 2021. 2.  8.   이경륜		 입주민 수정, list에서 aptCode직접받기
 * 2021. 2.  11.  이경륜		 전출관리 작업 (리스트 조회)
 * 2021. 2.  13.  이경륜		 전출자 상세보기 구현
 * 2021. 2.  19.  이경륜		 전출등록폼에서 관리비미납내역 screenSize수정
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.resident.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.jxls.reader.ReaderBuilder;
import org.jxls.reader.XLSReader;
import org.springframework.core.io.Resource;
import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.xml.sax.SAXException;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.car.service.CarService;
import kr.or.anyapart.car.vo.CarVO;
import kr.or.anyapart.commons.enumpkg.Browser;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.commonsweb.controller.ExcelDownloadViewWithJxls;
import kr.or.anyapart.maintenancecost.service.CostOfficeService;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.receipt.service.ReceiptService;
import kr.or.anyapart.receipt.vo.ReceiptVO;
import kr.or.anyapart.resident.service.ResidentService;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.servicecompany.vo.ServiceAttachVO;
import kr.or.anyapart.setting.service.MemberService;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class ResidentController extends BaseController {
	
	@Inject
	private ResidentService residentService;

	@Inject
	private ReceiptService receiptService;
	
	@Inject
	private CostOfficeService costService;
	
	@Inject
	private CarService carService;
	
	@Inject
	private MemberService memberService;
	
	@Inject
	private WebApplicationContext container;
	
	@ModelAttribute("resident")
	public ResidentVO resident() {
		return new ResidentVO();
	}
	/**
	 * [입주민관리-입주관리] 전체입주민 리스트 조회 화면
	 * @author 이경륜
	 */
	@RequestMapping("/office/resident/moveinList.do")  // movein으로 바꿔야겠음
	public String moveinList(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("resident") ResidentVO resident
			,@RequestParam(value="dong", required=false, defaultValue="0000") String dong
			,Model model
	) {
		HouseVO house = HouseVO.builder().aptCode(getAptCode(authMember)).dong(dong).build();
		try {
			List<HouseVO> dongList = residentService.retrieveDongList(house);
			List<HouseVO> hoList = residentService.retrieveHoList(house);
			model.addAttribute("dongList", dongList);
			model.addAttribute("hoList", hoList);
		} catch (DataAccessException e) {
			LOGGER.error("", e);
		}
		
		return "resident/moveinList";
	}
	
	/**
	 * [입주민관리-입주관리] 전체입주민 리스트 조회
	 * @author 이경륜
	 */							 // moveinList로 변경
	@RequestMapping(value="/office/resident/moveinListAjax.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String moveinListAjax(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("pagingVO") PagingVO<ResidentVO> pagingVO
			,@ModelAttribute("resident") ResidentVO resident
			,Model model
	) {
		pagingVO.setSearchDetail(resident);
		
		// 이거땜에 미입주 세대가 안나옴
//		if(StringUtils.isBlank(resident.getResMoveinStart())) resident.setResMoveinStart("1900-01-01");
//		if(StringUtils.isBlank(resident.getResMoveinEnd())) resident.setResMoveinEnd("2999-12-31");
		
		int totalRecord;
		try {
			totalRecord = residentService.retrieveResidentCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<ResidentVO> residentList = residentService.retrieveResidentList(pagingVO);
			pagingVO.setDataList(residentList);
		} catch (DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("전체조회", e);
		}
		
		model.addAttribute("pagingVO",pagingVO);
		return "jsonView";
	}
	
	/**
	 * [입주민관리-입주관리] 입주 등록
	 * @author 이경륜
	 */	
	@RequestMapping(value="/office/resident/moveinInsert.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
	public String moveinInsert(
		@Validated(InsertGroup.class) @ModelAttribute("resident") ResidentVO resident
		,Errors errors
		,Model model
	) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = residentService.createResident(resident);
				model.addAttribute("result",result);
				if(result == ServiceResult.FAILED) {
					message = INSERT_SERVER_ERROR_MSG;
				}else { // result == ALREADYEXISTS
					message = getCustomNoty("이미 입주한 세대입니다.");
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				LOGGER.error("", e);
			}
		}else {
			message = INSERT_CLIENT_ERROR_MSG;
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	
	/**
	 * [입주민관리-입주관리] 입주민 정보 수정
	 * @author 이경륜
	 */	
	@RequestMapping(value="/office/resident/moveinUpdate.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
	public String moveinUpdate(
			@Validated(UpdateGroup.class) @ModelAttribute("resident") ResidentVO resident
			,Errors errors
			,Model model
	) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			try {
				ServiceResult result = residentService.modifyResident(resident);
				model.addAttribute("result",result);
				if(result == ServiceResult.FAILED) {
					message = UPDATE_SERVER_ERROR_MSG;
				}
			} catch (DataAccessException e) {
				model.addAttribute("message", UPDATE_SERVER_ERROR_MSG);
				LOGGER.error("", e);
			}
		}else {
			message = UPDATE_CLIENT_ERROR_MSG;
		}
		if(message!=null) model.addAttribute("message", message);
		return "jsonView";
	}
	
	
	
	
	
	/**
	 * [입주민관리-입주관리] 입주민 정보 엑셀 다운로드
	 * @author 이경륜
	 */	
	@RequestMapping(value="/office/resident/movein/downloadExcel.do")
	public ExcelDownloadViewWithJxls excelJXLSForMoveIn(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("pagingVO") PagingVO<ResidentVO> pagingVO
			,@ModelAttribute("resident") ResidentVO resident
			,Model model) {
		
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchAptCode(getAptCode(authMember));
		pagingVO.setSearchVO(searchVO);
		moveinListAjax(authMember, pagingVO, resident, model);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return new ExcelDownloadViewWithJxls() {
			@Override
			public String getDownloadFileName() {
				return "입주민 정보.xlsx";
			}
			
			@Override
			public Resource getJxlsTemplate() throws IOException {
				return container.getResource("/WEB-INF/jxlstmpl/moveinTemplate.xlsx");
			}
		};
	}
	/**
	 * [입주민관리-입주관리] 입주민 정보 엑셀 일괄 등록 양식 다운로드
	 * @author 이경륜
	 */	
	@RequestMapping("/office/resident/movein/downloadTmpl.do")
	public String downloadTmpl(
			@ModelAttribute ServiceAttachVO param
			, @RequestHeader(value="User-Agent", required=false) String agent
			, Model model
		){
			Browser browser = Browser.getBrowserConstant(agent);
			AttachVO attach = new AttachVO();
			attach.setAttFilename("입주민일괄등록양식.xlsx");
			attach.setAttSavename("moveinSample.xlsx");
			model.addAttribute("attach", attach);
			return "excelTmplDownloadView";
		}
	
	/**
	 * [입주민관리-입주관리] 입주민 정보 엑셀 일괄 등록
	 * @author 이경륜
	 */	
	@RequestMapping(value="/office/resident/movein/uploadExcel.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
	public String uploadJXLS(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@RequestPart("excelFile") MultipartFile excelFile
			,Model model) {
			
			NotyMessageVO message = INSERT_SERVER_ERROR_MSG;
			ServiceResult result = ServiceResult.FAILED;
			
			List<ResidentVO> residentList = new ArrayList<>();
			Resource tmpl = container.getResource("classpath:kr/or/anyapart/jxlstmpl/moveinList.xml");
			
			try (
					InputStream is = new BufferedInputStream(tmpl.getInputStream())
			) {
				
					XLSReader reader = ReaderBuilder.buildFromXML(is);
					
					Map<String, Object> beans = new HashMap<>();
					beans.put("residentList", residentList);
					
					try {
						InputStream excelStream = excelFile.getInputStream();
						reader.read(excelStream, beans);
						
						// houseCode 생성하기 위해 aptCode 미리 셋팅
						residentList.forEach( resident -> resident.setAptCode(getAptCode(authMember)));
						
						result = residentService.createMuitlpleResident(residentList);
						
					} catch (InvalidFormatException e) {
						LOGGER.error("", e);
					}
				
			} catch (SAXException | IOException e) {
				LOGGER.error("", e);
			}
			
			switch (result) {
			case OK:
				message = null;
				break;
			case ALREADYEXIST:
				message = getCustomNoty("이미 입주한 세대를 포함한 파일입니다.");
				break;
			case FAILED:
				message = getCustomNoty("엑셀 업로드 양식에 맞지 않습니다.");
				break;
			}
		if(message != null) model.addAttribute("message", message);
		
		return "jsonView";
		
	}
	
	// ======================================== 전출
	
	/**
	 * [입주민관리-전출관리] 전체 전출자 리스트 조회 화면
	 * @return 리스트 화면
	 * @author 이경륜
	 */
	
	@RequestMapping("/office/resident/moveoutList.do")
	public String moveoutList(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("resident") ResidentVO resident
			,@RequestParam(value="dong", required=false, defaultValue="0000") String dong
			,Model model
	) {
		HouseVO house = HouseVO.builder().aptCode(getAptCode(authMember)).dong(dong).build();
		try {
			List<HouseVO> dongList = residentService.retrieveDongList(house);
			List<HouseVO> hoList = residentService.retrieveHoList(house);
			model.addAttribute("dongList", dongList);
			model.addAttribute("hoList", hoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "resident/moveoutList";
	}
	
	
	/**
	 * [입주민관리-전출관리] 전체입주민 리스트 조회
	 * @author 이경륜
	 */
	@RequestMapping(value="/office/resident/moveoutListAjax.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String moveoutListAjax(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("pagingVO") PagingVO<ResidentVO> pagingVO
			,@ModelAttribute("resident") ResidentVO resident
			,Model model
	) {
		pagingVO.setSearchDetail(resident);
		
		if(StringUtils.isBlank(resident.getResMoveoutStart())) resident.setResMoveoutStart("1900-01-01");
		if(StringUtils.isBlank(resident.getResMoveoutEnd())) resident.setResMoveoutEnd("2999-12-31");
		
		int totalRecord;
		try {
			totalRecord = residentService.retrieveMoveoutResidentCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<ResidentVO> residentList = residentService.retrieveMoveoutResidentList(pagingVO);
			pagingVO.setDataList(residentList);
		} catch (DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("전체조회", e);
		}
		
		model.addAttribute("pagingVO",pagingVO);
		return "jsonView";
	}
	
	/**
	 * [입주민관리-입주관리] 입주민 정보 엑셀 다운로드
	 * @author 이경륜
	 */	
	@RequestMapping(value="/office/resident/moveout/downloadExcel.do")
	public ExcelDownloadViewWithJxls excelJXLSForMoveOut(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("pagingVO") PagingVO<ResidentVO> pagingVO
			,@ModelAttribute("resident") ResidentVO resident
			,Model model) {
		
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchAptCode(getAptCode(authMember));
		pagingVO.setSearchVO(searchVO);
		moveoutListAjax(authMember, pagingVO, resident, model);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return new ExcelDownloadViewWithJxls() {
			@Override
			public String getDownloadFileName() {
				return "전출자 정보.xlsx";
			}
			
			@Override
			public Resource getJxlsTemplate() throws IOException {
				return container.getResource("/WEB-INF/jxlstmpl/moveoutTemplate.xlsx");
			}
		};
	}
	
	
	/**
	 * [입주민관리-전출관리] 전출자 정보 상세보기
	 * @param ResidentVO
	 * @return
	 */
	@RequestMapping(value="/office/resident/moveoutView.do")
	public String moveoutView(
			ResidentVO resident
			, Model model
	) {
		ResidentVO result = null;
		try {
			result = residentService.retrieveMoveoutResident(resident);
		} catch (DataAccessException e ) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
			LOGGER.error("전출자 상세조회 에러", e);
		} catch (NullPointerException e) {
			model.addAttribute("message", getCustomNoty("해당하는 정보가 없습니다."));
			LOGGER.error("전출자 상세조회 에러", e);
		}
		model.addAttribute("resident", result);
		return "office/resident/ajax/moveoutViewModal";
	}
	
	/**
	 * [입주민관리-전출관리] 전출자 정보 상세보기에서 수납내역 받아오기
	 * @param ResidentVO
	 * @return
	 */
	@RequestMapping(value="/office/resident/moveoutViewReceipt.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String moveoutView(
			ReceiptVO receipt
			, PagingVO<ReceiptVO> pagingVO
			, Model model
			
	) {		
			pagingVO.setScreenSize(5);
			pagingVO.setSearchDetail(receipt);
	
			int totalRecord;
			try {
				totalRecord = receiptService.retrieveMoveoutReceiptCount(pagingVO);
				pagingVO.setTotalRecord(totalRecord);
				
				List<ReceiptVO> receiptList = receiptService.retrieveMoveoutReceiptList(pagingVO);
				pagingVO.setDataList(receiptList);
			} catch (DataAccessException e) {
				model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
				LOGGER.error("전출자 수납내역 전체조회", e);
			}
			
			model.addAttribute("pagingVO",pagingVO);
			return "jsonView";
	}
	
	/**
	 * [입주민관리-전출관리] 전출 등록화면 으로 이동
	 * @author 이경륜
	 * @return
	 */
	@RequestMapping("/office/resident/moveoutForm.do")
	public String moveoutForm() {
		return "resident/moveoutForm";
	}

	/**
	 * [입주민관리-전출관리] 전출자 조회하여 비동기로 뿌려주기
	 * 	=============예외처리 정리필요함
	 * @author 이경륜
	 * @return
	 */
	@RequestMapping(value="/office/resident/moveoutFormAjax.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String moveoutFormAjax(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("pagingVO") PagingVO<CostVO> pagingVO
			,@ModelAttribute("cost") CostVO cost
			,Model model
	) {
		pagingVO.setSearchDetail(cost);
		pagingVO.setScreenSize(5);
		ResidentVO residentParam = ResidentVO.builder().houseCode(cost.getHouseCode()).build();
		ResidentVO residentResult = residentService.retrieveResidentByHouseCode(residentParam);
		
		if(residentResult != null) {
			model.addAttribute("resident", residentResult);
			
			cost.setMemId(residentResult.getMemId());
			
			int totalRecord;
			List<CarVO> carList = null;
			try {
				totalRecord = costService.retrieveUnpaidCostCount(pagingVO);
				pagingVO.setTotalRecord(totalRecord);
				
				List<CostVO> costList = costService.retrieveUnpaidCostList(pagingVO);
				pagingVO.setDataList(costList);
				
				carList = carService.retrieveCarListByMemId(residentResult); //입주민등록차량
				model.addAttribute("carList",carList);
				
				model.addAttribute("pagingVO",pagingVO);
				
			} catch (DataAccessException e) {
				model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
				LOGGER.error("전출 등록위해 세대 불러오기에서 오류남", e);
			} catch (NullPointerException e) {
				model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
				LOGGER.error("전출 등록위해 세대 불러오기에서 오류남", e);
			}
		}else {
			model.addAttribute("message", getCustomNoty("해당하는 정보가 없습니다."));
		}
		
		
		return "jsonView";
	}
	
	/**
	 * [입주민관리-전출관리] 미납내역 즉시수납처리
	 * 	=============예외처리필요함
	 * @author 이경륜
	 * @return
	 */
	@RequestMapping(value="/office/resident/moveoutPayCost.do", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String moveoutPayCost(
		@AuthenticationPrincipal(expression="realMember") MemberVO authMember
		,@ModelAttribute("cost") CostVO cost
		,@ModelAttribute("member") MemberVO member
		,Model model
		) {
		
		// 0. 아이디, 비번 인증을 위해 셋팅
		member.setMemId(authMember.getMemId());
		
		// 1. 비밀번호 확인 
		ServiceResult pwResult = memberService.checkMemberPassword(member);
		if(pwResult == ServiceResult.OK) {
			// 2. 미납
			try{
				ServiceResult result = receiptService.createUnpaidCostForMoveout(cost);
				model.addAttribute("result", result.name());
			}catch (DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				LOGGER.error("전출시 즉시수납처리에서 오류남", e);
			}
		}else {
			model.addAttribute("message", INVALID_PASSWORD_MSG);
		}
		return "jsonView";
	}
	
	/**
	 * [입주민관리-전출관리] 전출취소
	 * 	=============예외처리필요함
	 * @author 이경륜
	 * @return
	 */
	@RequestMapping(value="/office/resident/moveoutCancel.do", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String moveoutCancel(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@ModelAttribute("member") MemberVO member /*housecode 추가필요*/
			,@ModelAttribute("resident") ResidentVO resident /* memId가 어디바인딩되는지 확인필요*/
			,Model model
			) {
		
		// 0. 아이디, 비번 인증을 위해 셋팅
		member.setMemId(authMember.getMemId());
		
		// 1. 비밀번호 확인 
		ServiceResult pwResult = memberService.checkMemberPassword(member);
		if(pwResult == ServiceResult.OK) {
			// 2. 미납
			try{
				residentService.cancelResidentMoveout(resident);
				model.addAttribute("result", "OK");
			}catch (DataAccessException e) {
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				LOGGER.error("전출취소시 오류남", e);
			}
		}else {
			model.addAttribute("message", getCustomNoty("비밀번호 틀림"));
		}
		return "jsonView";
	}
	
	/**
	 * [입주민관리-전출관리] 전출등록
	 * 	=============예외처리필요함
	 * @author 이경륜
	 * @param authMember
	 * @param pagingVO
	 * @param resident
	 * @param model
	 * @param rttr
	 * @return
	 */
	@RequestMapping(value="/office/resident/moveoutInsert.do", method=RequestMethod.POST)
	public String moveoutInsert(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,PagingVO<ResidentVO> pagingVO
			,@ModelAttribute("resident") ResidentVO resident
			,Model model
			,RedirectAttributes rttr
	) {
		String goPage = "resident/moveoutForm";
		
		try {
			residentService.removeResident(resident);
		}catch (DataAccessException e) {
			model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
			LOGGER.error("전출등록시 오류남", e);
			return goPage;
		}
		goPage = "redirect:/office/resident/moveoutList.do";
		rttr.addAttribute("dongStart", resident.getDongStart());
		rttr.addAttribute("hoStart", resident.getHoStart());
		rttr.addAttribute("dongEnd", resident.getDongEnd());
		rttr.addAttribute("hoEnd", resident.getHoEnd());
		rttr.addAttribute("resMoveoutStart", resident.getResMoveoutStart());
		rttr.addAttribute("resMoveoutEnd", resident.getResMoveoutEnd());
		rttr.addAttribute("sortType", resident.getSortType());
		rttr.addAttribute("resName", resident.getResName());
		rttr.addAttribute("screenSize", pagingVO.getScreenSize());
		rttr.addAttribute("currentPage", pagingVO.getCurrentPage());
		return goPage;
	}
}
