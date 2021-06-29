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
 * 2021. 3. 01.         박지수            빌더 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.employee.vo;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.payment.dao.PaymentDAO;
import kr.or.anyapart.payment.vo.PaymentVO;
import kr.or.anyapart.vo.MemberVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of="memId")
@Builder
public class EmployeeVO implements Serializable{
	@NotBlank(groups={DeleteGroup.class, UpdateGroup.class})
	@Size(max = 60)
	private String memId; // 사용자 코드
	@NotBlank
	@Size(max = 5)
	private String aptCode; // 아파트코드
	@NotBlank
	@Size(max = 60)
	private String empName; // 사원명
	@NotBlank
	@Size(max = 40)
	private String empMail; // 이메일
	@NotBlank
	@Size(max = 11)
	private String empHp; // 핸드폰번호
	@NotBlank
	@Size(max = 5)
	private String empZip; // 우편번호
	@NotBlank
	@Size(max = 60)
	private String empAdd1; // 주소
	@NotBlank
	@Size(max = 60)
	private String empAdd2; // 상세주소
	@NotBlank
	@Size(max = 17)
	private String empAcct; // 계좌번호
	@NotBlank
	@Size(max = 60)
	private String positionCode; // 직책코드
	@Size(max = 7)
	private String empBirth; // 생년월일
	@NotBlank
	@Size(max = 11)
	private String empTel; // 자택번호
	private String empStart; // 입사일
	private String empEnd; // 퇴사일
	
	private String empOff; //휴가일수
	
	@NotBlank
	@Size(max=15) private String empBank; //급여계좌은행명
	
	//검색조건을 위한 컬럼
	private String searchStartS;
	private String searchStartE;
	private String searchEndS;
	private String searchEndE;
	private String empRetire;
	
	private String empImg;
	private MultipartFile empImage;
	
	public void setEmpImage(MultipartFile empImage) {
		if(empImage!=null && !empImage.isEmpty()) {
			this.empImage = empImage;
			this.empImg = UUID.randomUUID().toString();
		}
	}
	
	public void saveToEmpImg(File saveFolder) throws IOException {
		if(empImage!=null) {
			empImage.transferTo(new File(saveFolder, empImg));
		}
	}
	
	private List<LicenseVO> licenseList;
	private String[] licCodes;
	private String[] licDates;
	private List<MultipartFile> licImages;
	
	
	public void setLicImages(List<MultipartFile> licImages) throws IOException {
		this.licImages = licImages;
		if(licCodes==null && licDates==null && licImages==null) return;
		else {
			int codeSize = licCodes==null?0:licCodes.length;
			int dateSize = licDates==null?0:licDates.length;
			int imageSize = licImages==null?0:licImages.size();
			if((codeSize!=dateSize)||(codeSize!=imageSize)) {
				throw new IllegalArgumentException("자격증 사본이나 취득일 정보 누락");
			}
//			for(int i=0; i<licImages.size(); i++) {
//				licImgs.add(UUID.randomUUID().toString());
//			}
//			
		}
	}
	
	public void saveToEmpLic(File saveFolder) throws IOException {
		if(licImages!=null) {
			for(int i=0; i<licImages.size(); i++) {
				licImages.get(i).transferTo(new File(saveFolder, licenseList.get(i).getLicImg()));
			}
		}
	}

	private String[] deleteLicCodes;
	
	private MemberVO member;
	
	private PositionVO position;

	
}
