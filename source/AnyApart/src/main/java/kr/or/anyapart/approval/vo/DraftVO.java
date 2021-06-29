/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.    이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.approval.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.StringUtils;
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
@ToString(exclude= {"draftContent", "draftFile"})
@EqualsAndHashCode(of="draftId")
@AllArgsConstructor
@NoArgsConstructor
public class DraftVO implements Serializable{
	@NotNull (groups = {UpdateGroup.class,DeleteGroup.class})
	private Integer draftId; // 기안문서번호
	
	@NotBlank
	@Size(max = 60)
	private String taskCode; // 단위업무코드
	
	@NotNull  (groups = {InsertGroup.class})
	private Integer applineId; // 결재선번호
	
	private String draftDate; // 기안일자
	
	private String draftAcct; //지출계좌등록번호
	
	@NotBlank
	@Size(max = 200)
	private String draftTitle; // 제목

	@NotBlank
	@Size(max=4000) 
	private String draftContent; //내용
	
	private String draftFile; // 첨부파일저장경로
	
	@Size(max = 1)
	private String draftDelete; // 삭제여부
	
	@NotBlank
	@Size(max = 60)
	private String memId; // 사용자 코드 -> 기안 시 mem_nick으로 치환해서 데려옴
	
	private String draftWriter; // 삭제 시 memId와 작성자 id 비교하기 위함
	
	private transient List<MultipartFile> draftFiles;
	
	public void setDraftFiles(List<MultipartFile> draftFiles) {
		if(draftFiles==null || draftFiles.size()==0) return;
		this.draftFiles = draftFiles;
		this.draftAttList = new ArrayList<>();
		for(MultipartFile tmp : draftFiles) {
			if(StringUtils.isBlank(tmp.getOriginalFilename())) continue;
			draftAttList.add(new DraftAttVO(tmp));
		}
	}
	private transient List<DraftAttVO> draftAttList;
	
	private int startAttNo;
	
	private int[] delAttNos; // 파일지울때
	
	private Integer rnum; // rnum

	//검색조건을 위한 컬럼
	private String searchStart;
	private String searchEnd;
	
	private ApprovalVO approval; //1:1관계
	
	
}
