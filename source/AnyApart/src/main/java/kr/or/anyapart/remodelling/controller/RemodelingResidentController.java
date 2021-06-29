/**
 * @author 박정민
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                                             수정자                            수정내용
 * --------     --------   -----------------------
 * 2021. 1. 26.       박정민         최초작성
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
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.remodelling.service.IRemodelingService;
import kr.or.anyapart.remodelling.vo.RemodellingVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;

/**
 * 입주민 사이트 리모델링 신고 
 */
@Controller
public class RemodelingResidentController {
	@Inject
	private IRemodelingService service;
	
	@ModelAttribute("remodellingVO")
	public RemodellingVO remodellingVO() {
		return new RemodellingVO();
	}
	
	@RequestMapping("/resident/support/remodelingList.do")
	public String goList(Model model, PagingVO<RemodellingVO> pagingVO, 
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		if(pagingVO.getSearchVO()==null) {
			SearchVO searchVO = new SearchVO();
			searchVO.setSearchAptCode(authMember.getAptCode());
			pagingVO.setSearchVO(searchVO);
		}else {
			pagingVO.getSearchVO().setSearchAptCode(authMember.getAptCode());
		}
		int totalRecord = service.reteiveRmdlCountR(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		return "support/remodelingList";
	}
	
	/**
	 * 리모델링 신청글 목록 조회 ajax
	 * @param model
	 * @param currentPage
	 * @return
	 */
	@RequestMapping(value="/resident/support/remodelingList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String listAjax(Model model, PagingVO<RemodellingVO> pagingVO,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		if(pagingVO.getCurrentPage()==0) {
			pagingVO.setCurrentPage(1);
		}
		if(pagingVO.getSearchVO()==null) {
			SearchVO searchVO = new SearchVO();
			searchVO.setSearchAptCode(authMember.getAptCode());
			pagingVO.setSearchVO(searchVO);
		}else {
			pagingVO.getSearchVO().setSearchAptCode(authMember.getAptCode());
		}
		int totalRecord = service.reteiveRmdlCountR(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<RemodellingVO> rmdlList = service.retreiveList(pagingVO);
		pagingVO.setDataList(rmdlList);
		
		model.addAttribute("paginationInfo", new CustomPaginationInfo<>(pagingVO));
		
		return "jsonView";
	}
	
	
	/**
	 * 리모델링 신청 등록
	 * @return 처리 메시지
	 */
	@RequestMapping(value="/resident/support/insertRemodeling.do", method=RequestMethod.POST, 
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String insert(@Validated(InsertGroup.class) @ModelAttribute("rmdlVO")RemodellingVO rmdlVO, 
			BindingResult errors, Model model) {
		String message = "양식을 작성하세요";
		if(!errors.hasErrors()) {
			ServiceResult result = service.insertRmdl(rmdlVO);
			switch (result) {
			case OK:  
				message = "신청이 완료되었습니다.";
				model.addAttribute("message", NotyMessageVO.builder(message).type(NotyType.success).build());
				break;
			default:  
				message = "서버 오류로 신청 실패. 관리자에게 문의하세요.";
				break;
			}
		}else {
			model.addAttribute("message", NotyMessageVO.builder(message).build());
		}
		return "jsonView";
	}
	
	/**
	 * 리모델링 신청글 삭제
	 * @return 처리 메시지
	 */
	@RequestMapping(value="/resident/support/deleteRemodeling.do", //method=RequestMethod.POST, 
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String delete(RemodellingVO rmdlVO, Model model,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMember) {
		
		String message = "삭제 실패";
		ServiceResult result = service.deleteRmdl(rmdlVO, authMember);
		switch (result) {
		case OK:
			message = "취소되었습니다.";
			break;
		default:
			message = "서버 오류. 삭제실패.";
			break;
		}
		model.addAttribute("message", NotyMessageVO.builder(message).type(NotyType.success).build());
		return "jsonView";
	}
	
}
