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
 * 2021. 2. 24.    이경륜            관리비부과에 필요한 변수추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.vo;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.InsertGroup;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="houseCode")
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HouseVO implements Serializable{
//	@NotBlank
	@Size(max = 17)
	private String houseCode; // 세대코드
	@NotBlank
	@Size(max = 4)
	private String dong; // 동
	@NotBlank
	@Size(max = 4)
	private String ho; // 호
//	@NotBlank
	@Size(max = 1)
	private String moveYn; // 입주여부
	@NotBlank
	@Size(max = 5)
	private String aptCode; // 아파트코드
	@NotBlank
	@Size(max = 16)
	private String houseArea; // 세대면적
	
	@NotBlank(groups={InsertGroup.class})
	@Size(max = 2)
	private String floor;	// 생성할때 필요한 층
	
	private int resultCnt;	// db에서 성공한 값 가져오기
	
	private Integer totalHouseCnt;	// 전체 세대수
	private Integer moveinHouseCnt;	// 입주 세대수
	private Integer moveoutHouseCnt;// 미입주 세대수
	private String totalHouseArea;	// 전체 주거면적
	private String moveinHouseArea;	// 입주된 주거면적
	private String aptHeat;			// 아파트 난방방식
}
