<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="${cPath }/js/chartjs/Chart.min.js"></script> <!-- 박찬: chartJs -->
<script src="${cPath }/js/chartjs/chartjs-plugin-datalabels.min.js"></script> <!-- 이경륜: chartJs datalabel 플러그인-->
<style>
.col-xl-3{
	margin-top: 2%;
	margin-bottom: 2%;
}
#pagingArea{
	align-items: center;
}

    
</style>
<div class="container col-xl-12"> <!-- 이경륜이 추가 -->
<div class="row">
	 <div class="col-xl-3">
		<div class="card mb-4">
			<div class="card-header">
				<i class="fas fa-chart-bar mr-1"></i>
				<label class="apartName" style="color: blue;">모든 아파트</label>&nbsp;관리사무소 기능 이용 현황 
			</div>
			<div class="card-body container">
				<form id="menuForm">
					<input type="hidden" name="reqFlag" value="0" id="reqFlag"/>
				</form>
				<div class="d-flex justify-content-between">
               		<button class="btn btn-dark menuMonth" data-month="1">1개월</button>
               		<button class="btn btn-dark menuMonth" data-month="3">3개월</button>
               		<button class="btn btn-dark menuMonth" data-month="6">6개월</button>
               		<button class="btn btn-primary menuMonth" data-month="0">전체</button>
				</div>
				<div id="menuChartDiv">
					<canvas id="menuChart" width="400%" height="600%"></canvas>
				</div>
			</div>
		</div>
	</div>
    <div class="col-xl-3">
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-chart-area mr-1"></i>
                	아파트 목록 
                	 <a href="${cPath}/vendor/apartList.do" style="margin-left: 20%;"><i class="fa fa-desktop" aria-hidden="true"></i>&nbsp;회원관리</a>
                	 <a href="${cPath }/vendor" style="margin-left: 20%;"><i class="fa fa-undo" aria-hidden="true"></i>&nbsp;초기화</a>
            </div>
           <div class="card-body" id="list">
            <div>
	    	<form id="searchForm" action="${cPath }/vendor/search.do" method="get" class="form-inline">
				<input type="hidden" name="page" />
				<input type="hidden" name="currentPage" value="1">
		      <div class="card-body inputUI">
		      		<div class="ml-3" style="float:left">
		      			 <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
					    style="width:30px;height:30px;">&nbsp;&nbsp;
			        	<select name="searchType" class="custom-select searchSelect">
							<option value="aptName" ${'aptName' eq param.searchType?"selected":"" }>아파트명</option>
			        	</select> 
				       	<input type="text" name="searchWord" class="form-control col-sm-8" value="${pagingVO.searchVO.searchWord }" id="search">
		      		</div>
		      		<div class="ml-3" style="float:left">
					</div>
		      	</div>
			</form>
					    </div>
           <c:set var="apartList" value="${pagingVO.dataList }"/>
           <table class="table table-hover" id="apartTable">
				<thead class="thead-light" >
				<tr>
					<th class="text-center" scope="col">No.</th>
					<th class="text-center" scope="col">아파트명</th>
					<th class="text-center" scope="col">계약 시작일</th>
					<th class="text-center" scope="col">계약 만료일</th>
				</tr>
				</thead>
				<tbody id="apartListBody">
				
				</tbody>
			</table>
			 <div id="pagingArea" class="pagination justify-content-center">
        
            </div>
           </div>
        </div>
    </div>
   
	
     <div class="col-xl-3">
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-chart-bar mr-1"></i>
               <label class="apartName" style="color: blue;">모든 아파트</label> 관리사무소 문의글
            </div>
             
             <div class="card-body">
             
             		<select class="custom-select" name="yy" onchange="monthselect()" id="year">
             				<option selected="selected">모든 날짜 </option>
             			<c:forEach items="${yy}" var="year">
             			<option>${year.year }년</option>
             			</c:forEach>
             		</select>
             		
             			<select class="custom-select" name="mm" id="month" onchange="daySearchChart()">
             				<option>년도를 선택해주세요.</option>
             		</select>
			<div id="totalQna" data-qnatotal = ${qnaTotalCount.qnaTotal }  
							   data-qnareplytotal=${qnaTotalCount.qnareplyTotal }
							   data-notqnareply=${qnaTotalCount.notQnareply }>
             		<br>
			</div>
             <canvas id="officequestion" width="400%" height="600%"></canvas>
             </div>
        </div>
    </div>
      <div class="col-xl-3">
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-chart-bar mr-1"></i>
                	[벤더]관리사무소 공지사항 글 <a href="${cPath}/vendor/noticeList.do" style="margin-left: 10%;"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;더보기</a>
            </div>
            <div class="card-body" id="list">
           <table class="table" id="listBody">
				<thead class="thead-light" >
				<tr>
					<th class="text-center" scope="col">No.</th>
					<th class="text-center" scope="col">제목</th>
					<th class="text-center" scope="col">날짜</th>
				</tr>
				</thead>
				<tbody id="noticeBody">
				<c:set var="noticeList" value="${noticeList }"/>
				<c:if test="${not empty noticeList }">
					<c:forEach items="${noticeList }" var="notice" end ="4">
					<tr id="" data-bono="${notice.boNo }">
						<td class="text-center">${notice.rnum }</td>
						<td>${fn:substring(notice.boTitle,0,24) }
						<c:choose>
								<c:when test="${fn:length(notice.boTitle) gt 24 }">
								.....
								</c:when>
								<c:when test="${fn:length(notice.boTitle) lt 24 }">
								
								</c:when>
						</c:choose>
						</td>
						<td>${notice.boDate}</td>
              		</tr>
              		</c:forEach>
              		</c:if>
				</tbody>
			</table>
           </div>
        </div>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-chart-bar mr-1"></i>
                	관리사무소 문의글 <a href="${cPath}/vendor/qna/qnaList.do" style="margin-left: 10%;"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;더보기</a> 
            </div>
            <div class="card-body" id="list">
				<select name="boType" class="custom-select" onchange="qnaList()" id="boType">
				</select>
	           <table class="table" id="listBody">
				
				<thead class="thead-light" >
				<tr>
					<th class="text-center" scope="col">No.</th>
					<th class="text-center" scope="col">제목</th>
					<th class="text-center" scope="col">날짜</th>
				</tr>
				</thead>
				<tbody id="qnaList">
				<c:set var="qnaList" value="${qnaList }"/>
				<c:if test="${not empty qnaList }">
					<c:forEach items="${qnaList }" var="qna" end ="4">
					<c:if test="${qna.boDepth eq 1 }">
					<tr id="">
						<td class="text-center">${qna.rnum }</td>
						<td>${fn:substring(qna.boTitle,0,24) }
						<c:choose>
								<c:when test="${fn:length(qna.boTitle) gt 24 }">
								.....
								</c:when>
								<c:when test="${fn:length(qna.boTitle) lt 24 }">
								
								</c:when>
						</c:choose>
						</td>
						<td class="text-center">${qna.boDate}</td>
              		</tr>
              		</c:if>
              		</c:forEach>
              		</c:if>
				</tbody>
			</table>
			</div>
           </div>
        </div>
    </div>


