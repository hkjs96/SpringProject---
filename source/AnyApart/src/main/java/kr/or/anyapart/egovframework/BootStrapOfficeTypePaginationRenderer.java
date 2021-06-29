package kr.or.anyapart.egovframework;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationRenderer;

public class BootStrapOfficeTypePaginationRenderer implements PaginationRenderer{
	
	private static final String LIPTRN = "<li class='page-item %s' %s>";
	private static final String APTRN = "<a class='page-link' href='#' data-page='%1$s' onclick='%2$s(event)'>%3$s</a>";
	private static final String SPANPTRN = "<span class='page-link'>%s</span>";
	
	private String getPagingHTML(PaginationInfo paginationInfo, String jsFunction) {
		int startPage = paginationInfo.getFirstPageNoOnPageList();
		int blockSize = paginationInfo.getPageSize();
		int totalPage = paginationInfo.getTotalPageCount();
		int endPage = paginationInfo.getLastPageNoOnPageList();
		int currentPage = paginationInfo.getCurrentPageNo();
		
		StringBuffer html = new StringBuffer();
		html.append("<style>"
				+ ".pagination li.active span.page-link{"
				+ " border-color:#dee2e6;"
				+ " background-color:#343a40;} "
				+ ".pagination li.page-item a.page-link{" 
				+ " border-color:#dee2e6;"
				+ " color:gray;"
				+ "  background-color: #ffffff;}" 
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
