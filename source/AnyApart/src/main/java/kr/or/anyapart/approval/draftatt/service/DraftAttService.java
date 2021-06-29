/**
 * @author 이미정
 * @since 2021. 3. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 3. 3.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.approval.draftatt.service;

import kr.or.anyapart.approval.vo.DraftAttVO;
import kr.or.anyapart.approval.vo.DraftVO;

public interface DraftAttService {
	int processAttaches(DraftVO draft);
	public DraftAttVO download(DraftAttVO param);
	int processDeleteAttatch(DraftVO draft);
}
