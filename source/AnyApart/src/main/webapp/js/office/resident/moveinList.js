/**
 * @author 이경륜
 * @since 2021. 2. 9.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2021. 2. 9.  이경륜       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */ 
	// 샘플양식 다운 => 코드 수정 필요
//	const sampleDown = document.getElementById("sampleDownBtn");
//	
//	sampleDown.on("click", function() {
//		location.href="/template/excel/moveinSample.xlsx";
//	});
	
	// 엑셀파일첨부
	
	// 엑셀양식다운로드
	let historyState = 0; // 처음 페이지 진입했을때 상태값
	console.log("처음 페이지 진입:"+historyState);
	
	const sampleDownBtn = $("#sampleDownBtn");
	
	sampleDownBtn.on("click",function() {
		location.href = $.getContextPath() +"/office/resident/movein/downloadTmpl.do"
	});

	// 엑셀 파일 업로드
	const moveinExcelUploadModal = $("#moveinExcelUploadModal");
	const excelFile = $("#excelFile");
	excelFile.on("change", function() {
		const uploadFile = this.files[0];
		const ext = uploadFile.name.substr(uploadFile.name.lastIndexOf(".")+1).toLowerCase();
		
		if(ext != "xls" && ext != "xlsx") {
			getErrorNotyDefault("올바른 파일형식이 아닙니다.");
			this.value=null;
		}
	});
	
	// 서버로 엑셀 업로드
 	const uploadExcelBtn = $("#uploadExcelBtn");
	
 	uploadExcelBtn.on("click", function() {
 		console.log(excelFile);
 		if (isEmpty(excelFile.val())) {
 			getErrorNotyDefault("엑셀 파일을 첨부해 주세요.");
 			return;
 		}
 		if(!confirm("등록하시겠습니까?")) return;
		
 		const formData = new FormData($("#moveinExcelForm")[0]);
		
 		let url = $.getContextPath() +"/office/resident/movein/uploadExcel.do";
 		fetch(url, {
 			method: "POST"
 			, body: formData
 		})
 		.then(function(response) {
 			return response.json();
 			}
 		)
 		.then(function(json) {
 			if(json.message) {
 				getNoty(json);
 			}else {
 				getSuccessNotyDefault("성공적으로 처리되었습니다.");
 				moveinExcelUploadModal.modal("hide");
 				syncPageWithCurrent();
 				searchForm.submit();
 			}
 		})
 		.catch((error) => {
 			  console.error('Error:', error);
		});
 	});



	//====================엑셀 다운로드==========================
	$("#downExcelJxls").on("click", function(){
		let queryString = searchForm.serialize();
		let requestURL = $.getContextPath() +"/office/resident/movein/downloadExcel.do?" + queryString; 
		$(this).attr("href", requestURL);
		return true;
	});

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
			console.log($(this));
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
	let residentTable = $("#residentTable").on("click", ".updateBtn", updateResident)
										   .on("click", ".insertBtn", insertResident)
										   .find(listBody);
	
	

	
	let searchForm = $("#searchForm").ajaxForm({
		/*
		 * ajaxForm이 submit전 이미 serialize된 form의 input을 복사한 후 inputs를 대상으로 서버로 넘기고있음
		 * 값을 지정하고싶으면 form이 아닌 inputs 대상으로 지정해줘야함
		 */
		beforeSubmit: function(inputs, form, options) {
			console.log(inputs);
			inputs[0].value = loginAptCode; // preScript의 상수
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
					
					let button = null;
					if(resident.memId != null) { // 입주민이면
						button = $("<input>").attr({
													type:"button",
													value:"수정"
												}).addClass("btn btn-warning updateBtn")
												  .data("toggle","modal")
												  .data("target","#moveinUpdateModal");
					}else {
						button = $("<input>").attr({
												type:"button",
												value:"등록"
											}).addClass("btn btn-primary insertBtn")
											  .data("toggle","modal")
											  .data("target","#moveinInsertModal");
					}
					
					tr.append(
							$("<td>").text(resident.dong),
							$("<td>").text(resident.ho),
							$("<td>").text(resident.houseArea+"㎡"),
							$("<td>").text(resident.memId),
							$("<td>").text(resident.resName),
							$("<td>").text(formatTel(resident.resHp)),
							$("<td>").text(formatTel(resident.resTel)),
							$("<td>").text(resident.resMail).addClass("text-left"),
							$("<td>").text(resident.resBirth),
							$("<td>").text(resident.resJob),
							$("<td>").text(resident.moveYn),
							$("<td>").text(resident.resMovein),
							$("<td>").append(
									button
							)
					).data("resident", resident)
					 .addClass("text-center");
				
					trTags.push(tr);
				});
			}else{
				trTags.push(
					$("<tr>").html(
						$("<td colspan='13'>").text("조회 결과가 없습니다.").addClass("text-center")								
					)
				);
			}
	  		residentTable.html(trTags);
			if(residentList.length>0)
				pagingArea.html(resp.pagingVO.pagingHTML);
			
			/*
			 * 페이징 클릭후 뒤로가기 이벤트 때문에 넣음
			 */
			if(historyState!=0){
				let pageState = {flag: 'page'};
				history.pushState(pageState, null);
				console.log("=== 아래는 페이징 펑션에서 찍은 콘솔 ===");
				console.log(history);
				console.log(historyState);
			}
			--historyState;
