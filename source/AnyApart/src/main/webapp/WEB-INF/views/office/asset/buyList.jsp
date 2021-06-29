<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
#listDiv{
	width: 90%;
	margin-left: 50px;
}
	.tableScroll {
		max-width: 1000px;
		overflow-y: auto;
		max-height: 500px;
	}
	.tableScroll thead th{
		position: -webkit-sticky;
		position: sticky;
		top: 0;
	}
	tr {
		
	}
</style>

<br>
<h2>
	<strong>사용 · 구매 이력</strong>
</h2>
<br>
<div class="container" id="searchDiv">
	<div class="col-md-10 " style="border-style: outset; border-radius: 8px; margin: auto;">
		 <form id="searchForm" class="form-inline">
	    	<input type="hidden" name="page" />
			<input type="hidden" name="prodCode"/>
			<input type="hidden" name="prodIo"/>
			<input type="hidden" name="startDay"/>
			<input type="hidden" name="endDay"/>
			<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
			<input type="hidden" name="screenSize" value="${pagingVO.screenSize }"/>
	    </form>
		<div class="row g-0" style="margin-left: 20px;">
			<div class="col-md-2" style="margin-top: 30px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
					style="width: 30px; height: 30px; margin: auto;">&nbsp;&nbsp;<strong>검색조건</strong>
			</div>
			<div id="inputUI" class="col-md-10">
				<form class="form-inline">
					<div style="margin-top: 30px;">분류선택&nbsp;&nbsp;
					 	<select id="prodCode" name="prodCode" class="custom-select col-md-3">
							<option value>전체</option>
						</select>
						&nbsp;&nbsp;구매/사용구분&nbsp;&nbsp;
					 	<select id="prodIo" name="prodIo" class="custom-select col-md-3">
							<option value>구분</option>
							<option value="PURCHASE" ${pagingVO.searchDetail.prodIo eq 'PURCHASE' ? "selected":""}>구매</option>
							<option value="USE" ${pagingVO.searchDetail.prodIo eq 'USE' ? "selected":""}>사용</option>
						</select>
						<input name="searchWord" type="text" class="form-control col-md-2"> 
					</div>
					<div style="margin:10px 0;">
						<input class="form-control col-md-5" style="display: inline-block;" type="date" name="startDay" value="${pagingVO.searchDetail.startDay }"/>
						<input class="form-control col-md-5" style="display: inline-block;" type="date" name="endDay" value="${pagingVO.searchDetail.endDay }"/>
						<button id="searchBtn" class="btn btn-dark" style='margin: 5pt;'>검색</button>
						<button id="initBtn" class="btn btn-secondary" style='margin: 5pt;'>초기화</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<br>

<div class="mb-2" style="margin-left: auto; margin-right: auto; max-width: 1000px;">
	<span style="color: green;"><strong> * 클릭시 수정가능하시며 다시 클릭시 풀립니다. * 수정하신 뒤 엔터를 누르면 값이 변경됩니다. (날짜/수량/구분선택)</strong></span><br>
	<br>
	<div class="container">
		<div class="row"> 
			<div class="col-md-11" >
				<select id="screenSize" name="screenSize" class="custom-select col-md-2">
					<option value="10" ${pagingVO.screenSize eq 10 ? "selected":""}>10</option>
					<option value="25" ${pagingVO.screenSize eq 25 ? "selected":""}>25</option>
					<option value="50" ${pagingVO.screenSize eq 50 ? "selected":""}>50</option>
				</select>
				<span>개 씩 보기</span>
			</div>	
			<div class="col-md-1">
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#detailInsertModal">등록</button>
			</div>
		</div>
	</div>
</div>
<div class="text-center col-sm-12 tableScroll"  id="listDiv" style="margin-left: auto; margin-right: auto;">
	<table class="table table-hover table-bordered" style="margin-left: auto; margin-right: auto; max-width: 1000px;">
		<colgroup>
<!-- 			<col width="100px"> -->
			<col width="10%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="20%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead class="thead-light">
			<tr>
