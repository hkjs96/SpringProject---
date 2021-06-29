<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 2.      이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#licenseArea {
	margin-left: 2em;
}
</style>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<div class="container">
	<br>
	<h4>
		<strong>인사기본정보</strong>
	</h4>
	<br>
	<c:url value="/office/employee/employeeUpdate.do" var="updateURL"/>
	<c:url value="/office/employee/employeeForm.do" var="insertURL"/>
	<form method="post" id="employeeForm" name="employeeForm" enctype="multipart/form-data" data-insert="${insertURL }" data-update="${updateURL }">
	<div class="d-flex justify-content-end">
		<div class="d-flex justify-content-end">
		<c:if test="${not empty employee.empBank }">
			<input type="button" class="btn btn-dark" id="updateBtn" style='margin: 5pt;' value="수정">
		</c:if>
		<c:if test="${empty employee.empBank }">
			<input type="button" class="btn btn-dark" id="insertBtn" style='margin: 5pt;' value="등록">
		</c:if>
		</div>
	</div>
	<div class="card text-center col-auto">
		<div class="card-header">
			<ul class="nav nav-tabs card-header-tabs">
				<li class="nav-item"><a class="nav-link text-dark active"
					href="#"><strong>관리사무소직원</strong></a></li>
				<li><span class="reddot"> &nbsp;&nbsp;&nbsp;* 필수 입력 항목</span></li>
			</ul>
		</div>
		<div class="card-body row">
			<div class="col-sm-4"></div>
			<div class="col-sm-12 employeeForm card-header card-footer inputDiv">
			<c:if test="${empty employee.empBank }">
					<div class="row mb-3">
						<label for="memId" class="col-sm-2 col-form-label "><span class="reddot">* </span>사용자코드(ID)</label>
						<div class="col-sm-4">
								<input type="text" class="form-control" id="memId" name="memId"
								value="${employee.memId}" readonly>						
						</div>
						<label for="memPass" class="col-sm-2 col-form-label"><span class="reddot">* </span>비밀번호</label>
						<div class="col-sm-4">
							<input type="password" class="form-control" id="memPass"
								value="" name="memPass" placeholder="초기비밀번호는 휴대폰번호로 자동 설정" readonly>
						</div>
					</div>
				<hr>
					<div class="row mb-3">
						<label for="aptCode" class="col-sm-2 col-form-label "><span class="reddot">* </span>아파트코드</label>
						<div class="col-sm-10">
							<input type="text" class="form-control " id="aptCode"
							name="aptCode" value="${fn:substring(employee.memId, 0, 5)}"
							readonly>
						</div>
					</div>
					<div class="row mb-3">
						<label for="empBank" class="col-sm-2 col-form-label"><span class="reddot">* </span>급여은행</label>
						<div class="col-sm-4">
							<select id="empBank" name="empBank" class="form-control">
								<c:forEach items="${banks }" var="bank" varStatus="vs">
									<c:if test="${not empty bank.bankCode }">
										<option value="${bank.bankName }" ${employee.empBank eq bank.bankName ? 'selected':''}>"${bank.bankName }"</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<label for="empAcct" class="col-sm-2 col-form-label"><span class="reddot">* </span>계좌번호</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="empAcct"
								name="empAcct" value="302-15-502031" required onkeypress="return onlyAcct(event)" 
								placeholder="하이픈(-) 포함하여 입력" maxlength="17">
						</div>   
					</div>
			</c:if>	
			<c:if test="${not empty employee.empBank }">	
				<div>
					<input type="hidden" name="memId" value="${employee.memId}">
				</div>
			</c:if>	
					<div class="row mb-3">
						<label for="memRole" class="col-sm-2 col-form-label "><span class="reddot">* </span>사용자분류</label>
						<div class="col-sm-4">
							<select id="memRole" class="form-control" name="memRole">
								<c:forEach items="${roles }" var="role" varStatus="vs">
									<c:if test="${not empty role.codeId }">
										<option value="${role.codeId }" ${employee.member.memRole eq role.codeId ? 'selected':''}>"${role.codeName }"</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<label for="empName" class="col-sm-2 col-form-label"><span class="reddot">* </span>사원명</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="empName"
								name="empName" value="최사랑" required maxlength="60">
							<input type="hidden" name="memNick" id="memNick" value="">
						</div>
					</div>
					<div class="row mb-3">
						<label for="empBirth" class="col-sm-2 col-form-label"><span class="reddot">* </span>생년월일</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" id="empBirth"
								name="empBirth" value="1980-02-06" required>
						</div>
						<label for="empMail" class="col-sm-2 col-form-label"><span class="reddot">* </span>이메일</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="empMail"
								name="empMail" value="djfds@naver.com" placeholder="이메일 형식 입력 (예:aa892@naver.com)" 
								required maxlength="40">
						</div>
						
					</div>
					<div class="row mb-3">
						<label for="positionCode" class="col-sm-2 col-form-label"><span class="reddot">* </span>직책</label>
						<div class="col-sm-4">
							<select id="positionCode" name="positionCode" class="form-control">
								<c:forEach items="${positions }" var="position" varStatus="vs">
									<c:if test="${not empty position.positionCode }">
										<option value="${position.positionCode }" ${employee.positionCode eq position.positionCode ? 'selected':''}>"${position.positionName }"</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<div id="offDiv" class="col-sm-4">
							<select id="empOff" name="empOff" class="form-control" >
								<c:forEach items="${positions }" var="position" varStatus="vs">
									<c:if test="${not empty position.positionCode }">
										<option value="${position.positionOff }" >"${position.positionOff }"</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<label for="empStart" class="col-sm-2 col-form-label"><span class="reddot">* </span>입사일</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" id="empStart" name="empStart" value="2021-03-12" required>
						</div>
					</div>
					<div class="row mb-3">
						<label for="empHp" class="col-sm-2 col-form-label"><span class="reddot">* </span>핸드폰번호</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="empHp" name="empHp" value="010-5572-7833" required maxlength="13">
						</div>
						<label for="empTel" class="col-sm-2 col-form-label"><span class="reddot">* </span>자택번호</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="empTel" name="empTel" value="054-425-4521" required maxlength="13" >
						</div>
					</div>
					<div class="row mb-3">
						<label for="empZip" class="col-sm-2 col-form-label"><span class="reddot">* </span>우편번호</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" id="empZip" name="empZip" value="15215" required maxlength="5">
						</div>
						<input type="button" onclick="DaumPostcode()" value="우편번호 찾기"
							class="form-sm-2 btn btn-primary"><br>
					</div>
					<div class="row mb-3">
						<label for="empAdd1" class="col-sm-2 col-form-label"><span class="reddot">* </span>주소</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="empAdd1"
								name="empAdd1" value="대전 중구 중교로 9" required maxlength="60">
						</div>
						<label for="empAdd2" class="col-sm-2 col-form-label"><span class="reddot">* </span>상세주소</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="empAdd2"
								name="empAdd2" value="39의 2" required maxlength="60">
						</div>
					</div>
					<div class="row mb-3">
						<label for="empImage" class="col-sm-2 col-form-label">프로필사진</label>
						<div class="col-sm-8">
							<input type="file" class="custom-file-input" id="empImage"
								name="empImage"> <label class="custom-file-label"
								for="empImage">파일 첨부</label>
						</div>
					</div>
					<div class="row mb-3">
						<label for="empEnd" class="col-sm-2 col-form-label">자격증 </label>
						<input type="button" class="btn btn-dark mb-4" id="licResetBtn" value="선택 초기화">
						<div class="input-group mb-3">
							<c:forEach items="${employee.licenseList }" var="licEmployee"
								varStatus="vs">
								&nbsp;
								<c:if test="${not empty licEmployee.licCode }">
									<span id="${licEmployee.licCode }" class="input-group-text ml-5">
										${licEmployee.licName } &nbsp; <input type="button"
										class="btn btn-danger delBtn" value="삭제"
										data-code="${licEmployee.licCode }" />
									</span>
								</c:if>
							</c:forEach>
						</div>
						<div id="licenseArea" class="col-sm-12">
							<div class="input-group">
								<select id="licCodes" name="licCodes" class="form-control col-sm-10" multiple size="5">
									<c:forEach items="${licenses }" var="license">
										<c:set var="matched" value="${false }" />
										<c:forEach items="${employee.licenseList }" var="licEmployee">
											<c:if test="${licEmployee.licCode eq license.licCode }">
												<c:set var="matched" value="${true }" />
											</c:if>
										</c:forEach>
										<option value="${license.licCode }"
											class="${matched?'matched':'normal' }">${license.licName }</option>
									</c:forEach>
								</select> 
							</div>
						</div>
					</div>
			</div>
		</div>
	</div>
   </form>