<form id="dashBoardForm" action="${cPath }/vendor/dashBoardForm.do">
	<input type="hidden" name ="aptCode" value="">
</form>


<div class="modal fade" id="myLargeModalLabel" tabindex="-1" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog" data-bs-backdrop="static" style="max-width: 100%; width: auto; display: table;">
	  <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title h4" id="myLargeModalLabel">공지사항</h5>
	         <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	      
	      </div>
	      <div class="modal-footer">
			<input type="button" value="수정" class="btn btn-warning" id="modifyBtn" />
			<input type="button" value="저장" class="btn btn-primary" id="saveBtn" onclick="saveUpdate(); return false;"/>
			<input type="button" value="삭제" class="btn btn-danger" id="delectBtn" onclick="noticedelete()" />
             <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	</div>
</div>
</div>
<script type="text/javascript">

function syncPageWithCurrent() {
	let currentPage = $("li.page-item.active :eq(0)").text();
	searchForm.find("[name='currentPage']").val(currentPage);
}


let pagingArea = $("#pagingArea");
let pagingA = pagingArea.on('click', "a" ,function(){
	let page = $(this).data("page");
	searchForm.find("[name='currentPage']").val(page);
	searchForm.submit();
	searchForm.find("[name='currentPage']").val(1); 
	return false;
});	

