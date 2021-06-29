<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 22.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>

<script src="${pageContext.request.contextPath }/js/chartjs/Chart.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/js/chartjs/Chart.min.js"></script>

<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy년  MM월 dd일" /></c:set> 
<style>
.top {
	display: inline;
}

/* .popoverclz{ */
/*     max-width:600px; */
/* } */
</style>
<br>
<div id="top"> 
	<h2><strong>부과 처리</strong></h2>
</div>
<br>
<div class="container">
	<div class="row">
		<div class="col-sm-12" style="border-style: outset; border-radius: 8px;">
			<div class="row g-0">
				<div class="col-md-12" style="margin-top: 20px;">
					<i class="fas fa-user-friends fa-2x" style="margin-left: 10px; margin-top: 10px;"></i>
					<span>&nbsp;&nbsp;<strong>입주 세대 정보</strong></span>
				</div>
			</div>
			<div class="card-body">
				<div class="row g-0">
					<div class="col-md-12" style="text-align:center">
						<h2>${date } 기준 / ${commMeter.commYear }년 ${commMeter.commMonth }월 관리비</h2> 
						<br>
						<span>입주 세대수 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${house.moveinHouseCnt }" />
						&nbsp;/&nbsp;총세대수 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${house.totalHouseCnt }" /></span> 
						<br>
						<span>입주 면적 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${house.moveinHouseArea }" />
						&nbsp;/&nbsp;총 주거면적 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${house.totalHouseArea }" /></span> 
					</div>
				</div>
				<div class="row">
					<div class="d-flex justify-content-between col-sm-12">
						<div class="col-md-5 mr-2 float-left">
							<canvas id="housePplChart"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="d-flex justify-content-between mb-3">
	<input type="button" value="부과기준표"  class="btn btn-info" onclick="viewCostStandard();"/>
	<div><span class="reddot">* 부과처리 후에는 검침량  및 관리비를 수정할 수 없습니다.</span></div>
	<c:if test="${commMeter.commFlag eq 'Y' }">
		<div class="d-flex justify-content-end"><button class="btn btn-danger" disabled>부과마감</button></div>
	</c:if>
	<c:if test="${commMeter.commFlag eq 'N' }">
		<div class="d-flex justify-content-end"><button class="btn btn-danger" data-toggle="modal" data-target="#costInsertAuthModal">부과처리</button></div>
	</c:if>
</div>

<div class="d-flex justify-content-between mb-4">
	<div class="card text-center col-md-8 mr-4 float-left">
		<div class="card-header">
			<ul class="nav nav-tabs card-header-tabs">
				<li class="nav-item">
					<a class="nav-link text-dark active" href="#"><strong>공용관리비</strong></a>
				</li>
			</ul>
		</div>
		<div class="card-body row">
<!-- 			<span>공용관리비 총 발생금액 : </span> -->
			<div class="d-flex justify-content-between col-sm-12">
				<div class="col-md-5 mr-2 float-left">
					<canvas id="costCommChart"></canvas>
				</div>
				<div class="col-md float-left">			
					<table class="table table-bordered table-sm table-hover">
						<thead class="thead-dark">
							<tr>
								<th scope="col">항목</th>
								<th scope="col">발생 금액</th>
								<th scope="col">㎡당 부과 금액</th>
							</tr>
						</thead>
						<c:set var="costCommTotalBySpaceTotal" value="0"/>
						<tbody id="commListBody" class="thead-light">
							<c:if test="${not empty costCommList }">
								<c:forEach items="${costCommList }" var="costComm">
									<tr>
										<th>${costComm.costType }</th>
										<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costComm.costCommTotal }"/> 원</td>
										<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costComm.costCommTotalBySpace }"/> 원</td>
										<c:set var="costCommTotalBySpaceTotal" value="${costCommTotalBySpaceTotal + costComm.costCommTotalBySpace }"/>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>	
		</div>
	</div>
	
	<div class="card text-center col-md float-left">
		<div class="card-header">
			<ul class="nav nav-tabs card-header-tabs">
				<li class="nav-item">
					<a class="nav-link text-dark active" href="#"><strong>공동검침량</strong></a>
				</li>
			</ul>
		</div>
		<div class="card-body row">
			<div class="col-sm-12">
