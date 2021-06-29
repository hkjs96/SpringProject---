/**
] * @author 이경륜
 * @since 2021. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 27.    이경륜           최초작성
 * 2021. 2. 05.    박지수           iD, PW 찾기 위한 이름, 이메일 추가
 * 2021. 2. 06.    박지수           사용자 아파트 코드 추가
 * 2021. 2. 06.    박지수           builder 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude="memPass")
@EqualsAndHashCode(of="memId")
@Builder
public class MemberVO implements Serializable{
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 60)
	private String memId; // 사용자 코드
	@NotBlank(groups= {InsertGroup.class})
	@Size(max = 60)
	private String memNick; // 사용자 별명
	@NotBlank
	@Size(max = 200)
	@Pattern(regexp="^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,12}", groups={UpdateGroup.class} )
	private transient String memPass; // 사용자비밀번호
	@NotBlank(groups= {InsertGroup.class})
	@Size(max = 60)
	private String memRole; // 사용자분류
//	@NotBlank
	@Size(max = 1)
	private String memDelete; // 회원탈퇴여부
	
	private List<String> authority;
	
	
	/*
	 * ID, PW 찾기용
	 */
	private String memName;	// 사용자 이름
	private String memEmail; // 사용자 이메일
	private String aptCode;	// 사용자 소속 아파트 코드
	private String aptName; // 사용자 소속 아파트 이름
	
	// 이경륜: 쿼리수정하면서 지수가 한 코드 주석처리함
//	/**
//	 * @param aptCode the aptCode to set
//	 */
//	public void setMemId(String memId) {
//		this.memId = memId;
//		this.aptCode = memId.substring(0,5);
//		
//	}
	
	
}
