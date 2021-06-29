/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.    이경륜		       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.approval.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = { "applinedeId" })
@NoArgsConstructor
@ToString
public class LineDetailVO implements Serializable{
	@NotNull
	private Integer applinedeId; // 결재선상세번호
	@NotNull
	private Integer applineId; // 결재선번호
	@NotBlank
	@Size(max = 60)
	private String appCode; // 결재방법코드
	private Integer appOrder; // 결재우선순서
	@NotBlank
	@Size(max = 60)
	private String memId; // 사용자 코드 (결재선 내 결재자코드)
	@NotNull
	private String appYn; // 수신여부
	
	
	//== DB에 없는 컬럼 =======================
	private String lineMemId; // 기안문 작성 시 결재선 내 결재자코드 
	
	private Integer rnum;
	

	
	
	
}