function syncFormWithUI(inputs) {
	$(inputs).each(function(index, input){
		console.log($(this));
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
}
// keyup paste 하면 한글자씩 입력할때마다 바로보이지만 내가보기엔 이거쓰면 부화 걸릴듯
$("#search").on("change", function(){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	syncFormWithUI(inputs);
	searchForm.submit();
});


$("#resetBtn").on("click", function() {
	// input 박스 비우도록
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val(null);
	});

	// select 박스 첫번째 옵션이 선택되도록
	let selects = $("div#inputUI .searchSelect"); 
	$(selects).each(function(index, select) {
		$(select).children(":eq(0)").prop("selected", true);
	});

	syncFormWithUI(inputs);
});

let apartListBody = $("#apartListBody");


let apartTable = $("#apartTable").find(apartListBody);

let searchForm = $("#searchForm").ajaxForm({
	/*
	 * ajaxForm이 submit전 이미 serialize된 form의 input을 복사한 후 inputs를 대상으로 서버로 넘기고있음
	 * 값을 지정하고싶으면 form이 아닌 inputs 대상으로 지정해줘야함
	 */
	dataType : "json",
	success : function(resp) {
		if(resp.message){ // 실패시
			getNoty(resp);
			return;
		}
		apartListBody.empty();
		pagingArea.empty();
		let apartList = resp.pagingVO.dataList;
		
		let trTags = [];
		if(apartList.length>0){
			$(apartList).each(function(idx, apart){
				if(apart.aptDelete == "Y"){
					let tr = $("<tr data-aptcode='"+apart.aptCode+"' data-aptname='"+apart.aptName+"'>");
					let button = null;
					tr.append(
							$("<td>").text(apart.rnum).addClass("text-center"),
							$("<td>").text(apart.aptName),
							$("<td>").text(apart.aptStart).addClass("text-center"),
							$("<td>").text(apart.aptEnd).addClass("text-center")
					),
					trTags.push(tr);
				}
			});
		}else{
			trTags.push(
				$("<tr>").html(
					$("<td colspan='13'>").text("아파트 정보가 없습니다.")									
				)
			);
		}
		apartTable.html(trTags);
		if(apartList.length>0)
			pagingArea.html(resp.pagingVO.pagingHTML);

	},
	error : function(errResp) {
		console.log(errResp);
	}
}).submit();


	var aptCodeData =null;

apartListBody.on("click", "tr", function(){
	aptCodeData = $(this).data("aptcode");
	let aptCode= $("#dashBoardForm").find("[name='aptCode']").val(aptCodeData);
	let aptName = $(this).data("aptname");
	let year =$("#year");
	let month =$("#month");
	let dashBoardForm = $("#dashBoardForm").ajaxForm({
			
			dataType : "json",
			success : function(resp) {
				let yy = resp.yy;
				year.empty();
				let options = [];
				options.push("<option>모든 날짜</option>");
				month.empty();
				month.html("<option>년도를 선택해주세요.</option>")
				$(yy).each(function(idx, yy){
					let option = $("<option>");
					option.append(yy.year+"년"),
					options.push(option);
				})
					
				if(options.length != 0){
					year.html(options);
				}else{
					month.html("<option>년도를 선택해주세요.</option>")
				}
				
				let total = resp.qnaCount;
				qnatotal = total.qnaTotal;
				qnareplytotal =total.qnareplyTotal; 
				notqnareply =total.notQnareply;
				//차트js 업데이트
				$(".apartName").text(aptName);
				officeQuestion.data.datasets[0].data = [qnatotal, qnareplytotal, notqnareply,0];//차트js 업데이트
				officeQuestion.update();
			},	
			error : function(errResp) {
				console.log(errResp);
			}
		}).submit();
});


//=============================================================
// 이경륜: 로그 통계 시작============================================

