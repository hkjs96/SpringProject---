<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2021. 3. 1.  이경륜      수납에서 분리함
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.anyapart.or.kr/jsonUtils" prefix="ju" %>
<!-- pdf다운로드용 -->
<script type="text/javascript" src="${cPath }/js/pdf/html2canvas.min.js"></script>
<script type="text/javascript" src="${cPath }/js/pdf/jspdf.min.js"></script>
<!-- 끝 -->

<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy년  MM월 dd일" /></c:set> 
<br>
<style>
/* thead, tfoot 고정된 스크롤 테이블*/
/* 참고: https://codepen.io/paulobrien/pen/LBrMxa */

.wrapper { /*안되면 인라인으로*/
	height:500px;
	overflow: auto;
}

.fixedHeader {
   position: sticky;
   top: 0;
}


.wrapper tfoot,
.wrapper tfoot th,
.wrapper tfoot td {
  position: -webkit-sticky;
  position: sticky;
  bottom: 0;
  z-index:4;
}

tfoot td:first-child {
  z-index: 5;
}


#unpaidTable tr{
	height: 3em;
}

#unpaidTable {
	width: 50em;
}

#modalBodyDiv{
	width: 61.5em;
}

.smileIcon{
	width: 25px;
	height: 25px;
}

#detailTitle{
	margin-top: px;
	font-size: 30px;
}

.searchDiv{
	margin-left: 45px;
}

#noticeSpan{
	color:blue;
}
</style>
<div id="top"> 
	<h2><strong>미납 조회</strong></h2>
</div>
<form:form commandName="receiptSearchVO" id="searchForm" method="get">
<div class="container">
	<div class="col-md-12" style="border-style: outset; border-radius: 8px;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png"
					alt="searchIcon"
					style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색 조건</strong>
			</div>
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col-md-2 text-center align-self-center">
					동/호
				</div>
				<div class="col-md-3">
					<form:input path="dong" cssClass="form-control col-md-4" cssStyle="display: inline-block;" maxlength="4" onkeypress="return onlyNumber(event)"/>
		      		<label>&nbsp;동&nbsp;</label>
					<form:input path="ho" cssClass="form-control col-md-4" cssStyle="display: inline-block;" maxlength="4" onkeypress="return onlyNumber(event)"/>
			 		<label>&nbsp;호 &nbsp;</label>
			 	</div>
				<div class="col-md-2 text-center align-self-center">
					부과년월
				</div>
				<div class="col-md-3">
					<form:input path="costYear" cssClass="form-control col-md-4" cssStyle="display: inline-block;" maxlength="4" onkeypress="return onlyNumber(event)"/>
		      		<label>&nbsp;년&nbsp;</label>
					<form:input path="costMonth" cssClass="form-control col-md-4" cssStyle="display: inline-block;" maxlength="2" onkeypress="return onlyNumber(event)"/>
		      		<label>&nbsp;월&nbsp;</label>
				</div>
				<div class="col-md-2">
					<button class="btn btn-dark" id="searchBtn" onclick="goSearch()">검색</button>
					<button class="btn btn-secondary" id="resetBtn">초기화</button>
				</div>
			</div>
		</div>
	</div>
</div>
</form:form>
<br>
<br>
<span class="reddot">*&nbsp;</span><span>연체요율 : 미납관리비 * ${frMap['R_OVERDUE'] } * (연체일수 / 365)</span>
<br>
<span class="reddot">*&nbsp;</span><span>연체료는 연체요율에 근거하여 일할 계산되어 부과됩니다.</span>
<br>
<br>
<div class="d-flex justify-content-between mb-3">
	<button type="button" class="btn btn-primary" id="selectBtn">미납내역서 출력</button>
	<div class="d-flex justify-content-end"><button type="button" class="btn btn-danger" id="insertBtn">수납처리</button></div>
