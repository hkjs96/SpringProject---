<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 6.      박지수      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
	.inner {
		width : 600px;
		margin: 0 auto;
		margin-top: 40px; 
	}
</style>

<div id="container">
    <div class="inner">
        <!-- 아파트 정보 상세 조회 -->
        <div class="board-list">
            <form:form commandName="apart"  id="apartForm" method="post" enctype="multipart/form-data">
            <input type="hidden" name="aptCode" value="${apart.aptCode }" />
            <table>
	            	<colgroup>
						<col style="width: 150px">
						<col style="width: 120px">
						<col style="width: 120px">
					</colgroup>
		                <thead>
						<tr>
							<th colspan="1" scope="row">아파트이미지</th>
							<td colspan="2">
								<input type="file" name="aptImage" accept="image/*" class="form-control"/>
								<form:errors path="aptImage" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th colspan="1" scope="row">난방정책</th>
							<td>
								<select name="aptHeat" class="form-control">
									<option value>난방 선택</option>
								</select>
							</td>
						</tr>
						<tr>
							<th colspan="1" scope="row">관리사무소 전화번호</th>
							<td colspan="2">
								<input type="tel" name="aptTel" value="${apart.aptTel }" class="form-control"/>
								<form:errors path="aptTel" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th colspan="1" scope="row">관리소장명</th>
							<td colspan="2">
								<input type="text" name="aptHead" value="${apart.aptHead }" class="form-control"/>
								<form:errors path="aptHead" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th colspan="1" scope="row">계약시작일</th>
							<td colspan="2">
								<input type="date" name="aptStart" value="${apart.aptStart }" class="form-control"/>
								<form:errors path="aptStart" element="span" cssClass="error" />								
							</td>
						</tr>
						<tr>
							<th colspan="1" scope="row">계약만료일</th>
							<td colspan="2">
								<input type="date" name="aptEnd" value="${apart.aptEnd }" class="form-control"/>
								<form:errors path="aptEnd" element="span" cssClass="error" />								
							</td>
						</tr>
	                </thead>
	                <tbody>
	                </tbody>
	            </table>
		        <div align="center">
		        	<br>
					<input class="btn btn-dark" id="updateBtn" type="button" value="아파트 정보 변경">
				</div>
            </form:form>
        </div>
    </div>
</div>



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
let apartForm = $("#apartForm");
let aptTel = $(":input[name=aptTel]");
aptTel.val(formatTel(aptTel.val()));

$(document).on("keyup", aptTel, function(e){
	aptTel.val( aptTel.val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
});


/*---------------------------------------------------------------------------------*/

let updateBtn = $("#updateBtn").on("click", function(){
	let result = confirm("변경하시겠습니까 ?");
    
    if(result)
    {
    	aptTel.val(aptTel.val().replaceAll('-',''));
    	apartForm.submit();
    }
});

/*------------------------------------------------------------------------------------------------*/

let optTag = $("[name='aptHeat']");
$.ajax({
	url : "${cPath }/office/setting/apartOption.do",
	method : "get",
	dataType : "json",
	success : function(resp) {
		let opts = [];
		// 옵션을 동적으로 구성
		console.log(resp);
		$(resp.option).each(function(idx, opt){
			opts.push(
				// type을 그대로 유지하기 위해서 prop 를 사용
				$("<option>").text(opt.codeName)
							 .attr("value", opt.codeId)
							 .prop("selected", "${apart.aptHeat}"==opt.codeName)
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		optTag.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});

/*-----------------------------------------------------------------------------------------------*/

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
//                 document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
//                 if(roadAddr !== ''){
//                     document.getElementById("sample4_extraAddress").value = extraRoadAddr;
//                 } else {
//                     document.getElementById("sample4_extraAddress").value = '';
//                 }

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
</script>