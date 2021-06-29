/**
 * @author 이경륜
 * @since 2021. 2. 13.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 13.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.receipt.service;

import java.util.List;

import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.receipt.vo.ReceiptVO;
import kr.or.anyapart.vo.PagingVO;

public interface ReceiptService {
	/**
	 * [전출관리-전출등록] 전출자 상세조회시 수납내역 레코드수
	 * @param pagingVO
	 * @return 레코드 수
	 * @author 이경륜
	 */
	public int retrieveMoveoutReceiptCount(PagingVO<ReceiptVO> pagingVO);
	/**
	 * [전출관리-전출등록] 전출자 상세조회시 수납내역 리스트
	 * @param pagingVO
	 * @return 리스트
	 * @author 이경륜
	 */
	public List<ReceiptVO> retrieveMoveoutReceiptList(PagingVO<ReceiptVO> pagingVO);
	/**
	 * [전출관리-전출등록] 전출자 등록시 미납내역 즉시수납
	 * @param costVO
	 * @return ok, failed, 예외발생시 자동으로 throw됨
	 * @author 이경륜
	 */
	public ServiceResult createUnpaidCostForMoveout(CostVO costVO);
	/**
	 * [수납관리-수납조회] 수납내역 레코드수
	 * @param pagingVO
	 * @return 레코드수
	 * @author 이경륜
	 */
	public int retrievePaidReceiptCount(PagingVO<ReceiptVO> pagingVO);
	/**
	 * [수납관리-수납조회] 수납내역 리스트
	 * @param pagingVO
	 * @return 리스트
	 * @author 이경륜
	 */
	public List<ReceiptVO> retrievePaidReceiptList(PagingVO<ReceiptVO> pagingVO);
	/**
	 * [수납관리-미납조회] 미납내역리스트
	 * @param receiptVO
	 * @return 리스트
	 * @author 이경륜
	 */
	public List<CostVO> retrieveUnpaidReceiptList(ReceiptVO receiptVO);
	/**
	 * [수납관리-미납조회] 미납내역서에 출력할 아파트 관리비수납계좌 리스트
	 * @param receiptVO (aptCode)
	 * @return 리스트
	 * @author 이경륜
	 */
	public List<AccountVO> retrieveBillingAccountList(ReceiptVO receiptVO);
	/**
	 * [수납관리-미납조회] 미납내역 여러건 즉시수납
	 * @param receiptVO담은 list
	 * @return OK, FAILED
	 * @author 이경륜
	 */
	public ServiceResult createUnpaidReceipt(List<ReceiptVO> receiptList);
}
