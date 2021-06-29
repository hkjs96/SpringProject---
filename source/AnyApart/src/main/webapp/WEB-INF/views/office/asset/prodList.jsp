<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<style>
	#viewBody th {
		background-color: #e9ecef
	}
	.contentBody {
		width: 82%;
		margin: auto;
	}
	.tbodyScroll{
		overflow-y: auto;
		height: 400px; 
	}
	.tableScroll {
		overflow-y: auto;
		max-height: 556px;
	}
	.tableScroll thead th{
		position: -webkit-sticky;
		position: sticky;
		top: 0;
	}
	#listBody td {
		cursor: pointer;
	}
</style>


	<br>
	<h2><strong>물품관리</strong></h2>
	<br>
	<div class="container">
	<div class="col-md-12 " style="border-style:outset;border-radius: 8px;">
	    <form id="searchForm" class="form-inline">
	    	<input type="hidden" name="page" />
			<input type="hidden" name="prodCode"/>
			<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
			<input type="hidden" name="screenSize" value="${pagingVO.screenSize }"/>
	    </form>
		  <div class="prod row g-0 text-center">
			    <div class="col-md-2" style="margin: auto;">
			      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
			        style="width:30px;height:30px;margin: auto;">&nbsp;&nbsp;<strong>검색 조건</strong>
			    </div>
			    <div id="inputUI" class="col-md-10">
				    <div class="row card-body ">
				    	<div class="row col-md-9">
				        	&nbsp;&nbsp;<span style="margin: auto;">분류선택</span>&nbsp;&nbsp;
				        	<select id="prodCode" name="prodCode" class="custom-select col-md-2 prodCode" style="margin: auto;">
				        		<option value>전체</option>
				        	</select> 
				    		<input type="text" name="searchWord" class="form-control col-md-6" style="margin: auto;">
				    	</div>
				    	<div class="col-md-3">
							<button id="searchBtn" class="btn btn-dark"  style="margin: auto;">검색</button>
							<button id="initBtn" class="btn btn-secondary" style='margin: auto;'>초기화</button>
						</div>
					</div>
			    </div>
		  </div>
	</div>
	</div>
	<br>
	
	
<div class="mb-2" style="margin-left: 10%">
	<span style="color: green"><strong> * 클릭시 상세 조회가 가능합니다.</strong></span>
	<br>
	<select id="screenSize" name="screenSize" class="custom-select col-md-1">
		<option value="10" ${pagingVO.screenSize eq 10 ? "selected":""}>10</option>
		<option value="25" ${pagingVO.screenSize eq 25 ? "selected":""}>25</option>
		<option value="50" ${pagingVO.screenSize eq 50 ? "selected":""}>50</option>
	</select>
	<span>개 씩 보기</span>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#prodInsertModal" style="margin-left: 72%;">등록</button>
</div>

<div class="table-responsive table table-bordered contentBody tableScroll">
			<table class="table table-hover">
				<colgroup>
					<col width="10px">
					<col width="120px">
					<col width="120px">
					<col width="140px">
					<col width="140px">
					<col width="50px">
					<col width="60px">
				</colgroup>
			  <thead class="thead-light">
			    <tr class="text-center">
			      <th scope="col">No.</th>
			      <th scope="col">물품등록번호</th>
			      <th scope="col">물품분류</th>
			      <th scope="col">물품명</th>
			      <th scope="col">제조사</th>
			      <th class="text-right" scope="col" style="padding-rigt: 20px;">가격</th>
			      <th class="text-right" scope="col" style="padding-rigt: 20px;">수량(개)</th>
			    </tr>
			  </thead>
			  <tbody id="listBody">

			  </tbody>
			</table>
<!-- 			<ul class="pagination justify-content-center"> -->
<!-- 			    <li class="page-item" ><a class="page-link alert alert-secondary" href="#">Previous</a></li> -->
<!-- 			    <li class="page-item"><a class="page-link alert alert-secondary" href="#">1</a></li> -->
<!-- 			    <li class="page-item"><a class="page-link alert alert-secondary" href="#">2</a></li> -->
<!-- 			    <li class="page-item"><a class="page-link alert alert-secondary" href="#">3</a></li> -->
<!-- 			    <li class="page-item"><a class="page-link alert alert-secondary" href="#">Next</a></li> -->
<!-- 			</ul> -->
</div>	
<br>
<div id="pagingArea"></div>

