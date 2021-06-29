<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<script src="${pageContext.request.contextPath }/js/chartjs/Chart.min.js"></script>
<script src="${cPath }/js/chartjs/chartjs-plugin-datalabels.min.js"></script> <!-- 이경륜: chartJs datalabel 플러그인-->

<style>
	#doDraftP{
		color: blue;
	}

	.modal{
		height: 500px;
	}
	
	.widget-numbers {
	    font-weight: bold;
	    font-size: 2.5rem;
	    display: block;
	    line-height: 1;
	    margin: 1rem auto;
	}
	
	.icon-wrapper .icon-wrapper-bg {
	    position: absolute;
	    height: 100%;
	    width: 100%;
	    z-index: 3;
	    opacity: .2;
	}
	
	canvas{

	  /* width:700px !important; */
	  height:300px !important;
	
	}
	
	#qnaModal{
		height: 40em;
	}
	
	.btn{ /*인라인으로 할땐먹었는데 안먹고있음*/
		cursor: default;
	}
</style>
<ol class="breadcrumb mt-4">
    <li class="breadcrumb-item active">
    	<div class="d-flex justify-content-between">
    	<div class="align-self-center" style="display:inline-block;">
    		<h1 class="m-4"><strong>${authMember.aptName }</strong></h1>
    	</div>
    	<div class="align-self-center">
    		<span class="btn btn-lg btn-light">입주 세대수</span>
<!--     		<span class="btn btn-lg btn-light">&nbsp;:&nbsp;</span> -->
    		<span class="btn btn-lg btn-secondary">${house.moveinHouseCnt } 세대</span>
    		
    		<span class="btn btn-lg btn-light">총 세대수</span>
<!--     		<span class="btn btn-lg btn-light">&nbsp;:&nbsp;</span> -->
    		<span class="btn btn-lg btn-dark">${house.totalHouseCnt } 세대</span>
    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		<span class="btn btn-lg btn-light">입주 주거면적</span>
<!--     		<span class="btn btn-lg btn-light">&nbsp;:&nbsp;</span> -->
			<span class="btn btn-lg btn-secondary">${house.moveinHouseArea } ㎡</span>
			
    		<span class="btn btn-lg btn-light">총 주거면적</span>
<!--     		<span class="btn btn-lg btn-light">&nbsp;:&nbsp;</span> -->
			<span class="btn btn-lg btn-dark">${house.totalHouseArea } ㎡</span>
    	</div>
    	</div>
    </li>
</ol>
<div class="row">
    <div class="col-xl-4">
        <div class="card border-primary mb-4" style="height: 400px;">
            <div class="card-header d-flex justify-content-between">
            	<div>
	                <i class="fas fa-chalkboard-teacher mr-1"></i>
	           		AnyApart 공지사항
            	</div>
            	<div class="col-md-3  text-center pr-0">
	               	<a href="${cPath}/office/notice/noticeList.do" style="margin-left: 10%;"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;더보기</a>
            	</div>
            </div>
            <div class="card-body">
				<table class="table">
					<thead class="thead-light" >
					<tr>
						<th style="width:5%"  class="text-center" scope="col">No.</th>
						<th style="width:70%" class="text-center" scope="col">제목</th>
						<th style="width:25%" class="text-center" scope="col">날짜</th>
					</tr>
					</thead>
					<tbody id="noticeBody">
						<c:if test="${not empty vendorNoticeList }">
							<c:forEach items="${vendorNoticeList }" var="notice" end ="2">
								<tr id="" data-bono="${notice.boNo }">
									<td class="text-center">${notice.rnum }</td>
									<td><a href="${cPath }/office/notice/noticeView.do?boNo=${notice.boNo}">${fn:substring(notice.boTitle,0,24) }
									<c:choose>
											<c:when test="${fn:length(notice.boTitle) gt 24 }">
											.....
											</c:when>
											<c:when test="${fn:length(notice.boTitle) lt 24 }">
											
											</c:when>
									</c:choose>
									</a>
									</td>
									<td>${notice.boDate}</td>
			              		</tr>
		              		</c:forEach>
	              		</c:if>
          				<c:if test="${empty vendorNoticeList }">
							<tr class="text-center">
								<td colspan="3">조회 결과가 없습니다.</td>
							</tr>
						</c:if>	
	              		<tr>
	              		<c:if test="${fn:length(vendorNoticeList) gt 2 }">
	              			<td colspan="3" class="text-center">
	              				<a href="${cPath}/office/notice/noticeList.do">
              					<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;더보기</a>
	              			</td>
	              		</c:if>
	              		</tr>
					</tbody>
				</table>
            </div>
        </div>
    </div>
    <div class="col-xl-4">
        <div class="card border-success mb-4" style="height: 400px;">
            <div class="card-header d-flex justify-content-between">
            	<div>
                	<i class="fas fa-chart-bar mr-1"></i>면적별 입주 현황
                </div>
            </div>
            <div class="card-body">
