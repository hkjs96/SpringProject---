/**
 * @author 박찬
 * @since 2021. 2. 20.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                     수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 20.   박찬                최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commonsweb.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vendornotice.service.VendorNoticeService;
import kr.or.anyapart.board.vendorqna.service.VendorQnaService;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyLayout;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.vendorDashboard.service.VendorService;
import kr.or.anyapart.vendorDashboard.vo.DashboardVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.RequestLogVO;
import kr.or.anyapart.vo.SearchVO;

@Controller("vendorIndex")
public class IndexServlet extends BaseController{
	@Inject
	private VendorService service;
	
	@Inject
	private VendorNoticeService vNoticeService;
	
	@Inject
	private VendorQnaService vQnaService;
	/**
	 * 벤더 대시보드 들어갈 페이지
	 * [초기 세팅]
	 * 문의글 ,
	 * 공지사항 ,
	 * 모든 아파트의 문의글 수의 통계( 문의글 수, 답변된 글의 수 , 답변 되지 않은 글 수 )
	 * @param model
	 * @param searchDetail
	 * @param searchVO
	 * @param dash
	 * @return 
	 */
	@RequestMapping("/vendor")
	public String goVendor(Model model,@ModelAttribute("searchDetail") BoardVO searchDetail,
			@ModelAttribute("searchVO") SearchVO searchVO , DashboardVO dash) {
			
		try {
			
			PagingVO<BoardVO> pagingVO = new PagingVO<>();
			pagingVO.setSearchVO(searchVO);
			pagingVO.setSearchDetail(searchDetail);
			pagingVO.setTotalRecord(5);
			pagingVO.setCurrentPage(1);
			List<BoardVO> noticeList = vNoticeService.retrieveBoardList(pagingVO);
			List<DashboardVO> yy= service.reieveYearList(dash);
			DashboardVO qnaTotalCount = service.retrieveTotalQnaCount(dash);
			List<BoardVO> qnaList = vQnaService.retrieveBoardList(pagingVO);
			model.addAttribute("qnaList",qnaList);
			model.addAttribute("noticeList",noticeList);
			model.addAttribute("qnaTotalCount",qnaTotalCount);
			model.addAttribute("yy",yy);
			return "indexV";
		}catch (IndexOutOfBoundsException e){
			
			return "indexV";
		}
	}
	
	/**
	 * 아파트 리스트 검색 비동기 처리 
	 * @param currentPage
	 * @param searchVO
	 * @param model
	 * @return json
	 */
	@RequestMapping(value="/vendor/search.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String apartListAjax(
		@RequestParam(value="page",required=false, defaultValue="1" )int currentPage
		,@ModelAttribute("searchVO") SearchVO searchVO,Model model) {
		
		PagingVO<ApartVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		
		int totalRecord = service.retrieveApartCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<ApartVO> apartList = service.apartList(pagingVO); 
		pagingVO.setDataList(apartList);
		
		model.addAttribute("pagingVO",pagingVO);
		
		return "jsonView";
	}
	
	/**
	 * 글이 존재하는 해당 연도 불러오기  비동기 처리
	 * [아파트 선택시 해당 아파트의 문의글을 파악하여 연도  불러오기
	 *  해당 아파트의 전체 문의글 카운트 표시 ]
	 * [아파트 미선택시 모든 아파트의 문의글을 파악하여 연도 불러오기
	 *  모든 아파트의 전체 문의글 카운트 표시]
	 * @param dsVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/vendor/dashBoardForm.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String apartDashboard(DashboardVO dsVO,Model model) {
		
		DashboardVO qnaCount = service.retrieveTotalQnaCount(dsVO);
		
		List<DashboardVO> yy= service.reieveYearList(dsVO); 
		model.addAttribute("yy",yy);
		model.addAttribute("qnaCount",qnaCount);
		
		return "jsonView";
	}
	
	/**
	 * 벤더 문의글 종류 검색  비동기 처리
	 * @param model
	 * @param searchDetail
	 * @param boType
	 * @return
	 */
	@RequestMapping(value="/vendor/qnaType.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String qnaSearchAjax(Model model,@ModelAttribute("searchDetail") BoardVO searchDetail,
		@RequestParam("boType") String boType) {
		
		PagingVO<BoardVO> pagingVO = new PagingVO<>();
		SearchVO as = new SearchVO ();
		as.setSearchType(boType);
		pagingVO.setSearchVO(as);
		pagingVO.setSearchDetail(searchDetail);
		pagingVO.setTotalRecord(5);
		pagingVO.setCurrentPage(1);
		List<BoardVO> qnaListAjax = vQnaService.retrieveBoardList(pagingVO);
		
		model.addAttribute("qnaList",qnaListAjax);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/vedor/dayList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String dayList(DashboardVO dashboardVO ,Model model) {
		
		List<DashboardVO> mm = service.retrieveMondayList(dashboardVO);
	
		if(mm.size() !=0) {
			mm.get(0).setAptCode(dashboardVO.getAptCode());
			DashboardVO qnaTotalCount = service.retrieveTotalQnaCount(mm.get(0));
			model.addAttribute("qnaTotalCount",qnaTotalCount);
		}else {
			DashboardVO defalutVO =new DashboardVO();
			defalutVO.setAptCode(dashboardVO.getAptCode());
			DashboardVO qnaTotalCount = service.retrieveTotalQnaCount(defalutVO);
			model.addAttribute("qnaTotalCount",qnaTotalCount);
		}
		model.addAttribute("mm",mm);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/vedor/searchDayChart.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String dayChart(DashboardVO dsVO , Model model) {
		
		DashboardVO qnaTotalCount = service.retrieveTotalQnaCount(dsVO);
		model.addAttribute("qnaTotalCount",qnaTotalCount);
		return "jsonView";
	}
	
	
	
	/**
	 * 벤더 대쉬보드 공지사항 수정 폼 이동 
	 * @param param
	 * @param model
	 * @return 모달창으로 load
	 */
	@RequestMapping(value="/ajax/noticeAjaxUpdateForm.do", method=RequestMethod.GET)
	public String ajaxNoticeUpdateForm(@ModelAttribute BoardVO param
		, Model model
		){
		
			BoardVO board =vNoticeService.retrieveBoard(param);
			
			model.addAttribute("board", board);
			return "vendor/noticeV/modalAjax/noticeAjaxForm";
	}
	
	/**
	 * 벤더 대쉬보드 공지사항 수정 
	 * @param board
	 * @param errors
	 * @param currentPage
	 * @param model
	 * @param redirectAttributes
	 * @param searchVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/ajax/noticeAjaxUpdate.do" ,method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public NotyMessageVO vendorNoticeUpdateDo(@Validated(UpdateGroup.class)
	@ModelAttribute("board") BoardVO board
	, BindingResult errors
	, Model model) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = vNoticeService.modifyBoard(board);
				message = OK_MSG;
				
			if(result == ServiceResult.FAILED) {
				message = UPDATE_SERVER_ERROR_MSG;
			}
		}else {
			message= UPDATE_CLIENT_ERROR_MSG;
		}
		if(message!=null) {
			model.addAttribute("message",message);
		}
		return message;
	}
	
	
	
	/**
	 * 벤더 대시보드 에서 보여줄 관리사무소 상세조회 modal
	 * @param param
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value="/ajax/noticeView.do")
	public String vendorNoticeAjaxView(@ModelAttribute BoardVO param
			,Model model,RedirectAttributes redirectAttributes) {
		
		BoardVO boardVO= vNoticeService.retrieveBoard(param);
		if("Y".equals(boardVO.getBoDelete())) {
			redirectAttributes.addFlashAttribute("message", NotyMessageVO.builder("이미 삭제된 글임.").build());
			return "redirect:/vendor/noticeList.do";
		}else {
			model.addAttribute("board", boardVO);
			return "vendor/noticeV/modalAjax/noticeAjaxView";
		}
	}
	
	/**
	 * 벤더 공지사항 리스트 불러오기 ajax
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/vendor/noticeAjaxList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String vendorNoticeList(Model model) {
		try {
			PagingVO<BoardVO> pagingVO = new PagingVO<>();
			pagingVO.setTotalRecord(5);
			pagingVO.setCurrentPage(1);
			pagingVO.setScreenSize(5);
			List<BoardVO> noticeList = vNoticeService.retrieveBoardList(pagingVO);
			model.addAttribute("noticeList",noticeList);
			
			return "jsonView";
		}catch (IndexOutOfBoundsException e){
			
			return "indexV";
		}
	}
	/**
	 * 벤더 공지사항 삭제 ajax
	 * @param board
	 * @param errors
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/vendor/noticeAjaxDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public NotyMessageVO delete(@Validated(DeleteGroup.class) @ModelAttribute("board") 
	BoardVO board, BindingResult errors,
			RedirectAttributes redirectAttributes) {
		NotyMessageVO message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = vNoticeService.removeBoard(board);
				message = OK_MSG;
				
			if(result == ServiceResult.FAILED) {
				message = DELETE_SERVER_ERROR_MSG;
			}
		}else {
			message= DELETE_CLIENT_ERROR_MSG;
		}
		if(message!=null) {
		}
		return message;
	}
	
	/**
	 * 메뉴별 통계
	 * @param model
	 * @return
	 * @author 이경륜
	 */
	@RequestMapping(value="/vendor/menuList.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String menuList(
			@ModelAttribute RequestLogVO requestLogVO
			,Model model
	) {
		try {
			List<RequestLogVO> menuList = service.retrieveRequestLogList(requestLogVO);
			model.addAttribute("menuList", menuList);
		} catch (DataAccessException e) {
			model.addAttribute("message", SELECT_SERVER_ERROR_MSG);
		}
		return "jsonView";
	}
}
