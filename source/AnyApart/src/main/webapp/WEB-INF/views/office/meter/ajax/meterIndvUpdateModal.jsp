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
	margin-left: 70%;
}
</style>
<c:set var="miVO" value="${miVO }" />    
<form id="updateForm" action="${cPath }/office/meter/modifyMeterIndv.do" method="post">
	<input type="hidden" name="indvNo" value="${miVO.indvNo }"/>
	<table class="table">
		<tr>
			<td><span class="reddot">* </span>검침연</td>
			<td><input type="number" name="indvYear" value="${miVO.indvYear }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>검침월</td>
			<td><input type="number" name="indvMonth" value="${miVO.indvMonth }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>난방검침량</td>
			<td colspan="2"><input type="number" name="indvHeat" value="${miVO.indvHeat }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>급탕검침량</td>
			<td colspan="2"><input type="number" name="indvHotwater" value="${miVO.indvHotwater }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>수도검침량</td>
			<td colspan="2"><input type="number" name="indvWater" value="${miVO.indvWater }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>전기검침량</td>
			<td colspan="2"><input type="number" name="indvElec" value="${miVO.indvElec }" required></td>
		</tr>
		<tr>
			<td><span class="reddot">* </span>입주민코드</td>
			<td colspan="2"><input type="text" name="memId" value="${miVO.memId }" required></td>
		</tr>
	</table>
	
	<button type="button" id="insertBtn" class="btn btn-primary">등록</button>
	<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
</form>    

<script>
$("#updateForm").validate({
	rules: 
    {
		indvYear: {maxlength: 4}
	    ,indvMonth:{maxlength: 2}
	    ,indvHeat:{maxlength: 12}
	    ,indvHotwater:{maxlength: 12}
	    ,indvWater:{maxlength: 12}
	    ,indvElec:{maxlength: 12}
    }
});

</script>
