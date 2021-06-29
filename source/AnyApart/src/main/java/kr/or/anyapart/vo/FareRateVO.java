/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.      이경륜       가격계산 비율 산정표
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of="frId")
@ToString
public class FareRateVO implements Serializable{
	private String frId; // 가격/비율ID
	private Float fr; // 가격/비율값
	private String frContent; // 가격/비율설명
	private String frHowto; // 계산방법
}
