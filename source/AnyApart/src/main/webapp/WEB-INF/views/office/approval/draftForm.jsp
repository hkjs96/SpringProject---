<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 13  이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal" />
	<c:set var="authMember" value="${principal.realMember }" />
</security:authorize>

<style>
.modalDiv {
	height: 25em;
}

.first {
	float: left;
	width: 45%;
	box-sizing: border-box;
}

.second {
	float: left;
	width: 13%;
	box-sizing: border-box;
	border: none;
	font-size: 15pt;
	margin-left: 10px;
}

.third {
	float: right;
	width: 40%;
	box-sizing: border-box;
}

.modalBtn {
	width: 100px;
	height: 30px;
	margin: 5px;
	line-height: 0px;
	font-size: 13px;
}

.mainTb th:nth-child(2n+1), .mainTb td:nth-child(2n+1) {
	background-color: #e9ecef;
	text-align: center;
	font-weight: bold;
}

.modalTb {
	text-align: center;
}

.modal-content {
	font-size: 15pt;
}

#draftDiv {
	height: 80em;
	width: 60em;
}

.badge {
	width: 60px;
	height: 20px;
}

.secondTb {
	margin-top: 60px;
	border: 1px solid #a2baba;
}

.modalSpan {
	color: blue;
}
</style>
<br>