</div>
<div class="wrapper">
	<table class="table table-bordered table-hover table-sm">
		<thead class="thead-light text-center">
			<tr class="text-center">
				<th  scope="col" class="fixedHeader align-middle"></th>
				<th  scope="col" class="fixedHeader align-middle">부과년월</th>
				<th  scope="col" class="fixedHeader align-middle">동</th>
				<th  scope="col" class="fixedHeader align-middle">호</th>
				<th  scope="col" class="fixedHeader align-middle">세대주명</th>
				<th  scope="col" class="fixedHeader align-middle">부과액</th>
				<th  scope="col" class="fixedHeader align-middle">연체료</th>
				<th  scope="col" class="fixedHeader align-middle">총 수납금액합</th>
				<th  scope="col" class="fixedHeader align-middle">연체일수</th>
			</tr>	
		</thead>
		<tbody>
			<c:if test="${not empty unpaidList }">
				<c:set var="costTotalAll" value="0"/>
				<c:set var="costLateFeeAll" value="0"/>
				<c:set var="costTotalPlusLateAll" value="0"/>
				<c:forEach items="${unpaidList }" var="cost" varStatus="vs">
					<c:if test="${not empty cost.costMonth }">
						<tr class="text-center" id="${cost.memId }${vs.index }">
							<td><input type="checkbox" name="printChkBox"/></td>				
							<td>${cost.costYear }&nbsp;/&nbsp;${cost.costMonth }</td>				
							<td>${cost.dong}</td>
							<td>${cost.ho}</td>
							<td>${cost.resName}</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costTotal}"/> 원</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.lateFee}"/> 원</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costTotalPlusLate}"/> 원</td>
							<td class="text-right">${cost.lateDayCnt} 일</td>
						</tr>
						<script>
							var string = '${ju:toJson(cost)}';
							var json = JSON.parse(string);
							var id = "${cost.memId }${vs.index }";
							$("#"+id).data("cost", json);
						</script>
					</c:if>
					<c:if test="${empty cost.costMonth }">
						<tr class="text-center table-warning">
							<td colspan="5">호계</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costTotal }"/> 원</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.lateFee}"/> 원</td>
							<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costTotalPlusLate}"/> 원</td>
							<td class="text-right">-</td>
						</tr>
						<c:set var="costTotalAll" value="${costTotalAll + cost.costTotal }"/>
						<c:set var="costLateFeeAll" value="${costLateFeeAll + cost.lateFee }"/>
						<c:set var="costTotalPlusLateAll" value="${costTotalPlusLateAll + cost.costTotalPlusLate }"/>
					</c:if>
				</c:forEach>
				</tbody>
				<tfoot>
					<tr class="text-center table-danger">
						<td colspan="5">총계</td>
						<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costTotalAll }"/> 원</td>
						<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costLateFeeAll}"/> 원</td>
						<td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${costTotalPlusLateAll}"/> 원</td>
						<td class="text-right">-</td>
					</tr>
				</tfoot>
			</c:if>
			<c:if test="${empty unpaidList }">
				<tr>
					<td colspan="9" class="text-center">
						미납 내역이 없습니다.
					</td>
				</tr>
				</tbody>
			</c:if>
	</table>
</div>