<!-- 				<span>공동검침량 총 발생금액 : </span> -->
				<table class="table table-bordered table-sm table-hover">
					<thead class="thead-dark">
						<tr>
							<th scope="col">항목</th>
							<th scope="col">검침량</th>
							<th scope="col">발생 금액</th>
							<th scope="col">㎡당 부과 금액</th>
						</tr>
					</thead>
					<tbody id="commMeterListBody" class="thead-light">
						<tr>
							<th>난방</th>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commHeat }"/></td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commHeatCost }"/> 원</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commHeatCostBySpace }"/> 원</td>
						</tr>
						<tr>
							<th>급탕</th>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commHotwater }"/></td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commHotwaterCost }"/> 원</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commHotwaterCostBySpace }"/> 원</td>
						</tr>
						<tr>
							<th>수도</th>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commWater }"/></td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commWaterCost }"/> 원</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commWaterCostBySpace }"/> 원</td>
						</tr>
						<tr>
							<th>전기</th>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commElec }"/></td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commElecCost }"/> 원</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${commMeter.commElecCostBySpace }"/> 원</td>
						</tr>
					</tbody>
				</table>
			</div>	
		</div>
	</div>
</div>

<div class="card text-center col-md-12 float-left">
	<div class="card-header">
		<ul class="nav nav-tabs card-header-tabs">
			<li class="nav-item">
				<a class="nav-link text-dark active" href="#"><strong>세대별 요금</strong></a>
			</li>
		</ul>
	</div>
	<div class="card-body row">
		<div class="col-sm-12">

			<table class="table table-bordered table-sm table-hover" id="costTable">
				<thead class="align-middle">
					<tr>
						<td colspan="21" style="text-align:center">
							<i class="fas fa-search fa-2x"></i><span>검색조건</span>
							<form:form modelAttribute="pagingVO2" id="searchForm" method="get">
								<form:hidden path="searchDetail.aptCode" value="${authMember.aptCode }"/>
								<form:hidden path="currentPage"/>
								<form:select path="searchDetail.resType" id="resType" onchange="resetPage();" cssClass="custom-select col-md-1">
									<form:option value="" label="전체"/>
									<form:option value="STAY" label="기입주"/>
									<form:option value="IN" label="전입"/>
									<form:option value="OUT" label="전출"/>
								</form:select>
								<input type="submit" value="검색" class="btn btn-dark"/>
							</form:form>
						</td>
					</tr>
					<tr>
						<td colspan="21" style="text-align:center">
							<div id="pagingArea" style="display: inline-block;">
								<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="col" rowspan="2" class="align-middle table-secondary">동</th>
						<th scope="col" rowspan="2" class="align-middle table-secondary">호</th>
						<th scope="col" rowspan="2" class="align-middle table-secondary">세대주명</th>
						<th scope="col" rowspan="2" class="align-middle table-secondary">면적</th>
						<th scope="col" colspan="2" class="align-middle table-secondary">난방</th>
						<th scope="col" colspan="2" class="align-middle table-secondary">급탕</th>
						<th scope="col" colspan="2" class="align-middle table-secondary">수도</th>
						<th scope="col" colspan="2" class="align-middle table-secondary">전기</th>
						<th scope="col" colspan="2" class="align-middle table-secondary">주차비</th>
						<th scope="col" rowspan="2" class="align-middle table-secondary">수선<br>유지비</th>
						<th scope="col" rowspan="2" class="align-middle table-secondary">장기수선<br>충당금</th>
						<th scope="col" rowspan="2" class="align-middle table-secondary">입주자회의<br>운영비</th>
						<th scope="col" class="align-middle table-danger">공용관리비</th>
						<th scope="col" colspan="2" class="align-middle table-danger">개별관리비</th>
						<th scope="col" class="align-middle table-danger">관리비</th>
					</tr>
					<tr>
						<th scope="col" class="align-middle table-active">검침량</th>
						<th scope="col" class="align-middle table-active">요금</th>
						<th scope="col" class="align-middle table-active">검침량</th>
						<th scope="col" class="align-middle table-active">요금</th>
						<th scope="col" class="align-middle table-active">검침량</th>
						<th scope="col" class="align-middle table-active">요금</th>
						<th scope="col" class="align-middle table-active">검침량</th>
						<th scope="col" class="align-middle table-active">요금</th>
						<th scope="col" class="align-middle table-active">차량수</th>
						<th scope="col" class="align-middle table-active">요금</th>
						<th scope="col" class="table-warning">총액</th>
						<th scope="col" class="table-warning">공용요금</th>
						<th scope="col" class="table-warning">개별요금</th>
						<th scope="col" class="table-warning">총액</th>
					</tr>
				</thead>
				<tbody id="indvListBody">
					<c:set var="costList" value="${pagingVO.dataList }" />
			    	<c:if test="${not empty costList }">
			    		<c:forEach items="${costList }" var="cost" varStatus="vs">
							<tr>
								<td>${cost.dong }</td>
								<td>${cost.ho }</td>
								<td>${cost.resName }</td>
								<td>${cost.houseArea }㎡</td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.indvHeat }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvHeat }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.indvHotwater }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvHotwater }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.indvWater }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvWater }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.indvElec }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvElec }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.carCnt }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costPark }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costAs }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costLas }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCouncil }"/></td>
								<c:set var="costCommTotal" value="${cost.houseArea * costCommTotalBySpaceTotal / 10 }"/><!-- 세대수 적어서 우선10으로 나눠둠 -->
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costCommTotal }"/></td>
								<c:set var="costCommMeterTotal" value="${cost.houseArea * (commMeter.commHeatCostBySpace + commMeter.commHotwaterCostBySpace + commMeter.commWaterCostBySpace + commMeter.commElecCostBySpace) }"/>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costCommMeterTotal }"/></td>
								<c:set var="costIndvMeterTotal" value="${cost.costIndvHeat + cost.costIndvHotwater + cost.costIndvWater + cost.costIndvElec + cost.costPark + cost.costAs +cost.costLas + cost.costCouncil }"/>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costIndvMeterTotal }"/></td>
								<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costCommTotal+costCommMeterTotal+costIndvMeterTotal }"/></td>
							</tr>
			    		</c:forEach>
			    	</c:if>
			    	<c:if test="${empty costList }">
			    		<tr>
			    			<td colspan="21" class="text-center">
			    				조회 결과가 없습니다.
			    			</td>
			    		</tr>
			    	</c:if>
				</tbody>
			</table>
		</div>	
	</div>
