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
package kr.or.anyapart.approval.draft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.approval.vo.ApprovalLineVO;
import kr.or.anyapart.approval.vo.ApprovalVO;
import kr.or.anyapart.approval.vo.DraftVO;
import kr.or.anyapart.approval.vo.LineDetailVO;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.vo.CodeVO;

@Repository
public interface DraftDAO {

	public List<CodeVO> selectTaskCodeList();

	public List<AccountVO> selectAcctList(String aptCode);

	public List<CodeVO> selectAppCodeList();

	public List<EmployeeVO> selectAppEmpList(EmployeeVO employee);

	public DraftVO selectDraftBasicInfo(EmployeeVO employee);

	public int insertAppovalLine(DraftVO draftVO);

	public int selectLastAppLineId();

	public int insertDraft(DraftVO draftVO);

	public LineDetailVO selectMinLineDeId(DraftVO draftVO);

	public int insertApproval(ApprovalVO appVO);

	public int insertLineDetail(ApprovalLineVO alVO);




}
