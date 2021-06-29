/**
 * @author 이경륜
 * @since 2021. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 27.    이경륜           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.vo;

import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class MemberWrapper extends User{
	public MemberWrapper(MemberVO realMember) {
		super(realMember.getMemId(), realMember.getMemPass(),
				!"Y".equals(realMember.getMemDelete()),
				!"Y".equals(realMember.getMemDelete()),
				!"Y".equals(realMember.getMemDelete()),
				!"Y".equals(realMember.getMemDelete()),
				Collections.singleton(new SimpleGrantedAuthority(realMember.getMemRole())));
		this.realMember = realMember;
	}

	
//	private static Collection<GrantedAuthority> makeAuthorities(List<String> authority){
//		Set<GrantedAuthority> authorities = new HashSet<>();
//		for(String role : authority) {
//			authorities.add(new SimpleGrantedAuthority(role));
//		}
//		return authorities;
//	}
//	
//	public MemberWrapper(MemberVO realMember) {
//		super(realMember.getMemId(), realMember.getMemPass(), 
//				!"Y".equals(realMember.getMemDelete()),
//				!"Y".equals(realMember.getMemDelete()),
//				!"Y".equals(realMember.getMemDelete()),
//				!"Y".equals(realMember.getMemDelete()),
//				makeAuthorities(realMember.getAuthority()));
//		this.realMember = realMember;
//	}
	
	private MemberVO realMember;
	public MemberVO getRealMember() {
		return realMember;
	}
	
}