<!-- 				<th scope="col">#</th> -->
				<th scope="col">No.</th>
				<th scope="col">일자</th>
				<th scope="col">물품등록번호</th>
				<th scope="col">물품분류</th>
				<th scope="col">물품명</th>
				<th scope="col">구분</th>
				<th scope="col">수량 (개)</th>
				<th scope="col">삭제</th>
			</tr>
		</thead>
		<tbody id="listBody">
			<c:set var="detailList" value="${pagingVO.dataList }" />
			<c:if test="${not empty detailList }">
				<c:forEach var="detail" items="${detailList }" varStatus="idx">
						<tr>
							<td scope="row">${pagingVO.totalRecord - idx.index - pagingVO.screenSize*(pagingVO.currentPage-1) }</td>
							<td >
								<span>${detail.prodIoDate }</span>
								<input class="updateTd" type="date" name="prodIoDate" value="${detail.prodIoDate }" required >
							</td>
							<td>
								${detail.prodId }
								<input type="hidden" name="ioNo" value="${detail.ioNo }" required >
							</td>
							<td>${detail.prodCode }</td>
							<td class="text-left">${detail.prodName }</td>
							<td >
								<c:if test="${'구매' eq detail.prodIo }">
									<span style="color: red">${detail.prodIo }</span>
								</c:if>
								<c:if test="${'사용' eq detail.prodIo }">
									<span style="color: blue">${detail.prodIo }</span>
								</c:if>
								<select class="updateTd" name="prodIo" class="custom-select col-md-9" required>
									<option value>전체</option>
									<option value="PURCHASE" ${'구매' eq detail.prodIo ?"selected":""} >구매</option>
									<option value="USE" ${'사용' eq detail.prodIo ?"selected":""}>사용</option>
								</select>
							</td>
							<td class="text-right" ><!-- 물품 갯수를 세온것을 max로 한정하는걸 해보면 좋을텐데 아쉽다. -->
								<span>${detail.prodIoQty }</span>
								<input class="updateTd" type="number" name="prodIoQty" max="99999" min="1" value="${detail.prodIoQty }" required>
							</td>
							<td>
								<input type="button" class="btn btn-danger" value="삭제" onclick="removeDetail('${detail.ioNo }')"/>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty detailList}">
					<tr>
						<td colspan="8">검색 결과 없음.</td>
					</tr>
				</c:if>
			
		</tbody>
	</table>
	<form id="updateFm" method="post" action="">
		<input type="hidden" name="ioNo" required />
		<input type="hidden" name="prodIoDate" required />
		<input type="hidden" name="prodIoQty" max="99999" min="1" required/>
		<input type="hidden" name="prodIo" required/>
	</form>
</div>
<div id="pagingArea">${pagingVO.pagingHTML }</div>
<!-- 구매/사용내역 등록 모달 -->
<div class="modal fade" id="detailInsertModal" tabindex="-1" aria-labelledby="detailInsertModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-dialog-scrollable modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="detailInsertModalLabel">구매/사용 내역 등록</h3>
			</div>
			<form id="insertForm">
				<div class="modal-body" style="max-height: 800px;">
					<div>
						<div class="card-body row">
							<div class="col-sm-12">
								<div class="text-right">
									<span id="plusBtn" class="btn btn-primary plusBtn">추가하기</span>
								</div>
								<hr>
								<table class="table table-hover table-bordered">
									<colgroup>
										<col style="width: 120px">
										<col style="width: 60px">
										<col style="width: 30px">
										<col style="width: 80px">
										<col style="width: 40px">
									</colgroup>
									<thead class="thead-light">
										<tr>
											<th class="text-center" scope="col">물품선택</th>
											<th class="text-center" scope="col">사용/구매일자</th>
											<th class="text-center" scope="col">수량</th>
											<th class="text-center" scope="col">내역구분</th>
											<th class="text-center" scope="col">추가</th>
										</tr>
									</thead>
									<tbody id="insertArea" class="tbody-light">
										<tr>
											<td class="text-center">
												<select id="prodId" name="detailList[0].prodId" class="custom-select col-md-12" required>
													<option value>선택하세요</option>
												</select>
											</td>
											<td class="text-center">
												<input type="date" name="detailList[0].prodIoDate" required >
											</td>
											<td class="text-center">
												<input type="number" name="detailList[0].prodIoQty" max="99999" min="1" required >
											</td>
											<td class="text-center">
												<select name="detailList[0].prodIo" class="custom-select col-md-9" required>
													<option value>전체</option>
													<option value="PURCHASE" >구매</option>
													<option value="USE" >사용</option>
												</select>
											</td>
											<td class="text-center last now"><span class='btn btn-danger minusBtn'>-</span></td>
										</tr>
									</tbody>
								</table>
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

