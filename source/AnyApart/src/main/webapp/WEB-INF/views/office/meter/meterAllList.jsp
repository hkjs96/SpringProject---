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
#comm, #indv{
	margin-top: 3%;
	margin-left: 3%;
}
#comm th, td{
	text-align: center;
	border: 1px solid #e9ecef;
}
button.nav-link.active {
    margin-right: 3px;
    margin-left: 3px;
}
#myTabContent {
    padding-left: 0px;
    padding-right: 0px;
}
#meterDiv{
	padding: 0px;
}
#comm td:nth-child(1){
	text-align: left;
	padding-left: 40px;
}
#comm td:nth-child(2), td:nth-child(3){
	text-align: right;
	padding-right: 20px;
}
#commChartDiv{
	margin-bottom: 20px;
}
#thisYearDiv{
	width: 70%;
	margin: 30px 0 1% 5%;
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
#energyTextDiv{
	margin-top: 30px;
	margin-right: 12%;
	text-align: center;
	font-weight: 600;
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
#dateSpan{
	font-weight: bolder;
	color:#3D45EF;
}
#percentSpan{
	color:red;
	font-size: 1.3em;
}
#commChartDiv1, #commChartDiv2{
	margin-left: 15%;
	margin-top: 50px;
}
#commChartDiv2{
	margin-top: 100px;
}
#energyCalDiv{
	margin-left: 40%;
}
</style>	
<c:set var="tmVO" value="${thisMonthMCVO }"/>
<c:set var="pmVO" value="${preMonthMCVO }"/>
<c:set var="apart" value="${apart }"/>

<br>
<h2>
	<strong>검침 통계</strong>
</h2>
<br>
<div class="card col-md-12" id="meterDiv">
	<div>
		<ul class="nav nav-tabs " id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
		    	<button class="nav-link active" data-tabid='comm' type="button" role="tab" aria-controls="comm" aria-selected="true">전월 비교</button>
		  	</li>
		  	<li class="nav-item" role="presentation">
		    	<button class="nav-link" data-tabid='indv' type="button" role="tab" aria-controls="indv" aria-selected="false" id="yearTabBtn">연도별 비교</button>
		  	</li>
		</ul>
	</div>
	<div class="tab-content col-md-12" id="myTabContent">
	<%----------------------------------------------- 공동검침 ----------------------------------------------------------%>
		<div class="tab-pane fade show active" id="comm" role="tabpanel" aria-labelledby="comm-tab">
			<h4>■ 전월대비 에너지 사용량 </h4>
			<div id="energyTextDiv">
				<span id="dateSpan"><span id="thisYearSpan"></span>년 <span id="thisMonthSpan"></span>월</span> 기준, ${apart.aptName } 아파트
				에너지(전기/난방/수도/급탕) 사용량은<br> 전월 대비 <span id="percentSpan"></span>하였습니다.
			</div>
			<div class="row" id="commChartDiv1">
				<div class="col-md-9">
					<canvas id="water" style="height:60%;width:100%;"></canvas>
					<table class="table">
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
								<td>급탕(m<sup>3</sup>)</td>
								<td><fmt:formatNumber value="${pmVO.commHotwater }" pattern="#,###"/></td>
								<td><fmt:formatNumber value="${tmVO.commHotwater }" pattern="#,###"/></td>
								<td>
								<c:if test="${tmVO.commHotwater - pmVO.commHotwater > 0}">
									<span class="down">${tmVO.commHotwater - pmVO.commHotwater }</span>😡
								</c:if>
								<c:if test="${tmVO.commHotwater - pmVO.commHotwater <= 0}">
									<span class="up">${-(tmVO.commHotwater - pmVO.commHotwater) }</span>😊
								</c:if>
								</td>
							</tr>
							<tr>
								<td>수도(m<sup>3</sup>)</td>
								<td><fmt:formatNumber value="${pmVO.commWater }" pattern="#,###"/></td>
								<td><fmt:formatNumber value="${tmVO.commWater }" pattern="#,###"/></td>
								<td>
								<c:if test="${tmVO.commWater - pmVO.commWater > 0}">
									<span class="down">${tmVO.commWater - pmVO.commWater }</span>😡
								</c:if>
								<c:if test="${tmVO.commWater - pmVO.commWater <= 0}">
									<span class="up">${-(tmVO.commWater - pmVO.commWater) }</span>😊
								</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>		
			<div class="row" id="commChartDiv2">
				<div class="col-md-9">
					<canvas id="heat" style="height:60%;width:100%;"></canvas>
					<table class="table" style="margin-bottom: 10%;">
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
								<td>전기(kWh)</td>
								<td><fmt:formatNumber value="${pmVO.commElec }" pattern="#,###"/></td>
								<td><fmt:formatNumber value="${tmVO.commElec }" pattern="#,###"/></td>
								<td>
								<c:if test="${tmVO.commElec - pmVO.commElec > 0}">
									<span class="down">${tmVO.commElec - pmVO.commElec }</span>😡
								</c:if>
								<c:if test="${tmVO.commElec - pmVO.commElec <= 0}">
									<span class="up">${-(tmVO.commElec - pmVO.commElec) }</span>😊
								</c:if>
								</td>
							</tr>
							<tr>
								<td>난방(kWh)</td>
								<td><fmt:formatNumber value="${pmVO.commHeat }" pattern="#,###"/></td>
								<td><fmt:formatNumber value="${tmVO.commHeat }" pattern="#,###"/></td>
								<td>
								<c:if test="${tmVO.commHeat - pmVO.commHeat > 0}">
									<span class="down">${tmVO.commHeat - pmVO.commHeat }</span>😡
								</c:if>
								<c:if test="${tmVO.commHeat - pmVO.commHeat <= 0}">
									<span class="up">${-(tmVO.commHeat - pmVO.commHeat) }</span>😊
								</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="tab-pane fade show active" id="indv" role="tabpanel" aria-labelledby="indv-tab">
			<h4>■ 연도별 비교</h4>
			<div id="energyCalDiv">
				<img src="${cPath }/images/pyear.png" class="pcyearBtn" >
				<span id="commCalyear">2021</span>
				<img src="${cPath }/images/nyear.png" class="ncyearBtn">
			</div>
			<div class="row">
				<div class="card col-md-10" id="thisYearDiv">
					<canvas id="thisYear" style="height:500px;"></canvas>
				</div>
				<span style="margin-left: 5%;">- 차트 레이블에서 검침항목을 선택하면 해당항목이 사라지며 나머지 그래프 변화를 상세히 보실 수 있습니다.</span>
			</div>
		</div>	
	</div>
