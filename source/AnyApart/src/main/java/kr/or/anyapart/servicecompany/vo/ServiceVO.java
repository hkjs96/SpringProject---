package kr.or.anyapart.servicecompany.vo;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.stereotype.ExcelProperties;
import kr.or.anyapart.vo.BaseVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "svcId",callSuper=true)
@ToString(exclude= {"svcFile","attachList"})
@AllArgsConstructor
@NoArgsConstructor
@ExcelProperties({"svcRum","svcName","svcCode","svcStart","svcEnd","svcDeposit"})
@Builder
public class ServiceVO extends BaseVO{
	@NotBlank(groups = DeleteGroup.class)
	@Size(max = 60)
	private String svcId; // 용역업체ID
	private String svcStart; // 계약시작일
	private String svcEnd; // 계약만료일
	@NotNull
	private String svcDeposit; // 계약금
	@NotBlank(groups = InsertGroup.class)
	@Size(max = 5)
	private String aptCode; // 아파트코드
	@NotBlank(groups = InsertGroup.class)
	@Size(max = 60)
	private String svcCode; // 용역업종코드
	private String reSvccode;
	@NotBlank(groups = InsertGroup.class)
	@Size(max = 200)
	private String svcName; // 업체명
	@NotBlank(groups = InsertGroup.class)
	@Size(max = 5)
	private String svcZip; // 업체 우편번호
	@NotBlank
	@Size(max = 60)
	private String svcAdd1; // 업체주소
	@Size(max = 60)
	private String svcAdd2; // 업체주소2
	@NotBlank(groups = InsertGroup.class)
	@Size(max = 11)
	private String svcTel; // 업체 연락처
	@Size(max = 60)
	private String svcHead; // 업체 대리인
	@Size(max = 11)
	private String svcHeadTel; // 업체 대리인 연락처
	@NotBlank
	@Size(max = 60)
	private String svcBank; // 은행코드
	private String reSvcbank;
	@NotBlank
	@Size(max = 17)
	private String svcAcct; // 계좌번호
	
	private String aptName;// 아파트 명
	
	private Integer svcRum;
	
	
	private transient List<MultipartFile> svcFile;
	
	public void setSvcFile(List<MultipartFile> svcFile) {
		if(svcFile==null || svcFile.size()==0) return;
		this.svcFile = svcFile;
		this.attachList = new ArrayList<>();
		for(MultipartFile tmp : svcFile) {
			if(StringUtils.isBlank(tmp.getOriginalFilename())) continue;
			attachList.add(new ServiceAttachVO(tmp));
		}
	}
	
	private transient List<ServiceAttachVO> attachList;
	
	private int startAttNo;
	private int[] delAttNos; // 파일지울때
	
	private String svcDel;
}
