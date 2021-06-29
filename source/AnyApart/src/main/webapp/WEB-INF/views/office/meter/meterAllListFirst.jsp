<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 25.  박정민      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<style>
  .u_ni_dashboard_component__3F04k{
	font-size: 13px;
	line-height: 1.5;
	font-family: Noto Sans DemiLight,AppleSDGothicNeo-Regular,'Malgun Gothic','맑은 고딕',dotum,'돋움',sans-serif;
	-webkit-font-smoothing: antialiased;
	color: #333;
	letter-spacing: -0.2px;
	margin: 0;
	position: relative;
	padding: 25px 30px;
	border-radius: 1px;
	border: 1px solid #E0E5EE;
	background: #fff;
	box-sizing: border-box;
	padding-bottom: 20px;
  }
#comm{
	margin-top: 3%;
	margin-left: 3%;
}
#comm th, td{
	text-align: center;
}
#elecDiv, #heatDiv{
	margin-left: 0px;
}
#indvByEnergyDiv .card-header{
	padding: 2px;
}
#indvByEnergyDiv .card-body{
	padding-top: 20px;
}
button.nav-link.active {
    margin-right: 3px;
    margin-left: 3px;
}
#commTableDiv{
	margin-right: 2%;
	margin-left: 4%;
}
#myTabContent {
    padding-left: 0px;
    padding-right: 0px;
}
#meterDiv{
	padding: 0px;
	height:1000px;
}
#commTableDiv td:nth-child(1){
	text-align: left;
	padding-left: 20px;
}
#commTableDiv td:nth-child(2), td:nth-child(3){
	text-align: right;
	padding-right: 20px;
}
#comm .card{
	height: 260px;
}
#commChartDiv{
	margin-bottom: 20px;
}
#thisYearDiv{
	width: 70%;
	margin: 30px 0 1% 5%;
}
#commTableDiv th, td{
	border: 1px solid #e9ecef;
}
#commCalyear, #indvCalyear{
	font-size: 2.0em;
	margin: 0 25px;
}
#pcyearBtn, #piyearBtn{
	margin-left: 40%;
}
img{
	height: 25px;
	margin-bottom: 2px;
}
hr{
	width: 180px;
	margin-left: 0px;
}
#indvTopDiv{
	margin-bottom: 5%;
	margin-left: 5%;
}
.down{
	color:red;
	font-size: 0.8em;
	padding-right: 20px;
}
.up{
	color:#39ea0c;
	font-size: 0.8em;
	padding-right: 20px;
}
</style>	
<c:set var="tmVO" value="${thisMonthMCVO }"/>
<c:set var="pmVO" value="${preMonthMCVO }"/>
<br>
<h4>전체검침</h4>
<br>
<div class="card col-md-12" id="meterDiv">
	<div>
		<ul class="nav nav-tabs " id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
		    	<button class="nav-link active" data-tabid='comm' type="button" role="tab" aria-controls="comm" aria-selected="true">공동검침</button>
		  	</li>
		  	<li class="nav-item" role="presentation">
		    	<button class="nav-link" data-tabid='indv' type="button" role="tab" aria-controls="indv" aria-selected="false" id="indvLi">세대검침</button>
		  	</li>
		</ul>
	</div>
	<div class="tab-content col-md-12" id="myTabContent">
	<%----------------------------------------------- 공동검침 ----------------------------------------------------------%>
		<div class="tab-pane fade show active" id="comm" role="tabpanel" aria-labelledby="comm-tab">
		■ 전월비교 
		<hr>
			<div class="row">
				<div class="card text-center col-md-4" id="commTableDiv">
					<table class="table table-border">
						<thead class="thead-light">
							<tr>
								<th>항목</th>
								<th>전월</th>
								<th>당월</th>
								<th>비교값</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>급탕</td>
								<td><fmt:formatNumber value="${pmVO.commHotwater }" pattern="#,###"/></td>
								<td><fmt:formatNumber value="${tmVO.commHotwater }" pattern="#,###"/></td>
								<td>
								<c:if test="${tmVO.commHotwater - pmVO.commHotwater >= 0}">
									<span class="down">${tmVO.commHotwater - pmVO.commHotwater }</span>😡
								</c:if>
								<c:if test="${tmVO.commHotwater - pmVO.commHotwater < 0}">
									<span class="up">${-(tmVO.commHotwater - pmVO.commHotwater) }</span>😊
								</c:if>
								</td>
							</tr>
							<tr>
								<td>수도(t)</td>
								<td><fmt:formatNumber value="${pmVO.commWater }" pattern="#,###"/></td>
								<td><fmt:formatNumber value="${tmVO.commWater }" pattern="#,###"/></td>
								<td>
								<c:if test="${tmVO.commWater - pmVO.commWater >= 0}">
									<span class="down">${tmVO.commWater - pmVO.commWater }</span>😡
								</c:if>
								<c:if test="${tmVO.commWater - pmVO.commWater < 0}">
									<span class="up">${-(tmVO.commWater - pmVO.commWater) }</span>😊
								</c:if>
								</td>
							</tr>
							<tr>
								<td>난방</td>
								<td><fmt:formatNumber value="${pmVO.commHeat }" pattern="#,###"/></td>
								<td><fmt:formatNumber value="${tmVO.commHeat }" pattern="#,###"/></td>
								<td>
								<c:if test="${tmVO.commHeat - pmVO.commHeat >= 0}">
									<span class="down">${tmVO.commHeat - pmVO.commHeat }</span>😡
								</c:if>
								<c:if test="${tmVO.commHeat - pmVO.commHeat < 0}">
									<span class="up">${-(tmVO.commHeat - pmVO.commHeat) }</span>😊
								</c:if>
								</td>
							</tr>
							<tr>
								<td>전기(kWh)</td>
								<td><fmt:formatNumber value="${pmVO.commElec }" pattern="#,###"/></td>
								<td><fmt:formatNumber value="${tmVO.commElec }" pattern="#,###"/></td>
								<td>
								<c:if test="${tmVO.commElec - pmVO.commElec >= 0}">
									<span class="down">${tmVO.commElec - pmVO.commElec }</span>😡
								</c:if>
								<c:if test="${tmVO.commElec - pmVO.commElec < 0}">
									<span class="up">${-(tmVO.commElec - pmVO.commElec) }</span>😊
								</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="card col-md-6" id="commChartDiv">
					<canvas id="water" style="height:50%;width:100%;"></canvas>
					<canvas id="heat" style="height:50%;width:100%;"></canvas>
				</div>
			</div><br><br>
			■ 연도별 비교
			<hr>
			<img src="${cPath }/images/pyear.png" class="pcyearBtn" >
			<span id="commCalyear">2021</span>
			<img src="${cPath }/images/nyear.png" class="ncyearBtn">
			<div class="row">
				<div class="card col-md-10" id="thisYearDiv">
					<canvas id="thisYear" style="height:500px;width:100%;"></canvas>
				</div>
				<span style="margin-left: 5%;">- 차트 레이블에서 검침항목을 선택하면 해당항목이 사라지며 나머지 그래프 변화를 상세히 보실 수 있습니다.</span>
			</div>
		</div>
	<%----------------------------------------------------- 세대검침 -------------------------------------------------------------%>
	  	<div class="tab-pane fade" id="indv" role="tabpanel" aria-labelledby="indv-tab">
	  	<br>
	  		<div id="indvTopDiv">
		  		동 선택
				<select name="dong" onchange="indvByEnergyDongSelect(this.value)" class="custom-select col-md-2 searchSelect" >
					<option>1401</option>
					<option>1403</option>
					<option>1406</option>
				</select><br>
		  	</div> 
		  		<img src="${cPath }/images/pyear.png" class="piyearBtn" >
				<span id="indvCalyear">2021</span>
				<img src="${cPath }/images/nyear.png" class="niyearBtn">
	  		<div class="row" id="indvByEnergyDiv">
	  			<div class="col-md-5" style="margin-left: 5%;">
			  		<div class="card text-center mb-4" id="elecDiv">
			  			<div class="card-body">
			  				<canvas id="elecIndvByEnergyCanvas" width="550%" height="180%"></canvas>
			  			</div>
			  		</div>
			  		<div class="card text-center mb-4" id="hotWaterDiv">
			  			<div class="card-body">
			 	 			<canvas id="hotWaterIndvByEnergyCanvas" width="550%" height="180%"></canvas>
			 	 		</div>	
			  		</div>
	  			</div>
	  			<div class="col-md-5">
			  		<div class="card text-center mb-4" id="heatDiv">
			  			<div class="card-body">
			 	 			<canvas id="heatIndvByEnergyCanvas" width="550%" height="180%"></canvas>
			 	 		</div>	
			  		</div>
			  		<div class="card text-center mb-4" id="waterDiv">
			  			<div class="card-body">
				  			<canvas id="waterIndvByEnergyCanvas" width="550%" height="180%"></canvas>
				  		</div>	
			  		</div>
			  	</div>	
	  		</div>
	  	</div>
	</div>