<!--             	<div class="col-auto" style="height: 150px;"> -->
<%--             		<canvas id="houseAreaChart"></canvas> --%>
<!--             	</div> -->
            	<div class="col-auto" >
            		<canvas id="houseAreaBarChart" width="100%" height="50"></canvas>
            	</div>
            </div>
        </div>
    </div>    
    <div class="col-xl-4">
        <div class="card border-success mb-4" style="height: 400px;">
            <div class="card-header d-flex justify-content-between">
            	<div>
                	<i class="fas fa-chart-bar mr-1"></i>최근 6개월 간 전입 / 전출 추이
                </div>
                <div class="col-md-5 text-center pr-0">
	                <a href="${cPath}/office/resident/moveinList.do"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;입주관리</a>
	                <a href="${cPath}/office/resident/moveoutList.do"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;전출관리</a>
                </div>
            </div>
            <div class="card-body">
            	<div class="col-auto">
            		<canvas id="resInOutChart" width="100%" height="50"></canvas>
            	</div>
            </div>
        </div>
    </div>    
</div>
<div class="row">
    <div class="col-xl-4">
        <div class="card border-primary mb-4" style="height: 400px;">
            <div class="card-header d-flex justify-content-between">
            	<div>
	                <i class="fa fa-question-circle mr-1"></i>
	           		답변되지 않은 문의글
            	</div>
            	<div class="col-md-3  text-center pr-0">
	               	<a href="${cPath}/office/website/officeQna/officeQnaList.do" style="margin-left: 10%;"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;더보기</a>
            	</div>
            </div>
            <div class="card-body">
				<table class="table">
					<thead class="thead-light" >
					<tr>
						<th style="width:5%"  class="text-center" scope="col">No.</th>
						<th style="width:70%" class="text-center" scope="col">제목</th>
						<th style="width:25%" class="text-center" scope="col">날짜</th>
					</tr>
					</thead>
					<tbody id="qnaBody">
			  			<c:set var="size" value="${fn:length(officeQnaList)}"/>
					  	<c:if test="${not empty officeQnaList }">
					  		<c:forEach items="${officeQnaList }" var="board" end="2">
					  			<tr data-bo-no='${board.boNo }'>
					  				<td class="text-center">${size-board.rnum+1 }</td>
									<td>
										<a href="">${fn:substring(board.boTitle,0,24) }
											<c:if test="${fn:length(board.boTitle) gt 24 }">
												.....
											</c:if>
										</a>
									</td>
					  				<td class="text-center">${board.boDate }</td>
							    <tr>
					  		</c:forEach>
						</c:if>
						<c:if test="${empty officeQnaList }">
							<tr class="text-center">
								<td colspan="3">조회 결과가 없습니다.</td>
							</tr>
						</c:if>	
	              		<tr>
	              		<c:if test="${fn:length(officeQnaList) gt 2 }">
	              			<td colspan="3" class="text-center">
	              				<a href="${cPath}/office/website/officeQna/officeQnaList.do">
              					<i class="fa fa-plus" aria-hidden="true"></i>&nbsp;더보기</a>
	              			</td>
	              		</c:if>
	              		</tr>
					</tbody>
				</table>
            </div>
        </div>
    </div>
    <div class="col-xl-8">
        <div class="card border-success mb-4" style="height: 400px;">
            <div class="card-header d-flex justify-content-between">
                <div>
	                <i class="fas fa-chart-area mr-1"></i>
	           		최근 1년간 관리비 추이
            	</div>
            	<div class="col-md-3  text-center pr-0">
	               	<a href="${cPath}/office/cost/costIndvList.do" style="margin-left: 10%;"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;세대별 조회</a>
            	</div>
            </div>
            <div class="card-body"><canvas id="costChart" width="100%" height="50"></canvas></div>
        </div>
    </div>
