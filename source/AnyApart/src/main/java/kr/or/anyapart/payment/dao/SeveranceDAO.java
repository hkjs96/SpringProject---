/**
 * @author 이미정
 * @since 2021. 2. 23.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 23.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.payment.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.payment.vo.SeveranceVO;
import kr.or.anyapart.vo.PagingVO;

@Repository
public interface SeveranceDAO {

	public int selectSvcrCount(PagingVO<SeveranceVO> pagingVO);

	public List<SeveranceVO> selectSvrcList(PagingVO<SeveranceVO> pagingVO);

	public int insertSvrc(SeveranceVO param);

	public SeveranceVO selectSvrcViewForUpdate(SeveranceVO param);

	public int updateSvrc(SeveranceVO param);

	public int deleteSvrc(SeveranceVO svrcVO);

}