<div class="card container" id="draftDiv"
	style="border: 5px solid lightgray; padding: 10px;">
	<div>
		<div class="form-row float-right">
			<button type="button" class="btn btn-sm alert alert-secondary"
				style='margin: 5pt;' data-toggle="modal" data-target="#lineModal">
				결재선 지정</button>
			<c:if test="${empty updateFlag }">
				<button class="btn btn-sm alert alert-secondary"
					style='margin: 5pt;' id="insertBtn">상신</button>
			</c:if>
			<c:if test="${not empty updateFlag }">
				<button class="btn btn-sm alert alert-secondary"
					style='margin: 5pt;' id="updateBtn">수정</button>
			</c:if>
			<button class="btn btn-sm alert alert-secondary"
				style='margin: 5pt; margin-right: 10pt;' id="resetBtn">상신취소</button>
		</div>
	</div>

	<div class="card-img-top">
		<div class="container">
			<div style='height: 4em;'>
				<h3 style="text-align: center;">
					<strong>업 무 기 안</strong>
				</h3>
			</div>
		</div>
	</div>

	<c:url value="/office/approval/draftUpdate.do" var="updateURL" />
	<c:url value="/office/approval/draftInsert.do" var="insertURL" />
	<div class="card-body">
		<form class="form-inline" method="post" id="draftForm"
			name="draftForm" enctype="multipart/form-data"
			data-insert="${insertURL }" data-update="${updateURL }">
			<table class="table mainTb table-sm">
				<tbody id="draftBody">
					<tr>
						<td class="align-middle" width="15%">문서번호</td>
						<td class="align-middle" width="35%">
							${draftBasicInfo.draftId} <input type="hidden"
							class="form-control" id="draftId" name="draftId"
							value="${draftBasicInfo.draftId}">
						</td>
						<td class="align-middle" width="15%">단위업무</td>
						<td width="35%"><select id="taskCode" name="taskCode"
							class="form-control" required>
								<option value="">전체</option>
								<c:forEach items="${taskCodeList}" var="taskCode" varStatus="vs">
									<c:if test="${not empty taskCode.codeId }">
										<option value="${taskCode.codeId}" ${taskCode.codeName eq '예산/회계' ? 'selected' : ''}>${taskCode.codeName }</option>
									</c:if>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td class="align-middle">작성자</td>
						<td colspan="3">${draftBasicInfo.memId} <input type="hidden"
							class="form-control" id="memId" name="memId"
							value="${authMember.memId}">
						</td>
					</tr>
					<tr>
						<td class="align-middle">결재선</td>
						<td class="align-middle" colspan='3'><input type="text"
							id="firstEmpName" name="lineEmpName" value=""
							class="form-control col-sm-2" readonly required> <input
							type="hidden" name="lineMemId" value=""> <input
							type="hidden" name="appOrder" value=""> <select
							name="appCode" class="form-control col-sm-2 codeSelect" disabled>
								<option value="">선택</option>
								<c:forEach items="${appCodeList }" var="appCode" varStatus="vs">
									<c:if test="${not empty appCode.codeId}">
										<option value="${appCode.codeId }" >${appCode.codeName }</option>
									</c:if>
								</c:forEach>
						</select> <input type="text" name="lineEmpName" value=""
							class="form-control col-sm-2" readonly> <input
							type="hidden" name="lineMemId" value=""> <input
							type="hidden" name="appOrder" value=""> <select
							name="appCode" class="form-control col-sm-2 codeSelect" disabled>
								<option value="">선택</option>
								<c:forEach items="${appCodeList }" var="appCode" varStatus="vs">
									<c:if test="${not empty appCode.codeId}">
										<option value="${appCode.codeId }">${appCode.codeName }</option>
									</c:if>
								</c:forEach>
						</select> <input type="text" name="lineEmpName" value=""
							class="form-control col-sm-2" readonly> <input
							type="hidden" name="lineMemId" value=""> <input
							type="hidden" name="appOrder" value=""> <select
							name="appCode" class="form-control col-sm-2 codeSelect" disabled>
								<option value="">선택</option>
								<c:forEach items="${appCodeList }" var="appCode" varStatus="vs">
									<c:if test="${not empty appCode.codeId}">
										<option value="${appCode.codeId }">${appCode.codeName }</option>
									</c:if>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td class="align-middle">제목</td>
						<td colspan='3'><input type="text" id="draftTitle"
							name="draftTitle" class="form-control col-sm-12" placeholder="제목 입력"
							value="${draftBasicInfo.draftTitle}" required></td>
					</tr>
					<tr>
						<td class="align-middle">지출계좌</td>
						<td><select id="draftAcct" name="draftAcct"
							class="form-control">
								<option value="">전체</option>
								<c:forEach items="${acctList}" var="acct" varStatus="vs">
									<c:if test="${not empty acct.acctId }">
										<option value="${acct.acctId}"
											${acct.acctId eq 'A0024A002' ? 'selected' : '' }>${acct.acctComent }</option>
									</c:if>
								</c:forEach>
								<option value="">없음</option>
						</select></td>
						<td colspan='2' style='background-color: #ffffff;'></td>
					</tr>
					<tr>
						<td id="draftContentTd" colspan='4'
							style='background-color: #ffffff;'><textarea
								id="draftContent" name="draftContent" class="form-control"
								required>
						${draftBasicInfo.draftContent}
				  		${htmlVal}
				  	</textarea></td>
					</tr>
				</tbody>
			</table>
			<label for="draftFiles">첨부파일</label>
			<div class="custom-file" id="fileArea">
				<span> <c:if test="${not empty draftBasicInfo.draftAttList }">
						<p class="reddot">* 파일 아이콘을 클릭하면 기존 파일을 삭제할 수 있습니다.</p>
						<c:forEach items="${draftBasicInfo.draftAttList }" var="attach"
							varStatus="vs">
							<span title="다운로드" class="attatchSpan"> <img
								src="${cPath }/js/main/img/common/file.png" class="delAtt"
								data-att-no="${attach.attSn }" /> ${attach.attFilename }
								&nbsp;&nbsp;&nbsp;
							</span>
						</c:forEach>
					</c:if>
				</span>
				<div class="input-group">
					<input type="file" class="form-control col-sm-11" name="draftFiles"
						value="파일" /> <span id="plusBtn" class="btn btn-dark plusBtn">파일
						추가</span>
				</div>
			</div>
		</form>
	</div>
</div>

