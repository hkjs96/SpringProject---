/**
 * @author 이경륜
 * @since 2021. 2. 10.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2021. 2. 10. 이경륜       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */ 
// 등록 성공후 검색조건 들고왔을때, inputUI에 담긴 값을 form으로 옮겨주기위해 트리거로 searchBtn 작동하도록
$(document).ready(function() {
	$("#searchBtn").trigger("click");
})

//==================== validator 옵션
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

//====================엑셀 다운로드==========================
$("#downExcelJxls").on("click", function(){
	let queryString = searchForm.serialize();
	let requestURL = $.getContextPath() +"/office/resident/moveout/downloadExcel.do?" + queryString; 
	$(this).attr("href", requestURL);
	return true;
});



// ==================상세보기 모달===================
let moveoutViewModalBody = $("#moveoutViewModalBody");
let moveoutViewModal = $("#moveoutViewModal").on("hidden.bs.modal", function() {
	$(this).find(moveoutViewModalBody).empty();
});

let viewMoveout = function viewMoveout(event) {
	let resident = $(this).parents("tr:first").data("resident");
	console.log(resident);
	let modalURL = $.getContextPath() + "/office/resident/moveoutView.do?memId="+resident['memId'];
	moveoutViewModal.find(moveoutViewModalBody).load(modalURL, function(){
		moveoutViewModal.modal("show");
		
		// 상세보기 화면 수납내역 페이징
		let feePagingArea = $(".feePagingArea");
		let feePagingA = feePagingArea.on('click', "a" ,function(){
			let page = $(this).data("page");
			feeSearchForm.find("[name='currentPage']").val(page);
			feeSearchForm.submit();
			feeSearchForm.find("[name='currentPage']").val(1);
			return false;
		});
		
		let feeListTable = $("#receiptTable");
		let feeSearchForm = $("#feeSearchForm").ajaxForm({
			dataType : "json",
			success : function(resp) {
				feeListTable.find("tbody").empty();
				feePagingArea.empty();
				let receiptList = resp.pagingVO.dataList;
				let trTags = [];
				if(receiptList.length>0){
					$(receiptList).each(function(idx, receipt){
						let tr = $("<tr>");
						
						tr.append(
								$("<td>").html(receipt.rnum)
								,$("<td>").text(receipt.costYear + " / " +receipt.costMonth)
										.addClass("text-left")
								,$("<td>").text(numberWithCommas(receipt.costCommTotal)+" 원")
										.addClass("text-right")
								,$("<td>").text(numberWithCommas(receipt.costIndvTotal)+" 원")
										.addClass("text-right")
								,$("<td>").text(numberWithCommas(receipt.receiptCost)+" 원")
										.addClass("text-right")
								,$("<td>").text(receipt.receiptDate)
						).data("receipt", receipt).addClass("text-center");
						trTags.push(tr);
					});
				}else{
					trTags.push(
						$("<tr>").html(
							$("<td colspan='7'>").text("수납 내역이 없습니다.")									
						)
					);
				}
				feeListTable.find("tbody").html(trTags);
				if(receiptList.length>0)
					feePagingArea.html(resp.pagingVO.pagingHTML);
			},
			error : function(errResp) {
				console.log(errResp);
			}
		}).submit(); // 페이지 로드 후 1페이지의 수납내역 요청
		
	});	
}

//====================입주민 R==========================
//====================리스트 페이징==========================
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

//====================입주민 리스트 검색==========================

/*
 * UI와 Form 싱크 맞추는 함수
 */
function syncFormWithUI(inputs) {
	$(inputs).each(function(index, input){
		let name = $(this).attr("name");
		let value = $(this).val();
		let hidden = searchForm.find("[name='"+name+"']");
		hidden.val(value);
	});
}

$("#searchBtn").on("click", function(){
	let inputs = $(this).parents("div#inputUI").find(":input[name]");
	syncFormWithUI(inputs);
	searchForm.submit();
});

// 검색조건 초기화
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

// n개씩 보기
let screenSize = $("#screenSize").on("change",function(){
	let sizeNum = $(this).val();
	let hidden = searchForm.find("[name='screenSize']");
	hidden.val(sizeNum);
	searchForm.submit();
});

//====================입주민 리스트 비동기 R==========================
let listBody = $("#listBody");
// 동적으로 만들어진 코드에 이벤트 바인딩
let residentTable = $("#residentTable").on("click", ".cancelBtn", cancelMoveout)
									   .on("click", ".viewBtn", viewMoveout);


