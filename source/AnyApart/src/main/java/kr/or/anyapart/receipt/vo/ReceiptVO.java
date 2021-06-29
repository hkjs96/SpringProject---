package kr.or.anyapart.receipt.vo;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="receiptNo")
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ReceiptVO {
	@NotNull(groups={DeleteGroup.class, UpdateGroup.class})
	private Integer receiptNo; // 수납일련번호
	@NotNull
	private Integer costNo; // 관리비부과일련번호
//	@NotBlank
	@Size(max = 60)
	private String receiptMethod; // 수납방법코드
	@NotNull(groups=InsertGroup.class)
	private Integer receiptCost; // 수납금액
	private String receiptDate; // 수납일
	@Size(max = 1)
	private String receiptYn; // 수납여부
	
	private Integer rnum;
	
	@Size(max = 60)
	private String memId; // 사용자 코드 (검색용)
	
	private Integer costYear;	// 부과연도
	private Integer costMonth;	// 부과월
	
	
	private Integer costCommTotal; // 공동관리비
	private Integer costIndvTotal; // 개별관리비
	
	/**
	 * [수납관리-수납조회] 메뉴 위해 추가함 
	 * @author 이경륜
	 */
	private String dong;
	private String ho;
	private String resName;
	private Integer costTotal;	// 부과금액 총합
	private Integer lateFee;	// 연체료
	private String receiptType; // 납기내, 납기후
	@Size(max=5) 
	private String aptCode; //아파트코드
	
	private String dongStart;	// 전체: 0000
	private String dongEnd;		// 전체: 9999
	private String hoStart;		// 전체: 0000
	private String hoEnd;		// 전체: 9999

	private String receiptDateStart;
	private String receiptDateEnd;
}
