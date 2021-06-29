<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
#insertAccountDiv input {
	border: 0.5px solid #DEE2E6;
	width: 250px;
}

#insertAccountDiv {
	width: 1300px;
	margin-left: 100px;
	margin-top: 80px;
}

#insertAccountDiv td {
	text-align: left;
}
#listDiv{
	
	width: 1500px;
}

#apartCom{
float:left; 
width:181px; 
height:28px; 
line-height:28px; 
font-size:0.9em; 
color:#ffffff; 
background:#909090; 
text-align:center; 

}
#apartComForm{
position:absolute; 
width:auto; 
height:auto; 
left:360px; 
top:30px; 
z-index:1; 
background:#ffffff;
border:1px solid #909090; 
font-size:0.9em; 
line-height:1.5em; 
padding:10px 10px;
}
</style>
<div id="spec1" style="position:relative; z-index:1; left:0px; top:0px;display:none">
    <div id="apartComForm">
		<p><strong>아파트명</strong>:${apart.aptName }</p>
		<p><strong>아파트 주소</strong>:${apart.aptAdd1 } ${apart.aptAdd2 }</p>
		<p><strong>관리소장</strong>:${apart.aptHead }</p>
		<p><strong>전화번호</strong>:${apart.aptTel }</p>
		<p><strong>준공일</strong>:${apart.aptStart }</p>
		<p><strong>총새대수</strong>:${apart.aptCnt } 새대</p>
		<p><strong>면적수</strong>:${apart.aptArea }㎡</p>
    </div>
</div>
<form:form commandName="serviceVO" id="serviceForm" method="post" enctype="multipart/form-data">
<input type="hidden" value="${apart.aptCode }" name="aptCode">
<div id="insertAccountDiv">
	<div class="container">
		<div class="row">
			<div class="col-md-11">
				 <h1 class="display-6 font-weight-bold">용역업체 등록</h1>
			</div>
		</div>
	</div>
	<div class="card text-center col-auto">
		<div class="card-body row">
			<div class="col-sm-12">
				<table class="table">
					<tbody class="thead-light">
						<tr>
							<th colspan="4"><h4>아파트 정보</h4></th>						
						<tr>
							<th scope="col">아파트명 </th>
							<td>
							<div id="apartCom" onmouseover="view(true)" onmouseout="view(false)">
   							${apart.aptName }
							</div>
							</td>
							<th scope="col">업종 코드</th>
							<td><select name="svcCode" >
							<c:if test="${not empty serviceView.reSvccode}">
								<option value="${serviceView.reSvccode}">${serviceView.svcCode}</option>
							</c:if>
							<c:forEach items="${svcCodeList}" var="svcCode">
								<option value="${svcCode.codeId }" >${svcCode.codeName }</option>
							</c:forEach>							
							</select></td>
						</tr>
						<tr>
							<th colspan="4"><h4>용역업체 정보</h4></th>
						</tr>
						<tr>
							<th scope="col">업체명</th>
					        <td colspan="4"><input type="text" name="svcName" required="required" value="${serviceView.svcName }"></td>
						</tr>
						<tr>
					        <th scope="col">업체전화번호</th>
					        <td><input type="text" name="svcTel" required="required" value="${serviceView.svcTel }"></td>
					        <th scope="col">업체 우편번호</th>
					        <td><input type="text" name="svcZip" required="required" value="${serviceView.svcZip }" id="sample4_postcode" class="form-control">
					       		<form:errors path="svcZip" element="span" cssClass="error" />
								<input type="button" onclick="DaumPostcode()" value="우편번호 찾기" class="form-control btn btn-primary"><br></td>
					     </tr>
					     <tr>
					        <th scope="col">업체 주소</th>
					        <td><input type="text" name="svcAdd1" id="sample4_roadAddress"  placeholder="도로명주소"  class="form-control"required="required" value="${serviceView.svcAdd1 }">
						        <form:errors path="svcAdd1" element="span" cssClass="error" />
								<span id="guide" style="color:#999;display:none"></span>
					        </td>
								
					       
					        <th scope="col">업체 상세주소</th>
					        <td><input type="text" name="svcAdd2" id="sample4_detailAddress" class="form-control"  placeholder="상세주소" required="required" value="${serviceView.svcAdd2 }">
					        <form:errors path="svcAdd2" element="span" cssClass="error" />
					        </td>
					     </tr>
				         <tr>
					        <th scope="col">업체 대리인</th>
					        <td><input type="text" name="svcHead" required="required" value="${serviceView.svcHead }"></td>
					        <th scope="col">업체 대리인 연락처</th>
					        <td><input type="text" name="svcHeadTel" required="required" value="${serviceView.svcHeadTel }"></td>
					     </tr>
					     <tr>
					     	<th colspan="4"><h4>계약 정보</h4></th>
					     </tr>
						<tr>
							<th scope="col">은행명</th>
							<td>
							<select name="svcBank" >
							<c:if test="${not empty serviceView.reSvcbank}">
								<option value="${serviceView.reSvcbank}">${serviceView.svcBank}</option>
							</c:if>
							<c:forEach items="${bankCodeList}" var="svcBank" >
								<option value="${svcBank.bankCode }">${svcBank.bankName}</option>
							</c:forEach>							
							</select>
							</td>
							<th scope="col">계약금</th>
							<td><input type="text" name="svcDeposit" required="required" value="${serviceView.svcDeposit }"></td>
						</tr>
						<tr>
						  <th scope="col">계좌번호</th>
						  <td colspan="4"><input type="text" name="svcAcct" required="required" value="${serviceView.svcAcct }"></td>
						</tr>
						<tr>
							<th scope="col">계약 시작일</th>
							<td><input type="date" name=svcStart required="required" value="${serviceView.svcStart }"></td>
							<th scope="col">계약 만료일</th>
							<td><input type="date" name="svcEnd" required="required" value="${serviceView.svcEnd }"></td>
						</tr>
						<tr>
							<th colspan="4">추가 파일 등록</th>
						</tr>
				<tr>
					<th class="text-center">첨부파일</th>
					<td class="pb-1" id="fileArea" colspan="4">
					<c:if test="${not empty serviceView.attachList}">
						<c:forEach items="${serviceView.attachList}" var="attach" varStatus="vs">
						<c:choose>
						<c:when test="${attach.svcFilesize eq 0 }">
					
						</c:when>
						<c:when test="${attach.svcFilesize ne 0 }">
							<span title="다운로드${attach.svcFileNo }" class="attatchSpan" >
							<img src="${cPath }/js/main/img/common/file.png" class="delAtt" data-att-no="${attach.svcFileNo }"/>
							<label class="delAtt" data-att-no="${attach.svcFileNo }">${attach.svcFilename } </label> &nbsp; ${not vs.last?"|":"" }
							</span>
						</c:when>
						</c:choose>
						</c:forEach>		
					</c:if>
						<div class="input-group">
							<input type="file" class="form-control" value="파일" name="svcFile">
							<span class="btn btn-primary plusBtn">+</span>
						</div>
						<span class="error" ></span>
					</td>
				</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<div align="center">
	<input type="submit" class="btn btn-dark" role="alert" value="저장"
		style="display: inline; ">
	<input type="button" class="btn btn-dark" role="alert" value="목록으로" onclick="location.href=$.getContextPath() +'/office/servicecompany/serviceList.do'">