</div>
<script>
let indv = $("#indv");
var dong = indv.find("[name='dong']").val();
$(document).ready(function(){
	makeCommYearList("0000");
	indvByEnergyDongSelect(dong, Number("0000"));
});

<%--===================================================================== 세대검침 ===========================================================================--%>
let indvYearSpan = $("#indvCalyear");
function indvByEnergyDongSelect(dong, indvYear){
	let year = indvYearSpan.text();
	if(indvYear==null){
		indvYear = year;
	}
	$.ajax({
		url:"${cPath}/office/meter/meterIndvByEnergyAjax.do"
		,data:{"dong":dong, "indvYear":indvYear}
		,dataType:"json"
		,success:function(dongListByEnergy){  //선택한 동에대한 각 에너지 총 합 가져옴.
			let elecSumArr = [];
			let waterSumArr = [];
			let heatSumArr = [];
			let hotWaterSumArr = [];
			if(dongListByEnergy){
				$(dongListByEnergy).each(function(idx, indv){
					elecSumArr.push(indv.elecSum);
					waterSumArr.push(indv.waterSum);
					heatSumArr.push(indv.heatSum);
					hotWaterSumArr.push(indv.hotWaterSum);
				});
				elecSumArr.push(0);
				waterSumArr.push(0);
				heatSumArr.push(0);
				hotWaterSumArr.push(0);
			}
			elecIndvByEnergyCanvasByEnergyChart.data.datasets[0].data = elecSumArr;
			elecIndvByEnergyCanvasByEnergyChart.update();
			waterIndvByEnergyCanvasByEnergyChart.data.datasets[0].data = waterSumArr;
			waterIndvByEnergyCanvasByEnergyChart.update();
			heatIndvByEnergyCanvasByEnergyChart.data.datasets[0].data = heatSumArr;
			heatIndvByEnergyCanvasByEnergyChart.update();
			hotWaterIndvByEnergyCanvasByEnergyChart.data.datasets[0].data = hotWaterSumArr;
			hotWaterIndvByEnergyCanvasByEnergyChart.update();
		}
		,error:function(xhr){
			console.log("에러"+xhr.status);
		}
	});
	
}