</div>



<!-- 부과기준표 상세보기 모달 -->
<div class="modal fade" id="costStandardViewModal" tabindex="-1" aria-labelledby="costStandardViewModalLabel" aria-hidden="true" style=”z-index:1060;”>
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="costStandardViewModalLabel"><strong>부과기준표</strong></h3>
			</div>
			<div class="modal-body" id="costStandardViewModalBody">
				<!-- costStandardViewModal.jsp에서 읽어올 모달 바디 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<!-- 부과 처리시 관리자 비밀번호 인증 모달 -->
<div class="modal fade" id="costInsertAuthModal" tabindex="-1" aria-labelledby="costInsertAuthModalLabel" aria-hidden="true"  style=”z-index:1050;”>
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="costInsertAuthModalLabel"><strong>관리자 인증</strong></h4>
			</div>
			<form id="costInsertAuthForm" action="${cPath }/office/cost/costInsert.do" method="post">
				<input type="hidden" name="memId" value="${authMember.memId }" required/>
				<div class="modal-body">
					<span>${date } 기준</span>
					<br>
					<span>${commMeter.commYear }년 ${commMeter.commMonth }월 관리비 부과처리</span>
					<br>
					<span>* 부과처리 후에는 검침량 및 관리비를 수정할 수 없습니다.</span>
					<br>
					<table class="table table-bordered">
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="memPass" required/></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">등록</button>
					<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>


<script>
$(document).ready(function(){
	let currentPage = ${param.currentPage} + 0;
	
	if(currentPage != 0) {
		var offset = $('#costTable').offset();
		$('html').animate({scrollTop : offset.top}, 400);
	}
});



