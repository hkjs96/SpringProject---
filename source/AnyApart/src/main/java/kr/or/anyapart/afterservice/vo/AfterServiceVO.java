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

package kr.or.anyapart.afterservice.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup2;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.vo.BaseVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="asNo")
@ToString(exclude= {"asContent"})
@AllArgsConstructor
@NoArgsConstructor
public class AfterServiceVO extends BaseVO implements Serializable{
	@NotNull(groups= {DeleteGroup.class, UpdateGroup.class})
	private Integer asNo; // 수선신청글번호
	@NotBlank(groups= {InsertGroup.class})
	@Size(max = 60)
	private String asCode; // 수선분류코드
	@NotBlank(groups= {InsertGroup.class})
	@Size(max = 60)
	private String asStatus; // 접수상태코드
	@NotBlank(groups= {InsertGroup.class})
	@Size(max = 60)
	private String memId; // 사용자 코드
	@NotBlank(groups= {InsertGroup.class})
	@Size(max = 50)
	private String asTitle; // 제목
	@NotBlank(groups= {InsertGroup.class, UpdateGroup.class})
	@Size(max = 200)
	private String asContent; // 내용
	private String asDate; // 신청일자
	@Size(max=800) 
	private String asComment; //처리내역
	@NotBlank(groups= {InsertGroup2.class})
	@Size(max=15) 
	private String asSchedule; //처리일
	private String asEmployee; //처리담당자
	
	private int rnum;
	private String resName;
	private String memPass;
	private String dong;
	private String ho;  
	private String asStatusName;  //처리상태명
	private String asCodeName;  //분류명
	private String resultStatus;  //처리상태
	private String memNick;  //회원명
	private String aptCode;  
	
	private int schdNo; //일정 번호
	
	private Integer waitingCnt; //승인 대기 건 수
	
}