<!-- 결재선 지정 모달 -->
<!-- The Modal -->
<div class="modal" id="lineModal">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<p class="modal-title" style="font-size: 15pt;">- 결재선 지정</p>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body ">
				<div class="form-control modalDiv first" style="overflow: auto">
					<p class="modalSpan mb-2">* 직원을 클릭 후 결재방법을 선택해 주세요.</p>
					<table class="table modalTb">
						<thead class="thead-light">
							<tr>
								<th>직원번호</th>
								<th>직급</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody id="empListBody">
							<c:forEach items="${appEmpList }" var="appEmp" varStatus="vs">
								<c:if test="${not empty appEmp.memId}">
									<tr data-mem-id="${appEmp.memId }">
										<td class="memIdTd">${appEmp.memId }</td>
										<td class="positionNameTd">${appEmp.position.positionName}</td>
										<td class="empNameTd">${appEmp.empName }</td>
									</tr>
								</c:if>
								<c:if test="${empty appEmp.memId }">
									<tr>
										<td colspan="3">결재선 목록이 없습니다.</td>
									<tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="list-group second modalDiv text-center">
					<table class="table secondTb">
						<thead class="table-info">
							<tr>
								<th>결재방법</th>
							</tr>
						</thead>
						<tbody id="appCodeListBody">
							<c:forEach items="${appCodeList }" var="appCode" varStatus="vs">
								<c:if test="${not empty appCode.codeId}">
									<tr data-code-id="${appCode.codeId }">
										<td class="codeNameTd">${appCode.codeName }</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="form-control modalDiv third" style="float: right;">
					<p class="modalSpan mb-2">* 해당 직원을 클릭하면 결재선에서 삭제할 수 있습니다.</p>
					<table class="table modalTb ">
						<thead class="thead-light">
							<tr>
								<th>순서</th>
								<th>구분</th>
								<th>직원번호</th>
								<th>직급</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody id="lineListBody">

						</tbody>
					</table>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<input type="button" class="btn btn-dark" id="lineBtn" value="결재자지정">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>








<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>
<script>

//==CKEDITOR 설정===============================================================================
//이미지 등록
var editor = CKEDITOR.replace("draftContent", {
	 filebrowserImageUploadUrl: '${cPath }/notice/imageUpload.do?command=QuickUpload&type=Images'
});

//문서 기본 css
CKEDITOR.config.contentsCss = '${cPath}/css/css/draft.css';
//editor 크기
CKEDITOR.config.height = '40em';

editor.on( 'required', function( evt ) {
    editor.showNotification( '내용이 누락되었습니다. 입력해 주세요.', 'warning' );
    evt.cancel();
} );


//==기안문 작성 중 타 메뉴 이동 시 이동 확인================================================================
	$( "h1" ).not( ".bar" );
//not (".collapsed") : 최하위 메뉴를 선택했을 때만 확인창 	
$("#layoutSidenav a").not(".collapsed").on("click", function(e) {
	//제목이나 내용이 있으면 확인
	if(!isEmpty(CKEDITOR.instances.draftContent.getData())||!isEmpty($("#draftTitle").val())){
		let confirmChk = confirm("작성 중인 문서가 있습니다. 다른 메뉴로 이동하시겠습니까?");
		if(!confirmChk){
			//기존 a링크 이벤트 막기
	        e.preventDefault();
			return;
		}
	};
});

let lineArr = null;

$("#resetBtn").on("click", function() {
	let chk = confirm("상신 취소하시겠습니까?");
	
	if(chk){
		location.href="${cPath}/office/approval/draftForm.do";
	}else{
		return;
	}
	
});

$("#fileArea").on("click", ".plusBtn", function() {
	let clickDiv = $(this).parents("div.input-group");
	let newDiv = clickDiv.clone();
	newDiv.find("#plusBtn").remove();
	let fileTag = newDiv.find("input[type='file'], .custom-file-label");
	fileTag.val("");
	clickDiv.after(newDiv);
});

//각 form들 정의
let draftForm = $("#draftForm");

$(".delAtt").on("click", function() {
	let attNo = $(this).data("attNo");
	draftForm.append($("<input>", {
		type : "hidden",
		name : "delAttNos",
		value : attNo
	}));

	$(this).parent("span:first").hide();
});