//===================페이징
let searchForm = $("#searchForm");
/*
 * 검색조건 바뀌면 페이지1페이지로 셋팅
 */
function resetPage() {
	searchForm.find("[name='currentPage']").val(1);
}
function pageLinkMove(event){
	event.preventDefault();
	let page = $(event.target).data("page");
	searchForm.find("[name='currentPage']").val(page);
	searchForm.submit();
	return false;
}

//==================부과기준표 모달===================
let costStandardViewModalBody = $("#costStandardViewModalBody");
let costStandardViewModal = $("#costStandardViewModal");

function viewCostStandard(event) {
	let modalURL = $.getContextPath() + "/office/cost/costStandardView.do";
	costStandardViewModal.find(costStandardViewModalBody).load(modalURL, function(){
		costStandardViewModal.modal("show");
	});
}


//==================부과처리 관리자 인증 모달===================
//validator 옵션
const validateOptions = {
		onsubmit:true,
		onfocusout:function(element, event){
			return this.element(element);
		},
		errorPlacement: function(error, element) {
			element.tooltip({
				title: error.text()
				, placement: "top"
				, trigger: "manual"
				, delay: { show: 500, hid: 100 }
			}).on("shown.bs.tooltip", function() {
				let tag = $(this);
				setTimeout(() => {
					tag.tooltip("hide");
				}, 3000)
			}).tooltip('show');
	  	}
	}
	
//moveoutCancelAuthForm을 위한 ajaxForm 옵션
function commonSuccess(resp){
	console.log(resp);
	if(resp.result == "OK"){
		costInsertAuthForm.get(0).reset();
		costInsertAuthModal.modal("hide");
	}
	getNoty(resp);
}
let options={
	beforeSubmit: function(form, options) {
		if(!confirm("당월 관리비를 부과처리 하시겠습니까?")) return;
	}	
	,dataType: "json"
	,success: commonSuccess
};


let costInsertAuthModal = $("#costInsertAuthModal").on("hidden.bs.modal", function(){
	$(this).find("form").get(0).reset();
});

let costInsertAuthForm = $("#costInsertAuthForm");
let validatorForAuthForm = costInsertAuthForm.validate(validateOptions);
costInsertAuthForm.ajaxForm(options);




//==================================chartJs=============================
var cvsHousePplChart = document.getElementById('housePplChart');
//================공영관리비
var cvsCostCommChart = document.getElementById('costCommChart');
var costTypeArr=[];
var costCommTotalArr=[];

<c:if test="${not empty costCommList }">
	<c:forEach items="${costCommList }" var="costComm">
		costTypeArr.push("${costComm.costType}");
		costCommTotalArr.push(${costComm.costCommTotal });
	</c:forEach>
</c:if>

var costCommChart = new Chart(cvsCostCommChart, {
	type: 'horizontalBar'//[https://www.chartjs.org/docs/latest/axes/ <<(컨트롤 +우클릭) 여기 가서 원하는 타입 바꿔주면 모양바껴용
	,data: {
		labels: costTypeArr
		,datasets: [{
			label: '발생금액'
			,data: costCommTotalArr //값들 입력
			,backgroundColor: [
				'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
				'rgba(255, 159, 64, 0.2)',
				'rgba(255, 205, 86, 0.2)',
				'rgba(75, 192, 192, 0.2)',
				'rgba(54, 162, 235, 0.2)',
				
			]
			,borderColor: [
				'rgb(255, 99, 132)',// 값 갯수당 만들고 색깔 
				'rgb(255, 159, 64)',
				'rgb(255, 205, 86)',
				'rgb(75, 192, 192)',
				'rgb(54, 162, 235)',
			]
			,borderWidth: 2
		}]
	},
	options: {
		responsive: true
		,scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true
				}
			}]
			,xAxes: [{
				ticks: {
					beginAtZero: true
					,callback: function(value, index) {
			            if(value.toString().length > 8) return (Math.floor(value / 100000000)).toLocaleString("ko-KR") + "억";
			            else if(value.toString().length > 4) return (Math.floor(value / 10000)).toLocaleString("ko-KR") + "만";
			            else return value.toLocaleString("ko-KR"); 
			          }
				}
			}]
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

</script>