<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 1. 29.    박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>

<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>

<style>
#formDiv{
	width: 90%;
	padding: 20px;
	margin-right: 0px;
}
th, td{
	padding: 10px;
}
th{
	text-align: center;
	background-color: #FBF9FA;
}
#insertBtn{
	margin-left: 43%;
	margin-top: 50px;
	margin-right: 0px;
}
#resetBtn, #goListBtn{
	margin-top: 50px;
}
#rowDiv{
	margin: 0px;
}
table{
	width: 80%;
	border: 1px solid #DDDDDD; 
}
input, select{
	border: 1px solid #DDDDDD; 
}
</style>
<h4>수리신청</h4>
<c:set var="asVO" value="${asVO}" />   
<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>

<div id="formDiv">
<form:form commandName="asVO" method="post" id="repairForm">
	<form:hidden path="memId" value="${authMember.memId }"/>
	<form:hidden path="asStatus" value="ASING"/>
	<table class="table table-bordered">
		<tbody>
			<tr>
				<th scope="row">시설선택</th>
				<td>
					<select name="asCode" required class="form-control">
						<option value>선택</option>
						<option value="ASRES" ${'ASRES' eq asVO.asCode?"selected":"" }>세대 수리 신청</option>
						<option value="ASAPT" ${'ASAPT' eq asVO.asCode?"selected":"" }>아파트 시설 수리 신청</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td>
					<form:input path="asTitle" name="asTitle" required="required" class="form-control"/>
					<form:errors path="asTitle" element="span" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td>
				<form:textarea path="asContent" name="asContent" cssClass="form-control" required="required" style="height: 500px;"/>
				<form:errors path="asContent" element="span" cssClass="error" />
				</td>
			</tr>
		</tbody>
	</table>	
	<input type="submit" id="insertBtn" class="btn btn-default" value="등록">
	<input type="reset" id="resetBtn" class="btn btn-secondary" value="취소">
	<input type="button" id="goListBtn" class="btn btn-primary" value="목록으로">
</form:form>	
</div>
<script>
CKEDITOR.replace("asContent",{
	filebrowserImageUploadUrl: '${cPath}/resident/space/imageUpload.do?command=QuickUpload&type=Images'
	, height : '500px'		
});

let repairForm = $("#repairForm");

repairForm.validate({
	rules: 
    {
		asTitle: 
    	{
	        required: true,
	        maxlength: 15
        }
        ,asContent:{maxlength: 200, minlength:1}
    }
});

$("#goListBtn").on("click", function(){
	location.href="${cPath}/resident/support/afterServiceList.do";
});
</script>