<!-- 물품 등록 모달 -->
<div class="modal fade" id="prodInsertModal" tabindex="-1" aria-labelledby="prodInsertModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-dialog-scrollable modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="prodInsertModalLabel">물품등록</h3>
			</div>
			<form id="insertForm">
				<div class="modal-body" style="max-height: 600px;">
					<div>
						<div class="card text-center col-auto">
							<div class="card-body row">
								<div class="col-sm-12">
									<div class="text-right">
									<span id="injectBtn" class="btn btn-warning">시연용 추가하기</span>
									<span id="plusBtn" class="btn btn-primary plusBtn">추가하기</span>
									</div>
									<hr>
									<table class="table table-boardered">
										<colgroup>
											<col style="width: 120px">
											<col style="width: 60px">
											<col style="width: 30px">
											<col style="width: 60px">
											<col style="width: 30px">
											<col style="width: 60px">
										</colgroup>
										<thead class="thead-light">
											<tr class="text-center">
												<th scope="col">물품분류코드</th>
												<th scope="col">물품명</th>
												<th scope="col">가격</th>
												<th scope="col">제조사</th>
												<th scope="col">수량 (개)</th>
												<th scope="col">삭제</th>
											</tr>
										</thead>
											<tbody id="insertArea" class="tbody-light tbodyScroll">
												<tr>
													<td>
														<input type="hidden" name="prodList[0].aptCode" value="${pagingVO.searchVO.searchAptCode }"/>
														<select name="prodList[0].prodCode" class="custom-select md-6 prodCode">
										        			<option value>전체</option>
										        		</select>
													</td>
													<td><input name="prodList[0].prodName" size="12" type="text"></td>
													<td><input name="prodList[0].prodPrice" size="12" type="number" onkeypress="return onlyNumber(event)" min="0" max="9999999999"></td>
													<td><input name="prodList[0].prodCompany" size="12" type="text"></td>
													<td><input name="prodList[0].prodQty" size="12" type="number" onkeypress="return onlyNumber(event)" min="0" max="9999999999"></td>
													<td class="last now"><span class='btn btn-danger minusBtn'>-</span></td>
												</tr>
											</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
			<div class="modal-footer">
				<button id="submitBtn" class="btn btn-primary">저장</button>
<!-- 				<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button> -->
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- <button type="button" class="btn btn-dark" data-toggle="modal" data-target="#repairInsertModal">수리이력등록</button> -->
<!-- 물품 상세 보기 모달 -->
<div class="modal fade" id="prodViewModal" tabindex="-1" aria-labelledby="prodViewModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-dialog-scrollable modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="prodViewModalLabel">물품 상세 정보</h3>
			</div>
			<div class="modal-body">
				<table id="viewBody" class="table ">
					<tr>
						<th><span class="reddot">* </span>물품코드</th>
						<td id="viewId">
							
						</td>
						<th><span class="reddot">* </span>물품분류</th>
						<td id="viewCode">
							
						</td>
					</tr>
					<tr>
						<th><span class="reddot">* </span>물품명</th>
						<td id="viewName">
							
						</td>
						<th><span class="reddot">* </span>제조사/구매처</th>
						<td id="viewCompany">
							
						</td>
					</tr>
					<tr>
						<th><span class="reddot">* </span>가격(원)</th>
						<td id="viewPrice">
							
						</td>
						<th><span class="reddot">* </span>수량(개)</th>
						<td id="viewQty">
							
						</td>
					</tr>
				</table>
					<strong style="color: green">구매/사용 내역</strong>
				<div class="tableScroll">
					<table class="table ">
						<thead class="thead-light" id="detailHead"></thead>
						<tbody id="detailBody"></tbody>
					</table>
					<hr>
				</div>
					<strong class="repairBody" style="color: green">수리 이력</strong>
				<div class="tableScroll">
					<table class="table  repairBody">
						<thead class="thead-light" id="repairHead"></thead>
						<tbody id="repairBody"></tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
<!-- 					<button type="submit" class="btn btn-primary">저장</button> -->
<!-- 				<button id="submitBtn" class="btn btn-primary">저장</button> -->
<!-- 				<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button> -->
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>
//n개씩 보기
let screenSize = $("#screenSize").on("change",function(){
	let sizeNum = $(this).val();
	let hidden = searchForm.find("[name='screenSize']");
	hidden.val(sizeNum);
	searchForm.submit();
});

// 초기화 버튼
let initBtn = $("#initBtn");
initBtn.on("click", function(){
	event.preventDefault();
	$("#inputUI").find(":input").val("");
	$("[name=startDay]").val("");
	$("[name=endDay]").val("");
	return false;
});

//----------------------------------------------------------------------

let viewBody = $("#viewBody");

let prodViewModal = $("#prodViewModal");

let insertFm;
let data;

$("#submitBtn").on("click",function(){
	insertFm = $("#insertForm");
	data = insertFm.serialize();
	$.ajax({
		url : "${cPath }/office/asset/prod/prodInsert.do"
		, data : data
		, method : "post"
		, success : function(resp){
			searchForm.submit();
			let firstTr = $("#insertArea").children().first();
			firstTr.siblings("tr").detach();
			firstTr.find(":input").val("");
			$("#prodInsertModal").modal('hide');
			getNoty(resp);	// 노티 메시지 
		}
		, errors : function(xhr){
			console.log(xhr);
		}
	});
});

