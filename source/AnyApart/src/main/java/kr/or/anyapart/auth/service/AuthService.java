/**
 * @author 박지수
 * @since 2021. 2. 5.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 5.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.auth.service;

import org.springframework.stereotype.Service;

import kr.or.anyapart.vo.MemberVO;

@Service
public interface AuthService {
	/**
	 * 존재하는 회원정보인지 조회
	 * @param member
	 */
	public String retrieveMember(MemberVO member); 
	
	/**
	 * 회원 ID 조회
	 * @param member
	 */
	public MemberVO retrieveId(MemberVO member);
	
	/**
	 * 회원 메일로 비밀번호 변경 페이지 전송
	 * @param member
	 * @return 확인 메시지
	 */
	public String passSite(MemberVO member, String site);
	
	/**
	 * 회원 비밀번호 변경
	 * @param memPass
	 * 실패시 예외 발생
	 */
	public void modifyPass(MemberVO member);
}