//validation Check(tooltip)
const validateOptions = {
    onsubmit:true
    ,onfocusout:function(element, event){
       return this.element(element);
    }
    ,errorPlacement: function(error, element) {
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

draftForm.validate(validateOptions);


let selectedEmp = new Array();
let selectedArr = new Array();
let selIdx = null;

let empListBody = $("#empListBody");

empListBody.on("click", "tr", function() {

selIdx = $(this).index();  	
	
selectedEmp = new Array();

$("#empListBody tr").css( "background-color", "white" );

$(this).css( "background-color", "#a2baba" );

selectedEmp.push($(this).find(".memIdTd").text());
selectedEmp.push($(this).find(".positionNameTd").text());
selectedEmp.push($(this).find(".empNameTd").text());

});	
	
let lineSeq = 1;

let appCodeListBody = $("#appCodeListBody");

let lineListBody = $("#lineListBody");
let trTags = [];
appCodeListBody.on("click", "tr", function() {
	
	if(lineSeq>3){
		getErrorNotyDefault("검토 및 결재자는 3명까지 지정할 수 있습니다");	
		return;
	}
	
	if(isEmpty(selectedEmp)){
		getErrorNotyDefault("직원 선택 후 결재방법을 선택해 주세요.");	
		return;
	}
	
	
	selectedApp = new Array();
	
	$("#appCodeListBody tr").css( "background-color", "white" );
	
	$(this).css( "background-color", "#d0e8f2" );
	selectedApp.push(this.dataset.codeId); 
	selectedApp.push($(this).find(".codeNameTd").text()); 
	
	
	let tr = $("<tr>");
	tr.append(
		$("<td>").text(lineSeq++),		
		$("<td>").text(selectedApp[1]),		
		$("<td>").text(selectedEmp[0]),		
		$("<td>").text(selectedEmp[1]),		
		$("<td>").text(selectedEmp[2])	
	);
	
	trTags.push(tr);
	
	let tmpNum
	   for (var x in trTags) {
	      let text = trTags[x].children().eq(1).text();
	      console.log(text);
	      if(text == '결재'|| text == '대결'){
	         let tmp = trTags[x];
	         trTags.splice(x, 1);
	         trTags.push(tmp);
	         
	         for(var y in trTags){
	             trTags[y].find("td:eq(0)").text(parseInt(y)+1);
	         }
	         
	         console.log(tmp);
	         console.log(trTags);
	         break;
	      }
	   }
	   

	
	lineListBody.html(trTags);
	
// 	selectedApp = new Array();
// 	selectedEmp = new Array();
	
	$("#appCodeListBody tr").css( "background-color", "white" );
	$("#empListBody tr").css( "background-color", "white" );
	
	empListBody.find("tr:eq('"+selIdx+"')").hide();
	selIdx = null;
	
	console.log(selectedApp);
	console.log(selectedEmp);
	
	selectedApp = new Array();
	selectedEmp = new Array();
	
});	


lineListBody.on("click", "tr", function() {
	
	let delIdx = $(this).index();
	let delNum = $(this).find("td:eq(0)").text();
	
	if(delNum!=null){
		lineSeq-=1;
	}
	
	trTags.splice(delIdx, 1);
 	$(this).detach();
 	let memId = $(this).find("td:eq(2)").text();
 	
 	$("#empListBody tr").each(function (index, item) {
 		if($(this).find("td:eq(0)").text()==memId){
 			$("#empListBody tr").eq(index).show();
 		}
 	});
 	
 	$("#lineListBody tr").each(function (index, item) {
 		let remainNum = $(this).find("td:eq(0)").text();
 		
 		if(delNum<remainNum){
	 		$(this).find("td:eq(0)").html($(this).find("td:eq(0)").text()-1);
 		}
 	});
});	


$("#lineBtn").on("click", function(){
 	let arr = new Array();
	let smarr = new Array();
 	$("#lineListBody tr").each(function (index, item) {
 		var td = $(this).children();
 	 	td.each(function(i){
 	 		smarr.push(td.eq(i).text());
 	    });
 		arr.push(smarr);
 		smarr = new Array();
 	});
 	
	if(arr[arr.length-1][1] == "검토"){
		getErrorNotyDefault("결재선 마지막 순서의 결재방법은 결재 또는 대결이어야 합니다.");	
		return;
	}
 	
 	$("#draftBody").find(":input[name=lineEmpName]").each(function (index, item) {
 		$(this).val("");
 	})
 	$("#draftBody").find(":input[name=lineMemId]").each(function (index, item) {
 		$(this).val("");
 	})
 	$("#draftBody").find(":input[name=appCode]").each(function (index, item) {
 		$(this).val("");
 	})
 	$("#draftBody").find(":input[name=appOrder]").each(function (index, item) {
 		$(this).val("");
 	})
 	
 	$("#draftBody").find(":input[name=lineEmpName]").each(function (index, item) {
 		if(arr[index]!=null){
 			$(this).val(arr[index][4]);
 		}
 	});
 	
 	$("#draftBody").find(":input[name=lineMemId]").each(function (index, item) {
		if(arr[index]!=null){
 			$(this).val(arr[index][2]);
		}
 	});
 	
 	$("#draftBody").find(":input[name=appCode]").each(function (index, item) {
 		if(arr[index]!=null){
 		var targetText = arr[index][1];   
	 		var targetVal = $('#draftBody option:contains(' + targetText + ')').val();    //text로 옵션을 찾고 해당 value를 구한다.
 			$(this).val(targetVal);
 		}
 	});
 	
 	$("#draftBody").find(":input[name=appOrder]").each(function (index, item) {
 		if(arr[index]!=null){
	 		$(this).val(parseInt(arr[index][0]));
 		}
 	});
 	
 	$("#lineModal").modal("hide");
 	
});



$("#insertBtn,#updateBtn").on("click", function(){
	let flag = null;
	let action = null;
	if($(this).prop("id")=="updateBtn"){ //수정
		flag = confirm("수정하시겠습니까?");
		
		
	}else{
		action = draftForm.data("insert"); //등록
		flag = confirm("등록하시겠습니까?");
	}
	 	if(flag){
	
		draftForm.attr("action", action);
		
		action = draftForm.data("update");
		
		if($("#firstEmpName").val()==""){
			getErrorNotyDefault("결재선을 지정해주십시오.");	
			return;
		}
		
		$("#draftBody").find(":input[name=lineEmpName]").each(function (index, item) {
	 		if($(this).val()==""){
	 			$(this).attr("disabled", true);
	 		}
		});
	 	$("#draftBody").find(":input[name=lineMemId]").each(function (index, item) {
	 		if($(this).val()==""){
	 			$(this).attr("disabled", true);
	 		}
	 	});
	 	$("#draftBody").find(":input[name=appCode]").each(function (index, item) {
	 		if($(this).val()==""){
	 			$(this).attr("disabled", true);
	 		}else{
	 			$(this).attr("disabled", false);
	 		}
	 	});
	 	$("#draftBody").find(":input[name=appOrder]").each(function (index, item) {
	 		if($(this).val()==""){
	 			$(this).attr("disabled", true);
	 		}
	 	});
		
		draftForm.submit();
		
		$("#draftBody").find(":input[name=lineEmpName]").each(function (index, item) {
 			$(this).attr("disabled", false);
		});
	 	$("#draftBody").find(":input[name=lineMemId]").each(function (index, item) {
 			$(this).attr("disabled", false);
	 	});
	 	$("#draftBody").find(":input[name=appCode]").each(function (index, item) {
 			$(this).attr("disabled", true);
	 	});
	 	$("#draftBody").find(":input[name=appOrder]").each(function (index, item) {
 			$(this).attr("disabled", false);
	 	});
	}
});


//모달 닫으면 값 초기화 
$('.modal').on('hidden.bs.modal', function (e) {
// 	  $(this).find('form')[0].reset();
});

</script>



