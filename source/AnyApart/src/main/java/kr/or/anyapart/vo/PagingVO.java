/**
 * @author 이경륜
 * @since 2021. 1. 27.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                     수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 27.   이경륜            최초작성
 * 2021. 2.  8.   이경륜		 페이지 계산 코드 분리
 * 2021. 2. 18.   이경륜		 previous/next 이전/다음으로 변경
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PagingVO<T> {
	public PagingVO(int screenSize, int blockSize) {
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	private int totalRecord;
	private int screenSize = 10;
	private int blockSize = 5;
	private int currentPage;
	private int totalPage;
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	private int firstPageNoOnPageList;
	private int lastPageNoOnPageList;
	private List<T> dataList;
	
	private SearchVO searchVO;
	private T searchDetail;
	
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		this.totalPage = (totalRecord + (screenSize - 1)) / screenSize;
	}
	
//	public void setCurrentPage(int currentPage) {
//		this.currentPage = currentPage;
//		this.endRow = currentPage * screenSize;
//		this.startRow = endRow - (screenSize - 1);
//		this.startPage = blockSize * ( (currentPage-1) / blockSize ) + 1;
//		this.endPage = startPage + (blockSize - 1);
//	}

	/**
	 * 위의 계산식을 분리하여 적용함
	 * 이유: currentPage, screenSize 를 commandObject로 오토바인딩해서 받을때
	 * 		setter 호출 순서를 지정할 수 없어 screenSize가 적용되지 않아서 
	 * 		getter, setter 호출시점에 따라 계산 되도록 변경함.
	 * 		PagingVO를 사용하는 기존 작성된 코드에는 영향주지않음.
	 * @author 이경륜
	 */
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public void setScreenSize(int screenSize) {
		this.screenSize = screenSize;
	}
	
	public int getEndRow() {
		this.endRow = currentPage * screenSize;
		return endRow;
	}
	public int getStartRow() {
		this.startRow = endRow - (screenSize - 1);
		this.startPage = blockSize * ( (currentPage-1) / blockSize ) + 1;
		this.endPage = startPage + (blockSize - 1);
		return this.startRow;
	} 
//	<nav aria-label='...'>
//	  <ul class='pagination'>
//	    <li class='page-item disabled'>
//	      <span class='page-link'>Previous</span>
//	    </li>
//	    <li class='page-item'><a class='page-link' href='#'>1</a></li>
//	    <li class='page-item active' aria-current='page'>
//	      <span class='page-link'>2</span>
//	    </li>
//	    <li class='page-item'><a class='page-link' href='#'>3</a></li>
//	    <li class='page-item'>
//	      <a class='page-link' href='#'>Next</a>
//	    </li>
//	  </ul>
//	</nav>
	
	private static final String LIPTRN = "<li class='page-item %s' %s>";
	private static final String APTRN = "<a class='page-link' href='#' data-page='%s'>%s</a>";
	private static final String SPANPTRN = "<span class='page-link'>%s</span>";
	
	public String getMorePage() {
		StringBuffer html = new StringBuffer();
		if(currentPage<totalPage) {
			html.append("<a class='btn border-success w-75' data-page='"+(currentPage+1)+"'>더보기</a>");
			html.append("<button type='button' class='m-3 btn btn-secondary scrollTop'>↑</button>");
		}
		return html.toString();
	}
	
	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		html.append("<nav aria-label='...'>");
		html.append("<ul class='pagination justify-content-center'>");
		// previous
		html.append(String.format(LIPTRN, startPage < blockSize?"disabled":"", ""));
		if(startPage < blockSize) {
			html.append(String.format(SPANPTRN, "이전"));
		}else {
			html.append(String.format(APTRN, (startPage - blockSize), "이전"));
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
				html.append(String.format(APTRN, page, page));
			}
			html.append("</li>");
		}
		
		// Next
		html.append(String.format(LIPTRN, endPage >= totalPage?"disabled":"", ""));
		if(endPage >= totalPage) {
			html.append(String.format(SPANPTRN, "다음"));
		}else {
			html.append(String.format(APTRN, (endPage + 1) ,"다음"));
		}
		html.append("</li>");
		html.append("</ul>");
		html.append("</nav>");
		return html.toString();
	}
}


















