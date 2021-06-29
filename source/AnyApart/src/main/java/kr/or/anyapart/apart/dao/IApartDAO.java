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
 * 2021. 3. 1.		박지수	아파트 정보 생성후  관리사무소장 계정생성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.apart.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface IApartDAO {
	public int apartCount(PagingVO<ApartVO> pagingVO);
	public List<ApartVO> retrieveApartList(PagingVO<ApartVO> pagingVO);
	public ApartVO retrieveApart(String aptCode);
	public int insertApart(ApartVO apart);
	/**
	 * 아파트 정보 변경을 한다.
	 * @param apart 변경할 아파트 정보를 담은 VO
	 * @return 변경 성공시 1 실패시 0 , 쿼리 실패시 SQLException
	 */
	public int updateApart(ApartVO apart) throws SQLException;
	
	public List<HouseVO> retrieveHouse(String aptCode);
	public int insertHouse(HouseVO house);
	public int deleteHouse(String houseCode);
	
	/**
	 * 아파트 관리사무소장 계성 생성
	 * @param aptHead
	 * @return
	 */
	public int insertApartHead(EmployeeVO aptHead);
	
	/**
	 * 아파트 세대 숫자를 변경해준다.
	 * @param house
	 * @return
	 */
	public int updateApartCnt(HouseVO house);
}
