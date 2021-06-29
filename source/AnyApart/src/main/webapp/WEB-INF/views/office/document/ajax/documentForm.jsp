<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 2. 5.    박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>
<style>
#insertTable th{
	background-color: #E9ECEF;
	text-align: center;
}
#insertTable td{
	text-align: left;
}
img{
	width: 20px;
	height: 20px;
}
#insertBtn{
	margin-left: 0px;
}
textarea.form-control {
    height: 100px;
}
</style>
<c:set var="command" value="${command }"/>
<br>
<form:form commandName="boardVO" id="insertForm" enctype="multipart/form-data" method="post">
<!-- Modal Header -->
<div class="modal-header">
	<c:if test="${'MODIFY' eq command }">
	<h4>일반문서 수정</h4>
	</c:if>
	<c:if test="${'MODIFY' ne command }">
	<h4>일반문서 등록</h4>
	</c:if>
	<button type="button" class="close" id="closeBtn" data-dismiss="modal">X</button>
</div>
<br>
<!-- Modal body -->
<div class="modal-body">
<c:set var="boardVO" value="${boardVO }"/>
	<input type="hidden" name="boWriter" value="${authMember.memId }"/>
	<input type="hidden" name="boHit" value="${boardVO.boHit }"/>
	<table class="table table-bordered" id="insertTable">
		<tbody id="tbodyViewResult">
			<tr>
				<th>제목</th>
				<td colspan="3"><form:input path="boTitle" required="required" cssClass="form-control"/></td>
			</tr>
			<tr>
				<th>작성자ID</th>
				<td colspan="3">${authMember.memId }</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td colspan="3">${authMember.memNick }</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
				<c:if test="${not empty boardVO.attachList and 'MODIFY' eq command}">
					<c:forEach items="${boardVO.attachList }" var="att">
						<span>
						<img src="${cPath }/images/delete.png" class="delAtt" data-attsn="${att.attSn }">
						${att.attFilename }</span>
					</c:forEach>
				</c:if>
					<input type="file" multiple="multiple" name="boFiles" value="${boardVO.attachList }">
					<form:errors name="boFiles" element="span" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textArea row="20px" name="boContent" required class="form-control">${boardVO.boContent }</textArea>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- Modal footer -->
<div class="modal-footer">
	<input type="submit" class="btn btn-primary" id="insertBtn" value="저장">
	<input type="button" class="btn btn-danger" id="cancleBtn" data-dismiss="modal" value="취소">
</div>
</form:form>	
<script type="text/javascript">
let insertForm = $("#insertForm");
insertForm.validate({
	rules: {
		boTitle: {maxlength: 15}
    }
});

//---------------- 기존 첨부파일 삭제 시 delAttNos에 추가 -------------------
$(".delAtt").on("click", function(){
	let attSn = $(this).data("attsn");
	insertForm.append(
		$("<input>").attr({
			"type":"hidden"
			, "name":"delAttNos"
		}).val(attSn)		
	);
	$(this).parent("span:first").hide();
});

$("[name='boFiles']").on("blur", function(){
});
</script>