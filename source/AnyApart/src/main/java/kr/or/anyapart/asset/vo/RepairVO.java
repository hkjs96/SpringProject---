/**
 * @author 이경륜
 * @since 2021. 1. 28.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.         이경륜            최초작성
 * 2021. 2. 17.         박지수            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.vo;

import java.io.Serializable;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.vo.MemberVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(of="repairNo")
@ToString
public class RepairVO implements Serializable{
	@NotBlank(groups={InsertGroup.class})
	@Size(max=60)
	private String prodId; // 물품 등록 번호
	@NotBlank(groups={UpdateGroup.class, InsertGroup.class})
	private String repairDate; // 수리일자
	@NotBlank(groups={UpdateGroup.class, InsertGroup.class})
	@Size(max=200)
	private String repairContent; // 수리내용
	
	@Min(0) @Max(1000000000)
	private Integer repairPrice; // 수리비
	@NotNull(groups={DeleteGroup.class, UpdateGroup.class})
	private Integer repairNo; // 등록순서
	
	private String aptCode;	// 해당 아파트 단지 것만 조회용 아파트 코드 
	private String startDay; // 검색용 시작 날짜
	private String endDay;	// 검색용 끝 날짜
	private String prodName;	// 검색용 물품명 
	private String prodCode;	// 검색용 물품 코드
	
	private MemberVO member; 	// 삭제 확인용
	
	public void checkDay() throws ParseException {
		LocalDate date1 = LocalDate.parse(startDay, DateTimeFormatter.ISO_DATE);
		LocalDate date2 = LocalDate.parse(endDay, DateTimeFormatter.ISO_DATE);
		
		if(!date1.equals(date2) && !date1.isBefore(date2)){
			String tmp = startDay;
			startDay = endDay;
			endDay = tmp;
		}
	}
}