//			let ajaxUrl = $(this)[0].url;
//			history.pushState(null, null, ajaxUrl); // url이 ajaxUrl로 바뀌게됨..ㅠ
		},
		error : function(errResp) {
			console.log(errResp);
		}
	}).submit();

	//====================입주민 C,U==========================
	let moveinUpdateModal = $("#moveinUpdateModal").on("hidden.bs.modal", function(){
		$(this).find("form").get(0).reset();
	});
	let moveinInsertModal = $("#moveinInsertModal").on("hidden.bs.modal", function(){
		$(this).find("form").get(0).reset();
	});
	
	function commonSuccess(resp){
		if(resp.result == "OK"){
			moveinInsertForm.get(0).reset();
			moveinUpdateForm.get(0).reset();
			moveinInsertModal.modal("hide");
			moveinUpdateModal.modal("hide");
			syncPageWithCurrent();
			searchForm.submit();
		}else if(resp.message){
			getNoty(resp);
		}
	}
		
	let options ={
		dataType : "json",
		beforeSerialize : function (form, options) {
			if(!confirm("등록하시겠습니까?")) return;
// 	  		console.log(arguments); // arguments: 모든 파라미터에 대한 정보를 가지고있는 의사변수
			if(form.find(":input[name='aptCode']")) form.find(":input[name='aptCode']").val(loginAptCode); // insert때만 aptCode 입력
			
			let dong = form.find(":input[name='dong']").val();
	  		let ho = form.find(":input[name='ho']").val();
	  		if(ho.length==3) ho='0'+ho;
	  		let houseCode = loginAptCode+'D'+dong+'H'+ho;
	  		form.find(":input[name='houseCode']").val(houseCode);
		  	return form.valid(); // 밸리데이션 작동이후에 input값이 바뀌기때문에 한번더 체크
// 		  	return true; // 위에 houseCode만드는 코드가 반드시 실행된다면 true로 둬도됨
	  	},
	  	beforeSubmit : function(inputs, form, options) {
	  		console.log(inputs);
	  	},
		success :commonSuccess
	}
		

	
	const validateOptions = {
			onsubmit:true,
			onfocusout:function(element, event){
				return this.element(element);
			},
			errorPlacement: function(error, element) {
				element.tooltip({
					title: error.text()
					, placement: "right"
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
	
	// ajaxForm, validator 둘다 submit handler를 가지고 있어서 둘중 어느 핸들러가 실행될지 순서결정해주기위해서 이렇게 코드
	let moveinInsertForm = $("#moveinInsertForm");
	let validator = moveinInsertForm.validate(validateOptions); // 이런 옵션에 따라 validation을 걸어놓겠다 라는 의미 검증하겠다는 의미아님
	moveinInsertForm.ajaxForm(options);

	let moveinUpdateForm = $("#moveinUpdateForm");
	let validator2 = moveinUpdateForm.validate(validateOptions); // 이런 옵션에 따라 validation을 걸어놓겠다 라는 의미 검증하겠다는 의미아님
	moveinUpdateForm.ajaxForm(options);
	
	// 입주민 정보 수정
	function updateResident(event) {
		let resident = $(this).parents("tr:first").data("resident");
		for(let prop in resident){
			$(moveinUpdateForm).find("[name='"+prop+"']").val(resident[prop]);
		}
		moveinUpdateModal.modal("show");
	}
	
	// 입주민 정보 등록(테이블에서 등록버튼 눌렀을 때)
	function insertResident(event) {
		let resident = $(this).parents("tr:first").data("resident");
		for(let prop in resident){
			if(prop=='dong' || prop=='ho') { // 입주정보테스트
				$(moveinInsertForm).find("[name='"+prop+"']").val(resident[prop]);
			}
		}
		moveinInsertModal.modal("show");
	}

	$(window).on('popstate', function(event){
		// 방법1
		var hstate = history.state;
		console.log("뒤로가기이벤트발생 , historyState :" + historyState);
		if(hstate!=null && hstate.flag=='page' && historyState != -1) {
//		if(hstate!=null && hstate.flag=='page') {
			console.log("=== 아래는 뒤로가기 펑션에서 찍은 콘솔 ===");
			++historyState;
			console.log(historyState);
			syncPageWithCurrent(); // 생각을,, 잘못했네,,,, 이거넣을게아니라 뒤로가기전에 어느페이지에있었는지를 넣어야됐꾼...
			searchForm.submit();
		}else {
			history.back();
		}
//		// History Check
//		var hstate = history.state;
//		console.log(hstate);
//		console.log(hstate.formData);
//		if(hstate != null && hstate.formData) {
//			// History 가 있을 경우 해당 FromData 로  HTML Paint
//			searchForm.submit();
//		}else{
//			// History 가 없는 경우 Browser Back 기능
//			history.back(); // or history.go(-1);
//		}
//		
		// 방법2
//		var data = event.originalEvent.state;
//		console.log(data);
//		if(data) {
//			searchForm.submit();
//		}else {
//			history.back();
//		}
	});
