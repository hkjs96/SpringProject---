/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.    이경륜     	  최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.remodelling.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.vo.BaseVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="rmdlNo")
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class RemodellingVO implements Serializable{
	@NotNull(groups= {UpdateGroup.class})
	@Min(0)
	private Integer rmdlNo; // 공사신고글번호
	@NotBlank(groups= {UpdateGroup.class})
	@Size(max = 1)
	private String rmdlYn; // 확인여부
	@NotBlank(groups= {InsertGroup.class})
	@Size(max = 800)
	private String rmdlTitle; // 제목
	@NotBlank
	@Size(max = 60)
	private String memId; // 사용자 코드
	@NotBlank(groups= {InsertGroup.class})
	private String rmdlStart; // 시작일
	@NotBlank(groups= {InsertGroup.class})
	private String rmdlEnd; // 종료일
	@NotBlank(groups= {UpdateGroup.class})
	private String rmdlDate; // 신고일자
	
	private String house_code;
	private String dong;
	private String ho;
	private String aptCode;
	
	private String cDate1; //캘린더 조회 날짜 1
	private String cDate2;  //캘린더 조회 날짜 2
	
	private Integer waitingCnt; //승인 대기 건 수
	
	private String memNick;
}
