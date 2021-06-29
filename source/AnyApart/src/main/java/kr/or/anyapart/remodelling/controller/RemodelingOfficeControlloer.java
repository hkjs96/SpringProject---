/**
 * @author 박정민
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                                             수정자                            수정내용
 * --------     --------   -----------------------
 * 2021. 1. 26.       작성자명         최초작성
 * Copyright (c) 2021. 1. 26. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.remodelling.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.document.dao.IOthersDAO;
import kr.or.anyapart.remodelling.service.IRemodelingService;
import kr.or.anyapart.remodelling.vo.RemodellingVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.ScheduleVO;
import kr.or.anyapart.vo.SearchVO;

/**
 * 관리자 사이트 리모델링 신고 관리
 */
@Controller
public class RemodelingOfficeControlloer {
	
	@Inject
	private IRemodelingService service;
	@Inject
	private IOthersDAO dao;
	
	/**
	 * 리모델링 신고목록 조회
	 * @return
	 */
	@RequestMapping("/office/construction/remodelingList.do")
	public String list(PagingVO<RemodellingVO> pagingVO, Model model, 
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember,
			@RequestParam(value="rmdlYn", required=false)String rmdlYn) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		RemodellingVO searchDetail = new RemodellingVO();
		searchDetail.setRmdlYn(rmdlYn);
		pagingVO.setSearchDetail(searchDetail);
		if(pagingVO.getSearchVO()==null) {
			SearchVO searchVO = new SearchVO();
			searchVO.setSearchAptCode(authMember.getAptCode());
			pagingVO.setSearchVO(searchVO);
		}else {
			pagingVO.getSearchVO().setSearchAptCode(authMember.getAptCode());
		}
		
		pagingVO.setTotalRecord(service.reteiveRmdlCount(pagingVO));
		RemodellingVO rmdlVO = new RemodellingVO();
		rmdlVO.setWaitingCnt(service.retreiveRmdlWaitingCnt(pagingVO));
//		List<HouseVO> dongList = dao.selectDongList(authMember);
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		model.addAttribute("rmdlVO", rmdlVO);
//		model.addAttribute("dongList", dongList);
//		model.addAttribute("dong", "0000"); //초깃값
		return "construction/remodelingList";
	}
	
	/**
	 * 리모델링 신고 목록 ajax
	 * @param pagingVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/office/construction/remodelingList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<RemodellingVO> listAjax(PagingVO<RemodellingVO> pagingVO, Model model,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember,
			@RequestParam(value="rmdlYn", required=false)String rmdlYn) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		RemodellingVO searchDetail = new RemodellingVO();
		searchDetail.setRmdlYn(rmdlYn);
		pagingVO.setSearchDetail(searchDetail);
		if(pagingVO.getSearchVO()==null) {
			SearchVO searchVO = new SearchVO();
			searchVO.setSearchAptCode(authMember.getAptCode());
			pagingVO.setSearchVO(searchVO);
		}else {
			pagingVO.getSearchVO().setSearchAptCode(authMember.getAptCode());
		}
		
		pagingVO.setTotalRecord(service.reteiveRmdlCount(pagingVO));
		List<RemodellingVO> rmdlList = service.retreiveListOffice(pagingVO);
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return rmdlList;
	}
	
	/**
	 * 리모델링 신청 승인
	 * @param rmdlVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/construction/approval.do")
	public String approval(RemodellingVO rmdlVO, Model model) {
		String message = "서버오류. 승인 실패";
		ServiceResult result = service.approvalRmdl(rmdlVO);
		switch (result) {
		case OK:
			message = "승인되었습니다. 승인된 일정은 일정관리에서 조회할 수 있습니다.";
			break;
		default:
			break;
		}
		model.addAttribute("message", message);
		return "jsonView";
	}
	
	/**
	 * 리모델링 승인 취소 - 리모델링 관리 ajax 
	 * @param rmdlVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/construction/rmdlApprovalCancelAjax.do")
	public String approvalCancleAjax(RemodellingVO rmdlVO, Model model) {
		String message = "서버오류. 취소 실패";
		ServiceResult result = service.approvalCancelRmdlManage(rmdlVO);
		switch (result) {
		case OK:
			message = "정상적으로 처리되었습니다.";
			break;
		default:
			break;
		}
		model.addAttribute("message", message);
		return "jsonView";
	}
	
	/**
	 * 리모델링 승인 취소 - 일정관리 
	 * @param rmdlVO
	 * @param model
	 * @return
	 */
	@RequestMapping("/office/construction/rmdlApprovalCancel.do")
	public String approvalCancle(ScheduleVO scheduleVO, Model model, RedirectAttributes rttr) {
		String goPage = "redirect:/office/calendar/wholeCalendar.do";
		String message = "서버오류. 삭제 실패";
		ServiceResult result = service.approvalCancelRmdl(scheduleVO);
		if(result==ServiceResult.OK) {
			rttr.addFlashAttribute("message", NotyMessageVO.builder("정상적으로 처리되었습니다.").type(NotyType.success).build());
		}else {
			rttr.addFlashAttribute("message", NotyMessageVO.builder(message).build());
		}
		return goPage;
	}
}
