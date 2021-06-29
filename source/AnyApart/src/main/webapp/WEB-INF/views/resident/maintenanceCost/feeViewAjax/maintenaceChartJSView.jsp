<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
.column {  
     float: left;  
    width: 48%;  
     padding: 15px;  
   }   
</style>


<div class="row" style="width: 900px">

<div class ="column" align="right">
	<canvas id="costTypeChar" width="100%" height="100%"></canvas>
</div>
<div class= "column" align="left">
	<div>
		<table class="table-bordered">
			<tr>
				<th colspan="4">동일면적 평균표</th>
			</tr>
			<tr>
				<th>년도/월</th>
				<th>우리집 금액</th>
				<th>동일면적 평균</th>
			</tr>
			<tbody id="costTbody">
			<c:if test="${not empty costTypeList }">
			<c:forEach items="${costTypeList }" var="costList">
			<tr>
				<td>${costList.costYear }/ ${costList.costMonth }</td>
				<td style="text-align: right;">${costList.costType}원</td>
				<td style="text-align: right;"></td>
			</tr>
			</c:forEach>
			</c:if>
			</tbody>	
		</table>
	</div>
</div>
</div>
<c:if test="${not empty costTypeList }">
<div id="datadiv">
<c:forEach items="${costTypeList }" var="costList">
	<input type="hidden" name="mon" value="${costList.costYear }년 ${costList.costMonth }월">
	<input type="hidden" name="cost" value="${costList.costType}">
</c:forEach>

<c:forEach items="${costSameAreaList}" var="costList">
	<input type="hidden" name="sameCost" value="${costList.sameAreaAvg}">
</c:forEach>
</div>
</c:if>

<script type="text/javascript">

var chart5 = document.getElementById('costTypeChar');
var month = [];
var cost = [];
var sameCost = [];
$("input[name=mon]").each(function(index,item){
	month.push($(item).val());
})
$("input[name=cost]").each(function(index,item){
	cost.push($(item).val());
	$("#costTbody > tr:nth-child("+index+") > td:nth-child(2)").html($(item).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+"원");
})
$("input[name=sameCost]").each(function(index,item){
	sameCost.push($(item).val());
	$("#costTbody > tr:nth-child("+index+") > td:nth-child(3)").html($(item).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+"원");
	
	
})
var costTypeChar = new Chart(chart5, {
	type: 'line',//[https://www.chartjs.org/docs/latest/axes/ <<(컨트롤 +우클릭)
	//여기 가서 원하는 타입 바꿔주면 모양바껴용
	
	data: {
		labels: month,
		datasets: [{
			label: '금액',
			type: 'bar',
			data: cost,//값들 입력
			backgroundColor: 'rgba(187, 193, 83, 0.6)',
			borderWidth: 2
		}
		,
		{
			label: '평균',
			data: sameCost,//값들 입력
			borderColor: 'rgba(144, 99, 132, 1)',// 값 갯수당 만들고 색깔 
			backgroundColor: 'rgba(0, 0, 0, 0)',
			borderWidth: 2
		}
		
		]
	}
});


</script>