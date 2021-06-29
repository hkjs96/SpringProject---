/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.    이경륜           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.approval.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of="applineId")
public class ApprovalLineVO implements Serializable{
	@NotNull
	private Integer applineId; // 결재선번호
	@NotBlank
	@Size(max = 60)
	private String memId; // 사용자 코드
	
	//== DB에 없는 컬럼 ========================================
	private List<LineDetailVO> lineDetailList; //결재선상세목록
	
	private int startAppNo;
}
