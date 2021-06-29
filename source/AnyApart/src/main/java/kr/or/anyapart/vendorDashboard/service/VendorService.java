package kr.or.anyapart.vendorDashboard.service;

import java.util.List;

import kr.or.anyapart.account.vo.AccountVO;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vendorDashboard.vo.DashboardVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.RequestLogVO;

public interface VendorService {

	public List<ApartVO> apartList(PagingVO<ApartVO> pagingVO);

	public int retrieveApartCount(PagingVO<ApartVO> pagingVO);

	public DashboardVO retrieveQnaCount(DashboardVO dsVO);

	public DashboardVO retrieveTotalQnaCount(DashboardVO dashboardVO);

	public List<DashboardVO> reieveYearList(DashboardVO dash);

	public List<DashboardVO> retrieveMondayList(DashboardVO dashboardVO);

	/**
	 * 로그 바탕으로 메뉴별 사용빈도 리스트
	 * @param requestLogVO
	 * @return 로그 list
	 */
	public List<RequestLogVO> retrieveRequestLogList(RequestLogVO requestLogVO);
}
