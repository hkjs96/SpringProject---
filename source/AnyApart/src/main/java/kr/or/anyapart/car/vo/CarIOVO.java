/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.    이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.car.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of="carIoSeq")
public class CarIOVO implements Serializable {
	@NotNull
	private long carIoSeq; // 입출차일련번호
	@NotBlank
	@Size(max = 60)
	private String carNo; // 차량번호
	@NotBlank
	@Size(max = 60)
	private String memId; // 사용자 코드
	private String carIoDate; // 입출차일시
	@Size(max = 1)
	private String carIochk; // 입출차 여부
	
	private String year;//년도
	private String month;// 월
	private String day;// 일
	private String dong;// 동
	private String ho;//호
	private String carType;// 차량명
	private String carSize; // 차량 크기
	private String carCodeNAME; // 목적 코드
	private String carIoHh; //시
	private String carIoMi; // 분
	private String aptCode;
	
}
