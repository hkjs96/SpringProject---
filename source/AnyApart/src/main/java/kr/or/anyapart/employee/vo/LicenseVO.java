/**
 * @author 이미정
 * @since 2021. 2. 2.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 2.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.employee.vo;


import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of= {"memId", "licCode"})
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LicenseVO {

	public LicenseVO(int licNo, String licCode, String licDate, String licImg, String memId) throws IOException {
		this.licNo = licNo;
		this.licCode = licCode;
		this.licDate = licDate;
		this.licImg = licImg;
		this.memId = memId;
	}
	
	private Integer licNo;
	private String memId;
	private String licCode;
	private String licName;
	private String licDate;
	private String licImg;
	private MultipartFile licImage;
	

}

