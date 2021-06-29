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
 * 2021. 2.  8.   이경륜		list 매핑 수정
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.board.freeboard.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.anyapart.board.freeboard.service.IReplyService;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.ReplyVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.vo.PagingVO;

@RestController
@RequestMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ReplyController extends BaseController{
	@Inject
	private IReplyService service;
	
	@RequestMapping(value="/resident/space/reply", method=RequestMethod.GET)
	public PagingVO<ReplyVO> list(
			@RequestParam(value="boNo", required=true) int boNo, 
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, HttpServletResponse resp) throws ServletException, IOException{
//		====검색, 특정글의 댓글만 조회
		ReplyVO searchDetail = new ReplyVO();
		searchDetail.setBoNo(boNo);
		
		PagingVO<ReplyVO> pagingVO = new PagingVO<>(5, 5);
		pagingVO.setSearchDetail(searchDetail);
//		========
		int totalRecord = service.retrieveReplyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord); // totalPage
		pagingVO.setCurrentPage(currentPage); // startRow, endRow, startPage, endPage
		
		List<ReplyVO> ReplyList = service.retrieveReplyList(pagingVO);
		pagingVO.setDataList(ReplyList);
		
		return pagingVO;
	}
	
	@RequestMapping(value="/resident/space/reply", method=RequestMethod.POST)
	public Map<String, Object> insert(
			@ModelAttribute("reply" )ReplyVO reply,
			HttpServletResponse resp
	) throws ServletException, IOException{
		ServiceResult result = service.createReply(reply);
		Map<String, Object> resultMap = Collections.singletonMap("result", result);
		return resultMap;
	}
	
	@RequestMapping(value="/resident/space/reply", method=RequestMethod.PUT)
	public Map<String, Object> update(@ModelAttribute("reply") ReplyVO reply,
			HttpServletResponse resp) throws ServletException, IOException {
		ServiceResult result = service.modifyReply(reply);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("result", result);
		if(ServiceResult.FAILED.equals(result)) {
			resultMap.put("message", UPDATE_SERVER_ERROR_MSG);
		}
		return resultMap;
	}
	
	@RequestMapping(value="/resident/space/reply", method=RequestMethod.DELETE)
	public Map<String, Object> delete(@ModelAttribute("reply") ReplyVO reply,
			HttpServletResponse resp) throws ServletException, IOException {
		ServiceResult result = service.removeReply(reply);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("result", result);
		if(ServiceResult.FAILED.equals(result)) {
			resultMap.put("message", DELETE_SERVER_ERROR_MSG);
		}
		return resultMap;
	}
	
	/**
	 * [관리사무소-사이트관리-자유게시판] 댓글리스트 조회
	 */
	@RequestMapping(value="/office/website/reply", method=RequestMethod.GET)
	public PagingVO<ReplyVO> listForOffice(
			@RequestParam(value="boNo", required=true) int boNo, 
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, HttpServletResponse resp) throws ServletException, IOException{
		return list(boNo, currentPage, resp);
	}
	/**
	 * [관리사무소-사이트관리-자유게시판] 댓글 삭제
	 */
	@RequestMapping(value="/office/website/reply", method=RequestMethod.DELETE)
	public Map<String, Object> deleteForOffice(@ModelAttribute("reply") ReplyVO reply,
			HttpServletResponse resp) throws ServletException, IOException {
		return delete(reply, resp);
	}

}
