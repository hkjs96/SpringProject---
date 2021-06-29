/**
 * @author 박지수
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 1.      박지수       최초작성
 * 2021. 2. 2.      박지수       동리스트 조회
 * 2021. 2. 3.      박지수       동리스트 조회 변경
 * 2021. 2. 4.		박지수	단지 등록, 단지 삭제
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.apart.dao.IApartDAO;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.setting.dao.MemberDAO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class ApartServiceImpl implements IApartService {

	private static final Logger logger = LoggerFactory.getLogger(ApartServiceImpl.class);
	@Inject
	private WebApplicationContext container;
	
	@Inject
	IApartDAO apartDAO;
	
	@Inject
	PasswordEncoder pwEncoder;
	
	@Inject
	private MemberDAO memberDao;
	
	
//	@Value("#{appInfo.apartImages}")
//	private String imagePath;
	
//	@Value("#{appInfo['apartImages']}")
	@Value("#{appInfo['boardFiles']}")
	private File saveFolder;
	public void setSaveFolder(File saveFolder) {
		this.saveFolder = saveFolder;
	}
	
	@PostConstruct
	public void init() {
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		logger.info("{}", saveFolder.getAbsolutePath());
	}
	
//	@PostConstruct
//	public void init() {
//		saveFolder = new File(container.getServletContext().getRealPath(imagePath));
//		if(saveFolder!=null && saveFolder.exists()) saveFolder.mkdirs();
//		logger.info("{}", saveFolder.getAbsolutePath());
//	}
	
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.apart.dao.IApartService#retrieveApartList()
	 */
	@Override
	public List<ApartVO> retrieveApartList(PagingVO<ApartVO> pagingVO) {
		return apartDAO.retrieveApartList(pagingVO);
	}
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.apart.dao.IApartService#apartCount()
	 */
	@Override
	public int apartCount(PagingVO<ApartVO> pagingVO) {
		return apartDAO.apartCount(pagingVO);
	}

	@Override
	public ApartVO retrieveApart(String aptCode) {
		return apartDAO.retrieveApart(aptCode);
	}

	/* 
	 * [ 아파트 관리사무소 등록 및 관리소장 계정 생성 ]
	 */
	@Transactional
	@Override
	public ServiceResult createApart(ApartVO apart) {
		
		int rowcnt = apartDAO.insertApart(apart);
		ServiceResult result = ServiceResult.FAILED;
		
		if(rowcnt>0) {
			try {
				apart.saveTo(saveFolder);
				
				String initPass = pwEncoder.encode(apart.getAptTel());	// 관리사무소장 초기 비밀번호를 관리 사무소 번호로 지정한다.
				
				EmployeeVO aptHead = EmployeeVO.builder()
										.aptCode(apart.getAptCode())
										.empName(apart.getAptHead())
										.empTel(initPass)
										.build();
				
				rowcnt = apartDAO.insertApartHead(aptHead);
				if(rowcnt == 0) throw new RuntimeException(" 아파트 정보 등록 실패");
//				MemberVO head = MemberVO.builder()
//									.memId(aptHead.getMemId()).build();
				
//				String memPass = pwEncoder.encode(aptHead.getMemId());
//				head.setMemPass(memPass);
//				memberDao.updateMember(head);
				
			} catch(IOException e)	{
				throw new RuntimeException(e);
			}
			result = ServiceResult.OK;
		}
		
		return result;
	}
	
	/*
	 * [아파트 정보 변경]
	 */
	@Override
	public void modifyApart(ApartVO apart) {
		// 결과를 받아서 예외 처리를 해줘야한다.
		try {
			int rowcnt = apartDAO.updateApart(apart);
			if(rowcnt == 0) {
				throw new RuntimeException();
			}
			apart.saveTo(saveFolder);
		} catch (SQLException | IOException e) {
			throw new RuntimeException(e);
		}
		
	}
	
	
	/*--------------------------------------------------------------------------------------------------------*/
	
	
	
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.apart.service.IApartService#retrieveHouse(java.lang.String)
	 */
	@Override
	public List<HouseVO> retrieveHouse(String aptCode) {
		return apartDAO.retrieveHouse(aptCode);
	}
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.apart.service.IApartService#createHouse(kr.or.anyapart.apart.vo.HouseVO)
	 */
	@Override
	public ServiceResult createHouse(HouseVO house) {
		int rowcnt = apartDAO.insertHouse(house);
		rowcnt = house.getResultCnt();
		ServiceResult result = ServiceResult.FAILED;
		
		if(rowcnt>0) {
			rowcnt = apartDAO.updateApartCnt(house);
			if(rowcnt>0) result = ServiceResult.OK;
		}
		
		return result;
	}
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.apart.service.IApartService#removeHouse(java.lang.String)
	 */
	@Override
	public boolean removeHouse(String houseCode) {
		boolean result = false;
		try {
			int rowcnt = apartDAO.deleteHouse(houseCode);
			if(rowcnt > 0) {
				result = true;
			}
//			else {
//				throw new RuntimeException("중복으로 insert 된 값이 없음");
//			}
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
		
		return result;
	}
	
}
