
package kr.or.anyapart.servicecompany.vo;

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
@EqualsAndHashCode(of= {"svcId","svcFileNo"})
@ToString(exclude="realFile")
public class ServiceAttachVO implements Serializable{
	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class}) 
	private Integer svcFileNo; //용역파일번호
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max=60) 
	private String svcId; //용역업체ID
	@NotBlank
	@Size(max=60) 
	private String svcFilename; //원본파일명
	@NotBlank
	@Size(max=50) 
	private String svcFile; //저장파일명
	@Size(max=7) 
	private String svcDate; //파일등록일
	@NotBlank
	@Size(max=60) 
	private String svcMime; //파일확장자명
	@NotNull 
	private long svcFilesize; //파일크기
	@Size(max=60) 
	private String svcFancy; //파일팬시크기
	
	
	public ServiceAttachVO(MultipartFile realFile) { // wrapper (adapter)
		this.realFile = realFile;
		this.svcFile = UUID.randomUUID().toString();
		this.svcFilename = realFile.getOriginalFilename();
		this.svcMime = realFile.getContentType();
		this.svcFilesize = realFile.getSize();
		this.svcFancy = FileUtils.byteCountToDisplaySize(realFile.getSize()); 
		
	}

	private transient MultipartFile realFile;
	public void saveTo(File saveFolder) throws IllegalStateException, IOException {
		if(realFile!=null) {
			realFile.transferTo(new File(saveFolder, svcFile));
		}
	}
}
