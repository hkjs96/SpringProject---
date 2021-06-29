<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 관리비 조회 -->
<style type="text/css"> 
#feeView{
	margin-left: 100px;
} 
#monthSelect{
	border-radius:20px;
	height: 40px;
	width: 200px;
	margin-left: 40%;
	margin-bottom: 20px; 
}

/** 마감일 div **/
.dday{
	color: white;
	font-size : 16px;
	text-align:center;
	padding-top:25px;
	background: #3FAAC8;
	width: 75px;
	height: 75px;
	margin-top:12px;
	margin-left:9px;
	margin-right:none;
	float: left;
	border-radius: 15px;
}
.deadline{
	float: left;
	padding-top: 20px;
	padding-left:50px;
	text-align: center;
	font-weight: 600;
}
/* 관리비 비교 카드3개 */
.col-md-8 .card-body{
	margin-top:5px;
	padding-top: 14px;
	color: black;
	background-color: white;
	height: 100px;
	width: 99%;
	font-weight: 600;
}  
.card-header{
    height: 45px;
    padding-top: 3%;
	background-color: #EBEFF0;
	text-align: center;
}
.card3{
	width: 33.33%;
    height: 250px;
	float: left;
	border: 2px solid #F1F3EB;
	margin-bottom: 60px;
	font-weight: 600;
}
.money{
	padding-left: 300px;
}
p{
	margin-bottom: 0;
}
.tcolor{
	color:#50B7D3;
}
.card3 img{  /* 임시 이미지 나중에 api로 변경*/
	width: 285px;
	height: 100px;
	margin-top: 20px;
}
#tableDiv{
	clear: both;
}
#tableDiv table{
	width: 100%;
}
#card-texttDiv{
	float: left;
	margin-left: 20px;
}
#moneyDiv{
	float: left;
	padding-left: 30px;
}
th, td{
	height: 35px;
	width: 25%;
}
th{text-align: center;}
td{
	text-align: right;
	padding-right: 10px;	
}
td:first-child, td:last-child{
	text-align: center;
}

#lastday{
	font-size: 30px;
	color: #4281f3;
}

#lastdayTitle{
	font-size: 16px;
    margin-top: 6%;
}
#maintenanceList{
    font-size: 30px;
    text-align: center;


}

