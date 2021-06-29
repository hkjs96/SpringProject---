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
 * 2021. 2. 7.		박지수	아파트 정보 변경
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.service;

import java.util.List;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.vo.PagingVO;

public interface IApartService {
	public int apartCount(PagingVO<ApartVO> pagingVO);
	public List<ApartVO> retrieveApartList(PagingVO<ApartVO> pagingVO);
	public ApartVO retrieveApart(String aptCode);
	public ServiceResult createApart(ApartVO apart);
	/**
	 * 아파트 정보 변경을 한다.
	 * @param apart 변경할 아파트 정보를 담은 VO
	 * 
	 * @return 변경 실패시 Exception 발생하여 Controller 에 예외를 넘긴다.
	 */
	public void modifyApart(ApartVO apart);
	
	public List<HouseVO> retrieveHouse(String aptCode);
	public ServiceResult createHouse(HouseVO house);
	/**
	 * 동 정보 설정에서 세대 정보 삭제
	 * @param houseCode 삭제할 아파트 코드
	 * @author 박지수
	 * @return 삭제 성공시 true, 삭제 실패시 false
	 */
	public boolean removeHouse(String houseCode);
}
