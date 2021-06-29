/**
 * @author 이미정
 * @since 2021. 2. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 10.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.employee.service;

import java.util.List;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.OffVO;
import kr.or.anyapart.vo.PagingVO;

public interface OffService{
	public List<OffVO> retrieveOffList(PagingVO<OffVO> pagingVO);

	public int retrieveOffCount(PagingVO<OffVO> pagingVO);

	public ServiceResult createOff(OffVO offVO);
	
	public OffVO retrieveOff(OffVO offVO);

	public ServiceResult modifyOff(OffVO offVO);
	
	public ServiceResult removeOff(OffVO offVO);

	public String retrieveNowOff(OffVO param);

	
}
