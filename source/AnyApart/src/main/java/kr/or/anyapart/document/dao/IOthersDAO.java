/**
 * @author 박정민
 * @since 2021. 2. 16.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 16.       박정민         최초작성
 * Copyright (c) 2021. 2. 16. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.document.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;

@Repository
public interface IOthersDAO {

	/**
	 * @param authMember
	 * @return
	 */
	List<HouseVO> selectDongList(MemberVO authMember);

	/**
	 * 세대검침 호 리스트 조회
	 * @param houseVO
	 * @return
	 */
	List<HouseVO> selectHoList(HouseVO houseVO);

	/**
	 * 세대검침 등록 입주민 리스트 조회
	 * @param authMemberVO
	 * @return
	 */
	List<ResidentVO> selectResidentList(MemberVO authMemberVO);

}
