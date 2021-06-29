package kr.or.anyapart.vendorDashboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vo.BoardVO;
import kr.or.anyapart.vendorDashboard.dao.VendorDAO;
import kr.or.anyapart.vendorDashboard.vo.DashboardVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.RequestLogVO;

@Service
public class VendorServiceImpl  implements VendorService{

	@Inject
	private VendorDAO vendorDAO;
	
	
	@Override
	public List<ApartVO> apartList(PagingVO<ApartVO> pagingVO) {
		
		return vendorDAO.selectApartList(pagingVO);
	}

	@Override
	public int retrieveApartCount(PagingVO<ApartVO> pagingVO) {
		return vendorDAO.selectApartCount(pagingVO);
	}

	@Override
	public DashboardVO retrieveQnaCount(DashboardVO dsVO) {
		return vendorDAO.apartQnaCount(dsVO);
	}

	@Override
	public DashboardVO retrieveTotalQnaCount(DashboardVO dsVO) {
		
		return vendorDAO.selectQnaTotalCount(dsVO);
	}

	@Override
	public List<DashboardVO> reieveYearList(DashboardVO dsVO) {
		return vendorDAO.selectYYYYList(dsVO);
	}

	@Override
	public List<DashboardVO> retrieveMondayList(DashboardVO dashboardVO) {
		return vendorDAO.selectMMList(dashboardVO);
	}

	@Override
	public List<RequestLogVO> retrieveRequestLogList(RequestLogVO requestLogVO) {
		return vendorDAO.selectRequestLogList(requestLogVO);
	}


	
	
	




}
