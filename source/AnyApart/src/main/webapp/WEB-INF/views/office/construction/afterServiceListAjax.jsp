<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%-- <link href="${cPath }/css/office/afterServiceList.css" rel="stylesheet"> --%>
<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>
<style>
.container{
	max-width: 1500px;
	margin: 0 auto;
}
/* 조회조건 */
#retrieveTopDiv {
	margin-top: 30px;
}
#listDiv {
	width: 95%;
	margin-left: 30px;
	margin-bottom: 30px;
}
#listDiv td:nth-child(3){
	text-align: left;
}
/* 상세조회 */
#viewDiv img {
	width: 600px;
	height: 500px;
}
#repairView th {
	text-align: center;
	background-color: #343A40;
	color: white;
}
#contentDiv {
	height: 200px;
}
#StatusBtnDiv {
	margin-right: 30%;
	margin: 10px;
}
#StatusBtnDiv button{
	margin-right: 10px;
}
#cancleBtn{
	margin-right: 10px;
}
#tbodyResult input{
	border : 1px solid #DEE2E6;
}
#message{
	width: 300px;
	margin-left: 700px; 
}
#insertSchdBtn{
	margin-top: 10px;
}
#explainP{
	font-weight: normal;
	font-size: 0.8em;
}
#uBtn{
	margin-left: 88%;
	margin-right: 10px;
}
#resultModal th{
	background-color: #E9ECEF;
	text-align: center;
}
#resultModal{
	margin-top: 50px;
}
.resultTh{
	width: 100px;
}
#resultBtn{
	margin-left: 91%;
}
</style>
<c:set var="paingVO" value="${paginationInfo.pagingVO }"/>	
<br>
<h4>
	<strong>수리 관리</strong>
</h4>
<br>
<div class="container">
	<div class="col-md-12 "
		style="border-style: outset; border-radius: 8px;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png"
					alt="searchIcon"
					style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색
					조건</strong>
			</div>
			<form id="searchForm">
				<input type="hidden" name="currentPage" value="1">
				<input type="hidden" name="searchVO.searchType">
				<input type="hidden" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }">
				<input type="hidden" name="asNo" >
			</form>
			<div class="col-md-10">
				<form class="form-inline">
					<div class="card-body " id="inputUI">
						분류선택
						<select class="custom-select col-md-2" name="searchVO.searchType">
							<option value>전체</option>
							<option value="title">제목</option>
						</select> 
						<input type="text" class="form-control col-md-2" name="searchVO.searchWord" value="${pagingVO.searchVO.searchWord }">
						<button class="btn btn-dark" id="searchBtn">검색</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<br>

<div id="retrieveTopDiv">
	<div class="container">
		<div class="row">
			<form id="searchDetailForm">
				<div class="col-md-12">
					시설 선택 
					<select name="asCode">
						<option value>선택</option>
						<option value="ASAPT" ${'ASAPT' eq param.asCode?"selected":"" }>아파트</option>
						<option value="ASRES" ${'ASRES' eq param.asCode?"selected":"" }>세대</option>
					</select> &nbsp;&nbsp; 
					접수상태 <select name="asStatus">
						<option value>선택</option>
						<option value="ASHOLD" ${'ASHOLD' eq param.asStatus?"selected":"" }>접수대기중</option>
						<option value="ASING" ${'ASING' eq param.asStatus?"selected":"" }>수선중</option>
						<option value="ASDONE" ${'ASDONE' eq param.asStatus?"selected":"" }>수선완료</option>
					</select> &nbsp;&nbsp;&nbsp;
					<input type="submit" id="retreiveBtn" class="btn btn-dark" role="alert" value="조회">
				</div>
			</form>
		</div>
	</div>