$(".piyearBtn").on("click", function(){
	let year = indvYearSpan.text();
	indvByEnergyDongSelect(dong, year-1);
	indvYearSpan.text(year-1);
});
$(".niyearBtn").on("click", function(){
	let year = indvYearSpan.text();
	indvByEnergyDongSelect(dong, Number(year)+1);
	indvYearSpan.text(Number(year)+1);
});

var indvOptions = {responsive: false};
var elecIndvByEnergyCanvasByEnergyChart = new Chart(document.getElementById('elecIndvByEnergyCanvas'), {
    type: 'bar',
    data : {
   	    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   	    datasets: [{
   	    	label: "전기 검침량"
   	        ,data: []
		   	,backgroundColor: ['rgba(54, 162, 235, 0.2)','rgba(54, 162, 235, 0.2)','rgba(54, 162, 235, 0.2)'
							,'rgba(54, 162, 235, 0.2)','rgba(54, 162, 235, 0.2)','rgba(54, 162, 235, 0.2)'
							,'rgba(54, 162, 235, 0.2)','rgba(54, 162, 235, 0.2)','rgba(54, 162, 235, 0.2)'
							,'rgba(54, 162, 235, 0.2)','rgba(54, 162, 235, 0.2)','rgba(54, 162, 235, 0.2)'
			]
   	    }]
   	},
   	options: indvOptions
});
var waterIndvByEnergyCanvasByEnergyChart = new Chart(document.getElementById('waterIndvByEnergyCanvas'), {
    type: 'bar',
    data : {
   	    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   	    datasets: [{
   	    	label: "수도 검침량"
   	    	,data: []
		   	,backgroundColor: ['rgba(255, 136, 176, 0.2)','rgba(255, 136, 176, 0.2)','rgba(255, 136, 176, 0.2)'
							,'rgba(255, 136, 176, 0.2)'	,'rgba(255, 136, 176, 0.2)'	,'rgba(255, 136, 176, 0.2)'
							,'rgba(255, 136, 176, 0.2)'	,'rgba(255, 136, 176, 0.2)' ,'rgba(255, 136, 176, 0.2)'
							,'rgba(255, 136, 176, 0.2)'	,'rgba(255, 136, 176, 0.2)'	,'rgba(255, 136, 176, 0.2)'
			]
   	    }]
   	},
   	options: indvOptions
});
var heatIndvByEnergyCanvasByEnergyChart = new Chart(document.getElementById('heatIndvByEnergyCanvas'), {
    type: 'bar',
    data : {
   	    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   	    datasets: [{
   	    	label: "난방 검침량"
   	        ,data: []
		   	,backgroundColor: ['rgba(62, 160, 88, 0.2)','rgba(62, 160, 88, 0.2)','rgba(62, 160, 88, 0.2)'
							,'rgba(62, 160, 88, 0.2)','rgba(62, 160, 88, 0.2)','rgba(62, 160, 88, 0.2)'
							,'rgba(62, 160, 88, 0.2)','rgba(62, 160, 88, 0.2)','rgba(62, 160, 88, 0.2)'
							,'rgba(62, 160, 88, 0.2)','rgba(62, 160, 88, 0.2)','rgba(62, 160, 88, 0.2)'
			]
   	    }]
   	},
   	options: indvOptions
});
var hotWaterIndvByEnergyCanvasByEnergyChart = new Chart(document.getElementById('hotWaterIndvByEnergyCanvas'), {
    type: 'bar',
    data : {
   	    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   	    datasets: [{
   	    	label: "급탕 검침량"
   	        ,data: []
		   	,backgroundColor: ['rgba(255, 169, 24, 0.2)','rgba(255, 169, 24, 0.2)','rgba(255, 169, 24, 0.2)'
				,'rgba(255, 169, 24, 0.2)','rgba(255, 169, 24, 0.2)','rgba(255, 169, 24, 0.2)'
				,'rgba(255, 169, 24, 0.2)','rgba(255, 169, 24, 0.2)','rgba(255, 169, 24, 0.2)'
				,'rgba(255, 169, 24, 0.2)','rgba(255, 169, 24, 0.2)','rgba(255, 169, 24, 0.2)'
			]
   	    }]
   	},
   	options: indvOptions
});