/*-------------------------------------------------------------------------------------------
	등록하기 UI 만들어 주는 부분
*/

String.prototype.replaceAt=function(index, character) {
    return this.substr(0, index) + character + this.substr(index+parseInt(character.length));
}

$(".minusBtn").hide();

$("#plusBtn").on("click", function(){
// 	let clickTr = $('#insertArea').find('tr').eq(0);
	let clickTr = $('#insertArea').find('tr').last();
	let newTr = clickTr.clone();
	let childInput = newTr.find(":input");
	let name;
	$(childInput).each(function(idx,element){
		// 각 input 값을 찾아서 name을 변경
		name = parseInt(element.name.substring(9,10));
		name = String(name + 1);
		str = element.name.replaceAt(9, name);
		element.setAttribute("name",str);
	});
	let minus = newTr.find(".minusBtn");
	$(minus).show();
	let inputTag = newTr.find(":input");
	inputTag.val("");
	clickTr.after(newTr);
	
	newTr.find("input[type=hidden]").val("${pagingVO.searchVO.searchAptCode }");
});

$("#insertArea").on("click", ".minusBtn", function(){
	let deleteTr = $(this).parent().parent();
	deleteTr.prev().find(".plusBtn").show();
	deleteTr.detach();
	
});


//---------------------------------------------------


//---------------------------------------------------

// let optTag = $("[name='prodCode']");
let optTag = $(".prodCode");
$.ajax({
	url : "${cPath }/prod/getOption.do ",
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
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		optTag.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});

let listBody = $("#listBody");
let viewTr;


let aptCode;

//----------------------------------------------------------------------
// 원찍어주는 함수
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


//----------------------------------------------------------------------


let searchForm = $("#searchForm").ajaxForm({
	// 응답데이터 받아 올수 었어야하기 때문에 resp가 있어야한다.
	// 정작빠진것은 응답데이터를 어떻게 받아오겠다라는 것이 없으니 알아야한다.
	dataType:"json",
	success:function(resp){
		// resp에 pagingVO가 포함
		let prodList = resp.pagingVO.dataList;
		let pagingHTML = resp.pagingVO.pagingHTML;
		aptCode = prodList[0].aptCode;
		let trTags = [];
		if(prodList.length>0){
			// 검색 결과가 있으면
			$(prodList).each(function(idx,prod){
				let price = numberWithCommas(prod.prodPrice); 
				let qty = numberWithCommas(prod.prodQty); 
				trTags.push(
					$("<tr>").append(
						$("<td>").text(resp.pagingVO.totalRecord - idx + - resp.pagingVO.screenSize*(resp.pagingVO.currentPage-1))
						, $("<td>").text(prod.prodId)
						, $("<td>").text(prod.prodCode)
						, $("<td>").text(prod.prodName).addClass("text-left")
						, $("<td>").text(prod.prodCompany).addClass("text-left")
						, $("<td>").text(price + ' 원').addClass("text-right")
						, $("<td>").text(qty).addClass("text-right")
					).data("prod", prod).addClass("text-center")	
				);
			});
		}else{
			// 검색 결과가 없으면
			trTags.push(
				$("<tr>").html(
					$("<td colspan='7'>").text("검색 결과 없음.")
				)
			);
		}
		let remainRowCnt = resp.pagingVO.screenSize - trTags.length;
//   		for(let i=0; i<remainRowCnt; i++){
//   			trTags.push($("<tr>").html($("<td colspan='7'>").html("&nbsp;")));
//   		}
		listBody.html(trTags);
		viewTr = $("#listBody").find("tr");
		pagingArea.html(pagingHTML);
// 		searchForm.find(":input[name='page']").val("");
	}
}).submit();


let detailHead = $("#detailHead");
let repairHead = $("#repairHead");
let detailBody = $("#detailBody");
let repairBody = $("#repairBody");
let repairTable = $(".repairBody");