</div>

<!-- 이미정 : qna 답변 모달 -->
  <div class="modal fade" id="qnaModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <p class="modal-title">- 답변되지 않은 문의글</p>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" id="qnaModalBody">
        	<table class="table table-bordered" id="qnaViewTb">
        	
        	</table>
        	
        	<form id = "answerForm" method="post">
	        	<table class="table table-bordered" id="answerInsertTb">
	        	
	        	</table>
        	</form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id="answerBtn">저장</button>
          <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
<!-- qna 답변 모달 끝 --> 

<!-- 이미정 : 결재문서 푸시 알림 모달  -->
  <div id="receptionDiv">
	  <button type="button" class="btn btn-light" data-toggle="modal" data-target="#receptionModal">
	     수신 결재문서 확인 모달(숨김)
	  </button>
  </div>

  <div class="modal" id="receptionModal">
    <div class="modal-dialog modal-dialog-centered modal-lg" >
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <p class="modal-title">[결재 대기 문서] 결재 대기중인 문서가 있습니다.</p>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
           	<p id="doDraftP">* 문서 번호를 클릭하면 바로 해당 문서로 이동할 수 있습니다.<p>
           	<table class="table text-center">
           		<thead class="thead-light">
           			<tr>
	           			<th width="10%">No</th>
	           			<th width="15%">기안일자</th>
	           			<th width="15%">단위업무</th>
	           			<th width="40%">제목</th>
	           			<th width="15%">작성자</th>
           			</tr>
           		</thead>
           		<tbody id="listBody">
						           		
           		</tbody>
           	 </table>
           	 <div class="d-flex justify-content-end">
	           	 <input type="button" class="btn btn-dark mr-2" value="수신함" id="goReceptionBtn">
	          	 <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
           	 </div>
          </div>
        </div>
      </div>
    </div>
<!-- 결재문서 푸시 알림 모달 끝 -->    
<script>
//== 이경륜 : 입주세대수 ========================================================================================
// 반도넛 차트 중앙에 숫자넣는 코드
// 참고 : http://jsfiddle.net/vencendor/e0c8rgbm/
/*
Chart.pluginService.register({ 
	beforeDraw: function (chart) {
		if (chart.config.options.elements.center) {
			//Get ctx from string
			var ctx = chart.chart.ctx;
       
			//Get options from the center object in options
			var centerConfig = chart.config.options.elements.center;
			var fontStyle = centerConfig.fontStyle || 'Arial';
			var txt = centerConfig.text;
			var color = centerConfig.color || '#000';
			var sidePadding = centerConfig.sidePadding || 20;
			var sidePaddingCalculated = (sidePadding/100) * (chart.innerRadius * 2)
			//Start with a base font of 30px
			ctx.font = "30px " + fontStyle;
       
			//Get the width of the string and also the width of the element minus 10 to give it 5px side padding
			var stringWidth = ctx.measureText(txt).width;
			var elementWidth = (chart.innerRadius * 2) - sidePaddingCalculated;

			// Find out how much the font can grow in width.
			var widthRatio = elementWidth / stringWidth;
			var newFontSize = Math.floor(30 * widthRatio);
			var elementHeight = (chart.innerRadius * 2);

			// Pick a new font size so it will not be larger than the height of label.
			var fontSizeToUse = 30;

			//Set font settings to draw it correctly.
			ctx.textAlign = 'center';
			ctx.textBaseline = 'middle';
			var centerX = ((chart.chartArea.left + chart.chartArea.right) / 2);
			var centerY = ((chart.chartArea.top + chart.chartArea.bottom) - 60); // 원래 80 이었
			ctx.font = fontSizeToUse+"px " + fontStyle;
			ctx.fillStyle = color;
       
			//Draw text in center
			ctx.fillText(txt, centerX, centerY);
		}
	}
});


var config = {
	type: 'doughnut'
	,data: {
		labels: [
			'입주'
			, '미입주'
		]
		,datasets: [{
			data: [${house.moveinHouseCnt}, ${house.totalHouseCnt - house.moveinHouseCnt}]
			,backgroundColor: [
				  "#FF6384",
				  "#FFCE56"
			]
			,hoverBackgroundColor: [
			  "#FF6384",
			  "#FFCE56"
			]
		}]
	}
	,options: {
		responsive: false
		,maintainAspectRatio: false
		,rotation: 1 * Math.PI
		,circumference: 1 * Math.PI
		,elements: {
				center: {
				text: '${house.totalHouseCnt}'+"세대"
				,color: '#FF6384' // Default is #000000
				,fontStyle: 'Arial' // Default is Arial
				,sidePadding: 20 // Defualt is 20 (as a percentage)
			}
		}
		,title: {
			display: true
			,text: '입주세대'
			,position: 'bottom'
			,fontSize: 15
			
		}
		,tooltips: {
			callbacks: {
				label: function (tooltipItem, data) {
					var tooltipValue = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					return parseInt(tooltipValue).toLocaleString()+"세대";
				}
			}
		}
	}
};
var cvsHouseAreaChart = document.getElementById("houseAreaChart").getContext("2d");
var houseAreaChart = new Chart(cvsHouseAreaChart, config);
*/

