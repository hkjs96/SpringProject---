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

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.receipt.dao.ReceiptDAO;
import kr.or.anyapart.receipt.vo.ReceiptVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class ReceiptServiceImpl implements ReceiptService{

	@Inject
	private ReceiptDAO receiptDAO;
	
	@Override
	public int retrieveMoveoutReceiptCount(PagingVO<ReceiptVO> pagingVO) {
		return receiptDAO.selectMoveoutReceiptCount(pagingVO);
	}

	@Override
	public List<ReceiptVO> retrieveMoveoutReceiptList(PagingVO<ReceiptVO> pagingVO) {
		return receiptDAO.selectMoveoutReceiptList(pagingVO);
	}

	@Override
	public ServiceResult createUnpaidCostForMoveout(CostVO costVO) {
		int cnt = receiptDAO.insertUnpaidCostForMoveout(costVO);
		ServiceResult result = cnt > 0 ? ServiceResult.OK : ServiceResult.FAILED;
		return result;
	}

	@Override
	public int retrievePaidReceiptCount(PagingVO<ReceiptVO> pagingVO) {
		return receiptDAO.selectPaidReceiptCount(pagingVO);
	}

	@Override
	public List<ReceiptVO> retrievePaidReceiptList(PagingVO<ReceiptVO> pagingVO) {
		return receiptDAO.selectPaidReceiptList(pagingVO);
	}

	@Override
	public List<CostVO> retrieveUnpaidReceiptList(ReceiptVO receiptVO) {
		return receiptDAO.selectUnpaidReceiptList(receiptVO);
	}

	@Override
	public List<AccountVO> retrieveBillingAccountList(ReceiptVO receiptVO) {
		return receiptDAO.selectBillingAccountList(receiptVO);
	}

	@Override
	public ServiceResult createUnpaidReceipt(List<ReceiptVO> receiptList) {
		ServiceResult result = ServiceResult.OK;
		int rowcnt = receiptDAO.insertUnpaidReceipt(receiptList);
		if(rowcnt == 0) result = ServiceResult.FAILED;
		return result;
	}

}