listBody.on("click", viewTr, function(e){
	console.log($(e.target).parent().children().eq(1));
	let prodId = $(e.target).parent().children().eq(1).text();
	searchForm.find("[name=prodId]").val();
	console.log(prodId);
	
	$.ajax({
		url : "${cPath }/office/asset/prod/prodView.do"
		, data : { prodId : prodId }
		, method : "get"
		, dataType : "json"
		, success : function(data){
			
			/*
				여기에 동적으로 만들어 주는 부분 들어가야한다.
			*/
			let viewProd = data.prod;
			let detailList = viewProd.detailList;
			let repairList = viewProd.repairList;
			
			let price = numberWithCommas(viewProd.prodPrice);
			if(viewProd != null){
				$("#viewId").text(viewProd.prodId);
				$("#viewCode").text(viewProd.prodCode);
				$("#viewName").text(viewProd.prodName);
				$("#viewCompany").text(viewProd.prodCompany);
				$("#viewPrice").text(price+"원");
				$("#viewQty").text(viewProd.prodQty);
				
			}
			
			let detailThTags = [];
			let detailTrTags = [];
			if(detailList.length>0){
				detailThTags.push(
					$("<tr>").append(
						$("<th>").text("No.")
						, $("<th>").text("일자")
						, $("<th>").text("수량(개)")
						, $("<th>").text("구분")
					).addClass("text-center")
				);
				$(detailList).each(function(idx, detail){
					detailTrTags.push(
						$("<tr>").append(
							$("<td>").text(detail.ioNo)
							, $("<td>").text(detail.prodIoDate)
							, $("<td>").text(detail.prodIoQty).addClass("text-right")
							, $("<td>").text(detail.prodIo).css("color", detail.prodIo=="구매"?"red":"blue")
						).data("detail", detail).addClass("text-center")
					);
				});
			}else{
				detailTrTags.push(
					$("<tr>").html(
						$("<td colspan='4'>").text("검색 결과 없음.")
					)		
				);
			}
			
			let repairThTags = [];
			let repairTrTags = []; 
			if(repairList.length>0 && repairList[0].repairNo != null){
				repairThTags.push(
					$("<tr>").append(
						$("<th>").text("No.")
						, $("<th>").text("일자")
						, $("<th>").text("수리내용")
						, $("<th>").text("수리비")
					).addClass("text-center")
				);
				$(repairList).each(function(idx, repair){
					let price = numberWithCommas(repair.repairPrice);
					repairTrTags.push(
						$("<tr>").append(
							$("<td>").text(repair.repairNo)
							, $("<td>").text(repair.repairDate)
							, $("<td>").text(repair.repairContent).addClass("text-left")
							, $("<td>").text(price+" 원").addClass("text-right")
						).data("repair", repair).addClass("text-center")
					);
				});
				repairTable.show();
			}else{
				repairTrTags.push(
					$("<tr>").html(
						$("<td colspan='4'>").text("검색 결과 없음.")
					)		
				);
				repairTable.hide();
			}
			
			
			detailHead.html(detailThTags);
			repairHead.html(repairThTags);
			detailBody.html(detailTrTags);
			repairBody.html(repairTrTags);
			prodViewModal.modal('show');
		}
		, errors : function(xhr){
			console.log(xhr);
		}
	});
});

let searchBtn = $("#searchBtn").on("click", function(){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
	searchForm.submit();
});

let pagingArea = $("#pagingArea").on("click", "a" ,function(event){
	event.preventDefault();
	let page = $(this).data("page");
	searchForm.find("[name='page']").val(page);
	searchForm.submit();
	searchForm.find("[name='page']").val("");
	return false;
});

let code = $("#prodCode").on("change", function(){
// 	event.preventDefault();
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
		console.log(value);
		console.log(hidden.val());
	});
	searchForm.submit();
// 	return false;
})
</script>



<script>
	// 시연용 데이터 자동 입력 버튼
	/*
		delete from PRODDETAIL 
		where prod_id in ('A0024P014', 'A0024P013', 'A0024P012');
		
		delete from PROD
		where prod_id in ('A0024P014', 'A0024P013', 'A0024P012');
		
		commit;
	*/
	let injectBtn = $("#injectBtn").on("click", function(){
		$("#plusBtn").click();
		$("#plusBtn").click();
		
		$(":input[name='prodList[0].prodCode']").val("L001");
		$(":input[name='prodList[0].prodName']").val("검정네임펜1다스");
		$(":input[name='prodList[0].prodPrice']").val("8700");
		$(":input[name='prodList[0].prodCompany']").val("모나미");
		$(":input[name='prodList[0].prodQty']").val("10");
		
		$(":input[name='prodList[1].prodCode']").val("L001");
		$(":input[name='prodList[1].prodName']").val("커터칼");
		$(":input[name='prodList[1].prodPrice']").val("350");
		$(":input[name='prodList[1].prodCompany']").val("피스코리아");
		$(":input[name='prodList[1].prodQty']").val("10");
		
		$(":input[name='prodList[2].prodCode']").val("L001");
		$(":input[name='prodList[2].prodName']").val("검정유성매직");
		$(":input[name='prodList[2].prodPrice']").val("7500");
		$(":input[name='prodList[2].prodCompany']").val("모나미");
		$(":input[name='prodList[2].prodQty']").val("12");
	});
</script>