//== 이경륜 : 면적별 입주세대 ========================================================================================
var houseAreaArr=[];
var moveinCntArr=[];
var moveoutCntArr=[];
var totalCntArr=[];

<c:if test="${not empty houseInfoList }">
	<c:forEach items="${houseInfoList }" var="house">
		houseAreaArr.push("${house.houseArea}");
		moveinCntArr.push("${house.moveinHouseCnt}");
		moveoutCntArr.push("${house.moveoutHouseCnt}");
		totalCntArr.push("${house.totalHouseCnt}");
	</c:forEach>
</c:if>

var barOptions_stacked = {
	    tooltips: {
	        enabled: true
	    },
	    hover :{
	        animationDuration:0
	    },
	    scales: {
	        xAxes: [{
	            ticks: {
	                beginAtZero:true,
	                fontFamily: "'Open Sans Bold', sans-serif",
	                fontSize:11
	            },
	            scaleLabel:{
	                display:false
	            },
	            gridLines: {
	            }, 
	            stacked: true
	        }],
	        yAxes: [{
	            gridLines: {
	                display:false,
	                color: "#fff",
	                zeroLineColor: "#fff",
	                zeroLineWidth: 0
	            },
	            ticks: {
	                fontFamily: "'Open Sans Bold', sans-serif",
	                fontSize:11,
					beginAtZero: true
					,callback: function(value, index) {
						return value.toLocaleString("ko-KR")+"㎡";
			          }
	            },
	            stacked: true
	        }]
	    },
	    legend:{
	        display:true
	    },
	    
// 	    animation: {
// 	        onComplete: function () {
// 	            var chartInstance = this.chart;
// 	            var ctx = chartInstance.ctx;
// 	            ctx.textAlign = "left";
// 	            ctx.font = "9px Open Sans";
// 	            ctx.fillStyle = "#fff";

// 	            Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
// 	                var meta = chartInstance.controller.getDatasetMeta(i);
// 	                Chart.helpers.each(meta.data.forEach(function (bar, index) {
// 	                    data = dataset.data[index];
// 	                    if(i==0){
// 	                        ctx.fillText(data, 50, bar._model.y+4);
// 	                    } else {
// 	                        ctx.fillText(data, bar._model.x-25, bar._model.y+4);
// 	                    }
// 	                }),this)
// 	            }),this);
// 	        }
// 	    },
	    pointLabelFontFamily : "Quadon Extra Bold",
	    scaleFontFamily : "Quadon Extra Bold",
	    responsive:true
	    ,maintainAspectRatio: false
	    
	};
	var cvsHouseAreaBarChart = document.getElementById('houseAreaBarChart');
	var houseAreaBarChart = new Chart(cvsHouseAreaBarChart, {
	    type: 'horizontalBar',
	    data: {
	        labels: houseAreaArr,
	        
	        datasets: [{
	        	label:'입주'
	            ,data: moveinCntArr
	            ,backgroundColor: 'rgba(255, 99, 132, 0.2)'
	            ,borderColor: 'rgb(255, 99, 132)'
	            ,borderWidth: 1
	        },{
	        	label:'미입주'
	            ,data: moveoutCntArr
	            ,backgroundColor: 'rgba(54, 162, 235, 0.2)'
	            ,borderColor: 'rgb(54, 162, 235)'
	            ,borderWidth: 1
	        }]
	    },

	    options: barOptions_stacked
	});