</style>    
<div id="feeView">
		<form:form >
		<select id="monthSelect" name="day" onchange="this.form.submit()" >
		<c:if test="${empty costDay}">
			<option value="">---</option>
		</c:if>
			<option selected disabled="disabled" style="background-color: lime;">${affter.costYear}년${affter.costMonth}월</option>
		<c:forEach items="${costDay}" var="costDay" >
			<option value="${costDay.rnum-1}">${costDay.costYear}년${costDay.costMonth}월</option>
		</c:forEach>							
		</select>
		</form:form>
	<div class="card mb-3" style="width: 100%; height:110px; background-color: #EBEFF0;">
	  <div class="row g-0">
	    <div class="col-md-4">
	    	<div class="dday">
	    	<c:choose>
	    		<c:when test="${affter.count  gt 0}">
		    		D-${affter.count }
	    		</c:when>
				<c:when test="${affter.count lt 0}">
					마감
				</c:when>
				<c:when test="${affter.count eq 0 }">
					D-DAY
				</c:when>	    	
	    	</c:choose>
	    	</div>
	    	<div id="lastdayTitle"align="center" data-duedate="${affter.costDuedate}">납부마감일</div>
	    	<div id="lastday" align="center" id="costDuedate">${affter.costDuedate}</div>
	    </div>
	    <div class="col-md-8">
	      <div class="card-body">
	      <table>
	      <tr>
		      <td colspan="2" align="left">${affter.costMonth }월 분 부과 금액</td>
		      <td class="total" align="left"></td>
	      </tr>
	      <tr>
		      <td colspan="2" align="left">납부하실 금액</td>
		      <td class="total" align="left"></td>
	      </tr>
	      </table>
	      </div>
	    </div>
	  </div>
	</div>
	<label style="color: red;">* 본 그래프는 ${affter.costYear }년도 기준입니다.</label>
	<br>
	<div class="card3">
	  <div class="card-header">
	  		전월달 비교 
	  </div>
	  <div class="card-body">
	  <canvas id="myChart1" width="295%" height="180px"></canvas>
	  </div>
	</div> 
	<div class="card3">
	  <div class="card-header">
	    우리아파트 동일면적 비교
	  </div>
	  <div class="card-body">
	  <canvas id="myChart2" width="295%" height="180px"></canvas>
	  </div>
	</div> 
	<div class="card3">
	  <div class="card-header">
	    에너지 사용량 동일면적 비교
	  </div>
	  <div class="card-body">
	  <canvas id="myChart3" width="295%" height="180px"></canvas>
	  </div>
	</div>  
	<div id="maintenanceList">
	관리비 항목 상세조회</div>
	<label style="font-size: 15px; color: red;">*각 항목을 선택하면 상세조회 가능합니다.</label>
	<div id="tableDiv">
	<table class="table-bordered">
		<thead style="background-color: #ebeff0;">
			<tr>
				<th>항목</th>
				<th id="month1" data-num1=${affter.costMonth }>당월</th>
				<th id="month2" data-num2=${before.costMonth }>전월</th>
				<th>증감</th>
			</tr>
		</thead>
		<tbody id="tbody" data-avg =${affter.costAvg } data-sameavg =${affter.sameAreaAvg } data-sameengareaavg =${affter.sameEngAreaAvg }>
			<tr data-type="COMMON">
				<td>일반관리비</td>
				<td>${affter.costCommon }</td>
				<td>${before.costCommon }</td>
				<td></td>
			</tr>
			<tr data-type="CLEANING">
				<td>청소비</td>
				<td>${affter.costCleaning}</td>
				<td>${before.costCleaning}</td>
				<td></td>
			</tr>
			<tr data-type="DISINFECT">
				<td>소독비</td>
				<td>${affter.costDisinfect}</td>
				<td>${before.costDisinfect}</td>
				<td></td>
			</tr>
			<tr data-type="ELEVATOR">
				<td>승강기유지비</td>
				<td>${affter.costElevator}</td>
				<td>${before.costElevator}</td>
				<td></td>
			</tr>
			<tr data-type="AS">
				<td>수선유지비</td>
				<td>${affter.costAs}</td>
				<td>${before.costAs}</td>
				<td></td>
			</tr>
			<tr data-type="LAS">
				<td>장기수선충당금</td>
				<td>${affter.costLas}</td>
				<td>${before.costLas}</td>
				<td></td>
			</tr>
			<tr data-type="PARK">
				<td>주차비</td>
				<td>${affter.costPark}</td>
				<td>${before.costPark}</td>
				<td></td>
			</tr>
			<tr data-type="SECURITY">
				<td>경비비</td>
				<td>${affter.costSecurity}</td>
				<td>${before.costSecurity}</td>
				<td></td>
			</tr>
			<tr data-type="COUNCIL">
				<td>입주자 대표회의 운영비</td>
				<td>${affter.costCouncil}</td>
				<td>${before.costCouncil}</td>
				<td></td>
			</tr>
			<tr data-type="COMM_HEAT">
				<td>난방 공용</td>
				<td>${affter.costCommHeat}</td>
				<td>${before.costCommHeat}</td>
				<td></td>
			</tr>
			<tr data-type="INDV_HEAT">
				<td>난방 전용</td>
				<td>${affter.costIndvHeat}</td>
				<td>${before.costIndvHeat}</td>
				<td></td>
			</tr>
				<tr data-type="COMM_HOTWATER">
				<td>급탕 공용</td>
				<td>${affter.costCommHotwater}</td>
				<td>${before.costCommHotwater}</td>
				<td></td>
			</tr>
				<tr data-type="INDV_HOTWATER">
				<td>급탕 전용</td>
				<td>${affter.costIndvHotwater}</td>
				<td>${before.costIndvHotwater}</td>
				<td></td>
			</tr>
				<tr data-type="COMM_ELEC">
				<td>전기 공용</td>
				<td>${affter.costCommElec}</td>
				<td>${before.costCommElec}</td>
				<td></td>
			</tr>
				<tr data-type="INDV_ELEC">
				<td>전기 전용</td>
				<td>${affter.costIndvElec}</td>
				<td>${before.costIndvElec}</td>
				<td></td>
			</tr>
				<tr data-type="COMM_WATER">
				<td>수도 공용</td>
				<td>${affter.costCommWater}</td>
				<td>${before.costCommWater}</td>
				<td></td>
			</tr>
				<tr data-type="INDV_WATER">
				<td>수도 전용</td>
				<td>${affter.costIndvWater}</td>
				<td>${before.costIndvWater}</td>
				<td></td>
			</tr>
			
		</tbody>
	</table>
	</div>