</div>
<script>
var date = new Date();
var year = date.getFullYear();
let updown = "";
$(document).ready(function(){
	let tSum = ${tmVO.commElec+tmVO.commHeat+tmVO.commHotwater+tmVO.commWater};
	let pSum = ${pmVO.commElec+pmVO.commHeat+pmVO.commHotwater+pmVO.commWater};
	let sub = tSum-pSum;
	let percent = (sub>0?sub:-sub)/pSum*100;
	
	makeCommYearList("0000");
	
	$("#thisYearSpan").html(year);
	$("#thisMonthSpan").html('${tmVO.commMonth}');
	if(sub<0){updown="감소"}else{updown="증가"}
	$("#percentSpan").html(percent.toFixed(1)+"% "+updown);
	
	//--------------------- 탭메뉴 ---------------------------
	$('#myTab button').click(function(){
		$('#myTab').find(".nav-link").removeClass('active');
		$('.tab-content').find(".tab-pane").removeClass('show active');
		
		let contentId = $(this).data("tabid");
		$(this).addClass('active');
		$('#'+contentId).addClass("show active");
	});
	$("#indv").hide();
});

$("#yearTabBtn").on("click", function(){
	$("#indv").show();
});
<%--===================================================================== 공동검침 ===========================================================================--%>
<%-------------------------------------- 전월비교 ------------------------------------------%>
let thisMonthWater = []
let thisMonthHeat = []
thisMonthWater.push(${tmVO.commHotwater});
thisMonthWater.push(${tmVO.commWater});
thisMonthWater.push(0);
thisMonthHeat.push(${tmVO.commElec});
thisMonthHeat.push(${tmVO.commHeat});

