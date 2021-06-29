<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 26.      박지수      최초작성
* 2021. 2. 13.      박지수      name 등 수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<div class="container col-sm-5 mt-3">
<br>
<h4><strong>계정설정 </strong></h4>
<br>
</div>
<div class="container col-sm-5 card-header card-footer">
	 <form id="fm" method="post">
		 	<security:authentication property="principal" var="principal" />
	        <c:set var="authMember" value="${principal.realMember }" />
        	<input type="hidden" name="memId" value="${authMember.memId }"/>
		  <div class="row mb-4 mt-5 ml-4">
			    <label for="currentPass" class="col-sm-6 col-form-label ">현재 비밀번호</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="now" name="currentPass">
			    </div>
		  </div>
		  <div class="row mb-4 ml-4">
		  	<span style="color: blue">**비밀번호 변경시 영문자, 숫자, 특수문자 포함해 8~12 까지 가능합니다.</span>
			    <label for="memPass" class="col-sm-6 col-form-label ">새 비밀번호</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="memPass" name="memPass">
			    </div>
		  </div>
		  <div class="row mb-4 ml-4">
			    <label for="checkPass" class="col-sm-6 col-form-label ">비밀번호 확인</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="checkPass" name="checkPass">
			    </div>
		  </div>
		   <div class="d-flex justify-content-end">
			   <button id="submitBtn" class="btn btn-dark" style='margin:5pt;'>변경</button>
		   </div>
	</form>
</div>

<script>
let checkPass;
let updatePass;
let fm = $("#fm");
 
$("#submitBtn").on("click", function(){
	checkPass = $("#checkPass");
	updatePass = $("#memPass");
	
	if(checkPass.val() != updatePass.val()) {
	     alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
	     checkPass.focus();
	     return false;
	}else{
		fm.serialize();
		fm.method = "post";
		fm.submit();
	}
});
 
</script>