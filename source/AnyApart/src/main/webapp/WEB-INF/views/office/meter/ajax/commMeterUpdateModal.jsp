<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 2. 19.    박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.btn-primary{
	margin-left: 55%;
}
</style>
<c:set var="cmVO" value="${cmVO }" />    
<form id="updateForm" action="${cPath }/office/meter/modifyMeterComm.do" method="post">
	<input type="hidden" name="aptCode" value="${auth.aptCode }"/>
	<input type="hidden" name="commNo" value="${cmVO.commNo }"/>
	<table class="table">
		<tr>
			<td><span class="reddot">* </span>검침연</td>
			<td><input type="number" name="commYear" value="${cmVO.commYear }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>검침월</td>
			<td><input type="number" name="commMonth" value="${cmVO.commMonth }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>난방검침량</td>
			<td colspan="2"><input type="number" name="commHeat" value="${cmVO.commHeat }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>급탕검침량</td>
			<td colspan="2"><input type="number" name="commHotwater" value="${cmVO.commHotwater }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>수도검침량</td>
			<td colspan="2"><input type="number" name="commWater" value="${cmVO.commWater }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>전기검침량</td>
			<td colspan="2"><input type="number" name="commElec" value="${cmVO.commElec }" required></td>
		</tr>
	</table>
	
	<button type="submit" class="btn btn-primary">등록</button>
	<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
</form>    

<script>
$("#updateForm").validate({
	rules: 
    {
		commYear: {maxlength: 4}
        ,commMonth:{maxlength: 2}
        ,commHeat:{maxlength: 12}
        ,commHotwater:{maxlength: 12}
        ,commWater:{maxlength: 12}
        ,commElec:{maxlength: 12}
    }
});
</script>
