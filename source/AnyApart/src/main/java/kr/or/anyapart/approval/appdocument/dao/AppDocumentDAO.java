/**
 * @author 이미정
 * @since 2021. 2. 25.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 25.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.approval.appdocument.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.approval.vo.ApprovalVO;
import kr.or.anyapart.approval.vo.DraftVO;
import kr.or.anyapart.approval.vo.LineDetailVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface AppDocumentDAO {
	
	public int selectSendingCount(PagingVO<DraftVO> pagingVO);

	public List<DraftVO> selectSendingList(PagingVO<DraftVO> pagingVO);

	public DraftVO selectDraftInfo(DraftVO param);

	public int selectReceptionCount(PagingVO<DraftVO> pagingVO);

	public List<DraftVO> selectReceptionList(PagingVO<DraftVO> pagingVO);

	public int selectWholeAppCount(PagingVO<DraftVO> pagingVO);

	public List<DraftVO> selectWholeAppList(PagingVO<DraftVO> pagingVO);

	public int selectAppLineId(DraftVO param);

	public List<LineDetailVO> selectLineDatailList(int appLineId);

	public int updateToFinalSuccess(LineDetailVO lastldVO);

	public int updateToNextSuccess(LineDetailVO nextldVO);

	public List<LineDetailVO> selectldListForSuccess(int nowApplideid);

	public int updateToFinalSuccess(DraftVO draftVO);

	public int approvalReject(ApprovalVO updateVO);

	public int updateDraft(DraftVO draft);

	public int updateApproval(ApprovalVO appVO);

	public void updateLineDetail(LineDetailVO lineDetailVO);

	public void deleteLineDetail(LineDetailVO lineDetailVO);

	public int selectMaxLinedeld();

	public void addLineDetail(LineDetailVO lineDetailVO);

	public int draftCancel(ApprovalVO updateVO);

	public int draftDelete(DraftVO draftVO);

	public List<DraftVO> selectReceptionWaitList(ApprovalVO appVO);

	public int updateReceptionWaitList(LineDetailVO ldVO);
		


}
