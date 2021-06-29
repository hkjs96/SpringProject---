<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 2. 12.    박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="boardVO" value="${boardVO }"/>
<table class="table table-bordered" id="insertTable">
	<colgroup>
		<col width="25%">
	</colgroup>
	<tbody>
		<tr>
			<th>제목</th>
			<td colspan="3">${boardVO.boTitle }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td colspan="3">${boardVO.boWriter }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td colspan="3">${boardVO.boDate }</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td colspan="3">
			<c:if test="${not empty boardVO.attachList}">
				<c:forEach items="${boardVO.attachList }" var="attVO" varStatus="vs"> 
					<c:url value="/board/download.do" var="downloadURL">
						<c:param name="attSn" value="${attVO.attSn }"/>
						<c:param name="boNo" value="${boardVO.boNo }"/>
					</c:url>
					<a href="${downloadURL }">
						<span title="다운로드">${attVO.attFilename }</span>
						${not vs.last?"|":"" }
					</a>
				</c:forEach>
			</c:if>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3">${boardVO.boContent }</td>
		</tr>
	</tbody>
</table>

<input type='button' class='btn btn-warning' id='updateBtn' data-bono='${boardVO.boNo }' value='수정'>
<input type='button' class='btn btn-danger' id='deleteBtn' data-bono='${boardVO.boNo }' value='삭제'>


