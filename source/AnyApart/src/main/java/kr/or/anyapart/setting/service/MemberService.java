/**
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 13.      박지수      최초 작성
* 2021. 2. 16.      박지수      회원체크
* 2021. 3. 04.      박지수      입주민 회원 정보 조회
* Copyright (c) 2021 by DDIT All right reserved
*/
package kr.or.anyapart.setting.service;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;

public interface MemberService {
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
	public void modifyMember(MemberVO member, String updatePass);

	/**
	 * member의 정보를 확인 
	 * @param member
	 * @author 박지수 (return 타입 void로 최초 작성)
	 * @see 이경륜 (return 타입 ServiceResult로 변경)
	 */
	public ServiceResult checkMemberPassword(MemberVO member);

	/**
	 * member의 정보를 확인 
	 * @param member
	 * @author 박지수 (return 타입 void로 최초 작성)
	 */
	public void checkMemberPassword(MemberVO member, String memPass);
	
	/**
	 * 입주민 회원의 정보를 조회
	 * @param member
	 * @return
	 */
	public ResidentVO retrieveResident(MemberVO member);
}
