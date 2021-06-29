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
 * 2021. 2. 09.         박지수            VO CLASS 작성
 * 2021. 2. 13.         박지수            List 생성
 * 2021. 2. 20.         박지수            detailList, repairList 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="prodId")
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProdVO implements Serializable {
	@NotBlank(groups={DeleteGroup.class, UpdateGroup.class})
	@Size(max=60) 
	private String prodId; //물품 등록 번호
	@Size(max=60) 
	private String prodCode; //물품분류코드
	@NotBlank(groups={InsertGroup.class, UpdateGroup.class})
	@Size(max=60) 
	private String prodName; //물품명
	@NotNull(groups={InsertGroup.class, UpdateGroup.class}) 
	@Min(0) 
	private Integer prodPrice; //물품 가격
	@NotBlank(groups={InsertGroup.class, UpdateGroup.class})
	@Size(max=200) 
	private String prodCompany; //물품 제조사
	@NotNull(groups={InsertGroup.class, UpdateGroup.class})
	@Min(0) 
	private Integer prodQty; //수량
	@NotBlank(groups={UpdateGroup.class})
//	@Size(max=5) 
	private String aptCode; //아파트코드
	
//	private List<ProdVO> prodList;
	
	private List<ProdDetailVO> detailList;
	private List<RepairVO> repairList;
}