</div>
<br>
<p id="explainP">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ▪ 목록을 선택하면 처리상태를 변경할 수 있습니다.</p>
<%------------------------------ 목록 테이블 ------------------------------------%>
<div class="card text-center col-auto" id="listDiv">
	<div class="card-body row">
		<div class="col-sm-12">
			<table class="table table-hover">
				<colgroup>
					<col width="110px;">
					<col width="220px;">
					<col width="45%;">
					<col width="220px;">
					<col width="220px;">
					<col width="220px;">
					<col width="220px;">
				</colgroup>
				<thead  class="thead-light">
					<tr>
						<th scope="col">글번호</th>
						<th scope="col">수선분류</th>
						<th scope="col">제목</th>
						<th scope="col">회원ID</th>
						<th scope="col">신청일</th>
						<th scope="col">처리상태</th>
						<th scope="col">일정등록</th>
					</tr>
				</thead>
				<tbody id="tbodyList"></tbody>
			</table>
		</div>
	</div>
</div>
<div id="pagingDiv" class="pagination justify-content-center">
	<ui:pagination paginationInfo='${paginationInfo }' jsFunction='pageLinkMove' type='bsOffice'/>
</div>
<%------------------------------ 수리 상세조회 모달 ------------------------------------%>
<div class="modal" id="repairView" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<p class="modal-title" style="font-size: 15pt;">- 수리신청 상세</p>
				<button type="button" class="close" id="closeBtn" data-dismiss='modal'>&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body ">
				<div id="viewDiv">
					<div id="pDiv"></div>
					<table class="table table-bordered">
						<colgroup>
							<col width="15%">
							<col width="20%">
							<col width="15%">
							<col width="50%">
						</colgroup>
						<tbody id="tbodyViewResult">
						</tbody>
					</table>
					<p>신청내역</p>
					<table class="table table-bordered">
						<colgroup>
							<col width="15%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody id="tbodyModal"></tbody>
					</table>
				</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<div id="StatusBtnDiv"></div>
			</div>
		</div>
	</div>
</div>
<%------------------------------- 처리내역 등록, 수정 모달 -------------------------------------%>
<div class="modal" id="resultModal">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<p class="modal-title" style="font-size: 15pt;">- 수리내역 처리결과</p>
				<button type="button" class="close" id="closeRusultBtn" data-dismiss="modal">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body ">
				<form id="resultForm" >
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th>처리일</th>
							<td>
								<input type='date' name="asSchedule" required>
							</td>
						</tr>
						<tr>	
							<th>비고</th>
							<td colspan='3'>
								<textarea name='asComment' id='resultInputTag' class="form-control"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<div id="saveBtnDiv"></div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" >
//================================ 리스트 생성 =================================
	function makeList(){
		$.ajax({
			dataType:"json"
			,success : function(resp){
				let asList = resp;
				let trTags = []
				if(asList){
					$(asList).each(function(idx, asVO){
//--------------------------- 수선코드 생성 -----------------------------
						let schdBtn = "등록됨";
						if(asVO.schdNo==0){
							schdBtn = $("<button type='button' class='btn btn-primary' id='insertSchdBtn' data-asno='"+asVO.asNo+"'>일정등록</button>");	
						}
						trTags.push(
							$("<tr>").append(
								$("<td>").text(asVO.rnum),		
								$("<td>").text(asVO.asCodeName),		
								$("<td data-toggle='modal' data-target='#repairView' data-asno='"+asVO.asNo+"'>").text(asVO.asTitle).addClass("modalTd"),
								$("<td>").text(asVO.memId),		
								$("<td>").text(asVO.asDate),		
								$("<td>").text(asVO.asStatusName),	
								$("<td>").append(
									schdBtn
								)
							)		
						)
					})
				}else{
					trTags.push(
						$("<tr>").append(
							$("<td colspan='7'>").text("내역이 없습니다.")		
						)		
					)
				}
				$("#tbodyList").html(trTags);
			}
		});
	}
	
	$(document).ready(function(){
		makeList();
	});
	
