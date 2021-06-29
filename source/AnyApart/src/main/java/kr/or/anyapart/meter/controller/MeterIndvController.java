/**
 * @author 박정민
 * @since 2021. 2. 23.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 23.    박정민            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.meter.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.jxls.reader.ReaderBuilder;
import org.jxls.reader.XLSReader;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.xml.sax.SAXException;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.Browser;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.commonsweb.controller.ExcelDownloadViewWithJxls;
import kr.or.anyapart.document.dao.IOthersDAO;
import kr.or.anyapart.meter.dao.IMeterCommDAO;
import kr.or.anyapart.meter.service.IMeterCommService;
import kr.or.anyapart.meter.service.IMeterIndvService;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.meter.vo.MeterIndvListVO;
import kr.or.anyapart.meter.vo.MeterIndvVO;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class MeterIndvController extends BaseController{
	
	@Inject
	private IMeterIndvService service;
	
	@Inject
	private IMeterCommService serviceC;
	
	@Inject
	private WebApplicationContext container;
	
	@Inject
	private IOthersDAO dao;
	
	@Inject
	private IMeterCommDAO daoC;
	
	/**
	 * 세대 검침 목록 조회
	 * @param pagingVO
	 * @param model
	 * @param authMemberVO
	 * @return
	 */
	@RequestMapping("/office/meter/meterIndvList.do")
	public String meterIndvlist(PagingVO<MeterIndvVO> pagingVO, Model model,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO,
			@RequestParam(value="dong", defaultValue="0000", required=false)String dong,
			MeterIndvVO miVO) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		
		pagingVO.setSearchDetail(miVO);
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchAptCode(authMemberVO.getAptCode());
		pagingVO.setSearchVO(searchVO);
		
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MONTH, -1);
		SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyyMM");
		String commYear = dateFormat1.format(calendar.getTime()).substring(0,4);
		String commMonth = dateFormat1.format(calendar.getTime()).substring(4,6);
		MeterCommVO thisMonthMCVO = new MeterCommVO();
		thisMonthMCVO.setCommYear(Integer.parseInt(commYear));
		thisMonthMCVO.setCommMonth(Integer.parseInt(commMonth));
		thisMonthMCVO.setAptCode(authMemberVO.getAptCode());
		
		List<MeterIndvVO> dataList = new ArrayList<>();
		ApartVO apart = null;
		int totalCnt = 0;
		try {
			int totalRecord = service.retreiveMeterIndvCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			dataList = service.retreiveMeterIndvList(pagingVO);
			pagingVO.setDataList(dataList);
			apart = serviceC.selectApart(authMemberVO);
			
			thisMonthMCVO = daoC.selectExcelCommMeter(thisMonthMCVO);
			totalCnt = service.retreiveIndvMeterTotalCnt(pagingVO);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		model.addAttribute("authMember", authMemberVO);
		model.addAttribute("apart", apart);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("thisMonthMCVO", thisMonthMCVO);
		return "meter/meterIndvList";
	}
	
	/**
	 * 검색조건 호 리스트
	 * @param houseVO
	 * @param model
	 * @param authMemberVO
	 * @return
	 */
