/**
 * @author 이미정
 * @since 2021. 1. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 28.     이미정       최초작성
 * 2021. 2. 04.		이경륜	a태그 span으로 변경후 css추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.egovframework;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationRenderer;

public class BootStrapResidentTypePaginationRenderer implements PaginationRenderer{

	private static final String LIPTRN = "<li class='page-item %s' %s>";
	private static final String APTRN = "<span class='page-link' href='#' data-page='%1$s' onclick='%2$s(event)'>%3$s</span>";
	private static final String SPANPTRN = "<span class='selected-page-link'>%s</span>";
	
	private String getPagingHTML(PaginationInfo paginationInfo, String jsFunction) {
		int startPage = paginationInfo.getFirstPageNoOnPageList();
		int blockSize = paginationInfo.getPageSize();
		int totalPage = paginationInfo.getTotalPageCount();
		int endPage = paginationInfo.getLastPageNoOnPageList();
		int currentPage = paginationInfo.getCurrentPageNo();
		
		StringBuffer html = new StringBuffer();
		html.append("<style>"
				+ ".pagination li.active span.selected-page-link{"
				+ " border-color:#dee2e6;"
				+ " background-color:#ff8369; "
				+ " cursor:pointer;}"
				+ ".pagination li.page-item span.page-link{" 
				+ " border-color:#dee2e6;"
				+ " color:gray;"
				+ " background-color: #ffc2b6;" 
				+ " cursor:pointer;}"
				+ "</style>");
		html.append("<nav aria-label='...'>");
		html.append("<ul class='pagination justify-content-center'>");
		// previous
		html.append(String.format(LIPTRN, startPage < blockSize?"disabled":"", ""));
		if(startPage < blockSize) {
			html.append(String.format(SPANPTRN, "이전"));
		}else {
			html.append(String.format(APTRN, (startPage - blockSize), jsFunction, "이전"));
		}
		html.append("</li>");
		
		// page number
		if(endPage>totalPage) endPage = totalPage;
		for(int page=startPage; page<=endPage; page++) {
			html.append(String.format(LIPTRN, page==currentPage?"active":"", 
											page==currentPage?"aria-current='page'":""));
			if(page==currentPage) {
				html.append(String.format(SPANPTRN, page));
			}else {
				html.append(String.format(APTRN, page, jsFunction, page));
			}
			html.append("</li>");
		}
		
		// Next
		html.append(String.format(LIPTRN, endPage >= totalPage?"disabled":"", ""));
		if(endPage >= totalPage) {
			html.append(String.format(SPANPTRN, "다음"));
		}else {
			html.append(String.format(APTRN, (endPage + 1), jsFunction, "다음"));
		}
		html.append("</li>");
		html.append("</ul>");
		html.append("</nav>");
		return html.toString();
	}
	
	
	@Override
	public String renderPagination(PaginationInfo paginationInfo, String jsFunction) {
		return getPagingHTML(paginationInfo, jsFunction);
	}


}
