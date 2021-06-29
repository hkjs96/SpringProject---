/**
 * @author 박지수
 * @since 2021. 2. 16.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 16.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.buy.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.asset.buy.dao.ProdDetailDAO;
import kr.or.anyapart.asset.vo.ProdDetailVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class ProdDetailServiceImpl implements ProdDetailService {

	@Inject
	private ProdDetailDAO dao;
	
	/* 
	 * [레코드 수 조회]
	 */
	@Override
	public int countDetail(PagingVO<ProdDetailVO> paging) {
		return dao.countDetail(paging);
	}

	/* 
	 * [구매/수리 내역 조회]
	 */
	@Override
	public List<ProdDetailVO> retrieveDetailList(PagingVO<ProdDetailVO> paging) {
		return dao.retrieveDetailList(paging);
	}

	/* 
	 * [구매/수리 내역 저장]
	 */
	@Transactional
	@Override
	public void createDetail(List<ProdDetailVO> detailList) {
		try {
			int rowcnt = dao.insertDetail(detailList);
			if( rowcnt == 0 ) throw new CustomException("구매/사용 내역 등록에 실패함");
			for (ProdDetailVO prodDetail : detailList) {
				dao.updateProdQty(prodDetail);
			}
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [구매/수리 내역 수정]
	 */
	@Transactional
	@Override
	public void modifyDetail(ProdDetailVO prodDetail) {
		try {
			ProdDetailVO tmpDetail = dao.retrieveDetail(prodDetail);
			prodDetail.setProdId(tmpDetail.getProdId());
			int rollbackcnt = dao.rollbackProdQty(tmpDetail);
			int rowcnt = dao.updateDetail(prodDetail);
			rowcnt = dao.updateProdQty(prodDetail);
//			if(rollbackcnt == 0 ) throw new RuntimeException("변경 실패");
//			if(rowcnt == 0) throw new RuntimeException("변경 실패");
//			if(rowcnt == 0) throw new RuntimeException("변경 실패");
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [구매/수리 내역 삭제]
	 */
	@Override
	public void removeDetail(int ioNo) {
		ProdDetailVO remove = ProdDetailVO.builder()
								.ioNo(ioNo)
								.build();
		try {
			remove = dao.retrieveDetail(remove);
			dao.rollbackProdQty(remove);
			dao.deleteDetail(ioNo);
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}
	}

}
