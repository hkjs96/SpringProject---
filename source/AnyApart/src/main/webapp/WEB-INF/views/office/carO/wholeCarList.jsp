<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<style>
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
</style>
<br>
<div id="top"> 
	<h2><strong>신청 현황</strong></h2>
</div>

<div class="no-gutters row" id="CarListDiv">
      <div class="col-sm-6 col-md-4 col-xl-4" data-type="all" onclick="typeSearch(this)">
          <div class="card no-shadow rm-border bg-transparent widget-chart text-left">
              <div class="icon-wrapper rounded-circle">
                  <div class="icon-wrapper-bg opacity-10 bg-warning"></div>
              </div>
              <div class="widget-chart-content" >
                  <div class="widget-subheading" >신청 등록 수 </div>
                 <div class="widget-numbers" ><span id="totalNum" style="text-align: center;">${carSumNumber.total }</span>건</div>
              </div>
          </div>
          <div class="divider m-0 d-md-none d-sm-block"></div>
      </div>
      <div class="col-sm-6 col-md-4 col-xl-4" data-type="CR" onclick="typeSearch(this)">
          <div class="card no-shadow rm-border bg-transparent widget-chart text-left">
              <div class="icon-wrapper rounded-circle">
                  <div class="icon-wrapper-bg opacity-9 bg-danger"></div>
                  <i class="lnr-graduation-hat text-white"></i>
              </div>
              <div class="widget-chart-content" id="residentCarDiv">
                  <div class="widget-subheading">입주민 차량 신청 수</div>
                  <div class="widget-numbers"><span id="residentNum" style="text-align: center;">${carSumNumber.resident }</span>건</div>
              </div>
          </div>
          <div class="divider m-0 d-md-none d-sm-block"></div>
      </div>
      <div class="col-sm-12 col-md-4 col-xl-4" data-type="CV" onclick="typeSearch(this)">
          <div class="card no-shadow rm-border bg-transparent widget-chart text-left">
              <div class="icon-wrapper rounded-circle">
                  <div class="icon-wrapper-bg opacity-9 bg-success"></div>
                  <i class="lnr-apartment text-white"></i>
              </div>
              <div class="widget-chart-content" >
                  <div class="widget-subheading">방문객 차량 신청 수</div>
                  <div class="widget-numbers text-success"><span id="guestNum" style="text-align: center;">${carSumNumber.guest }</span>건</div>
              </div>
          </div>
      </div>
  </div>



<div class="table-responsive">
	<table class="table table-hover" id="residentTable">
		<thead class="thead-light">
			<tr class="text-center">
				<th>순번</th>
				<th>동  / 호</th>
				<th>차량 번호</th>
				<th>차량 명</th>
				<th>차량 크기</th>
				<th>용무 코드</th>
				<th>신청일</th>
				<th>신청 여부</th>
				<th colspan="2">기능</th>
			</tr>
		</thead>
		<tbody id="listBody">
		
		</tbody>
		<tfoot>
			<tr>
			</tr>
		</tfoot>
	</table>
</div>
<script>
var residentCar = 0;
var guestCar = 0;
var totalNum = 0;
function listAction(type){
	let URLType="all";
	if(type=="CV"){
		URLType="CV";
	}else if(type=="CR"){
		URLType="CR";
	}else{
		URLType = "all";
	}
	$.ajax({
		url:"${cPath}/office/carO/wholeCarListAjax.do?type="+URLType+""
		,method: "get"
		,dataType:"json"
		,success: function(res){
		var listBody = $("#listBody");
		var carList = res.carList;
		var total = 0;
		let trTags=[];		
		if(carList.length == 0){
			listBody.html("<td colspan='9'>신청된 차량이 없습니다.</td>").css("text-align","center");
		}else{
		$(carList).each(function(idx,carList){
			if(carList.carCode=='CV'){
				guestCar++;
			}else if(carList.carCode=='CR'){
				residentCar++;
			}
			let tr = $("<tr style='text-align:center;'>");
			tr.append(
				$("<td>").text(idx+1),		
				$("<td>").text(carList.dong+"동 /" + carList.ho+"호"),		
				$("<td>").text(carList.carNo),		
				$("<td>").text(carList.carType),		
				$("<td>").text(carList.carSize),		
				$("<td>").text(carList.carCodeName),		
				$("<td>").text(carList.applyDate),		
				$("<td>").text(carList.enrollFlag), 
				$("<td>").html(
				"<a class='btn btn-primary' id='enrollapproval' data-carno='"+carList.carNo+"' data-code='ENROLLAPPROVAL' onclick='carOk(this)'>승인</a>"+
				"<a class='btn btn-dark' id='enrollreject' data-carno='"+carList.carNo+"' data-code='ENROLLREJECT' onclick='carDel(this)'>반려</a>"
				)
			),
			trTags.push(tr);
			totalNum++;
			});
		listBody.html(trTags)
		$("#guestNum").text(guestCar);
		$("#residentNum").text(residentCar);
		$("#totalNum").text(guestCar+residentCar)
		residentCar= 0;
		guestCar = 0;
		totalNum = 0;
			}
		}
			
		,error: function (res){
			
		}
	
});
}

listAction();

// $("#CarListDiv").on("click","div",function(){
// 	let typeCode = $(this).data("type");
// 	console.log(typeCode);
// });

function typeSearch(e){
	var type = $(e).data("type");
	listAction(type);
}

// 승인
function carOk(e){
var carNumber = $(e).data('carno');
var code =$(e).data('code');
	
	$.ajax({
		url:"${cPath}/office/carO/enrollrejectAjax.do?type="+code+"&&carNo="+carNumber
		,method: "get"
		,dataType:"json"
		,success: function(res){
			var message = res;
			
			new Noty({
				 text:message.text, 
				 layout: message.layout,
				 type: message.type,
				 timeout: message.timeout,
				 progressBar: true
			}).show();
			listAction();
			
		},error:function(res){
			console.log(res)
			}
		});
}
// 반려
function carDel(e){
var carNumber = $(e).data('carno');
var code =$(e).data('code');

$.ajax({
	url:"${cPath}/office/carO/enrollrejectAjax.do?type="+code+"&&carNo="+carNumber
	,method: "get"
	,dataType:"json"
	,success: function(res){
		var message = res;
		new Noty({
			 text:message.text, 
			 layout: message.layout,
			 type: message.type ,
			 timeout: message.timeout,
			 progressBar: true
		}).show();
		listAction();
		
	},error:function(res){
		console.log(res)
		}
	});
	
}

</script>