</div>
<div class="modal" id="myModal">
    <div class="modal-dialog" data-bs-backdrop="static" style="max-width: 100%; width: auto; display: table;">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="modaltitle"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" id="modalBody">
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
<script type="text/javascript">
//전월 당월 계산 스크립트 
$("#residentTitle").html("관리비")
$("#residentSubTitle").html("관리비 조회");

var tr = $("#tbody >tr").length;
var num1= [];//당월
var num2= [];//전월
var sum = [];//전월 당월 합쳐서 증감 표현 
var affterAvg = $("#tbody").data("avg");//해당 날짜의 평균 관리비 토탈 
var affterSameAreaAvg=$("#tbody").data("sameavg");
var sameEngAreaAvg =$("#tbody").data("sameengareaavg");
var totalsumAffter=0;//당월달 합산
var totalsumBefore=0;//전월달 합산
var month1= $("#month1").data("num1");//당월
var month2= $("#month2").data("num2");//전월
var affterEngSum = 0;
var beforeEngSum = 0;

for (i=1; i<tr+1; i++){
	num1[i]=$("#tbody > tr:nth-child("+i+") > td:nth-child(2)").html();
	num2[i]= $("#tbody > tr:nth-child("+i+") > td:nth-child(3)").html();
	sum[i]=Number(num2[i])-Number(num1[i]);
	totalsumAffter += Number(num1[i]);
	totalsumBefore += Number(num2[i]);
	if( i > 8){
		affterEngSum += Number(num1[i]);
		beforeEngSum += Number(num2[i]);
	}
	if(sum[i] > Number(0) ){
		$("#tbody > tr:nth-child("+i+") > td:nth-child(4)").html("▼").css("color","blue");
	}else if(sum[i] < Number(0)){
		if(num2[i].length == 0){
			$("#tbody > tr:nth-child("+i+") > td:nth-child(4)").html("");
		}else{
		$("#tbody > tr:nth-child("+i+") > td:nth-child(4)").html("▲").css("color","red");
		}
	}
	if(num1[i].length ==0){
		$("#tbody > tr:nth-child("+i+") > td:nth-child(2)").html("-").css("text-align","center");
		$("#tbody > tr:nth-child("+i+") > td:nth-child(3)").html("-").css("text-align","center");
		$("#tbody > tr:nth-child("+i+") > td:nth-child(4)").html("-");
	}
	else if(num2[i].length == 0){
		$("#tbody > tr:nth-child("+i+") > td:nth-child(4)").html("-");
		$("#tbody > tr:nth-child("+i+") > td:nth-child(3)").html("-").css("text-align","center");
		
	}else{
		var num = String(Math.abs(sum[i]));
		$("#tbody > tr:nth-child("+i+") > td:nth-child(4)").append(num.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+" 원 ");
	}
	
	$("#tbody > tr:nth-child("+i+") > td:nth-child(2)").html(num1[i].replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+" 원 ");
	$("#tbody > tr:nth-child("+i+") > td:nth-child(3)").html(num2[i].replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+" 원 ");
	
}
let totalsumAffterString = String(totalsumAffter);
$(".total").html(totalsumAffterString.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+" 원 ");

