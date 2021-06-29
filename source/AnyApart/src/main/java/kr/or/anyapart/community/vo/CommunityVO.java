/**
 * @author 이경륜
 * @since 2021. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 27.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.community.vo;

import java.io.Serializable;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
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
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of="cmntNo")
@ToString(exclude="cmntDesc")
@Builder
public class CommunityVO implements Serializable{
	@NotNull(groups= {UpdateGroup.class})
	private Integer cmntNo; // 커뮤니티시설번호
	@NotBlank(message="시설 분류를 정해주세요")
	@Size(max = 60)
	private String cmntCode; // 커뮤니티시설 분류 코드
	@NotBlank(message="15자 이내")
	@Size(max = 60)
	private String cmntName; // 커뮤니티시설명
	
	@NotNull(message="숫자 4자리만 입력가능합니다.")
	@Max(9999)
	@Min(1)
	private Integer cmntSize; // 시설 규모
	
	@NotNull(message="숫자 4자리만 입력가능합니다.")
	@Max(9999)
	@Min(1)
	private Integer cmntCapa; // 수용인원
	
	@NotNull(message="숫자 4자리만 입력가능합니다.")
	@Max(9999)
	@Min(1)
	private Integer cmntLimit; // 예약제한인원
	
	@NotBlank
	@Size(max = 4)
	@Pattern(regexp = "[0-9]{1,4}", message = "1~4자리의 숫자만 입력가능합니다")
	private String cmntOpen; // 여는시간
	@NotBlank
	@Size(max = 4)
	@Pattern(regexp = "[0-9]{1,4}", message = "1~4자리의 숫자만 입력가능합니다")
	private String cmntClose; // 닫는시간
	private transient String cmntDesc; // 시설 설명
	@NotBlank
	@Size(max = 5)
	private String aptCode; // 아파트코드
}