let searchForm = $("#searchForm").ajaxForm({
	/*
	 * ajaxForm이 submit전 이미 serialize된 form의 input을 복사한 후 inputs를 대상으로 서버로 넘기고있음
	 * 값을 지정하고싶으면 form이 아닌 inputs 대상으로 지정해줘야함
	 */
	beforeSubmit: function(inputs, form, options) {
		inputs[0].value = loginAptCode; // preScript의 상수
		form.find("[name='searchVO.searchAptCode']").val(loginAptCode); // 등록폼갈때도 들고가야해서 넣어줌
// 			console.log(inputs[0].value);
// 			console.log(form.find("[name='searchVO.searchAptCode']").val());
		return true;
	},
	dataType : "json",
	success : function(resp) {
		if(resp.message){ // 실패시
			getNoty(resp);
			return;
		}
		listBody.empty();
		pagingArea.empty();
		let residentList = resp.pagingVO.dataList;
		let trTags = [];
		if(residentList.length>0){
			$(residentList).each(function(idx, resident){
				let tr = $("<tr>");
				
				let moveoutBtn = null;
				if(resident.moveYn == 'Y') { // house테이블의 move_yn이 y면 (이미 전출후 입주된 세대)
					moveoutBtn = $("<input>").attr({
												type:"button",
												value:"취소 불가"
											}).addClass("btn btn-danger disableBtn")
											  .prop("disabled",true);
				}else {
					moveoutBtn = $("<input>").attr({
											type:"button",
											value:"전출 취소"
										}).addClass("btn btn-warning cancelBtn")
										  .data("toggle","modal")
										  .data("target","#moveoutCancelAuthModal");
				}
				
				tr.append(
						$("<td>").text(resident.dong)
						,$("<td>").text(resident.ho)
						,$("<td>").text(resident.houseArea+"㎡")
						,$("<td>").text(resident.memId)
						,$("<td>").text(resident.resName)
						,$("<td>").text(formatTel(resident.resHp))
						,$("<td>").text(formatTel(resident.resTel))
						,$("<td>").text(resident.resMovein)
						,$("<td>").text(resident.resMoveout)
						,$("<td>").append(
								$("<input>").attr({
									type:"button",
									value:"상세보기"
								}).addClass("btn btn-primary viewBtn")
								  .data("toggle","modal")
								  .data("target","#moveoutViewModal")
						)
						,$("<td>").append(
								moveoutBtn
						)
				).data("resident", resident)
				 .addClass("text-center");
			
				trTags.push(tr);
			});
		}else{
			trTags.push(
				$("<tr>").html(
					$("<td colspan='11'>").text("조회 결과가 없습니다.")									
				).addClass("text-center")
			);
		}
		listBody.html(trTags);
		if(residentList.length>0)
			pagingArea.html(resp.pagingVO.pagingHTML);
	},
	error : function(errResp) {
		console.log(errResp);
		let contentArea = $("#contentArea").empty();
		contentArea.html(errResp.responseText);
	}
}).submit();



//============================= 전출 취소 처리 시작
//moveoutCancelAuthForm을 위한 ajaxForm 옵션
function commonSuccess(resp){
	if(resp.result == "OK"){
		moveoutCancelAuthForm.get(0).reset();
		moveoutCancelAuthModal.modal("hide");
		searchForm.submit();
	}else if(resp.message){
		getNoty(resp);
	}
}
let options={
	beforeSubmit: function(form, options) {
		if(!confirm("해당 세대를 전출취소 하시겠습니까?")) return;
	}	
	,dataType: "json"
	,success: commonSuccess
};

let moveoutCancelAuthModal = $("#moveoutCancelAuthModal").on("hidden.bs.modal", function(){
	$(this).find("form").get(0).reset();
});

let moveoutCancelAuthForm = $("#moveoutCancelAuthForm");
let validatorForAuthForm = moveoutCancelAuthForm.validate(validateOptions);
moveoutCancelAuthForm.ajaxForm(options);


function cancelMoveout(event) {
	let resident = $(this).parents("tr:first").data("resident");
	console.log(resident);
	for(let prop in resident){
		$(moveoutCancelAuthModal).find("[name='"+prop+"']").val(resident[prop]);
	}
	moveoutCancelAuthModal.modal("show");
}



//============================= 검색조건 등록폼으로 들고가기
let goToInsertForm = $("#goToInsertForm");
$("#insertBtn").on("click", function(event) {
	event.preventDefault();
	// 검색조건에 있던 값 옮겨담기
	let inputs = searchForm.find(":input[name]");
	$(inputs).each(function(index, input){
		let originalInput = $(this).clone();
		originalInput.appendTo(goToInsertForm);
	});
	goToInsertForm.submit();
	return false;
})





