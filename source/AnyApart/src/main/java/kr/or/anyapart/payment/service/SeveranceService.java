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
package kr.or.anyapart.payment.service;

import java.util.List;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.payment.vo.SeveranceVO;
import kr.or.anyapart.vo.PagingVO;

public interface SeveranceService {

	public int retrieveSvrcCount(PagingVO<SeveranceVO> pagingVO);

	public List<SeveranceVO> retrieveSvrcList(PagingVO<SeveranceVO> pagingVO);

	public ServiceResult createSvrc(SeveranceVO param);

	public SeveranceVO retriveSvrcViewForUpdate(SeveranceVO param);

	public ServiceResult updateSvrc(SeveranceVO param);

	public ServiceResult removeSvrc(SeveranceVO param);

}