//== 이경륜 : 전입전출 추이 ========================================================================================
var cvsResInOutChart = document.getElementById('resInOutChart');
var moveCalArr=[];
var moveinArr=[];
var moveoutArr=[];

<c:if test="${not empty moveinList }">
	<c:forEach items="${moveinList }" var="res">
		moveinArr.push("${res.rnum}");
		moveCalArr.push("${res.resMovein}");
	</c:forEach>
</c:if>

<c:if test="${not empty moveoutList }">
	<c:forEach items="${moveoutList }" var="res">
		moveoutArr.push("${res.rnum}");
	</c:forEach>
</c:if>

var resInOutChart = new Chart(cvsResInOutChart, {
	type: 'bar'//[https://www.chartjs.org/docs/latest/axes/ <<(컨트롤 +우클릭) 여기 가서 원하는 타입 바꿔주면 모양바껴용
	,data: {
		labels: moveCalArr
		,datasets: [{
			label: '전입'
			,data: moveinArr //값들 입력
			,backgroundColor: [
				'rgba(255, 99, 132, 0.2)'
				,'rgba(255, 99, 132, 0.2)'
				,'rgba(255, 99, 132, 0.2)'
				,'rgba(255, 99, 132, 0.2)'
				,'rgba(255, 99, 132, 0.2)'
				,'rgba(255, 99, 132, 0.2)'
				]
			,borderColor: [
				'rgb(255, 99, 132)' 
				,'rgb(255, 99, 132)' 
				,'rgb(255, 99, 132)' 
				,'rgb(255, 99, 132)' 
				,'rgb(255, 99, 132)' 
				,'rgb(255, 99, 132)' 
				]
			,borderWidth: 1
		},{
			label: '전출'
				,data: moveoutArr //값들 입력
				,backgroundColor: [
					'rgba(54, 162, 235, 0.2)'
					,'rgba(54, 162, 235, 0.2)'
					,'rgba(54, 162, 235, 0.2)'
					,'rgba(54, 162, 235, 0.2)'
					,'rgba(54, 162, 235, 0.2)'
					,'rgba(54, 162, 235, 0.2)'
					]
				,borderColor: [
					'rgb(54, 162, 235)'
					,'rgb(54, 162, 235)'
					,'rgb(54, 162, 235)'
					,'rgb(54, 162, 235)'
					,'rgb(54, 162, 235)'
					,'rgb(54, 162, 235)'
					]
				,borderWidth: 1
		}]
	},
	options: {
		responsive: true
		,maintainAspectRatio: false
		,scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true
					,stepSize: 1
				}
			}]
			
		}
		,legend: {
			position: 'top',
		}
	}
});

//== 이경륜 : 관리비 추이 ========================================================================================
var cvsCostChart = document.getElementById('costChart');
var costCalArr=[];
var costCommArr=[];
var costIndvArr=[];
var costTotalArr=[];

<c:if test="${not empty costMonthlyList }">
	<c:forEach items="${costMonthlyList }" var="cost">
		costCalArr.push("${cost.costDuedate}");
		costCommArr.push("${cost.costCommTotal}");
		costIndvArr.push("${cost.costIndvTotal}");
		costTotalArr.push("${cost.costTotal}");
	</c:forEach>
