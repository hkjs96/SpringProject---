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
 * 2021. 2. 16.         박지수            구체화
 * 2021. 2. 17.         박지수            VO 변경 ioNo 추가
 * 2021. 2. 17.         박지수            빌더 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.vo;

import java.io.Serializable;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of= {"ioNo"})
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProdDetailVO implements Serializable {
	@NotNull(groups= {UpdateGroup.class})
	private Integer ioNo;	// 등록 순서
	
	@NotBlank
	@Size(max=60) 
	private String prodId; //물품 등록 번호
	@NotBlank
	private String prodIoDate; //사용/구매일자
	@NotNull 
	@Min(0) 
	private Integer prodIoQty; //사용/구매수량
	@NotBlank
	@Size(max=60) 
	private String prodIo; //사용구매구분
	
	private String prodName;	// 물품명 
	private String AptCode;	// 검색용 아파트 코드
	private String prodCode; // 검색용 분류 코드
	private String startDay; // 검색용 시작 날짜
	private String endDay;	// 검색용 끝 날짜
	
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
