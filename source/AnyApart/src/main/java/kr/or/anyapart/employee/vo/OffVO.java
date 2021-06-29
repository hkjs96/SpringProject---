/**
 * @author 이미정
 * @since 2021. 2. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 10.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.employee.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.vo.CodeVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of="offNo")
public class OffVO implements Serializable{
	@NotNull (groups={DeleteGroup.class, UpdateGroup.class})
	@Min(0) 
	private Integer offNo; //휴가번호
	
	@NotBlank
	@Size(max=60) 
	private String offCode; //휴가분류번호
	
	@NotBlank (groups={InsertGroup.class})
	@Size(max=800) 
	private String offContent; //휴가내용
	
	private String offStart; //휴가시작일
	
	private String offEnd; //휴가종료일
	
	private String offUse; //사용 휴가일수
	
	private String offRemain; //잔여 휴가일수
	
	@NotBlank (groups={InsertGroup.class})
	@Size(max=60) 
	private String memId; //사용자 코드
	
	private EmployeeVO employee;
	
	private PositionVO position;
	
	private CodeVO codeVO;
	
	private String searchOffS; //검색 조건 휴가시작일
	
	private String searchOffE; //검색 조건 휴가종료일
	
}
