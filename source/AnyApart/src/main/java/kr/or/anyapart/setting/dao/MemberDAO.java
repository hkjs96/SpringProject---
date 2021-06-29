/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 13.      박지수      최초 작성
* 2021. 3. 04.      박지수      입주민 회원 정보 조회
* Copyright (c) 2021 by DDIT All right reserved
*/
package kr.or.anyapart.setting.dao;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;

@Repository
public interface MemberDAO {
	/**
	 * member를 조회
	 * @param member
	 * @return
	 */
	public MemberVO retrieveMember(MemberVO member);

	/**
	 * member정보를 변경
	 * @param member
	 * @return
	 */
	public int updateMember(MemberVO member);
	
	/**
	 * 입주민 회원의 정보를 조회
	 * @param member
	 * @return
	 */
	public ResidentVO retrieveResident(MemberVO member);
}