<script>

// n개씩 보기
let screenSize = $("#screenSize").on("change",function(){
	let sizeNum = $(this).val();
	let hidden = searchForm.find("[name='screenSize']");
	hidden.val(sizeNum);
	searchForm.submit();
});

removeDetail = function(ioNo){
	if (confirm("정말 삭제하시겠습니까??") == true){
		$.ajax({
			url : "${cPath}/office/asset/buy/buyRemove.do"
			, data : { ioNo : ioNo }
			, method : "post"
			, success : function(){
				searchForm.submit();
			}
			, errors : function(xhr){ console.log(xhr); }
		});
	}else{
		return false;
	}
}

//--------------------------------------------------------------------------//

let data;

let updateFm = $("#updateFm");
let updateTr = $("#listBody").find(".updateTd").toggle();
// updateTr.find(":input").toggle();

$("#listBody").on("click", updateTr, function(){
	let targetTr = $(event.target);
	let childSpan = targetTr.find("span");
	let childInput = targetTr.find(":input[name]");
	
	childSpan.toggle();
	childInput.toggle();
// 	console.log("none"==childSpan.css("display"));	// 처음 inline, 그다음 none

}).on("keypress", updateTr, function(e){
	let targetTr = $(event.target);
	let childSpan = targetTr.find("span");
	let childInput = targetTr.find(":input[name]");
	let inputSet = targetTr.parent().parent().find(":input[name]");
	
	if("none"!=childSpan.css("display")  && e.keyCode == 13 ){
		$(inputSet).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val();
			let hidden = updateFm.find("[name='"+name+"']");
			hidden.val(value);
		});
		data = updateFm.serialize();
		$.ajax({
			url : "${cPath}/office/asset/buy/buyUpdate.do"
			, data : data
			, method : "post"
			, success : function(resp){
				if(resp.message.text == "성공적으로 처리되었습니다."){
					searchForm.submit();
				}else{
					getNoty(resp);
				}
			}
			, errors : function(xhr){
				console.log(xhr);
			}
		});	
	}
});



//-----------------------------------------------------------------------------//

let prodIdTag = $("#prodId");
$.ajax({
	url : "${cPath }/prod/getProdId.do ",
	method : "get",
	dataType : "json",
	success : function(resp) {
		let opts = [];
		// 옵션을 동적으로 구성
		$(resp.prodId).each(function(idx, opt){
			opts.push(
				// type을 그대로 유지하기 위해서 prop 를 사용
				$("<option>").text(opt.prodName)
							 .attr("value", opt.prodId)
// 							 .prop("selected", "${pagingVO.searchDetail.prodCode}"==opt.prodId)
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		prodIdTag.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});

//----------------------------------------------------------------------//

let insertFm;

$("#submitBtn").on("click",function(){
	insertFm = $("#insertForm");
	data = insertFm.serialize();
	$.ajax({
		url : "${cPath }/office/asset/buy/buyInsert.do"
		, data : data
		, method : "post"
		, success : function(resp){
			if(resp.check == "OK"){
				searchForm.submit();
			}else{
				getNoty(resp);
			}
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
		name = parseInt(element.name.substring(11,12));
		name = String(name + 1);
		str = element.name.replaceAt(11, name);
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

let initBtn = $("#initBtn");
initBtn.on("click", function(){
	event.preventDefault();
	$("#inputUI").find(":input").val("");
	$("[name=startDay]").val("");
	$("[name=endDay]").val("");
	return false;
});

let pagingArea = $("#pagingArea");
pagingArea.on("click", "a" ,function(event){
	event.preventDefault();
	let page = $(this).data("page");
// 	console.log($('input[name=searchType]').val())
	searchForm.find("[name='page']").val(page);
	searchForm.submit();
	searchForm.find("[name='page']").val("");
	return false;
});

let searchForm = $("#searchForm");

$("#searchBtn").on("click", function(event){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
	searchForm.submit();
});

// let optTag = $("[name='prodCode']");
let optTag = $("#prodCode");
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
							 .prop("selected", "${pagingVO.searchDetail.prodCode}"==opt.codeId)
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		optTag.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});

</script>