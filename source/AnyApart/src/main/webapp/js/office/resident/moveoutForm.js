/**
 * @author 작성자명
 * @since 2021. 2. 16.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2021. 2. 16.  이경륜       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */ 
// validator 옵션
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

// ============================= 미납내역 즉시수납처리 시작
// moveoutPayAuthForm을 위한 ajaxForm 옵션
function commonSuccess(resp){
	if(resp.result == "OK"){
		moveoutPayAuthForm.get(0).reset();
		moveoutPayAuthModal.modal("hide");
		searchForm.submit();
	}else if(resp.message){
		getNoty(resp);
	}
}
let options={
	dataType: "json"
	,success: commonSuccess
};

let moveoutPayAuthModal = $("#moveoutPayAuthModal").on("hidden.bs.modal", function(){
		$(this).find("form").get(0).reset();
	});

let moveoutPayAuthForm = $("#moveoutPayAuthForm");
let validatorForAuthForm = moveoutPayAuthForm.validate(validateOptions);
moveoutPayAuthForm.ajaxForm(options);


function payCost(event) {
	let cost = $(this).parents("tr:first").data("cost");
	console.log(cost);
	for(let prop in cost){
		$(moveoutPayAuthForm).find("[name='"+prop+"']").val(cost[prop]);
	}
	moveoutPayAuthModal.modal("show");
}

//============================= 미납내역 즉시수납처리 끝


//============================= 세대조회하여 비동기로 전출세대 정보 받아오기
// 동적으로 만들어진 코드에 이벤트 바인딩
let costTable = $("#costTable").on("click", ".payCostBtn", payCost);

let pagingArea = $("#pagingArea");
let pagingA = pagingArea.on('click', "a" ,function(){
	let page = $(this).data("page");
	searchForm.find("[name='currentPage']").val(page);
	searchForm.submit();
	searchForm.find("[name='currentPage']").val(1); 
	return false;
});	


let costBody = $("#costBody");
let carBody = $("#carBody");

let searchForm = $("#searchForm");
let validator = searchForm.validate(validateOptions);
searchForm.ajaxForm({
	beforeSerialize : function (form, options) {
		if(form.find(":input[name='searchVO.searchAptCode']")) form.find(":input[name='searchVO.searchAptCode']").val(loginAptCode); // insert때만 aptCode 입력
		
		let dong = form.find(":input[name='dong']").val();
  		let ho = form.find(":input[name='ho']").val();
  		if(ho.length==3) ho='0'+ho;
  		let houseCode = loginAptCode+'D'+dong+'H'+ho;
  		form.find(":input[name='houseCode']").val(houseCode);
	  	return form.valid(); // 밸리데이션 작동이후에 input값이 바뀌기때문에 한번더 체크
//		  	return true; // 위에 houseCode만드는 코드가 반드시 실행된다면 true로 둬도됨
  	},
	dataType : "json",
	success : function(resp) {
		if(resp.message){ // 실패시
			getNoty(resp);
			return;
		}
		
		let inputs = searchForm.find(":text");
		$(inputs).each(function(index, input){
			$(this).prop("readonly",true);
		});
		
		flag.value = 'Y';
		clearAreas();
		
		/*
		 * 입주민정보
		 */
		let resident = resp.resident;
		for(let prop in resident) {
			let id = document.getElementById(prop);
			if(id === null) continue;
			id.innerHTML = formatTel(resident[prop]);
		}
		
		/*
		 * 차량내역
		 */
		let carList = resp.carList;
		
		let carTrTags = [];
		if(carList.length>0) {
			$(carList).each(function(idx, car){
				let tr = $("<tr>");
				
				tr.append(
						$("<td>").text(idx+1)
						,$("<td>").text(car.carNo)
						,$("<td>").text(car.carType)
				).data("car", car)
				 .addClass("text-center");
				
				carTrTags.push(tr);
			});
		}else {
			carTrTags.push(
					$("<tr>").html(
						$("<td colspan='3'>").text("등록된 차량이 없습니다.")									
					).addClass("text-center")
				);
		}
		carBody.html(carTrTags);
		
		/*
		 * 미납내역
		 */
		let costList = resp.pagingVO.dataList;
		let trTags = [];
		if(costList.length>0){
			$(costList).each(function(idx, cost){
				let tr = $("<tr>");
				
				let btn = $("<input>").attr({
											type:"button",
											value:"즉시수납"
										}).addClass("btn btn-warning payCostBtn")
										  .data("toggle","modal")
										  .data("target","#moveoutPayAuthModal");
				
				tr.append(
						$("<td>").text(idx+1)
						,$("<td>").text(cost.costYear)
						,$("<td>").text(cost.costMonth)
						,$("<td>").text(numberWithCommas(cost.costCommTotal))
						,$("<td>").text(numberWithCommas(cost.costIndvTotal))
						,$("<td>").text(numberWithCommas(cost.lateFee))
						,$("<td>").text(numberWithCommas(cost.costTotal+cost.lateFee))
						,$("<td>").append(btn)
				).data("cost", cost)
				 .addClass("text-center");
			
				trTags.push(tr);
			});
		}else{
			trTags.push(
					$("<tr>").html(
							$("<td colspan='8'>").text("관리비 미납내역이 없습니다.")									
						).addClass("text-center")
					);
		}
		costBody.html(trTags);
		if(costList.length>0)
			pagingArea.html(resp.pagingVO.pagingHTML);
	},
	error : function(errResp) {
		console.log(errResp);
// 		let contentArea = $("#contentArea").empty();
// 		contentArea.html(errResp.responseText);
	}
});



