package kr.or.anyapart.commons.advice;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.TransactionException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import kr.or.anyapart.CustomException;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyLayout;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;

/**
 * CustomException 을 발생하면, 404 상태 응답 전송
 *
 */
/*
 * 이경륜
 * - 어노테이션 밸류로 적혀있는 Exception 발생시 작동함
 * - try-catch로 컨트롤러에서 잡아주지 않으면 작동함
 * - servlet-context.xml의 IRVR 규칙에 따라 errors폴더 밑에 jsp 생성해두었음 
 */
@ControllerAdvice
public class ExceptionHandlerControllerAdvice {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ExceptionHandlerControllerAdvice.class);
	
	@ExceptionHandler(CustomException.class)
	public String customExceptionHandler(CustomException e, Model model) {
		model.addAttribute("exception", e);
		return "errors/errorView";
	}
	
	@ExceptionHandler(DataAccessException.class)
	public String customExceptionHandler(DataAccessException e, Model model) {
//		model.addAttribute("message", NotyMessageVO.builder("서버와 통신중 문제가 발생했습니다.")
//		.type(NotyType.error)
//		.layout(NotyLayout.topCenter)
//		.timeout(3000)
//		.build());
		return "errors/dataAccess";
	}
	@ExceptionHandler(TransactionException.class)
	public String customExceptionHandler(TransactionException e, Model model) {

		return "errors/transactionFailure";
	}
	@ExceptionHandler(EgovBizException.class)
	public String customExceptionHandler(EgovBizException e, Model model) {
		return "errors/egovError";
	}
	@ExceptionHandler(AccessDeniedException.class)
	public String customExceptionHandler(AccessDeniedException e, Model model) {
		return "errors/accessDenied";
	}
	

//	@ExceptionHandler(CustomException.class)
//	public void customExceptionHandler(CustomException e, HttpServletResponse resp) throws IOException {
//		resp.sendError(404, e.getMessage());
//	}
}





