<!-- 관리비 미납내역서  모달-->
<div class="modal fade" id="unpaidNoticeModal">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
    
			<!-- Modal Header -->
			<div class="modal-header">
				<h3 class="modal-title"><strong>관리비 미납내역서</strong></h3>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
      
			<!-- Modal body -->
			<div id="modalBodyDiv" class="modal-body d-flex justify-content-end">
				<input type="button" class="btn btn-dark" id="create_pdf" value="PDF 저장">
			</div>
			<div id="printDiv">
				<p class="text-center" id="detailTitle">관리비 미납내역서</p>
				<div class="modal-body d-flex justify-content-center ">
					<table class="table table-bordered text-center" id="unpaidTable">
						<thead class="thead-light">
							<tr>
								<td class="table-secondary text-center">수령인</td>
								<td class="text-center" id="toArea" colspan="3"></td>
							</tr>
							<tr>
								<td class="table-active">부과년월</td>
								<td class="table-active">관리비</td>
								<td class="table-active">연체료</td>
								<td class="table-active">합계</td>
							</tr>
						</thead>
						<tbody id="unpaidBody">

						</tbody>
						<tfoot>
							<tr>
								<td class="table-active">발행일 </td>
								<td>${date }</td>
								<td class="table-active">납부마감일</td>
								<td>${date }</td>
							</tr>
							<tr>
								<th class="table-secondary" colspan="4">수납처</th>
							</tr>
							<c:if test="${not empty billAcctList }">
								<c:forEach items="${billAcctList }" var="acct" varStatus="vs">
									<tr>
										<td class="table-active">계좌번호</td>
										<td>${acct.bankCode } ${acct.acctNo }</td>
										<td class="table-active">예금주</td>
										<td>${acct.acctUser }</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty billAcctList }">
								<tr>
									<td colspan="4">관리사무소로 연락바랍니다.</td>
								</tr>
							</c:if>
							<tr class="table-primary">
								<td colspan="4">
									${apart.aptName } 관리사무소장 ${apart.aptHead } (인)
						        </td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 미납내역 즉시수납 처리시 관리자 비밀번호 인증 모달 -->
<div class="modal fade" id="unpaidPayAuthModal" tabindex="-1" aria-labelledby="unpaidPayAuthModalLabel" aria-hidden="true"  style=”z-index:1050;”>
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="unpaidPayAuthModalLabel">관리자 인증</h4>
			</div>
			<form id="unpaidPayAuthForm" action="${cPath }/office/receipt/insertUnpaidReceipt.do" method="post">
				<div class="modal-body">
				
					<table class="table table-bordered">
						<tr>
							<th class="table-secondary text-center" colspan="2">${date } 기준</th>
						</tr>
						<tr>
							<th class="table-warning text-center" colspan="2">* 미납 관리비 수납처리 후에는<br>취소할 수 없습니다.</th>
						</tr>
						<tr>
							<th class="text-center table-light" style="width:25%">비밀번호</th>
							<td><input class="form-control" type="password" name="memPass" required/></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">저장</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
/*
 * - '조회' 눌렀을때 작동
 * - 스크린사이즈 변화있을때 searchForm 트리거링 
 */
let searchForm = $("#searchForm");
function goSearch() {
	let ho = searchForm.find(":input[name='ho']").val();
	if(ho.length==3) {
		ho='0'+ho;
		searchForm.find(":input[name='ho']").val(ho);
	}
	searchForm.attr("action", "<c:url value='/office/receipt/unpaidReceiptList.do'/>");
	searchForm.submit();
}

/*
 * 리셋
 */
$("#resetBtn").on("click", function(event) {
	event.preventDefault();
	
	let inputs = searchForm.find(":input[name]");
	$(inputs).each(function(index, input){
		$(this).val(null);
	});
	
	return false;
});