<%--===================================================================== 공동검침 ===========================================================================--%>
function makeCommYearList(year){
	$.ajax({
		url:"${cPath}/office/meter/meterCommByEnergyAjax.do"
		,data:{"year":year}
		,dataType:"json"
		,success:function(thisYearList){
			let elecSumArr = [];
			let waterSumArr = [];
			let heatSumArr = [];
			let hotWaterSumArr = [];
			if(thisYearList){
				$(thisYearList).each(function(idx, comm){
					hotWaterSumArr.push(comm.hotWaterSum);
					waterSumArr.push(comm.waterSum);
					heatSumArr.push(comm.heatSum*0.001);
					elecSumArr.push(comm.elecSum*0.01);
				});
			}
			thisYearChart.data.datasets[0].data = hotWaterSumArr;
			thisYearChart.data.datasets[1].data = waterSumArr;
			thisYearChart.data.datasets[2].data = heatSumArr;
			thisYearChart.data.datasets[3].data = elecSumArr;
			thisYearChart.update();
		}
		,error:function(xhr){
			console.log("에러"+xhr.status);
		}
	});
}
let yearSpan = $("#commCalyear");
$(".pcyearBtn").on("click", function(){
	let year = yearSpan.text()-1;
	makeCommYearList(year);
	yearSpan.text(year);
});
$(".ncyearBtn").on("click", function(){
	let year = Number(yearSpan.text())+1;
	makeCommYearList(year);
	yearSpan.text(year);
});


let thisMonthWater = []
let thisMonthHeat = []
thisMonthWater.push(${tmVO.commHotwater});
thisMonthWater.push(${tmVO.commWater});
thisMonthWater.push(0);
thisMonthHeat.push(${tmVO.commHeat});
thisMonthHeat.push(${tmVO.commElec});