</div>

<script>
	$(".custom-file-input").on("change", function() {
		  var fileName = $(this).val().split("\\").pop();
		  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
	  
	});
	
	let empTel = $(":input[name=empTel]");
	let empHp = $(":input[name=empHp]");
	//== 직원 등록 및 수정 ========================================================================================
	$(function(){
		$("#offDiv").hide();
		$("#empOff option").eq(0).prop("selected", true);
		var idx = $("#positionCode option").index( $("#positionCode option:selected") );
		  $("#empOff option").eq(idx).prop("selected", true);
		  
		  
		let empForm = $("#employeeForm");
		$("#insertBtn,#updateBtn").on("click", function(){
			let flag = null;
			let action = null;
			checkMail($("#empMail").val()); 
			
			if($(this).prop("id")=="updateBtn"){ //수정
				action = empForm.data("update");
				flag = confirm("수정하시겠습니까?");
			}else{
				action = empForm.data("insert"); //등록
				flag = confirm("등록하시겠습니까?");
			}
			if(flag){
				empForm.attr("action", action);
				let empName = $("#empName").val();
				$("#memNick").val(empName);
				
				empTel.val(empTel.val().replaceAll('-',''));
				empHp.val(empHp.val().replaceAll('-',''));
				
				empForm.submit();
			}
		});
	})
	
	
	//== 휴가 =================================================================================================
		
	//직책 따라 휴가일수 자동 변경되어 등록되게
	$("select[name=positionCode]").change(function(){
		  var idx = $("#positionCode option").index( $("#positionCode option:selected") );
		  $("#empOff option").eq(idx).prop("selected", true);
	});
	
	//validation tooltip check
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
	
	let validator = $("#employeeForm").validate(validateOptions);
	
	
	let licCodes = $("[name='licCodes']");
	let employeeForm = $("#employeeForm").on("reset", function(){
		$(".licImagesTB").remove();
		$.each(spanBuffer, function(idx, span){
			span.show();
			let licCode = span.prop("id");
			$(licCodes).find("[value='"+licCode+"']").addClass("matched");
		});
		spanBuffer.length=0;
		employeeForm.find("[name='deleteLicCodes']").remove();
	});
	let spanBuffer = [];
	
	//기존 자격증 삭제 처리시 테스트 코드
	$(".delBtn").on("click", function(){
		let dellicCode = $(this).data("code");
		employeeForm.append(
			$("<input>").attr({
				type:"hidden"
				, name:"deleteLicCodes"
				, value:dellicCode
			})
		);
		spanBuffer.push( $(this).closest("span") );
		$(this).closest("span").hide();
		$(licCodes).find("[value='"+dellicCode+"']").removeClass("matched");
	});	
	
	// 자격증 선택시, 이미지 태그 추가
	licCodes.on("blur", function(){
		$(".licImagesTB").remove();
		let selectTag = $(this);
		let options = $(this).find("option:selected")
		let licTB = $("<table class='licImagesTB table-bordered col-sm-10'>");
		selectTag.closest("div#licenseArea").append(licTB);
		$(options).each(function(idx, option){
			licTB.append(
				$("<tr>").append(
					$("<td class='align-middle'>").html($("<span>").addClass("mr-3").text($(option).text())),		
					$("<td class='align-middle'>").append(
						$("<input>").attr({
							type:"file"
							, 'class':"form-control mr-3"
							, name:"licImages"
							, required:true
							, id:"file_"+idx
						}),
						$("<img>").hide()
						.addClass("file_"+idx)
						.addClass("thumbnail")
					),
					$("<td class='align-middle'>").html(
						$("<input>").attr({
							type:"date"
							, 'class':"form-control mr-3"
							, name:"licDates"
							, required:true
							, id:"date_"+idx
							
						})
					)
				)
			);	
		});
	});
	
	//======이메일 체크 정규식==========================================================================================
	function isMail(number)
	{
	    var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	    return reg.test(number);
	}
	
	function checkMail(field) {
		console.log(field);
	   if(!isMail(field)){
		  getErrorNotyDefault("이메일 형식이 맞지 않습니다.");
	      return false;
	    }
	   
	   return true;
	}
	
	//=========자격증 등록 목록 초기화 버튼=================================================================================
	$("#licResetBtn").on("click", function(){
		let licSel = licCodes.find("option:selected");
		 $("#licCodes option").prop("selected", false);
		 $(".licImagesTB").remove();
	});
	
	//=========자격증 사본 미리보기=======================================================================================
	$("#employeeForm").on("change", "[type='file']", function(){
		let fileTag = this;
		let files = $(this).prop("files");
		let id = $(this).prop("id");
		if(!files) return;
		for(let idx=0; idx<files.length; idx++){
			let reader = new FileReader();
			reader.onloadend = function(event){
				let imgTag = $(fileTag).next("."+id);
				imgTag.attr("src", event.target.result);
				imgTag.attr("style", "height:100px;width:100px;");
				imgTag.show();
			}
			reader.readAsDataURL(files[idx]);
		}
	});
	
	//============계좌번호 체크 함수====================================================================================
	function onlyAcct(evt) {
	   var charCode = (evt.which) ? evt.which : event.keyCode; 
	  
	   if(charCode > 31 && ((charCode < 45 && 45 < charCode < 48) || charCode > 57)){
	           return false;
	   }
	   return true;
	}
	
	//============휴대폰번호, 전화번호 입력 시 하이픈 자동 삽입 ================================================================
	$(document).on("keyup", empTel, function(e){
		empTel.val( empTel.val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
	});
	$(document).on("keyup", empHp, function(e){
		empHp.val( empHp.val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
	});


	//======= 다음 우편번호 주소 API ====================================================================================
	var themeObj = {
		   //bgColor: "", //바탕 배경색
		   searchBgColor: "#FFFFFF", //검색창 배경색
		   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
		   //pageBgColor: "", //페이지 배경색
		   //textColor: "", //기본 글자색
		   queryTextColor: "#000000" //검색창 글자색
		   //postcodeTextColor: "", //우편번호 글자색
		   //emphTextColor: "", //강조 글자색
		   //outlineColor: "", //테두리
		};
	
	function DaumPostcode() {
	    new daum.Postcode({
	    	theme: themeObj,
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수
	
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('empZip').value = data.zonecode;
	            document.getElementById("empAdd1").value = roadAddr;
	          //   document.getElementById("empAdd2").value = data.jibunAddress;
	          
	        }
	    }).open();
	}
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