//============================= 미납내역 즉시수납처리 시작
//==================== validator 옵션
const validateOptions = {
// 		submitHandler: function(form) {
// 			if(!confirm("해당 미납관리비를 수납처리 하시겠습니까?")) return; // 이거넣으니까 갑자기안됨
// 		},
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

let unpaidPayAuthForm = $("#unpaidPayAuthForm");
let validatorForAuthForm = unpaidPayAuthForm.validate(validateOptions);

let unpaidPayAuthModal = $("#unpaidPayAuthModal").on("hidden.bs.modal", function(){
	$(this).find("form").get(0).reset();
});

$("#insertBtn").click(function(){ 
	var checkbox = $("input[name=printChkBox]:checked");
	if(checkbox.length == 0) {
		getErrorNotyDefault("수납할 미납기록을 선택해 주세요.");
		return;
	}
	
	// 체크된 체크박스 값을 가져온다
	checkbox.each(function(i) {

		let tr = checkbox.parent().parent().eq(i);
		let cost = tr.data("cost");
		
		let costNo = $("<input>").attr({
			type: "hidden"
			,name: "receiptList["+i+"].costNo"
			,value: cost.costNo
		});

		let receiptCost = $("<input>").attr({
			type: "hidden"
			,name: "receiptList["+i+"].receiptCost"
			,value: cost.costTotalPlusLate
		});
		
		unpaidPayAuthForm.append(costNo, receiptCost);
	});
	
	unpaidPayAuthModal.modal("show");
});




//================================ 미납내역서
let unpaidBody = $("#unpaidBody");

$("#selectBtn").click(function(){ 
	var checkbox = $("input[name=printChkBox]:checked");
	if(checkbox.length == 0) {
		getErrorNotyDefault("미납내역서를 출력할 미납기록을 선택해 주세요.");
		return;
	}
	
	let trTags=[]; // 미납내역서에 들어갈 월별내역
	let toArea = $("#toArea");
	
	let costTotalAll = 0;
	let lateFeeAll = 0;
	let costTotalPlusLateAll = 0;
	
	let tempId = '';
	let flag='Y'; // 모달딜레이위해서 추가함
	
	checkbox.each(function(i) { // 체크된 체크박스 값을 가져온다
		// checkbox.parent() : checkbox의 부모는 <td>이다.
		// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
		let tr = checkbox.parent().parent().eq(i);
		let cost = tr.data("cost");
		
		if(i>0 && tempId != cost.memId) {
			getErrorNotyDefault("동일 세대만 선택해 주세요.");
			flag = 'N';
			return;
		}
		
		tempId = cost.memId;
		
		let costYear = cost.costYear;
		let costMonth = cost.costMonth;
		let dong = cost.dong;
		let ho = cost.ho;
		let resName = cost.resName;
		let costTotal = cost.costTotal;
		let lateFee = cost.lateFee;
		let costTotalPlusLate = cost.costTotalPlusLate;
		
		costTotalAll += costTotal;
		lateFeeAll += lateFee;
		costTotalPlusLateAll += costTotalPlusLate;
		
		let trTag = $("<tr>");
		trTag.append(
				$("<td>").html(costYear + "년 " + costMonth + "월"),
				$("<td>").html(numberWithCommas(costTotal)+" 원").addClass("text-right"),
				$("<td>").html(numberWithCommas(lateFee)+" 원").addClass("text-right"),
				$("<td>").html(numberWithCommas(costTotalPlusLate)+" 원").addClass("text-right")
		);
		
		trTags.push(trTag);
		toArea.html(dong + "동 " + ho + "호 " + resName + " 님");
	});

	// 합계
	trTags.push(
				$("<tr>").append(
					$("<td>").html("합계").addClass("table-secondary"),
					$("<td>").html(numberWithCommas(costTotalAll)+" 원").addClass("text-right table-warning"),
					$("<td>").html(numberWithCommas(lateFeeAll)+" 원").addClass("text-right table-warning"),
					$("<td>").html(numberWithCommas(costTotalPlusLateAll)+" 원").addClass("text-right table-danger")
				)
	);
	unpaidBody.html(trTags);
	if(flag=='Y') {
		$("#unpaidNoticeModal").modal("show");
	}
});


/*
 * 미납내역서 pdf 
 */
// 참고 : https://chichi-story.tistory.com/10
$('#create_pdf').click(function() { // pdf저장 button id
		
	    html2canvas($('#printDiv')[0]).then(function(canvas) { //저장 영역 div id
		
		    // 캔버스를 이미지로 변환
		    var imgData = canvas.toDataURL('image/png');
			     
		    var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
		    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
		    var imgHeight = canvas.height * imgWidth / canvas.width;
		    var heightLeft = imgHeight;
		    var margin = 10; // 출력 페이지 여백설정
		    var doc = new jsPDF('p', 'mm');
		    var position = 0;
		       
		    // 첫 페이지 출력
		    doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
		    heightLeft -= pageHeight;
		         
		    // 한 페이지 이상일 경우 루프 돌면서 출력
		    while (heightLeft >= 20) {
		        position = heightLeft - imgHeight;
		        doc.addPage();
		        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
		        heightLeft -= pageHeight;
		    }
		 
		    // 파일 저장
		    doc.save('관리비 미납내역서.pdf');

		  
	});

});

</script>