</c:if>


var costChart = new Chart(cvsCostChart, {
	type: 'bar'//[https://www.chartjs.org/docs/latest/axes/ <<(컨트롤 +우클릭) 여기 가서 원하는 타입 바꿔주면 모양바껴용
	,data: {
		labels: costCalArr
		,datasets: [{
			label: '공용관리비'
			,data: costCommArr //값들 입력
			,backgroundColor: [
				'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				,'rgba(62, 160, 88, 0.2)'
				]
			,borderColor: [
				'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				,'rgb(62, 160, 88)'
				]
			,borderWidth: 1
			,datalabels: {
				anchor: 'center'
				,formatter: function(value) {
			          return numberWithCommas(value)+ "원";
		        }
			}
		},{
			label: '개별관리비'
				,data: costIndvArr //값들 입력
				,backgroundColor: [
					'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					,'rgba(255, 94, 0, 0.2)'
					
					]
				,borderColor: [
					'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					,'rgb(255, 94, 0)'
					]
				,borderWidth: 1
				,datalabels: {
					anchor: 'center'
					,formatter: function(value) {
				          return numberWithCommas(value)+ "원";
			        }
				}
		}]
	},
	options: {
		responsive: true
		,maintainAspectRatio: false
		,scales: {
			xAxes: [{
				stacked: true
			}]
			,yAxes: [{
				stacked: true
				,ticks: {
					beginAtZero: true
					,callback: function(value, index) {
			            if(value.toString().length > 8) return (Math.floor(value / 100000000)).toLocaleString("ko-KR") + "억";
			            else if(value.toString().length > 4) return (Math.floor(value / 10000)).toLocaleString("ko-KR") + "만";
			            else return value.toLocaleString("ko-KR"); 
			          }
				}
			}]
			
		}
		,legend: {
			position: 'top',
		}
		, tooltips: {
			callbacks: {
				label: function (tooltipItem, data) {
					var tooltipValue = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					return parseInt(tooltipValue).toLocaleString()+"원";
				}
			}
		}
	}
});

	//== 이미정 : 문서 푸시알림 ========================================================================================
		let listBody = $("#listBody");
		let trTags = [];
		let memId='<c:out value="${authMember.memId }"/>';		
		$(function(){
			// 모달 div hide처리
			$("#receptionDiv").hide();
			//결재 대기중인 리스트 조회
			$.ajax({
				url:"${cPath }/office/approval/receptionWaitListView.do"
				//현재 결재자 APP_NOWEMP 컬럼에 memId 담아 전송
				,data : {"appNowemp" : memId }
				,method : "post"
				,success : function(resp){
					if(resp.message){ //실패 
						getNoty(resp);
						return;
					}else{ 			  //성공
						
						let draftList = resp.draftList;
	
						//문서 리스트 테이블 생성
						if(draftList.length>0){
							$(draftList).each(function(idx, draft){
								let tr = $("<tr>");
								tr.append(
									$("<td>").text(draft.draftId).addClass("draftIdTd"), //기안일자		
									$("<td>").text(draft.draftDate), //기안일자		
									$("<td>").text(draft.taskCode),  //단위업무
									$("<td>").text(draft.draftTitle).addClass("text-left"), //제목
									$("<td>").text(draft.memId)	//작성자
								);
								trTags.push(tr);
							});
						listBody.html(trTags);
						$('#receptionModal').modal('show');
						
						
						//각 문서별 푸시알림 수신여부를 Y로 변경
						$.ajax({
							url:"${cPath }/office/approval/receptionWaitListUpdate.do"
							,data : {"memId" : memId }
							,method : "post"
							,success : function(resp){
	 							if(resp.message){
									getNoty(resp);
								}
							},
							error:function(xhr){
								console.log(xhr.status);
							}
						});
						
						}
					}
				},
				error:function(xhr){
					console.log(xhr.status);
				}
			});
		});
		
	
		//수신함 버튼 클릭하면 수신함으로 이동
		$("#goReceptionBtn").on("click", function(){
			location.href="${cPath}/office/approval/receptionList.do";
		});
		
		$(document).on("click", ".draftIdTd" ,function(){ 
			var idx = this.closest("tr .draftIdTd");
			location.href="${cPath}/office/approval/draftView.do?draftId="+idx.innerText;
		});
	//== 문서 푸시알림 끝 =================================================================================================
		
	//== 이미정 : qna 리스트 클릭하여 모달에서 답변 등록 =========================================================================	
	
	let qnaBody = $("#qnaBody");
	let qnaModal = $("#qnaModal");
	let qnaViewTb = $("#qnaViewTb");
	let answerInsertTb = $("#answerInsertTb");
	let answerForm = $("#answerForm");
		
	//리스트 글 클릭 - 동적 테이블 생성
	qnaBody.find("a").on("click", function(){
		event.preventDefault();
		let tr = this.closest("tr");
		let boNo = tr.dataset.boNo;
		$.ajax({
			url:"${cPath }/office/website/officeQna/officeQnaDashView.do"
			,data : {"boNo" : boNo}
			,method : "get"
			,success : function(resp){
				if(resp.message){
					getNoty(resp);
					return;
				}
				let board = resp.board;
				let button = null;
				let boTitle = null;
				let boContent = null;
				let hiddenBoWriter = null;
				let answerBoWriter = memId;
				let qnaBoParent = boNo;
				let hiddenBoDepth = board.boDepth;
				let trTags1 = [];
				let trTags2 = [];
				let tr1 = $("<tr>");
				let tr2 = $("<tr>");
				let tr3 = $("<tr>");
				
				let tr4 = $("<tr>");
				let tr5 = $("<tr>");
				if(board!=null){
					boTitle = $("<input>").attr({
						type:"text",
						name:"boTitle",
						value:""
					}).addClass("form-control col-sm-12");
					boContent = $("<textarea>").attr({
						rows:"20",
						name:"boContent",
						id:"boContent",
						value:""
					}).addClass("form-control col-sm-12")
					  .css("height","200px");
					hiddenBoWriter = $("<input>").attr({
						type:"hidden",
						name:"boWriter",
						value: answerBoWriter
					});
					hiddenBoParent = $("<input>").attr({
						type:"hidden",
						name:"boParent",
						value: qnaBoParent
					});
					hiddenBoDepth = $("<input>").attr({
						type:"hidden",
						name:"boDepth",
						value: hiddenBoDepth
					});

					tr4.append(
						$("<td>").text("답변 제목").addClass("table-warning text-center align-middle").css("width","20%"),
						$("<td>").append(boTitle).css("width","70%")
					);
					tr5.append(
						$("<td>").text("답변 내용").addClass("table-warning text-center align-middle").css("width","20%"),
						$("<td>").append(boContent).append(hiddenBoWriter).append(hiddenBoParent)
						.append(hiddenBoDepth).css("width","70%")
					);

					trTags2.push(tr4);
					trTags2.push(tr5);
					
				}else{
					trTags2.push(
						$("<tr>").html(
							$("<td colspan='3'>").text("글 정보가 없음.")									
						)
					);
				}
				qnaViewTb.html(trTags1);
				answerInsertTb.html(trTags2);
				$("#boContent").html(
						  "원글 질문 : " + board.boTitle + "\r\n"
					    + "원글 내용 : \r\n" + board.boContent + "\r\n"
						+ "==================================================" + "\r\n"
						+ "답변 내용 : ");
				qnaModal.modal("show");
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
	});
	
	//등록 버튼	
	$(document).on("click","#answerBtn",function(){ 
		let comfirmChk = confirm("등록하시겠습니까?");
		if(comfirmChk){
			let str = ($("#boContent").val()).replace(/(?:\r\n|\r|\n)/g, '<br/>');
			$("#boContent").val(str);
			$.ajax({
				url:"${cPath }/office/website/officeQna/officeQnaDashInsert.do"
				,data : answerForm.serialize()
				,method : "post"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						return;
					}else{
						alert("등록되었습니다.");
						location.reload();
					}
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}else{
			return;
		}
	});
	//== qna 답변 등록 끝 ==============================================================================================	
	
</script>
