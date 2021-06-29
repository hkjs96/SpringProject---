/**
 * @author 이미정
 * @since 2021. 2. 2.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 2.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.employee.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of="positionCode")
@ToString
public class PositionVO {
	@NotBlank
	@Size(max=60) 
	private String positionCode;
	
	@NotBlank
	@Size(max=60) 
	private String positionName;
	
	@NotNull 
	@Min(0) 
	private Integer positionPay;
	
	@NotNull 
	@Min(0) 
	private Integer positionOff;
}
