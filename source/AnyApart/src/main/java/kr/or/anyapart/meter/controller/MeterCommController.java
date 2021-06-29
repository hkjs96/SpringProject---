/**
 * @author 박정민
 * @since 2021. 2. 17.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 17.       박정민            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.meter.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
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
import kr.or.anyapart.meter.service.IMeterCommService;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

@Controller
public class MeterCommController extends BaseController{
	@Inject
	private IMeterCommService service;

	@Inject
	private WebApplicationContext container;
	
	/**
	 * 공동검침 목록 조회
	 * @param pagingVO
	 * @param model
	 * @param authMemberVO
	 * @return
	 */
	@RequestMapping("/office/meter/meterCommList.do")
	public String meterCommList(PagingVO<MeterCommVO> pagingVO, Model model
			,@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO
			,MeterCommVO cmVO) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		pagingVO.setSearchDetail(cmVO);
		SearchVO searchVO = new SearchVO();
		searchVO.setSearchAptCode(authMemberVO.getAptCode());
		pagingVO.setSearchVO(searchVO);
		ApartVO apart = null;
		int totalCnt = 0;
		try {
			int totalRecord = service.retreiveCommMeterCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			List<MeterCommVO> dataList = service.retreiveCommMeterList(pagingVO);
			pagingVO.setDataList(dataList);
			apart = service.selectApart(authMemberVO);
			totalCnt = service.retreiveCommMeterTotalCnt(pagingVO);
			
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		model.addAttribute("authMember", authMemberVO);
		model.addAttribute("apart", apart);
		model.addAttribute("totalCnt", totalCnt);
		return "meter/meterCommList";
	}
	
	/**
	 * 공동검침 단건 등록
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/meter/registMeterComm.do")
	public String insert(PagingVO<MeterCommVO> pagingVO, RedirectAttributes rttr,
			MeterCommVO cmVO, BindingResult errors) {
		if(!errors.hasErrors()) {
			try {
				int cnt = service.insertCommMeter(cmVO);
				if(cnt>0) {
					rttr.addFlashAttribute("message", NotyMessageVO.builder("등록되었습니다.").type(NotyType.success).build());
				}else if(cnt==-1) {
					rttr.addFlashAttribute("message", NotyMessageVO.builder("이미 등록되어 있는 검침월입니다.").build());
				}else {
					rttr.addFlashAttribute("message", NotyMessageVO.builder("서버오류. 등록실패").build());
				}
			}catch (Exception e) {
				LOGGER.info(e+"");
			}
		}else {
			rttr.addFlashAttribute("message", NotyMessageVO.builder("양식을 확인하세요").build());
		}
		return "redirect:/office/meter/meterCommList.do";
	}
	
	/**
	 * 공동검침 수정 모달 
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/meter/modifyMeterComm.do")
	public String goUpdate(PagingVO<MeterCommVO> pagingVO, MeterCommVO coMeterVO,
			Model model) {
		MeterCommVO cmVO = null;
		try {
			cmVO = service.retreiveCommMeter(coMeterVO);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		model.addAttribute("cmVO", cmVO);
		return "office/meter/ajax/commMeterUpdateModal";
	}
	
	/**
	 * 공동검침 수정 모달 
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/meter/modifyMeterComm.do", method=RequestMethod.POST)
	public String update(PagingVO<MeterCommVO> pagingVO, MeterCommVO cmVO, BindingResult errors,
			Model model, RedirectAttributes rttr) {
		if(!errors.hasErrors()) {
			try {
				int cnt = service.updateCommMeter(cmVO);
				if(cnt>0) {
					rttr.addFlashAttribute("message", NotyMessageVO.builder("수정되었습니다.").type(NotyType.success).build());
				}else {
					rttr.addFlashAttribute("message", NotyMessageVO.builder("서버오류. 수정실패").build());
				}
			}catch (Exception e) {
				LOGGER.info(""+e);
			}
		}else {
			rttr.addFlashAttribute("message", NotyMessageVO.builder("양식을 확인하세요").build());
		}
		return "redirect:/office/meter/meterCommList.do";
	}
	
	/**
	 * 공동검침 삭제 
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/meter/deleteMeterComm.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(PagingVO<MeterCommVO> pagingVO, MeterCommVO cmVO,
			Model model, RedirectAttributes rttr) {
		String message = "서버오류. 삭제실패";
		try {
			int cnt = service.deleteCommMeter(cmVO);
			if(cnt>0) {
				message = "삭제되었습니다.";
			}
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		return message;
	}
	
	/**
	 * 엑셀 샘플 양식 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/meter/sampleExcelDown.do")
	public String sampleExcelDown(@RequestHeader(value="User-Agent", required=false) String agent
			, Model model) {
		Browser browser = Browser.getBrowserConstant(agent);
		AttachVO attach = new AttachVO();
		attach.setAttFilename("공동검침샘플.xlsx");
		attach.setAttSavename("meterCommSample.xlsx");
		model.addAttribute("attach", attach);
		return "excelTmplDownloadView";
	}
	
	/**
	 * 엑셀 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/meter/downloadExcel.do")
	public ExcelDownloadViewWithJxls excelDown(PagingVO<MeterCommVO> pagingVO, Model model
			,@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO
			,@ModelAttribute("cmVO")MeterCommVO cmVO) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		pagingVO.setSearchDetail(cmVO);
		List<MeterCommVO> dataList = new ArrayList<>();
		try {
			int totalRecord = service.retreiveCommMeterCount(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			dataList = service.retreiveCommMeterList(pagingVO);
			pagingVO.setDataList(dataList);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		model.addAttribute("pagingVO", pagingVO);
		
		return new ExcelDownloadViewWithJxls() {
			@Override
			public String getDownloadFileName() {
				return "공동검침 내역.xlsx";
			}
			
			@Override
			public Resource getJxlsTemplate() throws IOException {
				return container.getResource("/WEB-INF/jxlstmpl/meterCommTemplate.xlsx");
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
	@RequestMapping(value="/office/meter/uploadExcel.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String excelUpload(Model model, @RequestPart("excelFile") MultipartFile excelFile
			,@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO) {
		String message = "서버오류. 실패";
		ServiceResult result = ServiceResult.FAILED;
		
		List<MeterCommVO> commMeterList = new ArrayList<>();
		Resource tmpl = container.getResource("classpath:kr/or/anyapart/jxlstmpl/meterCommList.xml");
		LOGGER.info("~~~~~~~~~~~~~~~~~~~~~~{}",tmpl);
		try (
				InputStream is = new BufferedInputStream(tmpl.getInputStream())
		) {
				XLSReader reader = ReaderBuilder.buildFromXML(is);
				Map<String, Object> beans = new HashMap<>();
				beans.put("commMeterList", commMeterList);
				try {
					InputStream excelStream = excelFile.getInputStream();
					reader.read(excelStream, beans);
					result = service.createMuitlpleCommMeter(commMeterList, authMemberVO);
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
			message = "엑셀 업로드 양식에 맞지 않습니다.";
			break;
		default : 
			break;
		}
		model.addAttribute("message", message);
		return "jsonView";
	}
}
