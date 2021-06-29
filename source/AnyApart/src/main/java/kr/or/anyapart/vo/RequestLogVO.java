/**
 * @author 이경륜
 * @since 2021. 3. 2.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 3. 2.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RequestLogVO {
	private Integer reqSeq;
	private String reqUser;
	private String reqUrl;
	private String reqDate;
	
	private Integer menuCnt;		// 그래프에 보여줄 카운트
	private String menuName;	// 메뉴이름
	
	private String reqFlag;		// 기간별검색조건
	
}