// 차트js
var ctx1 = document.getElementById('myChart1');
var myChart1 = new Chart(ctx1, {
	type: 'horizontalBar',//[https://www.chartjs.org/docs/latest/axes/ <<(컨트롤 +우클릭)
							//여기 가서 원하는 타입 바꿔주면 모양바껴용
	data: {
		labels: [month1+"월", month2+"월",'이번달 평균'],
		datasets: [{
			label: '전월비교',
			data: [totalsumAffter, totalsumBefore, affterAvg, 0 ],//값들 입력
			backgroundColor: [
				'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
				'rgba(54, 162, 235, 0.2)',
				'rgba(62, 160, 88, 0.2)',
				'rgba(54, 162, 235, 0.2)'
				
			],
			borderColor: [
				'rgba(255, 99, 132, 1)',// 값 갯수당 만들고 색깔 
				'rgba(54, 162, 235, 1)',
				'rgba(54, 162, 235, 1)',
			],
			borderWidth: 2
		}]
	},
	options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true
				}
			}]
		},
	}
});


var ctx2 = document.getElementById('myChart2');
var myChart2 = new Chart(ctx2, {
	type: 'horizontalBar',//[https://www.chartjs.org/docs/latest/axes/ <<(컨트롤 +우클릭)
							//여기 가서 원하는 타입 바꿔주면 모양바껴용
	data: {
		labels: [month1+"월", month2+"월", '이번달 평균'],
		datasets: [{
			label: '전월비교',
			data: [totalsumAffter, totalsumBefore,affterSameAreaAvg,0],//값들 입력
			backgroundColor: [
				'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
				'rgba(54, 162, 235, 0.2)',
				'rgba(62, 160, 88, 0.2)'
				
			],
			borderColor: [
				'rgba(255, 99, 132, 1)',// 값 갯수당 만들고 색깔 
				'rgba(54, 162, 235, 1)',
				'rgba(54, 162, 235, 1)'
			],
			borderWidth: 2
		}]
	},
	options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true
				}
			}]
		},
	}
});



var ctx3 = document.getElementById('myChart3');
var myChart3 = new Chart(ctx3, {
	type: 'horizontalBar',//[https://www.chartjs.org/docs/latest/axes/ <<(컨트롤 +우클릭)
							//여기 가서 원하는 타입 바꿔주면 모양바껴용
	data: {
		labels: [month1+"월", month2+"월", '평균'],
		datasets: [{
			label: '전월비교',
			data: [affterEngSum, beforeEngSum, sameEngAreaAvg, 0],//값들 입력
			backgroundColor: [
				'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
				'rgba(54, 162, 235, 0.2)',
				'rgba(62, 160, 88, 0.2)'
				
			],
			borderColor: [
				'rgba(255, 99, 132, 1)',// 값 갯수당 만들고 색깔 
				'rgba(54, 162, 235, 1)',
				'rgba(54, 162, 235, 1)'
			],
			borderWidth: 2
		}]
	},
	options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true
				}
			}]
		},
	}
});

let tbody = $("#tbody");
let serviceViewModal = $("#myModal").on("hidden.bs.modal", function(){
	$(this).find(".modal-body").empty();
});
tbody.on("click", "tr", function(){
	let type = $(this).data("type");
	let costName=$(this).children('td').first().text();
	
	$("#modaltitle").text(costName);
	let dudate = $("#lastdayTitle").data("duedate");
	serviceViewModal.find(".modal-body").load($.getContextPath()+"/resident/maintenanceCost/maintenaceView.do?costType="+type+"&costDuedate="+dudate, function(){
		serviceViewModal.modal("show");
	});
});

</script>