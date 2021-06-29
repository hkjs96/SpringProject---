/**
 * @author 박정민
 * @since 2021. 2. 23.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 23.       박정민            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.meter.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@ToString
@EqualsAndHashCode(of="indvNo")
public class MeterIndvVO {
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class}) 
	@Min(0) 
	private Integer indvNo; //개별검침기록번호
	@NotNull 
	@Min(0) 
	private Integer indvYear; //검침년도
	@NotNull 
	@Min(0) 
	private Integer indvMonth; //검침월
	private Integer indvHeat; //난방검침량
	private Integer indvHotwater; //급탕검침량
	private Integer indvWater; //수도검침량
	private Integer indvElec; //전기검침량
	@NotBlank
	@Size(max=60) 
	private String memId; //사용자 코드
	
	private Integer rnum; 
	private String houseCode; //세대 코드
	private String aptCode; //아파트코드
	private String dong; 
	private String ho; 
	
//	검색
	private String startYear;
	private String startMonth;
	private String endYear;
	private String endMonth;
	private String meter;
	private String sort;
	private String startDong;
	private String endDong;
	private String startHo;
	private String endHo;
	private String resName;
	
//	통계
	private String heatSum; 
	private String hotWaterSum;
	private String waterSum;
	private String elecSum;
	
//	전월비교
	private String pYear; //전년
	private String pMonth; //전월
	private Integer cHeat; //
	private Integer cHotwater; //
	private Integer cWater; //
	private Integer cElec; //전기비교
	
	private Integer totalCnt; //전체검침수
}
