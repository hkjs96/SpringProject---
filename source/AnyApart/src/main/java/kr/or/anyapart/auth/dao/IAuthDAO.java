/**
 * @author 박지수
 * @since 2021. 1. 30.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 30.      박지수       최초작성
 * 2021. 2. 05.      박지수       ID, PW 찾기
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.auth.dao;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.vo.MemberVO;

@Repository
public interface IAuthDAO {
	public MemberVO authMember(String username);
	/**
	 * 회원 ID 조회, 회원 존재 여부 확인
	 * @param member
	 * @return MemberVO, null 반환
	 */
	public MemberVO retrieveMember(MemberVO member);
	
	/**
	 * 회원 비밀 번호 변경
	 * @param member
	 * @return 성공시 1반환, 0반환
	 */
	public int updatePass(MemberVO member);
}