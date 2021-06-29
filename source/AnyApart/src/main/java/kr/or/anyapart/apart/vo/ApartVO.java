/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.      이경륜       아파트 정보 vo
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.vo;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.UUID;

import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="aptCode")
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ApartVO implements Serializable{
	@NotBlank(groups={DeleteGroup.class, UpdateGroup.class})
	@Size(max = 5)
	private String aptCode; // 아파트코드
	@NotBlank(message="아파트 명을 입력해주세요", groups={InsertGroup.class})
	@Size(max = 200)
	private String aptName; // 아파트명
	@NotBlank(message="우편번호를 입력해주세요" , groups={InsertGroup.class})
	@Size(min=5, max = 5, message="우편번호는 5자리 입니다.")
	private String aptZip; // 우편번호
	@NotBlank(message="아파트 주소를 입력해주세요" , groups={InsertGroup.class})
	@Size(max = 60, message="기본주소는 20자리까지 입력가능합니다.")
	private String aptAdd1; // 기본주소
//	@NotBlank
	@Size(max = 60, message="상세주소는 20자리까지 입력가능합니다.")
	private String aptAdd2; // 상세주소
//	@NotNull
	@Min(0)
	private Integer aptCnt; // 세대수
	@NotBlank(message="난방정책을 선택해주세요")
	@Size(max = 60)
	private String aptHeat; // 난방정책코드
	@NotBlank(message="관리사무소 전화번호를 입력해주세요")
	@Size(min=10, max = 11, message="10~11자리까지 입력가능합니다.")
	@Pattern(regexp="^\\d{2,3}\\d{3,4}\\d{4}$", message="021234567, 03112345678")
	private String aptTel; // 관리사무소 전화번호
	@NotBlank(message="관리사무소장명을 입력해주세요")
	@Size(max = 60, message="최대 20자리까지 가능합니다")
	@Pattern(regexp="^[가-힣]{3,6}?", message="한글만 입력가능합니다.")
	private String aptHead; // 관리소장명
	private String aptStart; // 계약시작일
	private String aptEnd; // 계약만료일
	@Size(max = 16)
	private String aptArea; // 총 주거면적
	@Size(max = 1)
	private String aptDelete; // 활성화여부
	
	private String aptImg; // 아파트프사저장경로
	
	private String codeName; //난방방법
	
	private Integer rnum;// 순서
	
	private MultipartFile aptImage;
	public void setAptImage(MultipartFile aptImage) {
		if(aptImage!=null  && !aptImage.isEmpty()) {
			this.aptImage = aptImage;
			this.aptImg = UUID.randomUUID().toString();
		}
	}
	
	public void saveTo(File saveFolder) throws IOException {
		if(aptImage!=null) {
			aptImage.transferTo(new File(saveFolder, aptImg));
		}
	}
	
	private String memId;	// 소장 계정
}
