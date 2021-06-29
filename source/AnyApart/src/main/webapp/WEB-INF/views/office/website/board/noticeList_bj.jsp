<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<div class="container">
	<br>
	<h4><strong>공지사항</strong></h4>
	<div class="d-flex justify-content-end">
   		 <div class="d-flex justify-content-end">
   		 <button onclick = "location.href = '${pageContext.request.contextPath}/office/website/officeNotice/officeNoticeForm.do'" class="btn btn-dark" style='margin:5pt;'>등록</button></div>
	</div>
	
	
	<form id="viewForm" method="get" action="${cPath }/office/website/officeNotice/officeNoticeView.do">
		<input type="hidden" name="boNo"  />
		<input type="hidden" name="page" value="${param.page }"/>
		<input type="hidden" name="searchType" value="${param.searchType }" />
		<input type="hidden" name="searchWord" value="${param.searchWord }"/>
	</form>
	  <div class="col-sm-12">
		  <table class="table table-bordered">
			  <thead class="thead-light text-center">
			    <tr>
			      <th style="width: 10%">No</th>
			      <th style="width: 40%">제목</th>
			      <th style="width: 15%">작성자</th>
			      <th style="width: 25%">작성일</th>
			      <th style="width: 10%">조회수</th>
			    </tr>
			  </thead>
			  <tbody id="listBody">
			  <c:set var="boardList" value="${pagingVO.dataList }"/>
			   <c:set var="size" value="${fn:length(boardList)}"/>
			  	<c:if test="${not empty boardList }">
			  		<c:forEach items="${boardList }" var="board">
			  			<tr data-bo-no='${board.boNo }'>
			  				<td class="text-center" >
			  				<c:if test="${pagingVO.currentPage eq pagingVO.totalPage}">
				  				${pagingVO.totalRecord-(board.rnum-1)%pagingVO.totalRecord}
			  				</c:if>
			  				<c:if test="${pagingVO.currentPage ne pagingVO.totalPage}">
				  				${pagingVO.screenSize-(board.rnum-1)%pagingVO.screenSize}
			  				</c:if>
			  				</td>
			  				<td>${board.boTitle }</td>
			  				<td class="text-center">${board.boWriter }</td>
			  				<td class="text-center">${board.boDate }</td>
			  				<td class="text-center">${board.boHit }</td>
					    <tr>
			  		</c:forEach>
				</c:if>
				<c:if test="${empty boardList }">
					<tr>
						<td colspan="5">게시글이 없습니다.</td>
					</tr>
				</c:if>
			  </tbody>
		</table>
	</div>
	<div id="pagingArea">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
	</div>
 
<div class="container">
	<div class="col-sm-6" style="border-style:outset;border-radius: 8px;margin-left:15em;">
	  <div class="row g-0">
		    <div>
	    	<form id="searchForm">
				<input type="hidden" name="page" />
				<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
				<input type="hidden" name="searchWord"  value="${pagingVO.searchVO.searchWord }"/>
			</form>
		    <form class="form-inline">
		      <div class="card-body inputUI">
		      		<div class="ml-3" style="float:left">
		      			 <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
					    style="width:30px;height:30px;">&nbsp;&nbsp;
			        	<select name="searchType" class="custom-select">
			        		<option value="">전체</option>
							<option value="title" ${'title' eq param.searchType?"selected":"" }>제목</option>
							<option value="content" ${'content' eq param.searchType?"selected":"" }>내용</option>
			        	</select> 
				       	<input type="text" name="searchWord" class="form-control col-sm-8" value="${pagingVO.searchVO.searchWord }">
		      		</div>
		      		<div class="ml-3" style="float:left">
					</div>
					    <div class="d-flex justify-content-end"><button class="btn btn-dark" id="searchBtn">검색</button></div>
		      </div>
		    </form>
		    </div>
	    </div>
	  </div>
 </div>    
</div>
 <script>
	let listBody = $("#listBody");
	listBody.on("dblclick", "tr", function() {
		let boNo = this.dataset.boNo;
		let viewForm = $("#viewForm");
		viewForm.find("[name='boNo']").val(boNo);
		console.log('${param.searchType}');
		console.log('${param.searchWord}');
		viewForm.submit();
	});	
 
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		return false;
	}
	
	let searchForm = $("#searchForm");
	$("#searchBtn").on("click", function(){
		let inputs = $(this).parents("div#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val();
			let hidden = searchForm.find("[name='"+name+"']");
			hidden.val(value);
		});
		searchForm.submit();
	});
 </script>