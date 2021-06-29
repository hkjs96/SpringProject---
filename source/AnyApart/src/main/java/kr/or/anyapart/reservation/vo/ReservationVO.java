package kr.or.anyapart.reservation.vo;

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
@EqualsAndHashCode(of="resvNo")
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReservationVO {
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer resvNo; // 예약 번호
	@NotNull(groups= {UpdateGroup.class, InsertGroup.class})
	private String resvDate; // 예약날짜
	@NotBlank(groups= {UpdateGroup.class, InsertGroup.class})
	@Size(max = 4)
	private String resvStart; // 사용시작시간
	@NotBlank(groups= {UpdateGroup.class, InsertGroup.class})
	@Size(max = 4)
	private String resvEnd; // 사용종료시간
	@NotNull(groups= {UpdateGroup.class, InsertGroup.class})
	private Integer resvCnt; // 인원수
	@NotNull(groups= {UpdateGroup.class, InsertGroup.class})
	private Integer cmntNo; // 커뮤니티시설번호
	@NotBlank(groups= {UpdateGroup.class})
	@Size(max = 60)
	private String memId; // 사용자 코드
	
	private String resvTime;	// 예약 시간을 담아서 가져올 변수
	private String cmntCode;	// 예약 리스트에 보여줄 용도의 시설 분류를 담을 변수
	private String cmntName; // 예약 리스트 보여줄 용도의 시설 이름
	private String resName;	// 예약한 사람이름
	private String resHp;	// 예약한 사람 폰번호
	private String aptCode;	// 조회를 위한 아파트 코드  
	
	private Integer resultCnt;	// 프로시저 결과값을 받음
	private String resvLast;	// 지난 예약인지 아닌지 파악하는 플래그용 변수
}