function commaify(value) {
	var result = (''+value).replace(/^(-?\d+)(\d{3})/, '$1,$2');
	return value == result? result : commaify(result);
}
let menuNameArr = [];
let menuCntArr = [];
let menuForm =$("#menuForm").ajaxForm({
	dataType: "json"
	,url: "${cPath}/vendor/menuList.do"
	,success : function(resp)  {
		if(resp.message){ // 실패시
			getNoty(resp);
			return;
		}
		let menuList = resp.menuList;
		
		menuNameArr = [];
		menuCntArr = [];
		
		// 기존에 있던 chart 없애는 코드
		var cvsMenuChart = document.getElementById('menuChart');
		cvsMenuChart.remove(); //canvas
		let menuChartDiv = document.querySelector("#menuChartDiv"); //canvas parent element
		menuChartDiv.insertAdjacentHTML("afterbegin", "<canvas id='menuChart' width='400%' height='600%'></canvas>"); //adding the canvas again
		cvsMenuChart = document.getElementById('menuChart');
		
		if(menuList.length>0) {
			$(menuList).each(function(idx, menu){
				menuNameArr.push(menu.menuName);
				menuCntArr.push(menu.menuCnt);
			})
		} else {
			// 로그없으면?
		}


		// 차트js 넣는 함수
		var menuChart = new Chart(cvsMenuChart, {
			type: 'horizontalBar'
			,data: {
				labels: menuNameArr
				,datasets: [{
					data: menuCntArr
					,backgroundColor: [
						'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
						'rgba(54, 162, 235, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
						'rgba(54, 162, 235, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
						'rgba(54, 162, 235, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)'
						
					]
					,borderColor: [
						'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
						'rgba(54, 162, 235, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
						'rgba(54, 162, 235, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(255, 99, 132, 0.2)',// 값 갯수당 만들고 색깔 
						'rgba(54, 162, 235, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)',
						'rgba(62, 160, 88, 0.2)'
					]
					,borderWidth: 2
					,datalabels: {
						anchor: 'center'
						,align: 'end'
						,formatter: function(value) {
					          return commaify(value);
				        }
					}
				}]
			},
			options: {
				responsive: false
				,scales: {
					yAxes: [{
						ticks: {
							beginAtZero: true
						}
					}]
				}
				,legend: {
		            display: false
            	}
			}
		});

	},error: function(errResp) {
		console.log(errResp);
	}
}).submit();

//기간 클릭시 menuForm에 넣기
$(".menuMonth").on("click", function (){
	let selectedMonth = $(this).data("month");
	$("#reqFlag").val(selectedMonth);
	$(this).removeClass("btn-dark");
	$(this).addClass("btn-primary");

	// 클릭한 검색조건 제외하고 안보이게
	let siblings = $(this).siblings();
	siblings.each(function(idx, btn) {
		$(this).removeClass("btn-primary");
		$(this).addClass("btn-dark");
	});
	
	menuForm.submit();
});
	
//이경륜: 로그 통계 끄읕============================================	
//=============================================================
	
	
	
// ======================================================
// 문의글: 박찬======================================================
	
var qnatotalData = $("#totalQna").data("qnatotal");
var qnareplytotalData=$("#totalQna").data("qnareplytotal");
var notqnareplyData=$("#totalQna").data("notqnareply");


var qnatotal = qnatotalData; //문의글 토탈 
var qnareplytotal = qnareplytotalData; //문의글 답변 완료 토탈
var notqnareply =notqnareplyData; // 문의글 미답변 토탈
var ctxOfficeQuestion = document.getElementById('officequestion');

