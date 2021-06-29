package kr.or.anyapart.car.vo;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of="carNo")
@ToString
public class EnrollcarVO  implements Serializable{
	@NotBlank(groups = InsertGroup.class)
	@Size(max=60) 
	private String memId; //사용자 코드
	@NotBlank(groups = UpdateGroup.class)
	@Size(max=60) 
	private String carNo; //차량번호
	@Size(max=7) 
	private String applyDate; //등록신청일
	@Size(max=7) 
	private String approvalDate; //등록승인일
	@Size(max=60) 
	private String enrollFlag; //상태코드
	
	private String carCode; // 입주민/방문 분류코드
	private String carType; // 차종
	private String carSize; //차량 크기
	private String dong; //동
	private String ho; //호
	private String resName; // 소유자 이름
	private String carYn;//신청 여부
	private String carCodeName;//입주민/방문 분류코드 이름
	private String type;// 검색 조건
	private String apartCode;
	private Integer total;
	private Integer resident;
	private Integer guest;
	
	
}
