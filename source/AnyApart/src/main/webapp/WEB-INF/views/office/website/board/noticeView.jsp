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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />

<style>
	.table td:nth-child(2n+1) {
	  background-color: #f7f7e8;
	  text-align:center;
	  font-weight: bold;
	  width:10em;
	}
	
	.table td:nth-child(2n) {
		width:10em;
	}
	
	.btn{
		margin:5px;
	}
</style>

<div class="container">
	<br>
	<h4><strong>공지사항</strong></h4>
	<br>
	 <table class="table table-bordered">
		<tr>
			<td class="text-center">글번호</td>
			<td class="text-center">${board.boNo }</td>
			<td class="text-center">작성자</td>
			<td class="text-center">${board.boWriter }</td>
		</tr>
		<tr>
			<td class="text-center">조회수</td>
			<td class="text-center">${board.boHit }</td>
			<td class="text-center">작성일</td>
			<td class="text-center">${board.boDate }</td>
		</tr>
		<tr>
			<td class="text-center">제목</td>
			<td colspan="3">${board.boTitle }</td>
		</tr>
		<tr>
			<td class="text-center align-middle" style="height:500px;">내용</td>
			<td colspan="3">${board.boContent }</td>
		</tr>
				<tr>
			<td class="text-center">첨부파일</td>
			<td colspan="3">
				<c:if test="${not empty board.attachList }">
					<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
						<c:url value="/board/download.do" var="downloadURL">
							<c:param name="attSn" value="${attach.attSn }" />
							<c:param name="boNo" value="${attach.boNo }" />
						</c:url>
						<a href="${downloadURL }">
							<span title="다운로드:">${attach.attFilename }</span>
							${not vs.last?"|":"" }
						</a>
					</c:forEach>		
				</c:if>
			</td>
		</tr>
	</table>   
	<div class="d-flex justify-content-center">
		<c:url value="/office/website/officeNotice/officeNoticeUpdate.do" var="updateURL">
			<c:param name="boNo" value="${board.boNo }"/>
		</c:url>
		<form id="updateForm" action="${cPath }/office/website/officeNotice/officeNoticeUpdate.do" method="GET">
			<input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
			<input type="hidden" class="form-control" name="page" value="${param.page }"/>
			<input type="hidden" class="form-control" name="searchType" value="${param.searchType }"/>
			<input type="hidden" class="form-control" name="searchWord" value="${param.searchWord }"/>
			<input type="submit" value="수정" class="btn btn-warning" id="updateBtn"/>
		</form>
		<form id="deleteForm" action="${cPath }/office/website/officeNotice/officeNoticeDelete.do" method="POST">
			<input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
			<input type="hidden" class="form-control" name="boType" value="${board.boType }"/>
			<input type="hidden" class="form-control" name="boWriter" value="${board.boWriter }"/>
			<input type="hidden" class="form-control" name="boWriterId" value="${board.boWriterId }"/>
			<input type="hidden" class="form-control" name="boDelete" value="${board.boDelete }"/>
			<input type="button" value="삭제" class="btn btn-danger" id="removeBtn" />
		</form>
		<form id="listForm" action="${cPath }/office/website/officeNotice/officeNoticeList.do" method="GET">
			<input type="hidden" class="form-control" name="page" value="${param.page }"/>
			<input type="hidden" class="form-control" name="searchType" value="${param.searchType }"/>
			<input type="hidden" class="form-control" name="searchWord" value="${param.searchWord }"/>
			<input type="submit" value="목록" class="btn btn-dark" id="listBtn">
		</form>
	</div>
</div>

<script>

	$("#removeBtn").on("click", function(){
		let comfirmChk = confirm("삭제하시겠습니까?");
		
		if(comfirmChk){
			$("#deleteForm").submit();
		}else{
			return;
		}

	});
	
</script>

