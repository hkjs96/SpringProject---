package kr.or.anyapart.maintenancecost.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of="costNo")
public class CostVO implements Serializable {
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer costNo; // 관리비부과일련번호
	@NotBlank
	@Size(max = 60)
	private String memId; // 사용자 코드
	@Size(max = 8)
	private String costDuedate; // 관리비납기일
	@NotBlank
	@Size(max = 4)
	private Integer costYear; // 관리비부과년도
	@NotBlank
	@Size(max = 2)
	private Integer costMonth; // 관리비부과월
	@NotNull
	private Integer costCommon; // 일반관리비
	@NotNull
	private Integer costCleaning; // 청소비
	@NotNull
	private Integer costSecurity; // 경비비
	@NotNull
	private Integer costDisinfect; // 소독비
	@NotNull
	private Integer costElevator; // 승강기유지비
	private Integer costPark; // 주차비
	@NotNull
	private Integer costCommHeat; // 난방공용
	@NotNull
	private Integer costIndvHeat; // 난방전용
	@NotNull
	private Integer costCommHotwater; // 급탕공용
	@NotNull
	private Integer costIndvHotwater; // 급탕전용
	@NotNull
	private Integer costCommElec; // 전기공용
	@NotNull
	private Integer costIndvElec; // 전기전용
	@NotNull
	private Integer costCommWater; // 수도공용
	@NotNull
	private Integer costIndvWater; // 수도전용
	@NotNull
	private Integer costAs; // 수선유지비
	@NotNull
	private Integer costLas; // 장기수선충당금
	@NotNull
	private Integer costCouncil; // 입주자대표회의운영비
	
	private Integer costCommTotal;	// 공동관리비
	private Integer costIndvTotal;	// 개별관리비
	private Integer costTotal;		// 관리비 총합
	private Integer lateFee;		// 연체료
	
	// 전출자 등록시 세대 조회 조건 (이경륜)
	private String resMoveout; // 전출일
	private String dong;
	private String ho;
	private String houseCode;
	
	
	private Integer receiptNo;// 미납내역 receipt에 insert시 selectKey받아오기위함
	private Integer receiptCost;// 미납내역 receipt에 insert시 합계 넣기위함
	private String receiptDate;// 납부 날짜 (없을시  ' - ' <<  존재할 시 납부한 날짜 ) 
	private String receiptMethod; //납부 방법
	
	//미납 여부 확인
	private String receiptYn;
	
	// 남은 날짜 수 (costDuedate - sysdate)
	private Integer count;
	// 남은 날짜 수 (연체된 날짜 - sysdate)
	private Integer newcount;
	// 날짜 순번
	private Integer rnum;
	// 해당 날짜 평균 관리비 
	private Double costAvg;
	// 동일 동 관리비 평균
	private Double sameAreaAvg;
	private String apartCode;
	//에너지 사용량 동일 면적 비교 평균
	private Double sameEngAreaAvg;
	
	// 관리비 조회때 필요한 컬럼 (이경륜)
	private String houseArea;	// 세대면적
	private String resName;		// 세대주명
	
	private String dongStart;	// 전체: 0000
	private String dongEnd;		// 전체: 9999
	private String hoStart;		// 전체: 0000
	private String hoEnd;		// 전체: 9999
	
	private List<HouseVO> dongList;
	private List<HouseVO> hoList;
	
	// 관리비 부과 산출할때 필요 (이경륜)
	@Size(max=5) 
	private String aptCode; //아파트코드
	private String moveinHouseArea;	// 입주된 주거면적
	private String aptHeat;			// 아파트 난방방식
	
	// 세대별 요금 보여줄때 필요 (이경륜)
	private Integer carCnt; // 차량수
	private Integer indvHeat; //난방검침량
	private Integer indvHotwater; //급탕검침량
	private Integer indvWater; //수도검침량
	private Integer indvElec; //전기검침량
	
	private Integer costCommTotalBySpace; // 당월 공용관리비 면적별 부과금액
	private String costType; // 일반관리비,청소비,소독비 종류...
	
	private String resType; // STAY(기입주) / IN (전입) / OUT(전출)
	private Integer lateDayCnt; // 연체일수
	private Integer costTotalPlusLate; // 연체료 합한 총합
	
	private Integer commNo; // 공동검침번호: 부과처리 후 공동검침 플래그 변경용
	
	private String costDuedateStart;		// 대시보드용
	private String costDuedateEnd; 			// 대시보드용
	private String costDuedateEndConnect; 	// 대시보드용
}