</div>
</form:form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

$("#fileArea").on("click", ".plusBtn", function(){
	let clickDiv = $(this).parents("div.input-group");
	let newDiv = clickDiv.clone();
	let fileTag = newDiv.find("input[type='file']");
	fileTag.val("");
	clickDiv.after(newDiv);		
});

	function view(opt) {
	  if(opt) {
	     spec1.style.display = "block";
	  }
	  else {
	     spec1.style.display = "none";
	  }
	}
	
	
	const validateOptions = {
            onsubmit:true
            ,onfocusout:function(element, event){
               return this.element(element);
            }
            ,errorPlacement: function(error, element) {
//                error.appendTo( $(element).parents("div:first") );
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
	
	let validator = $("#serviceForm").validate(validateOptions);
      
//       validateOptions.rules={
//          memId : {
//             remote : '${pageContext.request.contextPath}/signUp/idCheck.do'
//          }
//       }
//       validateOptions.messages={
//          memId : {
//             required : 'ID는 필수입력 사항입니다. 숫자, 영문자를 이용하여 5~15글자 이내로 입력해야 합니다.'
//             ,remote : '이미 존재하는 아이디입니다.'
//          },
         
//          memPass : {
//             required : '비밀번호는 필수입력 사항입니다. 특수문자를 포함한 영어만 입력할 수 있으며 5~12글자 이내로 입력해야 합니다.'
//          },
         
//          memName : {
//             required : '이름은 필수입력 사항입니다. 특수문자를 제외한 한글과 영어 모두 입력할 수 있으며 2~20글자 이내로 입력해야 합니다.'            
//          },
         
//          memMail : {
//             required : '이메일은 필수입력 사항입니다. abc@defg.hij 형식으로 입력해야 합니다.'
//          },
         
//          memHp : {
//             required : '휴대폰 번호는 필수입력 사항입니다. 01X-XXX(X)-XXXX 형식으로 입력해야 합니다.'
//          }
         
//       }
      
   let serviceForm =$("#serviceForm");
	$(".delAtt").on("click", function(){
		let attNo = $(this).data("attNo");
		serviceForm.append(
			$("<input>",{type:"hidden",name:"delAttNos",value:attNo}));
		
		$(this).parent("span:first").hide();
	});   

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

	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
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
             document.getElementById('sample4_postcode').value = data.zonecode;
             document.getElementById("sample4_roadAddress").value = roadAddr;

             var guideTextBox = document.getElementById("guide");
             // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
             if(data.autoRoadAddress) {
                 var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                 guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                 guideTextBox.style.display = 'block';

             } else if(data.autoJibunAddress) {
                 var expJibunAddr = data.autoJibunAddress;
                 guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                 guideTextBox.style.display = 'block';
             } else {
                 guideTextBox.innerHTML = '';
                 guideTextBox.style.display = 'none';
             }
         }
     }).open();
 }
	    
const contractExcelUploadModal = $("#contractExcelUploadModal");
const excelFile = $("#excelFile");
excelFile.on("change", function() {
	const uploadFile = this.files[0];
	const ext = uploadFile.name.substr(uploadFile.name.lastIndexOf(".")+1).toLowerCase();
	
	if(ext != "xls" && ext != "xlsx" && ext !="xlsm") {
		getErrorNotyDefault("올바른 파일형식이 아닙니다.");
		this.value=null;
	}
});
function listMove(){
	location.href=$.getContextPath() +'/office/servicecompany/serviceList.do'
}
</script>
