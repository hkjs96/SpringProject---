/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.   이경륜		       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.approval.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="appId")
@ToString
@NoArgsConstructor
public class ApprovalVO implements Serializable{
	@NotNull
	private Integer appId; // 결재번호
	@NotNull
	private Integer draftId; // 기안문서번호
	@NotNull
	private Integer applinedeId; // 결재선상세번호
	private String appStatus; // 결재상태코드
	private String appDate; // 결재일자
	private String appNowemp; //현재결재자코드
	
}