let preMonthWater = []
let preMonthHeat = []
preMonthHeat.push(${pmVO.commHeat});
preMonthHeat.push(${pmVO.commElec});
preMonthWater.push(${pmVO.commHotwater});
preMonthWater.push(${pmVO.commWater});

<%-------------------------------------- 급탕, 수도 ------------------------------------------%>
var ctx1 = document.getElementById('water');
var waterChart = new Chart(ctx1, {
    type: 'horizontalBar',
    data : {
   	    labels: ['급탕       ', '수도(t)   '],
   	    datasets: [{
   	    	label: "${pmVO.commMonth}월"
   	        ,data: preMonthWater
			,backgroundColor: [
				'rgba(23, 28, 42, 0.2)'
				,'rgba(23, 28, 42, 0.2)'
			]
			,borderColor: [
				'rgba(23, 28, 42, 0.2)'
				,'rgba(23, 28, 42, 0.2)'
			]	
   	    },
   	 	{
   	    	label: "${tmVO.commMonth}월"
   	        ,data: thisMonthWater
		   	,backgroundColor: [
		   		'rgba(54, 162, 235, 0.2)'
				,'rgba(54, 162, 235, 0.2)'
			]
			,borderColor: [
				'rgba(54, 162, 235, 0.2)'
				,'rgba(54, 162, 235, 0.2)'
			]
   	    }]
   	},
   	options: {
   		responsive: false
	}
});

<%-------------------------------------- 난방, 전기 ------------------------------------------%>
var ctx2 = document.getElementById('heat');
var heatChart = new Chart(ctx2, {
    type: 'horizontalBar',
    data : {
   	    labels: ['난방         ', '전기(kwh)'],
   	    datasets: [{
   	    	label: "${pmVO.commMonth}월"
   	        ,data: preMonthHeat
			,backgroundColor: [
				'rgba(23, 28, 42, 0.2)'
				,'rgba(23, 28, 42, 0.2)'
			]
			,borderColor: [
				'rgba(23, 28, 42, 0.2)'
				,'rgba(23, 28, 42, 0.2)'
			]	
   	    },
   	 	{
   	    	label: "${tmVO.commMonth}월"
   	        ,data: thisMonthHeat
		   	,backgroundColor: [
		   		'rgba(54, 162, 235, 0.2)'
				,'rgba(54, 162, 235, 0.2)'
			]
			,borderColor: [
				'rgba(54, 162, 235, 0.2)'
				,'rgba(54, 162, 235, 0.2)'
			]	
   	    }]
   	},
   	options: {
   		responsive: false
	}
});
<%-------------------------------------- 이번년도 전체 차트 ------------------------------------------%>
var ctx3 = document.getElementById('thisYear');
var thisYearChart = new Chart(ctx3, {
    type: 'line',
    data : {
   	    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   	    datasets: [{
   	    	label: ["급탕"]
   	    	,fill:false
   	        ,data: []
		   	,backgroundColor: [
		   		'rgba(0, 255, 0, 1)'
			]
			,borderColor: [
				'rgba(0, 255, 0, 1)'
			]	
   	    },
   	    {
   	    	label: ["수도"]
   	        ,data: []
   	 		,fill:false
		   	,backgroundColor: [
		   		'rgba(255, 238, 119, 1)'
			]
			,borderColor: [
				'rgba(255, 238, 119, 1)'
			]	
   	    },
   	    {
   	    	label: ["난방"]
   	        ,data: []
   	 		,fill:false
		   	,backgroundColor: [
		   		'rgba(0, 0, 255, 1)'
			]
			,borderColor: [
				'rgba(0, 0, 255, 1)'
			]	
   	    },
   	    {
   	    	label: ["전기"]
   	        ,data: []
   	 		,fill:false
		   	,backgroundColor: [
		   		'rgba(255, 0, 0, 1)'
			]
			,borderColor: [
				'rgba(255, 0, 0, 1)'
			]	
   	    }]
   	},
   	options: {
   		responsive: false   		
	}
});

//--------------------- 탭메뉴 ---------------------------
$(document).ready(function(){
	$('#myTab button').click(function(){
		$('#myTab').find(".nav-link").removeClass('active');
		$('.tab-content').find(".tab-pane").removeClass('show active');
		
		let contentId = $(this).data("tabid");
		$(this).addClass('active');
		$('#'+contentId).addClass("show active");
	});
});
</script>