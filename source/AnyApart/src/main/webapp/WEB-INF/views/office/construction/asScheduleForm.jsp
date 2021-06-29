<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 2. 10.    박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<style>
#insertDiv{
	margin-left: 15%;
	width: 60%;
}
th{
	background-color: #E9ECEF;
	color: black;
	text-align: center;
}
#insertForm th{
	background-color: #343A40;
	color: white;
	text-align: center;
}
#insertBtn{
	margin-left: 38%; 
}
</style>

<c:set var="asVO" value="${asVO }"/>
<br>
<h2><strong>수리 일정 등록</strong></h2>
<div id="insertDiv">

<br>
<p> ■ 신청내역</p>
<table class="table table-bordered" >
	<colgroup>
		<col width="25%;">
	</colgroup>
	<tbody>
		<tr>
			<th>제목</th>
			<td>${asVO.asTitle }</td>
		</tr>
		<tr>
			<th>시설분류</th>
			<c:if test="${asVO.asCode eq 'ASRES'}">
				<td>세대 수선</td>
				<input type="hidden" name="schdType" value="S003">
			</c:if>
			<c:if test="${asVO.asCode eq 'ASAPT'}">
				<td>아파트 수선</td>
				<input type="hidden" name="schdType" value="S002">
			</c:if>
		</tr>
		<tr>
			<th>신청일</th>
			<td>${asVO.asDate }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${asVO.asContent }</td>
		</tr>
	</tbody>
</table>

<p> ■ 일정등록</p>
<form method="post" id="insertForm">
<input type="hidden" name="aptCode" value="${authMember.aptCode }">
<input type="hidden" name="applyNo" value="${asVO.asNo}">
<c:if test="${asVO.asCode eq 'ASRES'}">
	<input type="hidden" name="schdType" value="S003">
</c:if>
<c:if test="${asVO.asCode eq 'ASAPT'}">
	<input type="hidden" name="schdType" value="S002">
</c:if>
<table class="table table-bordered">
	<colgroup>
		<col width="25%;">
		<col width="25%;">
		<col width="25%;">
		<col width="25%;">
	</colgroup>
	<tbody>
		<tr>
			<th>제목</th>
			<c:if test="${asVO.asCode eq 'ASRES'}">
				<td colspan="3"><input type="text" name="schdTitle" value="${asVO.dong }동 ${asVO.ho }호 세대수선" class="form-control" readonly></td>
			</c:if>
			<c:if test="${asVO.asCode eq 'ASAPT'}">
				<td colspan='3'><input type="text" name="schdTitle" class="form-control" required></td>
			</c:if>
		</tr>
		<tr>
			<th>시작일</th>
			<td><input type="date" name="schdStart" class="form-control" required></td>
			<th>종료일</th>
			<td><input type="date" name="schdEnd" class="form-control" required></td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3">
				<textarea row="5px" col="500px" name="schdContent" class="form-control"></textarea>
			</td>
		</tr>
	</tbody>
</table>   
<br>
<input type="submit" class="btn btn-primary" id="insertBtn" value="등록"> 
<input type="reset" class="btn btn-secondary" value="초기화"> 
<input type="button" class="btn btn-dark" id="goList" value="목록으로"> 
</form>  
</div>

<script>
$("#insertForm").validate({
	rules: 
    {
		schdTitle: 
    	{
	        required: true,
	        maxlength: 50
        }
        ,schdContent:{maxlength: 200}
    }
});

$("#goList").on("click", function(){
	searchForm.attr("action","${cPath}/office/construction/afterServiceList.do");
	searchForm.submit();
});
</script>