/**
 * @author 이경륜
 * @since 2021. 2. 13.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 13.    이경륜            최초작성
 * 2021. 3.  1.    이경륜		  수납조회 메뉴에 필요한 메서드
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.receipt.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.receipt.vo.ReceiptVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface ReceiptDAO {
	/**
	 * [전출관리-전출등록] 전출자 상세조회시 수납내역 레코드수
	 * @param pagingVO
	 * @return 레코드 수
	 * @author 이경륜
	 */
	public int selectMoveoutReceiptCount(PagingVO<ReceiptVO> pagingVO);
	/**
	 * [전출관리-전출등록] 전출자 상세조회시 수납내역 리스트
	 * @param pagingVO
	 * @return 리스트
	 * @author 이경륜
	 */
	public List<ReceiptVO> selectMoveoutReceiptList(PagingVO<ReceiptVO> pagingVO);
	/**
	 * [전출관리-전출등록] 전출자 등록시 미납내역 즉시수납
	 * @param costVO
	 * @return &gt; 0,  예외발생시 자동으로 throw됨
	 */
	public int insertUnpaidCostForMoveout(CostVO costVO);
	
	/**
	 * [수납관리-수납조회] 수납내역 레코드수
	 * @param pagingVO
	 * @return 레코드수
	 * @author 이경륜
	 */
	public int selectPaidReceiptCount(PagingVO<ReceiptVO> pagingVO);
	/**
	 * [수납관리-수납조회] 수납내역 리스트
	 * @param pagingVO
	 * @return 리스트
	 * @author 이경륜
	 */
	public List<ReceiptVO> selectPaidReceiptList(PagingVO<ReceiptVO> pagingVO);
	/**
	 * [수납관리-미납조회] 미납내역리스트
	 * @param receiptVO
	 * @return 리스트
	 * @author 이경륜
	 */
	public List<CostVO> selectUnpaidReceiptList(ReceiptVO receiptVO);
	/**
	 * [수납관리-미납조회] 미납내역서에 출력할 아파트 관리비수납계좌 리스트
	 * @param receiptVO (aptCode)
	 * @return 리스트
	 * @author 이경륜
	 */
	public List<AccountVO> selectBillingAccountList(ReceiptVO receiptVO);
	/**
	 * [수납관리-미납조회] 미납내역 여러건 즉시수납
	 * @param receiptVO담은 list
	 * @return 성공시 0보다큼
	 * @author 이경륜
	 */
	public int insertUnpaidReceipt(List<ReceiptVO> receiptList);
}
