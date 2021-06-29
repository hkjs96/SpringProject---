/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.    이경륜     	  최초작성
 * 2021. 3. 04.    박지수     	 memNick 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.resident.vo;

import java.util.List;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.car.vo.CarVO;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.receipt.vo.ReceiptVO;
import kr.or.anyapart.stereotype.ExcelProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of="memId")
@ToString
@ExcelProperties({"dong","ho","houseArea","memId","resName","resHp","resTel","resMail","resBirth","resJob","moveYn","resMovein"})
@AllArgsConstructor
@Builder
public class ResidentVO {
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 60)
	private String memId; // 사용자 코드
	@Size(max = 17)
	private String houseCode; // 세대코드
	@NotBlank
	@Size(max = 60)
	private String resName; // 세대주명
	@NotBlank(message="ㅋㅋ")
	@Size(max = 11)
	private String resHp; // 핸드폰 번호
	@NotBlank
	@Size(max = 11)
	private String resTel; // 비상연락처
	@Size(max = 40)
	@NotBlank
	@Email(message="메일누락")
	private String resMail; // 이메일
	private String resBirth; // 생년월일
	@Size(max = 60)
	private String resJob; // 직업
	@NotBlank
	private String resMovein; // 입주일
	private String resMoveout; // 전출일
	
	// 리스트에 보여줄 추가 컬럼
	private Integer rnum;
	private String dong;
	private String ho;
	private String houseArea;
	
	// 검색조건용
//	private String houseCodeStart;
//	private String houseCodeEnd;
	
	private String dongStart;	// 전체: 0000
	private String dongEnd;		// 전체: 9999
	private String hoStart;		// 전체: 0000
	private String hoEnd;		// 전체: 9999
	
	private String resMoveinStart;
	private String resMoveinEnd;
	
	private Integer resCarCount;// 보유 차량 수  

	private String resMoveoutStart;
	private String resMoveoutEnd;
	
	private String moveYn;		// 0: 전체, 1:입주, 2:미입주
	private String sortType;	// 0: housecode, 1: 최신순, 2: 과거순
	
	private String aptCode;
	
	
	private List<CarVO> carList;		 // 차량내역
	private List<ReceiptVO> receiptList; // 수납내역
	
	private String memNick;	// 회원 닉네임
}
