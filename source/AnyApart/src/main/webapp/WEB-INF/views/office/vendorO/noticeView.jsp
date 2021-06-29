<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  박 찬      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="${pageContext.request.contextPath }/js/main/js/front.js"></script>
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
						<c:choose>
							<c:when test="${attach.attFilesize eq 0 }">
							
							</c:when>
						
							<c:when test="${attach.attFilesize ne 0 }">
								<c:url value="/board/download.do" var="downloadURL">
									<c:param name="attSn" value="${attach.attSn }" />
									<c:param name="boNo" value="${attach.boNo }" />
								</c:url>
								
								<img src="${cPath }/js/main/img/common/file.png"/>
								<a href="${downloadURL }">
									<span title="다운로드:">${attach.attFilename }</span>
									${not vs.last?"|":"" }
								</a>
							</c:when>
						</c:choose>
					</c:forEach>		
				</c:if>
			</td>
		</tr>
	</table>
	<div class="d-flex justify-content-center">
		<a href="${cPath }/office/notice/noticeList.do" class="btn btn-dark">목록</a>
	</div>
 </div>
