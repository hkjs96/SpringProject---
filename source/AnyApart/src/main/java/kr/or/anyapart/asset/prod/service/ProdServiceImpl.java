/**
 * @author 박지수
 * @since 2021. 2. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 9.      박지수       최초작성, 물품 목록 조회
 * 2021. 2. 10.      박지수       물품 갯수 반환
 * 2021. 2. 20.      박지수       물품 상세조회
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.asset.prod.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import kr.or.anyapart.CustomException;
import kr.or.anyapart.asset.prod.dao.ProdDAO;
import kr.or.anyapart.asset.vo.ProdVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class ProdServiceImpl implements ProdService {

	Logger logger = LoggerFactory.getLogger(ProdServiceImpl.class);
	
	@Inject
	ProdDAO prodDao;
	
	/* 
	 * [물품 목록 조회]
	 */
	@Override
	public List<ProdVO> retrieveProdList(PagingVO<ProdVO> pagingVO) {
		return prodDao.retrieveProdList(pagingVO);
	}

	/* 
	 * [물품 갯수 조회]
	 */
	@Override
	public int prodCount(PagingVO<ProdVO> pagingVO) {
		return prodDao.prodCount(pagingVO);
	}

	/*
	 * [물품 등록]
	 */
	@Override
	public void createProd(List<ProdVO> prodList) {
		try {
			int rowcnt = prodDao.insertProd(prodList);
			if( rowcnt == 0 ) throw new CustomException("물품 등록에 실패함");
		}catch (DataAccessException e) {
			throw new RuntimeException(e);
		}
	}

	/* 
	 * [물품 상세 조회]
	 */
	@Override
	public ProdVO retrieveProd(ProdVO prod) {
		return prodDao.retrieveProd(prod);
	}
	
	
}
