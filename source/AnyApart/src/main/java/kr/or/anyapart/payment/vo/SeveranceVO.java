/**
 * @author 이미정
 * @since 2021. 2. 22.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 22.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.payment.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.employee.vo.EmployeeVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of="svrcNo")
public class SeveranceVO {
	
	@NotNull (groups= {UpdateGroup.class, DeleteGroup.class} )
	@Min(0) 
	private Integer svrcNo;
	
	private String svrcDate;
	
	@NotNull 
	@Min(0) 
	private Integer svrcCost;
	
	@NotBlank
	@Size(max=50) 
	private String svrcComment;
	
	@NotBlank
	@Size(max=60) 
	private String memId;
	
	//==계산을 위해 추가한 DB에는 없는 변수=======================
	
	private int rnum; 
	
	private Integer svrcThreetotal; //3개월간 임금총액

	private Integer svrcPayfortime; //시간당 통상임금
	
	private Integer svrcPayforday; //일 통상임금
	
	private Integer svrcNotuseoff; //연차수당
	
	private Integer svrcNotuseoffplus; //연차수당 가산액
	
	private Integer svrcAvgforday; //1일 평균임금
	
	private EmployeeVO employee; // 직원. 1:1관계

	private String searchSvrcS; //검색조건 퇴직금 지급일 시작
	
	private String searchSvrcE; //검색조건 퇴직금 지급일 끝
}