var config ={
	type: 'bar',//[https://www.chartjs.org/docs/latest/axes/ <<(컨트롤 +우클릭)
							//여기 가서 원하는 타입 바꿔주면 모양바껴용
	data: {
		labels: ["문의글 수", "답변완료 수", '답글 대기 수'],
		datasets: [{
			label:'문의글 통계표',
			data: [qnatotal, qnareplytotal, notqnareply, 0],//값들 입력
			backgroundColor: [
				'rgba(0, 0, 0, 0.46)',// 값 갯수당 만들고 색깔 
				'rgba(0, 255, 116, 0.46)',
				'rgba(255, 0, 0, 0.55)'
				
			],
			borderColor: [
				'rgba(0, 0, 0, 0.46)',// 값 갯수당 만들고 색깔 
				'rgba(0, 255, 116, 0.46)',
				'rgba(255, 0, 0, 0.55)'
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
					,stepSize: qnatotal > 10 ? 5 : 1
				}
			}]
		}
		,legend: {
	        display: false
		}
	}
};
var officeQuestion = new Chart(ctxOfficeQuestion,config);



let optTag = $("[name='boType']");
$.ajax({
	url : "${cPath }/board/getOption.do ",
	method : "get",
	dataType : "json",
	success : function(resp) {
		let opts = [];
		// 옵션을 동적으로 구성
		$(resp.option).each(function(idx, opt){
			opts.push(
				// type을 그대로 유지하기 위해서 prop 를 사용
				$("<option>").text(opt.codeName)
							 .attr("value", opt.codeId)
							 .prop("selected", "${pagingVO.searchDetail.boType}"==opt.codeId)
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		optTag.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});


let qnaBody = $("#qnaList");
function qnaList(){
	let codeId = $("#boType option:selected").val();
	$.ajax({
		url : "${cPath}/vendor/qnaType.do?boType="+codeId+""
		,method: "get",
		dataType :"json",
		success: function(resp){
			let qnaList = resp.qnaList;
			qnaBody.empty();
			let trTags = [];
			$(qnaList).each(function (idx,qna){
				let tr = $("<tr>");
				if(qna.boDepth == 1){
				tr.append(
						$("<td>").text(qna.rnum),
						$("<td>").text(qna.boTitle),
						$("<td>").text(qna.boDate)
				),
				trTags.push(tr);
				}
			})
			qnaBody.html(trTags)
		}
		,error:function(xhr){
			console.log("실패")
		}
	})
	
}
//해당 년도를 선택 할 그거에 맞는 해당 월 뿌려주기
//아파트 코드 소지시 해당 아파트의 글이 등록된 시간을 통해 월 뿌려주기
function monthselect(){
	let month = $("#month");
	let yearChar = $("#year option:selected").val();
	var year = yearChar.slice(0,-1);
	let urlchoose;
	if(aptCodeData == null){
		urlchoose="${cPath}/vedor/dayList.do?year="+year
	}else{
		urlchoose="${cPath}/vedor/dayList.do?year="+year+"&aptCode="+aptCodeData
	}
	$.ajax({
		url : urlchoose
		,method: "get",
		dataType :"json",
		success: function(resp){
			let mmList = resp.mm;
			let qnacount = resp.qnaTotalCount;
			officeQuestion.data.datasets[0].data = [qnacount.qnaTotal, qnacount.qnareplyTotal, qnacount.notQnareply,0];//차트js 업데이트
			officeQuestion.update();
			month.empty();
			let options = [];
			$(mmList).each(function(idx, mm){
				let option = $("<option>");
				option.append(mm.monday+"월"),
				options.push(option);
			})
			if(options.length != 0){
			month.html(options);
			}else{
				month.html("<option>년도를 선택해주세요.</option>")
			}
		},
		error: function (xhr){
			
		}
	
	})
	}

//년도와 월별 검색하여 차트js에 뿌려주는곳 
//아파트 코드 존재할 시 아파트 코드 url 참조 
function daySearchChart(){
	let month = $("#month option:selected").val().slice(0,-1);
	let year = $("#year option:selected").val().slice(0,-1);
	
	let urlchoose;
	if(aptCodeData == null){
		urlchoose="${cPath}/vedor/searchDayChart.do?monday='"+month+"'&&year="+year+""
	}else{
		urlchoose="${cPath}/vedor/searchDayChart.do?monday='"+month+"'&&year="+year+"&aptCode="+aptCodeData
	}
	$.ajax({
		url:urlchoose
		,method: "get"
		,dataType :"json"
		,success: function(resp){
			let qnacount = resp.qnaTotalCount;
			officeQuestion.data.datasets[0].data = [qnacount.qnaTotal, qnacount.qnareplyTotal, qnacount.notQnareply,0];//차트js 업데이트
			officeQuestion.update();
		}
		,error:function(xhr){
			
		}
		
	})
}



//=======================벤더 공지사항 상세보기==================================// 
let noticeModel = $("#myLargeModalLabel").on("hidden.bs.modal", function(){
	$(this).find(".modal-body").empty();
});

let noticeBoardkey = null;
$("#noticeBody").on("click", "tr", function(){
	
	noticeBoardkey = $(this).data("bono");
	noticeModel.find(".modal-body").load("${cPath}/ajax/noticeView.do?boNo="+noticeBoardkey);
	$("#saveBtn").hide();
	$("#modifyBtn").show();
	$("#delectBtn").show();
	$("#myLargeModalLabel").modal("show");
})

$("#modifyBtn").on("click",function(){
	$("#myLargeModalLabel").modal("hide");
		noticeModel.find(".modal-body").empty();

	var timeOut = function(){
		noticeModel.find(".modal-body").load("${cPath}/ajax/noticeAjaxUpdateForm.do?boNo="+noticeBoardkey+"");
		$("#modifyBtn").hide();
		$("#saveBtn").show();
		$("#delectBtn").hide();
		$("#myLargeModalLabel").modal("show");
	}
	setTimeout(timeOut,1000);
	
})


/**
 * 공지사항 수정 폼 작성후 저장 버튼 클릭 시 
 */
let noticeBody = $("#noticeBody");

function saveUpdate(){
	// submit말고 ajax로 보낼시 ck에디터가 작동을 하기전이기 때문에 버튼 클릭시 먼저 ck에디터를 작동시킨 후 보내주기
	for ( instance in CKEDITOR.instances )
	    CKEDITOR.instances[instance].updateElement();

var form = $("#noticeForm")[0];        
var formData = new FormData(form);
	var option={ 
		type: 'POST', 
		url: '${cPath }/ajax/noticeAjaxUpdate.do',
		processData: false, 
		contentType: false, 
		data: formData, 
		success: function(data) { 
			var message = data.text;
			var type= data.type;
			if(type='success'){
				noticeajaxList();
				if (confirm(message+" 해당글 상세보기를 하시겠습니까?") == true){ 
					$("#myLargeModalLabel").modal("hide");
					noticeModel.find(".modal-body").empty();

				var timeOut = function(){
					noticeModel.find(".modal-body").load("${cPath}/ajax/noticeView.do?boNo="+noticeBoardkey);
					$("#modifyBtn").show();
					$("#saveBtn").hide();
					$("#delectBtn").show();
					$("#myLargeModalLabel").modal("show");
				}
				setTimeout(timeOut,1000);
					
				 }else{ 
					 $("#myLargeModalLabel").modal("hide");
					 
				     return false;
				 }
			}
		} 
	};
	$.ajax(option);
};

function noticeajaxList(){
	$.ajax({
		url:"${cPath}/vendor/noticeAjaxList.do"
		,method: "get"
		,dataType:"json"
		,success: function(res){
			let noticeList = res.noticeList;
			noticeBody.empty();
			let trTags=[];
			$(noticeList).each(function(idx, notice){
				let tr = $("<tr data-bono='"+notice.boNo+"'>");
				tr.append(
					$("<td>").text(notice.rnum),
					$("<td>").text((notice.boTitle).substring(0,24)),
					$("<td>").text(notice.boDate)
				),
				trTags.push(tr);
			});
			noticeBody.html(trTags)
		
		},error :function(xhr){
		}
		
	});	
}
function noticedelete(){
	
	$.ajax({
		url:"${cPath}/vendor/noticeAjaxDelete.do?boNo="+noticeBoardkey
		,method: "get"
		,dataType:"json"
		,success: function(res){
			noticeajaxList();
			alert("해당글이 삭제 되었습니다.");
			$("#myLargeModalLabel").modal("hide");
		},error :function(xhr){
			console.log(xhr);
		}
		
	});	
	
	
}


</script>                