/**
 * @author 이경륜
 * @since 2021. 2. 23.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 23.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commonsweb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.vo.FareRateVO;

@Repository
public interface FareRateDAO {
	/**
	 * 어플리케이션 시작시 요금/비율표 가져오는 메서드
	 * @return 
	 * @author 이경륜
	 */
	public List<FareRateVO> selectFareRateList();
}