//================================ 리스트 상세조회 모달창 생성 =================================
	$("#tbodyList").on("click", ".modalTd", function(event){
		event.preventDefault();
		console.log(this);
		let asNo = $(this).data("asno");
		let tbodyViewResult = $("#tbodyViewResult");
		$.ajax({
			url:$.getContextPath()+"/office/construction/afterServiceView.do"
			,data:{"asNo":asNo}
			,dataType:"json"
			,success:function(resp){
				let asVO = resp;
				let trTags = [];
				let resultTrTags = [];
//--------------------------- 수선접수 상태 ---------------------------						
				let asStatus = "";
				if('ASHOLD'==asVO.asStatus){
					asStatus = $("<td>").append(
									$("<button type='button' class='btn btn-primary' id='approvalBtn' data-asno='"+asNo+"'>접수하기</button>")
								);
				}else if('ASING'==asVO.asStatus){
					asStatus = $("<td>").append(
									$("<button type='button' class='btn btn-danger' id='cancleBtn' data-asno='"+asNo+"'>승인취소</button>")
								);
				}
//--------------------------- 신청내역 table ---------------------------					
				if(asVO){
					let tr1 = $("<tr>");
					let tr2 = $("<tr>");
					let tr3 = $("<tr>");
					let tr4 = $("<tr>");
					let tr5 = $("<tr>");
					tr1.append(
						$("<th>").text("제목"),		
						$("<td colspan='3'>").text(asVO.asTitle)		
					);
					tr2.append(
						$("<th>").text("수선분류"),		
						$("<td>").text(asVO.asCodeName),		
						$("<th>").text("처리상태"),	
						$("<td>").append(
							$("<span>").text(asVO.asStatusName).addClass("badge badge-secondary")
						)		
					);
					tr3.append(
						$("<th>").text("작성자"),		
						$("<td>").text(asVO.memId),		
						$("<th>").text("작성일"),		
						$("<td>").text(asVO.asDate)		
					);
					tr4.append(
						$("<th>").text("동"),		
						$("<td>").text(asVO.dong),		
						$("<th>").text("호"),		
						$("<td>").text(asVO.ho)		
					);
					tr5.append(
						$("<th>").text("내용"),		
						$("<td colspan='3' id='contentDiv'>").append(
							$("<textarea>").text(asVO.asContent)			
						)	
					);
					CKEDITOR.replace("asContent");
					trTags.push(tr1);
					trTags.push(tr2);
					trTags.push(tr3);
					trTags.push(tr4);
					trTags.push(tr5);
//--------------------------- 처리내역 table ---------------------------					
					let resultTr1 = $("<tr>");
					let resultTr2 = $("<tr>");
					let pDiv = $("#pDiv");
					let asSchedule = "처리내역이 없습니다.";
					if(asVO.asSchedule!=null){
						asSchedule = asVO.asSchedule;
					}
					resultTr1.append(
						$("<th>").text("처리일자"),		
						$("<td colspan='3'>").text(asSchedule)
					);
					resultTr2.append(
						$("<th>").text("비고").addClass("resultTh"),		
						$("<td colspan='3'>").text(asVO.asComment)	
					);
					pDiv.html($("<p>처리내역</p>").css("border", "none"));
					let resultBtn = [];
					if(asVO.asSchedule==null){
						resultBtn.push($("<input type='button' value='처리완료' class='btn btn-warning' id='resultBtn' data-toggle='modal' data-target='#resultModal' data-asno='"+asNo+"'>"));
					}else{
						resultBtn.push(
							$("<input type='button' value='수정' class='btn btn-warning' id='uBtn' data-toggle='modal' data-target='#resultModal' data-asno='"+asNo+"'>"),
							$("<input type='button' value='삭제' class='btn btn-danger' id='deleteResult' data-asno='"+asNo+"'>")
						);
					}
					let tr6 = $("<tr>").append(
						$("<td colspan='5'>").append(
								resultBtn		
						)		
					)		
					resultTrTags.push(resultTr1);
					resultTrTags.push(resultTr2);
					resultTrTags.push(tr6);
					tbodyViewResult.html(resultTrTags);
//--------------------------- 접수중인글 제외한 상태만 처리내역 테이블 보이게 ---------------------------					
					if('ASHOLD'==asVO.asStatus){
						tbodyViewResult.hide();
						pDiv.hide();
					}else{
						tbodyViewResult.show();
						pDiv.show();
					}
//--------------------------- 처리내역 등록, 수정버튼 생성---------------------------					
					let saveBtnDiv = $("#saveBtnDiv");
					let btns = [];
					btns.push($("<input type='button' value='저장' class='updateCommentBtn btn btn-primary' data-dismiss='modal' data-asno='"+asNo+"'>"));
					btns.push($("<input type='button' value='취소' class='btn btn-secondary' id='cancleCommentBtn' data-dismiss='modal' data-asno='"+asNo+"'>"));
					saveBtnDiv.html(btns);
					
				}
				$("#tbodyModal").html(trTags);
				$("#StatusBtnDiv").html(asStatus);   //상태버튼(접수, 취소, 처리완료버튼)
				$("#repairView").modal('show');
			}
		});
		return false;
	});
	
