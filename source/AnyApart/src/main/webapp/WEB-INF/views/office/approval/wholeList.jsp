<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 26.      이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal"/>
	<c:set var="authMember" value="${principal.realMember }" />
	<input type="hidden" class="form-control" name="page" value="${param.page }"/>
	<input type="hidden" class="form-control" name="searchType" value="${param.searchType }"/>
	<input type="hidden" class="form-control" name="searchWord" value="${param.searchWord }"/>
</security:authorize>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />

<style>
	#searchImg{
		width:30px;
		height:30px;
		margin-left:20px;
	}
	
	#searchBtn{
		margin:5px;
	}
	
	.searchIconDiv{
		margin-left:5em;
	}
	
	#searchImgDiv{
		margin-top:1em;
	}
	
	.searchDiv{
		margin-left: 5em;
		margin-bottom: 2em;
	}
	.badge{
		width:120px;
		height:25px;
		font-size:16px;
	}
</style>


<!-- 상세유지시 상태값 넘김-------------------------------------------------------------------------------------------->
<form id="viewForm" method="get" action="${cPath }/office/approval/draftView.do">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="draftId"  />
	<input type="hidden" name="searchStart" value="${pagingVO.searchDetail.searchStart }" />
	<input type="hidden" name="searchStart" value="${pagingVO.searchDetail.searchEnd }" />
	<input type="hidden" name="taskCode" value="${pagingVO.searchDetail.taskCode }" />
	<input type="hidden" name="draftTitle" value="${pagingVO.searchDetail.draftTitle }" />
	<input type="hidden" name="draftContent" value="${pagingVO.searchDetail.draftContent }" />
	<input type="hidden" name="flag" value="whole" />
</form>

<!-- 서버 --------------------------------------------------------------------------------------------------------->
<form id="searchForm">
	<input type="hidden" name="searchVO.searchAptCode" value="${authMember.aptCode}">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchStart" value="${pagingVO.searchDetail.searchStart }" />
	<input type="hidden" name="searchEnd" value="${pagingVO.searchDetail.searchEnd }" />
	<input type="hidden" name="taskCode" value="${pagingVO.searchDetail.taskCode }" />
	<input type="hidden" name="draftTitle" value="${pagingVO.searchDetail.draftTitle }" />
	<input type="hidden" name="draftContent" value="${pagingVO.searchDetail.draftContent }" />
	<input type="hidden" name="flag" value="whole" />
</form>
<br>
<div>
	<h2><strong>전체문서함</strong></h2>
</div>
<br>
<div class="container">
	 <div class="container mt-4">
	 	<div class="col-sm-10 searchDiv" style="border-style:outset;border-radius: 8px;">
			  <div class="row g-0 ml-2">
				    <div id="searchImgDiv">
				      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon" id="searchImg" >&nbsp;&nbsp;<strong>검색 조건</strong>
				    </div>
				    <div id="inputUI">
					    <form class="form-inline">
					      <div class="card-body ">
					      		&nbsp;&nbsp;단위업무&nbsp;&nbsp;
						        	<select id="taskCode" name="taskCode" class="custom-select col-sm-4">
						        				<option value="">전체</option>
										<c:forEach items="${taskCodes }" var="taskCode" varStatus="vs">
											<c:if test="${not empty taskCode.codeId }">
												<option value="${taskCode.codeId }" ${pagingVO.searchDetail.taskCode eq taskCode.codeId ? 'selected':''}>"${taskCode.codeName }"</option>
											</c:if>
										</c:forEach>
									</select>
					        	 &nbsp;&nbsp;제목&nbsp;&nbsp;
						       	<input type="text" name="draftTitle" class="form-control col-md-12" value="${pagingVO.searchDetail.draftTitle }"> 
					        	 &nbsp;&nbsp;내용&nbsp;&nbsp;
						       	<input type="text" name="draftContent" class="form-control col-md-12" value="${pagingVO.searchDetail.draftContent }"> 
					      </div>
					      <div class="card-body">
				        		
						        	&nbsp;&nbsp;기안일자&nbsp;&nbsp;
						        	<input type="date" name="searchStart" class="form-control col-md-3" value="${pagingVO.searchDetail.searchStart }"> 
						        	 - <input type="date" name="searchEnd" class="form-control col-md-3" value="${pagingVO.searchDetail.searchEnd }"> 
					     	    <button class="btn btn-dark" id="searchBtn">검색</button>
					     	    <button class="btn btn-secondary" id="resetBtn">초기화</button>
					      </div>
					    </form>
				    </div>
			  </div>
		</div>
	 </div>
	<table class="table text-center"> 
	  <thead class="thead-light ">
	    <tr>
	      <th width="10%">No</th>
	      <th width="45%">제목</th>
	      <th width="15%">작성자</th>
	      <th width="15%">상태</th>
	      <th width="15%">기안일자</th>
	    </tr>
	  </thead>
	  <tbody id="listBody">
	   <c:set var="wholeList" value="${pagingVO.dataList }"/>
		  	<c:if test="${not empty wholeList }">
		  	 <c:set var="size" value="${fn:length(wholeList)}"/>
		  		<c:forEach items="${wholeList }" var="whole">
		  			<tr data-draft-id='${whole.draftId }'>
		  				<td>${size-whole.rnum+1 }</td>
		  				<td class="text-left">${whole.draftTitle }</td>
		  				<td>${whole.draftWriter }</td>
		  				<td>
		  				<c:if test="${whole.approval.appStatus eq '기안취소' }">
			  					<span class="badge badge-secondary">${whole.approval.appStatus }</span>
			  				</c:if>
			  				<c:if test="${whole.approval.appStatus eq '대기중' }">
			  					<span class="badge badge-primary">${whole.approval.appStatus }</span>
			  				</c:if>
			  				<c:if test="${whole.approval.appStatus eq '반려' }">
			  					<span class="badge badge-warning text-dark">${whole.approval.appStatus }</span>
			  				</c:if>
			  				<c:if test="${whole.approval.appStatus eq '결재중' }">
			  					<span class="badge badge-info">${whole.approval.appStatus }</span>
			  				</c:if>
			  				<c:if test="${whole.approval.appStatus eq '결재완료' }">
			  					<span class="badge badge-dark">${whole.approval.appStatus }</span>
			  				</c:if>
			  			</td>
		  				<td>${whole.draftDate }</td>
				    <tr>
		  		</c:forEach>
			</c:if>
			<c:if test="${empty wholeList }">
				<tr>
					<td colspan="5">조회 결과가 없습니다.</td>
				</tr>
			</c:if>	
	  </tbody>
	</table>
	  
	<div id="pagingArea">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
	</div>
 </div>

 <script>
    let listBody = $("#listBody");
	listBody.on("dblclick", "tr", function() {
		let draftId = this.dataset.draftId;
		let viewForm = $("#viewForm");
		viewForm.find("[name='draftId']").val(draftId);
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