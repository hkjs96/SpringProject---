/**
 * @author 박정민
 * @since 2021. 3. 8.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 3. 8.       박정민         최초작성
 * Copyright (c) 2021. 3. 8. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.meter.vo;

import java.util.List;

import javax.validation.Valid;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MeterIndvListVO {
	@Valid
	List<MeterIndvVO> indvList;
}
