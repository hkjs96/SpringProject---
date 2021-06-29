/**
 * @author 박정민
 * @since 2021. 2. 2.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 2.       박정민         최초작성
 * Copyright (c) 2021. 2. 2. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of="schdNo")
@ToString(exclude= {"schdContent"})
@Builder
public class ScheduleVO {
	@NotNull(groups= {DeleteGroup.class, UpdateGroup.class}) 
	@Min(0) 
	private Integer schdNo; //일정번호
	@NotBlank
	@Size(max=15) 
	private String schdType; //일정종류
	@Size(max=100) 
	private String schdTitle; //일정제목
	@Size(max=200) 
	private String schdContent; //일정내용
	@NotBlank
	@Size(max=20) 
	private String schdStart; //시작일
	@NotBlank
	@Size(max=20) 
	private String schdEnd; //종료일
	@Size(max=5) 
	private String aptCode; //아파트코드
	
	private int applyNo; //신청글번호
}