//	@RequestMapping(value="/office/meter/meterIndvList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public List<HouseVO> hoListAjax(HouseVO houseVO, Model model,
//			@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO) {
//		List<HouseVO> hoList = new ArrayList<>();
//		try {
//			houseVO.setAptCode(authMemberVO.getAptCode());
//			hoList = dao.selectHoList(houseVO);
//		}catch (Exception e) {
//			LOGGER.info(""+e);
//		}
//		return hoList;
//	}
	
	/**
	 * 세대검침 단건등록
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/meter/registMeterIndv.do")
	public String regist(PagingVO<MeterIndvVO> pagingVO, @ModelAttribute("indvList") MeterIndvListVO indvList,
			BindingResult errors, Model model, RedirectAttributes rttr) {
		String message = "서버오류. 등록실패";
		if(!errors.hasErrors()) {
			try {
				int cnt = service.insertMeterIndv(indvList);
				if(cnt>0) {
					rttr.addFlashAttribute("message", NotyMessageVO.builder("등록되었습니다.").type(NotyType.success).build());
				}else if(cnt==-1) {
					rttr.addFlashAttribute("message", NotyMessageVO.builder("이미 등록되어있는 세대입니다.").build());
				}else {
					rttr.addFlashAttribute("message", NotyMessageVO.builder(message).build());
				}
			}catch (Exception e) {
				LOGGER.info(""+e);
			}
		}else {
			rttr.addFlashAttribute("message", NotyMessageVO.builder("양식을 확인해주세요").build());
		}
		return "redirect:/office/meter/meterIndvList.do";
	}
	
	/**
	 * 세대검침 수정 모달 폼 이동 
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/meter/modifyMeterIndv.do")
	public String goUpdate(PagingVO<MeterIndvVO> pagingVO, MeterIndvVO meterIndvVO,
			Model model) {
		MeterIndvVO miVO = null;
		try {
			miVO = service.retreiveMeterIndv(meterIndvVO);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		model.addAttribute("miVO", miVO);
		return "office/meter/ajax/meterIndvUpdateModal";
	}
	
	/**
	 * 세대검침 수정 모달 
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/meter/modifyMeterIndv.do", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String update(PagingVO<MeterIndvVO> pagingVO, MeterIndvVO miVO, BindingResult errors,
			Model model) {
		ServiceResult result = ServiceResult.FAILED;
		String message = "서버오류. 수정실패";
		if(!errors.hasErrors()) {
			result = service.updateMeterIndv(miVO);
			switch (result) {
			case OK:
				message = "수정되었습니다.";
				break;
			case INVALIDID: 
				message = "존재하지 않는 입주민입니다.";
				break;
			default:
				break;
			}
		}else {
			message="양식을 확인하세요";
		}
		model.addAttribute("message", message);
		LOGGER.info("message~~~~~~~~~~~~~~~~~~~~:{}", message);
		return "jsonView";
	}
	
	/**
	 * 세대검침 삭제 
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/meter/deleteMeterIndv.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(PagingVO<MeterIndvVO> pagingVO, MeterIndvVO miVO,
			Model model, RedirectAttributes rttr) {
		int cnt = 0;
		try {
			cnt = service.deleteMeterIndv(miVO);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		String message = "서버오류. 삭제실패";
		if(cnt>0) {
			message = "삭제되었습니다.";
		}
		return message;
	}
	
	/**
	 * 엑셀 샘플 양식 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/meter/sampleExcelDownIndv.do")
	public String sampleExcelDown(@RequestHeader(value="User-Agent", required=false) String agent
			, Model model) {
		Browser browser = Browser.getBrowserConstant(agent);
		AttachVO attach = new AttachVO();
		attach.setAttFilename("세대검침샘플.xlsx");
		attach.setAttSavename("meterIndvSample.xlsx");
		model.addAttribute("attach", attach);
		return "excelTmplDownloadView";
	}
	
	/**
	 * 엑셀 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/meter/downloadExcelIndv.do")
	public ExcelDownloadViewWithJxls excelDown(PagingVO<MeterIndvVO> pagingVO, Model model
			,@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO
			,@ModelAttribute("miVO")MeterIndvVO miVO) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		pagingVO.setSearchDetail(miVO);
		try {
			int totalRecord = service.retreiveMeterIndvCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<MeterIndvVO> dataList = service.retreiveMeterIndvList(pagingVO);
			pagingVO.setDataList(dataList);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		model.addAttribute("pagingVO", pagingVO);
		
		return new ExcelDownloadViewWithJxls() {
			@Override
			public String getDownloadFileName() {
				return "세대검침 내역.xlsx";
			}
			
			@Override
			public Resource getJxlsTemplate() throws IOException {
				return container.getResource("/WEB-INF/jxlstmpl/meterIndvTemplate.xlsx");
			}
		};
	}
	
	/**
	 * 엑셀 업로드
	 * @param model
	 * @param excelFile
	 * @param authMemberVO
	 * @return
	 */
	@RequestMapping(value="/office/meter/uploadExcelIndv.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String excelUpload(Model model, @RequestPart("excelFile") MultipartFile excelFile
			,@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO) {
		String message = "서버오류. 실패";
		ServiceResult result = ServiceResult.FAILED;
		
		List<MeterIndvVO> meterIndvList = new ArrayList<>();
		Resource tmpl = container.getResource("classpath:kr/or/anyapart/jxlstmpl/meterIndvList.xml");
		
		try (
				InputStream is = new BufferedInputStream(tmpl.getInputStream())
		) {
				XLSReader reader = ReaderBuilder.buildFromXML(is);
				Map<String, Object> beans = new HashMap<>();
				beans.put("meterIndvList", meterIndvList);
				try {
					InputStream excelStream = excelFile.getInputStream();
					reader.read(excelStream, beans);
					result = service.createMuitlpleIndvMeter(meterIndvList);
				} catch (InvalidFormatException e) {
					LOGGER.error("", e);
				}
		} catch (SAXException | IOException e) {
			LOGGER.error("", e);
		}
		switch (result) {
		case OK:
			message = "등록되었습니다.";
			break;
		case ALREADYEXIST:
			message = "이미 등록된 검침내역을 포함한 파일입니다.";
			break;
		case NOTEXIST:
			message = "등록할 데이터가 없습니다. 데이터를 입력해주세요";
			break;
		default : 
			break;
		}
		model.addAttribute("message", message);
		return "jsonView";
	}
	
}
