<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 2. 9.  박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    

<c:set var="vo" value="${schdVO }"/>
<!-- Modal Header -->
<div class="modal-header" >
	<h4>아파트 일정</h4>
</div>
<!-- Modal body -->
<table class="table table-bordered">
	<colgroup>
		<col width="30%">
	</colgroup>
	<tbody>
		<tr>
			<th>제목</th>
			<td colspan='3'>${vo.schdTitle }</td>
		</tr>
		<tr>
			<th>일시</th>
			<td>${vo.schdStart } ~ ${vo.schdEnd }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan='3'>${vo.schdContent }</td>
		</tr>
	</tbody>
</table>
<div class="modal-footer" >
	<input type="button" class="btn btn-danger" value="삭제" id="deleteBtn">
	<c:if test="${vo.schdType ne 'S004'}">
	<input type="button" class="btn btn-warning" value="수정" id="updateBtn">
	</c:if>
	<input type="button" class="btn btn-secondary" data-dismiss="modal" value="닫기" id="closeBtn">
</div>