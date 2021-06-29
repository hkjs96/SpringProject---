/**
 * @author 이미정
 * @since 2021. 2. 24.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 24.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.approval.draft.service;

import java.util.List;

import kr.or.anyapart.approval.vo.DraftVO;
import kr.or.anyapart.approval.vo.LineDetailVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.vo.EmployeeVO;

public interface DraftService {


	DraftVO retrieveDraftBasicInfo(EmployeeVO employee);

	List<EmployeeVO> retrieveAppEmpList(EmployeeVO employee);

	ServiceResult createDraft(DraftVO draftVO, LineDetailVO ldVO);

}
