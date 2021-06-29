/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.    이경륜           최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.vo;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.UUID;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.io.FileUtils;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of= {"boNo","attSn"})
@ToString(exclude="realFile")
public class AttachVO implements Serializable{
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer boNo; // 게시글 번호
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer attSn; // 파일순번
	@NotBlank
	@Size(max = 60)
	private String attSavename; // 파일저장명
	@NotBlank
	@Size(max = 60)
	private String attFilename; // 파일원본명
	@NotNull
	private long attFilesize; // 파일크기
	@NotBlank
	@Size(max = 60)
	private String attMime; // 파일확장자
	@Size(max = 60)
	private String attFancy; // 파일팬시크기
	
	public AttachVO(MultipartFile realFile) { // wrapper (adapter)
		this.realFile = realFile;
		this.attSavename = UUID.randomUUID().toString();
		this.attFilename = realFile.getOriginalFilename();
		this.attMime = realFile.getContentType();
		this.attFilesize = realFile.getSize();
		this.attFancy = FileUtils.byteCountToDisplaySize(realFile.getSize()); 
	}

	private transient MultipartFile realFile;
	public void saveTo(File saveFolder) throws IllegalStateException, IOException {
		if(realFile!=null) {
			realFile.transferTo(new File(saveFolder, attSavename));
		}
	}
}