//================================ 일정등록 ======================================	
	$("#tbodyList").on("click", "#insertSchdBtn", function(){
		let asNo = $(this).data("asno");
		searchForm.find("[name='asNo']").val(asNo);
		searchForm.attr("action", "${cPath}/office/construction/registAsSchedule.do?");
		searchForm.submit();
	});
	
	let tbodyMessage = $("#tbodyMessage");  
	let repairView = $("#repairView")  //수리상세조회 모달
	let message = $("#message")   //처리완료후 메시지 모달
	
//================================ 처리버튼 클릭 이벤트 처리 ======================================
	$("#StatusBtnDiv").on("click", "button", function(){
		let buttonId = $(this).attr("id");
		let resultStatus = "";
		if(buttonId=='approvalBtn'){  //접수중 상태에서 승인버튼 - 없어짐
			resultStatus = "ASHOLD";
		}else if(buttonId=='cancleBtn'){  //수리중 상태에서 승인취소버튼
			resultStatus = "ASCANCEL";
		}else if(buttonId=='doneCancleBtn'){
			resultStatus = "ASDONE";	
		}else{                         //수리중 상태에서 수리완료버튼
			resultStatus = "ASING";
		}
		let asNo = $(this).data("asno");
		
		if(confirm("처리상태를 변경하시겠습니까?")){
			$.ajax({
				url : $.getContextPath()+"/office/construction/afterServiceChange.do"
				, data : {
					"asNo":asNo,
					"resultStatus" : resultStatus	
				}
				, dataType : "text"
				, success : function(resp){
					alert(resp);
					repairView.modal('hide');
					makeList();
				}
			});
		}
	});

//================================ 처리내역 등록 및 수정======================================	
	$("#saveBtnDiv").on("click", ".updateCommentBtn", function(){
		let resultForm = $("#resultForm");
		let asNo = $(this).data("asno");
		let asComment = resultForm.find("[name='asComment']").val();
		let asSchedule = resultForm.find("[name='asSchedule']").val();
		$.ajax({
			url:$.getContextPath()+"/office/construction/afterServiceUpdateResult.do"
			,method:"post"
			,dataType:"text"	
			,data:{
				"asNo" : asNo
				,"asComment" : asComment
				,"asSchedule" : asSchedule
			}
			,success:function(resp){
				alert(resp);
				if(resp=="변경되었습니다."){
					$("#resultModal").modal('hide');
					repairView.modal('hide');
					makeList();
				}
			}
		});
	});
	
	$("#tbodyViewResult").on("click", "#deleteResult", function(){
		let asNo = $(this).data("asno");
		if(confirm("삭제하시겠습니까?")){
			location.href="${cPath}/office/construction/deleteResult.do?asNo="+asNo;
		}
	});
	
//========================== 모달창 close===============================
	$("#saveBtnDiv").on("click", "#cancleCommentBtn", function(){
		$("#resultModal").modal('hide');
	});
	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='currentPage']").val(page);
		searchForm.submit();
		return false;
	}
	
	let searchForm = $("#searchForm");
	$("#searchBtn").on("click", function(){
		let inputs = $(this).parents("div#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val();
			let hidden = searchForm.find("[name='"+name+"']");
			hidden.val(value);
		});
		searchForm.submit();
	});
	
	$("#resultForm").validate({
		rules : {
			asSchedule : {required:true, minlength:1}
		}
	});
</script>