/**
 * @author 이경륜
 * @since 2021. 2. 2.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 2.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commonsweb.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyLayout;
import kr.or.anyapart.board.vo.NotyMessageVO.NotyType;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.SearchVO;

public class BaseController {
	
	protected Logger LOGGER = LoggerFactory.getLogger(this.getClass());
	
	public void setAptCode(MemberVO authMember, SearchVO searchVO) {
		String aptCode = getAptCode(authMember);
		searchVO.setSearchAptCode(aptCode);
	}
	
	public String getAptCode(MemberVO authMember) {
		String memRole = authMember.getMemRole();
		String aptCode = null;
		if(!"ROLE_ADMIN".equals(memRole)) {
			aptCode = authMember.getMemId().substring(0, 5);
		}
		return aptCode;
	}
	
	public NotyMessageVO getCustomNoty(String msg) {
		return NotyMessageVO.builder(msg)
				.type(NotyType.error)
				.layout(NotyLayout.topCenter)
				.timeout(3000)
				.build();
	}
	protected static final NotyMessageVO OK_MSG = NotyMessageVO.builder("성공적으로 처리되었습니다.")
																		.type(NotyType.success)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
			
	protected static final NotyMessageVO INSERT_SERVER_ERROR_MSG = NotyMessageVO.builder("서버 오류로 등록에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	protected static final NotyMessageVO INSERT_CLIENT_ERROR_MSG = NotyMessageVO.builder("필수값 누락으로 등록에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	protected static final NotyMessageVO SELECT_SERVER_ERROR_MSG = NotyMessageVO.builder("서버 오류로 조회에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	protected static final NotyMessageVO SELECT_CLIENT_ERROR_MSG = NotyMessageVO.builder("필수값 누락으로 조회에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	protected static final NotyMessageVO UPDATE_SERVER_ERROR_MSG = NotyMessageVO.builder("서버 오류로 수정에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	protected static final NotyMessageVO UPDATE_CLIENT_ERROR_MSG = NotyMessageVO.builder("필수값 누락으로 수정에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	protected static final NotyMessageVO DELETE_SERVER_ERROR_MSG = NotyMessageVO.builder("서버 오류로 삭제에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	protected static final NotyMessageVO DELETE_CLIENT_ERROR_MSG = NotyMessageVO.builder("필수값 누락으로 삭제에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	protected static final NotyMessageVO INVALID_PASSWORD_MSG = NotyMessageVO.builder("비밀번호가 일치하지 않습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	
	protected static final NotyMessageVO FAILED_UPDATE_PASSWORD_MSG = NotyMessageVO.builder("비밀번호 변경에 실패했습니다.")
																		.type(NotyType.error)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	
	protected static final NotyMessageVO UPDATE_PASSWORD_MSG = NotyMessageVO.builder("비밀번호 변경에 성공했습니다.")
																		.type(NotyType.success)
																		.layout(NotyLayout.topCenter)
																		.timeout(3000)
																		.build();
	
	protected static final NotyMessageVO LOGOUT_MSG = NotyMessageVO.builder("로그 아웃 되었습니다.")
			.type(NotyType.success)
			.layout(NotyLayout.topCenter)
			.timeout(3000)
			.build();
	
	protected static final NotyMessageVO DELETED_MSG = NotyMessageVO.builder("이미 삭제된 글입니다.").build();
	
	protected static final NotyMessageVO NOT_FIND_MSG = NotyMessageVO.builder("이미 존재하지않는 글입니다.").build();
}
