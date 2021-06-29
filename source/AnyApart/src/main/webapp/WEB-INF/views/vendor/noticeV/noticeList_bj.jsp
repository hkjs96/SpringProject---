<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  박 찬      최초작성
* 2021. 3.  8.  이경륜  ui수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <div id="container">
        <div class="inner">
            <!-- 공지사항 -->
            <div class="board-list">
                <div align="right">
					<input class="btn btn-green" type="button" value="새글 등록" onclick="location.href='${cPath }/vendor/noticeForm.do'">
				</div>
				<br>
                <table>
                    <colgroup>
						<col style="width: 10px">
						<col style="width: 200px">
						<col style="width: 50px">
						<col style="width: 90px">
						<col style="width: 30px">
						<col style="width: 20px">
                    </colgroup>
                    <thead>
                    <tr>
                    <tr>
                        <th>No.</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="boardList" value="${pagingVO.dataList }"/>
                    	<c:if test="${not empty boardList }">
                    		<c:forEach items="${boardList }" var="board">
                    			<tr>
    			                   <td>${board.rnum}</td>
	                   				<c:url value="/vendor/noticeView.do?boNo=${board.boNo }" var="viewURL" />
	                   				<td class="subject">
	                   				<a href="${board.boDelete ne 'Y' ? viewURL : '#' }">${board.boTitle }</a></td>
	                   				<c:if test="${board.boWriter eq 'ADMIN'}">
										<c:set target="${board }" property="boWriter" value="벤더" />	                   				
<%-- 	                   				<td>[AnyApart]<br>${board.boWriter }</td> --%>
										<td><c:out value="${board.boWriter }"/></td>
	                   				</c:if>
	                   				<td>${board.boDate }</td>
	                   				<td>${board.boHit }</td>
	                   				<td>
		                   				<c:url value="/vendor/noticeUpdate.do" var="updateURL">
											<c:param name="boNo" value="${board.boNo }" />
										</c:url>
	                   				<input class="btn btn-blue" type="button" value="수정" onclick="location.href='${updateURL}'">
	                   				<form id="board" action="${cPath }/vendor/noticeDelete.do" method="POST">
													<input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
					                   				<input type="hidden" class="form-control" name="boType" value="${board.boType }"/>
					                   				<input type="hidden" class="form-control" name="boDelete" value="${board.boDelete }"/>
							        <input class="btn btn-red" type="submit" value="삭제">
							        </form>
          					 	</td>
          					 	</tr>
                    		</c:forEach>
                    	</c:if>
                    </tbody>
                </table>
                <br>
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
							<option value="title" ${'title' eq param.searchType?"selected":"" }>제목</option>
<%-- 							<option value="writer" ${'writer' eq param.searchType?"selected":"" }>작성자</option> --%>
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
        </div>
    </div>
    
<script type="text/javascript">

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