let moveoutForm = $("#moveoutForm");
let validatorForm = moveoutForm.validate({
		submitHandler: function(form) {
			if(flag.value != 'Y') {
				getErrorNotyDefault("전출할 세대를 조회해 주세요.");
				return;
			}
			if(!confirm("해당 세대를 전출처리 하시겠습니까?")) return;
			// 미납내역 존재유무 체크
			let valid = $(costBody).children("tr:first").data("cost") == undefined ? true : false;
			if(valid) {
				// 전출처리위해 memId, houseCode 보내기
				$(moveoutForm).find("[name='memId']").val($("#memId").text());
				
				let dong = $(searchForm).find(":input[name='dong']").val();
		  		let ho = $(searchForm).find(":input[name='ho']").val();
		  		if(ho.length==3) ho='0'+ho;
		  		let houseCode = loginAptCode+'D'+dong+'H'+ho;
				$(moveoutForm).find("[name='houseCode']").val(houseCode);
				
			    form.submit();
			}else {
				getErrorNotyDefault("관리비 미납 내역 존재시 전출 처리가 불가합니다.");
				return;
			}
		  }
		,onsubmit:true
		,onfocusout:function(element, event){
			return this.element(element);
		}
		,errorPlacement: function(error, element) {
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

)

/*
 * 테이블 영역 초기화에 필요한 3가지 함수
 */
function clearAreas() {
	carBody.empty();
	costBody.empty();
	pagingArea.empty();
}
function getCarBodyDefault(carTrTags) {
	carTrTags.push(
			$("<tr>").html(
				$("<td colspan='3'>").text("전출하고자하는 세대를 조회해 주세요.")									
			).addClass("text-center")
		);
}
function getCostBodyDefault(costTrTags) {
	costTrTags.push(
	$("<tr>").html(
			$("<td colspan='8'>").text("전출하고자하는 세대를 조회해 주세요.")									
		).addClass("text-center")
	);
}


/*
 * 검색조건 초기화 및 테이블 초기화
 */
$("#resetBtn").on("click", function() {
	
	searchForm.get(0).reset();
	moveoutForm.get(0).reset();
	
	$(dong).prop("readonly",false);
	$(ho).prop("readonly",false);
	
	$("#memId").text("");
	$("#resName").text("");
	$("#resHp").text("");
	$("#resTel").text("");
	
	clearAreas();
	
	let costTrTags = [];
	getCostBodyDefault(costTrTags);
	costBody.html(costTrTags);
	
	let carTrTags = [];
	getCarBodyDefault(carTrTags);
	carBody.html(carTrTags);
});


// 목록버튼 눌러 검색조건 들고 뒤로 가기
let moveoutListForm = $("#moveoutListForm");
$("#listBtn").on("click", function(event) {
	event.preventDefault();
	// 검색조건에 있던 값 옮겨담기
	let inputs = moveoutForm.find(":input[name]");
	$(inputs).each(function(index, input){
		let originalInput = $(this).clone();
		originalInput.appendTo(moveoutListForm);
	});
	moveoutListForm.submit();
	return false;
})