let preMonthWater = []
let preMonthHeat = []
preMonthWater.push(${pmVO.commHotwater});
preMonthWater.push(${pmVO.commWater});
preMonthHeat.push(${pmVO.commElec});
preMonthHeat.push(${pmVO.commHeat});

var ctx1 = document.getElementById('water');
var waterChart = new Chart(ctx1, {
    type: 'bar',
    data : {
   	    labels: ['급탕(m3)       ', '수도(m3)   '],
   	    datasets: [{
   	    	label: "${pmVO.commMonth}월"
   	        ,data: preMonthWater
			,backgroundColor: [
				'rgba(23, 28, 42, 0.3)'
				,'rgba(23, 28, 42, 0.3)'
			]
			,borderColor: [
				'rgba(23, 28, 42, 0.3)'
				,'rgba(23, 28, 42, 0.3)'
			]	
   	    },
   	 	{
   	    	label: "${tmVO.commMonth}월"
   	        ,data: thisMonthWater
		   	,backgroundColor: [
		   		'rgba(48, 152, 72, 1)'
				,'rgba(48, 152, 72, 1)'
			]
			,borderColor: [
				'rgba(48, 152, 72, 1)'
				,'rgba(48, 152, 72, 1)'
			]
   	    }]
   	},
   	options: {
   		responsive: false
	}
});

var ctx2 = document.getElementById('heat');
var heatChart = new Chart(ctx2, {
    type: 'bar',
    data : {
   	    labels: ['전기(kwh)', '난방         '],
   	    datasets: [{
   	    	label: "${pmVO.commMonth}월"
   	   	        ,data: preMonthHeat
				,backgroundColor: [
					'rgba(23, 28, 42, 0.3)'
					,'rgba(23, 28, 42, 0.3)'
				]
				,borderColor: [
					'rgba(23, 28, 42, 0.3)'
					,'rgba(23, 28, 42, 0.3)'
				]	
   	   	    }
   	    ,{
   	    	label: "${tmVO.commMonth}월"
   	        ,data: thisMonthHeat
			,backgroundColor: [
			 	'rgba(48, 152, 72, 1)'
			,'rgba(48, 152, 72, 1)'
			]
			,borderColor: [
				'rgba(48, 152, 72, 1)'
				,'rgba(48, 152, 72, 1)'
			]	
   	    }]
   	},
   	options: {
   		responsive: false
	}
});
<%-------------------------------------- 이번년도 전체 차트 ------------------------------------------%>
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
				let j = 0;
				for(var i=1;i<=12;i++){
					if(j<thisYearList.length && thisYearList[j].commMonth==i){
						hotWaterSumArr.push(thisYearList[j].hotWaterSum);
						waterSumArr.push(thisYearList[j].waterSum);
						heatSumArr.push(thisYearList[j].heatSum*0.1);
						elecSumArr.push(thisYearList[j].elecSum);
						j++;
					}else{
						hotWaterSumArr.push(0);
						waterSumArr.push(0);
						heatSumArr.push(0);
						elecSumArr.push(0);
					}
				}
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

var ctx3 = document.getElementById('thisYear');
var thisYearChart = new Chart(ctx3, {
    type: 'line',
    data : {
   	    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   	    datasets: [{
   	    	label: ["급탕(m3)"]
   	    	,fill:false
   	        ,data: []
		   	,backgroundColor: [
		   		'rgba(174, 0, 255, 1)'
			]
			,borderColor: [
				'rgba(174, 0, 255, 1)'
			]	
   	    },
   	    {
   	    	label: ["수도(m3)"]
   	        ,data: []
   	 		,fill:false
		   	,backgroundColor: [
		   		'rgba(0, 255, 0, 1)'
			]
			,borderColor: [
				'rgba(0, 255, 0, 1)'
			]	
   	    },
   	    {
   	    	label: ["난방(10kWh)"]
   	        ,data: []
   	 		,fill:false
		   	,backgroundColor: [
		   		'rgba(0, 89, 255, 1)'
			]
			,borderColor: [
				'rgba(0, 89, 255, 1)'
			]	
   	    },
   	    {
   	    	label: ["전기(kWh)"]
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


</script>