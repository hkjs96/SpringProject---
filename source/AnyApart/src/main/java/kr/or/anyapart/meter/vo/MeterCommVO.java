/**
 * @author 박정민
 * @since 2021. 2. 17.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 17.    박정민            최초작성
 * 2021. 2. 24	   이경륜		관리비 부과처리에 필요한 변수추가
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
@ToString(of="commNo")
@EqualsAndHashCode
public class MeterCommVO {
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class}) 
	@Min(0) 
	private Integer commNo; //공동검침기록번호
	@NotNull 
	@Min(0) 
	private Integer commYear; //검침년도
	@NotNull
	@Min(0) 
	private Integer commMonth; //검침월
	@NotNull 
	@Min(0) 
	private Integer commHeat; //난방검침량
	@NotNull 
	@Min(0) 
	private Integer commHotwater; //급탕검침량
	@NotNull 
	@Min(0)
	private Integer commWater; //수도검침량
	@NotNull 
	@Min(0) 
	private Integer commElec; //전기검침량
	@NotBlank
	@Size(max=5) 
	private String aptCode; //아파트코드
	
	private Integer rnum;
	
	
	private String startYear;
	private String startMonth;
	private String endYear;
	private String endMonth;
	private String meter;
	private String sort;
	
	/*
	 * 이경륜: 관리비 부과처리시 필요해서 추가함
	 */
	private Integer commHeatCost;		// 난방검침량 기준 총 발생금액
	private Integer commHotwaterCost;	// 급탕검침량 기준 총 발생금액
	private Integer commWaterCost;		// 수도검침량 기준 총 발생금액
	private Integer commElecCost;		// 전기검침량 기준 총 발생금액
	
	private Integer commHeatCostBySpace;		// 난방검침량 기준 총 발생금액 면적당 부과금액
	private Integer commHotwaterCostBySpace;	// 급탕검침량 기준 총 발생금액 면적당 부과금액
	private Integer commWaterCostBySpace;		// 수도검침량 기준 총 발생금액 면적당 부과금액
	private Integer commElecCostBySpace;		// 전기검침량 기준 총 발생금액 면적당 부과금액
	
	private String commFlag; // 부과여부
//	통계
	private String heatSum; 
	private String hotWaterSum;
	private String waterSum;
	private String elecSum;
	
	private Integer totalCnt; //전체검침수
	
}

