/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 13.      박지수      최초 작성
* 2021. 3. 01.      박지수      본인확인
* 2021. 3. 04.      박지수      입주민 회원 조회
* Copyright (c) 2021 by DDIT All right reserved
*/
package kr.or.anyapart.setting.service;

import javax.inject.Inject;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.setting.dao.MemberDAO;
import kr.or.anyapart.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	@Inject
	private PasswordEncoder pwEncoder;
	
	@Inject
	private AuthenticationManager authenticationManager;
	
	/*
	 * [회원 조회?]
	 */
	@Override
	public MemberVO retrieveMember(MemberVO member) {
		return null;
	}

	/*
	 * [ 회원 비밀 번호 변경 ] 
	 */
	@Override
	public void modifyMember(MemberVO member, String updatePass) {
//		member.setMemPass(pwEncoder.encode(member.getMemPass()));
//		MemberVO dbMember = dao.retrieveMember(member);
//			// DB 저장된 비밀번호와, 인코딩 안된 입력된 비밀번호 비교
//		boolean check = pwEncoder.matches(member.getMemPass(), dbMember.getMemPass());
//		if(!check) throw new RuntimeException("존재하는 회원이 아님");
		try {
			String encodedUpdatePass = pwEncoder.encode(updatePass);
			member.setMemPass(encodedUpdatePass);
			int rowcnt = dao.updateMember(member);
			if(rowcnt > 0) {
				// 새로운 인증 토큰을 발급 받아서 바뀐 정보로 인가 정보를 생성해줌
				Authentication auth = new UsernamePasswordAuthenticationToken(member.getMemId(), updatePass);
				Authentication newAuth = authenticationManager.authenticate(auth);
				SecurityContextHolder.getContext().setAuthentication(newAuth);
			}else {
				throw new RuntimeException("변경 실패");
			}
		}catch (BadCredentialsException e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [맞는 회원인지 확인]
	 * 최초작성: 박지수
	 * 구현부수정: 이경륜
	 */
	@Override
	public ServiceResult checkMemberPassword(MemberVO member) {
		MemberVO dbMember = dao.retrieveMember(member);
			// 
		/*
		 * DB 저장된 비밀번호와, 인코딩 안된 입력된 비밀번호 비교 by 박지수
		 * - bcrypt 인코딩시 시간값도 들어가기때문에 equals로 완벽한 비교는 불가
		 * - matches 메서드를 통해 비교할 수 있음
		 */
		boolean check = pwEncoder.matches(member.getMemPass(), dbMember.getMemPass());
		ServiceResult result = check == true ? ServiceResult.OK : ServiceResult.INVALIDPASSWORD;
		return result;
	}

	/* 
	 * [ 본인 확인 ]
	 */
	@Override
	public void checkMemberPassword(MemberVO member, String memPass) {
		boolean check = pwEncoder.matches(memPass, member.getMemPass());
		if(!check) throw new RuntimeException("본인 인증 실패");
	}

	/* 
	 * [ 입주민 회원 정보 조회 ]
	 */
	@Override
	public ResidentVO retrieveResident(MemberVO member) {
		return dao.retrieveResident(member);
	}
}
