/**
 * @author 이미정
 * @since 2021. 2. 23.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 23.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.payment.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.payment.dao.SeveranceDAO;
import kr.or.anyapart.payment.vo.SeveranceVO;
import kr.or.anyapart.vo.PagingVO;


@Service
public class SeveranceServiceImpl implements SeveranceService{

	@Inject
	private SeveranceDAO svrcDAO;
	
	@Override
	public int retrieveSvrcCount(PagingVO<SeveranceVO> pagingVO) {
		return svrcDAO.selectSvcrCount(pagingVO);
	}

	@Override
	public List<SeveranceVO> retrieveSvrcList(PagingVO<SeveranceVO> pagingVO) {
		return svrcDAO.selectSvrcList(pagingVO);
	}

	@Transactional
	@Override
	public ServiceResult createSvrc(SeveranceVO param) {
		int cnt = 0;
		
		ServiceResult result = ServiceResult.FAILED;
		
		cnt+=svrcDAO.insertSvrc(param);
		
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public SeveranceVO retriveSvrcViewForUpdate(SeveranceVO param) {
		return svrcDAO.selectSvrcViewForUpdate(param);
	}

	@Override
	public ServiceResult updateSvrc(SeveranceVO param) {
		int cnt = 0;
		
		ServiceResult result = ServiceResult.FAILED;
		
		cnt+=svrcDAO.updateSvrc(param);
		
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public ServiceResult removeSvrc(SeveranceVO param) {
		SeveranceVO svrcVO = svrcDAO.selectSvrcViewForUpdate(param);
		if(svrcVO==null) throw new CustomException(param.getSvrcNo() + "번에 해당하는 퇴직정산 내역이 없습니다.");
		
		ServiceResult result = ServiceResult.FAILED;
		
		int cnt = svrcDAO.deleteSvrc(svrcVO);
		
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
}
