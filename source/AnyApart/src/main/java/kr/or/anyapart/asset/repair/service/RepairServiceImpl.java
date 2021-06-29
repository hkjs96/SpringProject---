/**
 * @author 박지수
 * @since 2021. 2. 17.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 17.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.repair.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.asset.repair.dao.RepairDAO;
import kr.or.anyapart.asset.vo.ProdDetailVO;
import kr.or.anyapart.asset.vo.RepairVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class RepairServiceImpl implements RepairService {

	@Inject
	private RepairDAO dao;
	
	/* 
	 * [수리이력 레코드 수 조회]
	 */
	@Override
	public int countRepair(PagingVO<RepairVO> paging) {
		return dao.countRepair(paging);
	}

	/* 
	 * [수리이력 리스트 조회]
	 */
	@Override
	public List<RepairVO> retrieveRepairList(PagingVO<RepairVO> paging) {
		return dao.retrieveRepairList(paging);
	}

	/* 
	 * [수리이력 등록]
	 */
	@Override
	public void createRepair(RepairVO repair) {
		try {
			int rowcnt = dao.insertRepair(repair);
			if( rowcnt == 0 ) throw new CustomException("수리 이력 등록에 실패함");
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [수리이력 변경]
	 */
	@Override
	public void modifyRepair(RepairVO prodRepair) {
		try {
			int rowcnt = dao.updateRepair(prodRepair);
//			if(rowcnt == 0 ) throw new RuntimeException("변경 실패");
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}

	}

	/* 
	 * [수리이력 삭제]
	 */
	@Override
	public void removeRepair(RepairVO repair) {
		int rowcnt = dao.deleteCheck(repair);
		if(rowcnt == 0 ) throw new RuntimeException("인가 되지 않은 사용자가 자원을 삭제하려함");
		try {
			rowcnt = dao.deleteRepair(repair.getRepairNo());
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}

	}

}
