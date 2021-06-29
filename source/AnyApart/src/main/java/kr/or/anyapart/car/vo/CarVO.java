/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.      이경륜        최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.car.vo;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of="carNo")
@ToString
public class CarVO implements Serializable{
	@NotBlank(groups=InsertGroup.class)
	@Size(max = 60)
	private String carNo; // 차량번호
	@Size(max = 60)
	private String memId; // 사용자 코드
	@Size(max = 60)
	private String carCode; // 입주민/방문분류코드
	@Size(max = 60)
	private String carType; // 차종
	@NotBlank(groups=InsertGroup.class)
	private String carSize; //차량 크기
	private String carSizeName;
	private String carCodeName;
	private Integer ioseq;
	private String carIochk;
}
