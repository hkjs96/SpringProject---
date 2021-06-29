/**
 * @author 이미정
 * @since 2021. 2. 8.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 8.      이미정       최초작성
 * 2021. 2. 13. 	이미정   	employeeVO 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.payment.vo;


import java.util.List;

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
@EqualsAndHashCode(of="payNo")
public class PaymentVO {
	@NotNull (groups = {UpdateGroup.class,DeleteGroup.class})
	private Integer payNo; //급여지급번호
	
	@NotBlank
	@Size(max=4) 
	private String payYear; //년
	
	@NotBlank
	@Size(max=2) 
	private String payMonth; //월
	
	@NotNull 
	@Min(0) 
	private Integer payBase; //기본급
	
	@NotNull 
	@Min(0) 
	private Integer payPlus; //직책수당
	
	@Min(0) 
	private Integer payOvertime; //연장근로수당
	
	@NotNull 
	@Min(0) 
	private Integer payMeal; //식대
	
	@NotNull 
	@Min(0) 
	private Integer payHealth; //건강보험
	
	@NotNull 
	@Min(0) 
	private Integer payPension; //국민연금
	
	@NotNull 
	@Min(0) 
	private Integer payEmployee; //고용보험
	
	@NotNull 
	@Min(0) 
	private Integer payIncometax; //소득세
	
	@NotNull 
	@Min(0) 
	private Integer payLocalIncometax; //지방소득세
	
	@NotBlank
	@Size(max=60) 
	private String memId; //사용자코드
	
	private EmployeeVO employee;
	
	//====예상급여 계산을 위해 DB컬럼에 없는 변수 생성=============================
	
	@Min(0) 
	private Integer payTmpsum; // 급여계
	
	@Min(0) 
	private Integer payDeductsum; // 공제합계
	
	@Min(0) 
	private Integer payRealsum; // 실수령액
	
	private Integer payLastday; // 특정 달 마지막날
	
	private String flag; //table open 상태  여부 확인 flag

	
	
}
