<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
.column {
  float: left;
  width: 25%;
  padding: 15px;
}

</style>

<br>
<div id="top"> 
<h2><strong>차량 관리</strong></h2>
	<div align="right">
		<input type="button" id="carADDBtn" value="차량 등록" class="btn btn-dark">
	</div>
</div>
	<div class="btn-group btn-group-toggle" data-toggle="buttons" style="width: 100%">
	  <label class="btn btn-success">
	    <input type="radio" name="options" id="option1" value="1" autocomplete="off" checked><span>#해당 차량 별 조회는 하단부 클릭</span>
	  </label>
	</div>
  <div class="no-gutters row" id="CarListDiv">
      <div class="col-sm-6 col-md-4 col-xl-4" data-type="all" onclick="typeSearch(this)">
          <div class="card no-shadow rm-border bg-transparent widget-chart text-left">
              <div class="icon-wrapper rounded-circle">
                  <div class="icon-wrapper-bg opacity-10 bg-warning"></div>
              </div>
              <div class="widget-chart-content" >
                  <div class="widget-subheading" >등록된 차량 수 </div>
                 <div class="widget-numbers" style="text-align: center;"><span id="totalNum"> ${carSumNumber.total }</span>건</div>
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
                  <div class="widget-subheading">입주민 차량 수</div>
                  <div class="widget-numbers" style="text-align: center;"><span id="residentNum">${carSumNumber.resident }</span>건</div>
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
                  <div class="widget-subheading">방문객 차량 수</div>
                  <div class="widget-numbers text-success" style="text-align: center;"><span id="guestNum">${carSumNumber.guest }</span>건</div>
              </div>
          </div>
      </div>
  </div>
<div class="table-responsive">
	<table class="table table-hover" id="residentTable">
		<thead class="thead-light" id="listhead">
			<tr class="text-center">
				<th>순번</th>
				<th>동  / 호</th>
				<th>차량 번호</th>
				<th>차량 명</th>
				<th>차량 크기</th>
				<th>용무 코드</th>
				<th>등록일</th>
			</tr>
		</thead>
		
	</table>
	<div class="table-responsive" style="width: 100%; height: 600px; overflow: auto" id="listDiv">
	<table class="table table-hover" id="residentTable">
		<tbody id="listBody">
	
		</tbody>
	</table>
	</div>
</div>

 <div id="usercarDiv">
 	<div style="margin-left: 45%; margin-right: 45%; width: 30%;">
	 		<select class ="custom-select col-md-4 searchSelect" name="dong">
	 			<c:forEach items="${dong }" var="dong">
	 				<option>${dong } 동</option>
	 			</c:forEach>
	 		</select>
	 	</div>
	 <div id="hoListDiv">
		 <div class="column">
		  	  <h2>Column</h2>
		  	  <img alt="" src="${cPath }/images/apartImages/aprtDong.png" style="width: 300px">
	 	 </div>
	 </div>
  </div>
  
  <div class="modal fade" id="myLargeModalLabel" tabindex="-1" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog" data-bs-backdrop="static" style="max-width: 100%; width: auto; display: table;">
	  <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title h4" id="myLargeModalLabel">차량등록 시스템</h5>
	         <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	      
	      </div>
	      <div class="modal-footer">
	      <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=20f2924230e0e2fb25bc546e44c0b498&libraries=services,clusterer,drawing&autoload=false"></script>
			<input type="button" value="등록" class="btn btn-primary mr-3" id="addBtn" />
             <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	</div>
</div>

<script>

let carAddForm = $("#myLargeModalLabel").on("hidden.bs.modal", function(){
	$(this).find(".modal-body").empty();
});

$("#carADDBtn").on("click",function(){
	carAddForm.find(".modal-body").load($.getContextPath()+"/office/carO/residentCarAdd.do", function(){
		carAddForm.modal("show");
	});
})
	
	carAllList();
	$("#usercarDiv").hide();
	$("input:radio[name=options]").click(function(){
	    if($("input[name=options]:checked").val() == "1"){
	    	$("#usercarDiv").hide();
	    	$("#listDiv").show();
	    	$("#listhead").html(
				"<tr class='text-center'>"+
				"<th>순번</th>"+
				"<th>동  / 호</th>"+
				"<th>차량 번호</th>"+
				"<th>차량 명</th>"+
				"<th>차량 크기</th>"+
				"<th>용무 코드</th>"+
				"<th>등록일</th>"+
				"</tr>"
			)
			carAllList();
			
	    }
	});
	
	function clickEv(e){
// 	var hos = $(e).data('ho');	
// 	var dong = $(e).data('dong');
	
// 		carAddForm.find(".modal-body").load($.getContextPath()+"/office/carO/donghoCarInfoChart.do?dong="+dong+"&&ho="+hos+"", function(){
// 			carAddForm.modal("show");
// 		});
	}
	
	function carAllList(type){
		let URLType="all";
		if(type=="CV"){
			URLType="CV";
		}else if(type=="CR"){
			URLType="CR";
		}else{
			URLType = "all";
		}
		
		$.ajax({
			url:"${cPath}/office/carO/residentCarListAll.do?type="+URLType+""
			,method: "get"
			,dataType:"json"
			,success: function(res){
				var listBody = $("#listBody");
				var carList = res.carList;
				let trTags=[];
				if(carList.length == 0){
					listBody.html("등록된 차량이 없습니다.").css("text-align","center");
				}else{
					
				$(carList).each(function(idx,carList){
					let tr = $("<tr style='text-align:center;'>");
					tr.append(
						$("<td>").text(idx+1),		
						$("<td>").text(carList.dong+"동 /" + carList.ho+"호"),		
						$("<td>").text(carList.carNo),		
						$("<td>").text(carList.carType),		
						$("<td>").text(),
						$("<td>").text(carList.carSize),		
						$("<td>").text(carList.carCodeName),		
						$("<td>").text(carList.approvalDate)		
					),
					trTags.push(tr);
					totalNum++;
					});
				listBody.html(trTags)
				}
			}
			,error: function (res){
				
			}
		
	});
		
	}
	
	function typeSearch(e){
		var type = $(e).data("type");
		carAllList(type);
	}
</script>
