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
package kr.or.anyapart.approval.appdocument.service;

import java.util.List;

import kr.or.anyapart.approval.vo.ApprovalVO;
import kr.or.anyapart.approval.vo.DraftVO;
import kr.or.anyapart.approval.vo.LineDetailVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.PagingVO;

public interface AppDocumentService {

	public int retrieveSendingCount(PagingVO<DraftVO> pagingVO);

	public List<DraftVO> retrieveSendingList(PagingVO<DraftVO> pagingVO);

	public DraftVO retrieveDraftInfo(DraftVO param);

	public int retrieveReceptionCount(PagingVO<DraftVO> pagingVO);

	public List<DraftVO> retrieveReceptionList(PagingVO<DraftVO> pagingVO);

	public int retrieveWholeAppCount(PagingVO<DraftVO> pagingVO);

	public List<DraftVO> retrieveWholeAppList(PagingVO<DraftVO> pagingVO);

	public int retrieveAppLineId(DraftVO param);

	public List<LineDetailVO> retrieveLineDatailList(int appLineId);

	public ServiceResult approvalSuccess(DraftVO draftVO);

	public ServiceResult approvalReject(DraftVO draftVO);

	public ServiceResult modifyDraft(DraftVO draft, LineDetailVO ldVO);

	public ServiceResult draftCancel(DraftVO draftVO);

	public ServiceResult draftDelete(DraftVO draftVO);

	public List<DraftVO> retrieveReceptionWaitList(ApprovalVO appVO);

	public ServiceResult modifyReceptionWaitList(LineDetailVO ldVO);
	


	

}
