package kr.or.anyapart.vo;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class CustomPaginationInfo<T> extends PaginationInfo {
	private PagingVO<T> pagingVO;

	public CustomPaginationInfo(PagingVO<T> pagingVO) {
		super();
		this.pagingVO = pagingVO;
		super.setCurrentPageNo(pagingVO.getCurrentPage());
		super.setPageSize(pagingVO.getBlockSize());
		super.setRecordCountPerPage(pagingVO.getScreenSize());
		super.setTotalRecordCount(pagingVO.getTotalRecord());
	}

	public PagingVO<T> getPagingVO() {
		return pagingVO;
	}
}
