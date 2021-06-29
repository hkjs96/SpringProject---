package kr.or.anyapart.vendorDashboard.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vendorDashboard.vo.DashboardVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.RequestLogVO;

@Repository
public interface VendorDAO {

	public int selectApartCount(PagingVO<ApartVO> pagingVO);

	public List<ApartVO> selectApartList(PagingVO<ApartVO> pagingVO);

	public DashboardVO apartQnaCount(DashboardVO dsVO);

	public DashboardVO selectQnaTotalCount(DashboardVO dsVO);

	public List<DashboardVO> selectMMList(DashboardVO dashboardVO);

	public List<DashboardVO> selectYYYYList(DashboardVO dsVO);
	
	public List<RequestLogVO> selectRequestLogList(RequestLogVO requestLogVO);
}


