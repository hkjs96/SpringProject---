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
<div class="modal-header" >
<c:if test="${schdVO.schdType eq 'S001'}">
	<p>🟧 아파트 행사 일정</p>
</c:if>
<c:if test="${schdVO.schdType eq 'S002'}">
	<p>🟦 아파트 수선 일정</p>
</c:if>
<c:if test="${schdVO.schdType eq 'S004'}">
	<p>🟪 리모델링 일정</p>
</c:if>
</div>
<!-- Modal body -->
<div class="modal-body ">
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
</div>	
<!-- Modal footer -->
<div class="modal-footer">
	<input type="button" value="확인" id="closeBtn" data-dismiss="modal" class="btn btn-default">
</div>