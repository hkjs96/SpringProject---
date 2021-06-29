<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 2. 15.  박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style>
th{
	text-align: center;
	background-color: #E9ECEF;
}
#insertBtn{
	margin-bottom: 10px;
	margin-left: 38%;
	margin-top: 10px;
}
</style>    
<c:set var="modify" value="${modify }"/>
<c:set var="schdVO" value="${schdVO }"/>
<c:set var="authMemberVO" value="${authMemberVO }"/>
<form:form commandName="schdVO" id="insertEventForm" method="post">
<!-- Modal Header -->
	<div class="modal-header">
		<c:if test="${empty modify}">	
			<h4><strong>일정등록</strong></h4> 
		</c:if>
		<c:if test="${!empty modify}">	
			<h4><strong>일정수정</strong></h4> 
		</c:if>
		<button type="button" class="close" id="closeBtn" data-dismiss='modal'>&times;</button>
	</div>
	<!-- Modal body -->
	<div class="modal-body">
		<input type="hidden" name="aptCode" value="${authMember.aptCode }">
		<table class="table table-bordered">
			<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="20%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td colspan="3"><form:input path="schdTitle" name="schdTitle" class="form-control" /></td>
				</tr>
				<tr>
					<th>일정구분</th>
					<td colspan="3">
					<c:if test="${empty modify}">	
						<span>아파트행사</span>
						<input type="hidden" name="schdType" value="S001">
					</c:if>
					<c:if test="${!empty modify}">
						<c:choose>
							<c:when test="${schdVO.schdType eq 'S001'}">
								아파트행사
								<input type="hidden" name="schdType" value="S001">
							</c:when>
							<c:when test="${schdVO.schdType eq 'S002'}">
								아파트 수리
								<input type="hidden" name="schdType" value="S002">
							</c:when>
							<c:otherwise>
								세대 수리
								<input type="hidden" name="schdType" value="S003">
							</c:otherwise>
						</c:choose>
					</c:if>
					</td>
				</tr>
				<tr>
					<th>시작일</th>
					<td colspan="3"><input type="date" name="schdStart" value="${schdVO.schdStart }" required class="form-control"></td>
				</tr>
				<tr>
					<th>종료일</th>
					<td colspan="3"><input type="date" name="schdEnd" value="${schdVO.schdEnd }" required class="form-control"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea rows="5px;" name="schdContent" class="form-control">${schdVO.schdContent }</textarea></td>
				</tr>
			</tbody>
		</table>
	</div>	
	<!-- Modal footer -->
	<div class="modal-footer">
		<input type="submit" class="btn btn-primary" id="insertBtn" value="저장">
		<input type="reset" class="btn btn-secondary" value="초기화"> 
		<input type="button" class="btn btn-danger" id="closeBtn" value="닫기">
	</div>
</form:form>    
<script>
$("#insertEventForm").validate({
	rules: 
    {
		schdTitle: 
    	{
	        required: true,
	        maxlength: 15
        }
        ,schdContent:{maxlength: 200}
    }
});

</script>	
