<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  박정민      최초작성
* 2021. 2.  8.  이경륜	dataTable 주석
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/js/startbootstrap-sb-admin-gh-pages/dist/js/scripts.js"></script>
<!-- 박정민 : chart안쓰는 페이지에서 오류나서 주석처리하고 index 페이지에 추가해둠 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script> -->
<%-- <script src="${pageContext.request.contextPath }/js/startbootstrap-sb-admin-gh-pages/dist/assets/demo/chart-area-demo.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath }/js/startbootstrap-sb-admin-gh-pages/dist/assets/demo/chart-bar-demo.js"></script> --%>
<!-- 박정민 : 끝 -->
<!-- 이경륜 : dataTable 쓰지 않는데 로드되고 있어서 주석처리해둠 -->
<!-- <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script> -->
<%-- <script src="${pageContext.request.contextPath }/js/startbootstrap-sb-admin-gh-pages/dist/assets/demo/datatables-demo.js"></script> --%>
<!-- 이경륜 : 끝 -->

<style>
	#footer{
		background-color: #F8F9FA;
		font-size: 12px;
	    margin-top: 2em;		
	}
	
	.inner{
		background-color: #F8F9FA;
		margin-left:13em;
		margin-top:10em;
	}
	
	#aptName{
		font-size:14px;
		margin-top:3em;
		margin-bottom: 2em;
		margin-left:10em;
	}
	
	.infoC{
	margin-left:20em;
		margin-top:4em;
		margin-bottom: 2em;
		font-size: 14px;
	}
	
	.copyC{
	margin-left:15em;
		margin-top:4em;
		margin-bottom: 2em;
		font-size: 13px;
		color: gray;
		font-style: italic;
	}
	
</style>


 <div id="footer" >
     <div class="inner form-inline">
   	    <div id="aptName">
      	</div>
		<div class="infoC">
            <p id="info"></p>
		</div>
		<div class="copyC">
            <p id="copy">Copyright 2021 AnyApart CORP. ALL RIGHTS RESERVED.</p>
		</div>
     </div>
 </div>

<script>
/**
 * 금액 입력 시 실시간으로 콤마 찍어주는 함수
 * 사용법 :  input type class에 onlyNumber 추가하여 사용
 * @author 이미정
 */
$(".onlyNumber").keypress(function (event) {
    if (event.which && (event.which < 48 || event.which > 57)) {   //숫자만 받기
        event.preventDefault();
    }
}).keyup(function () {
    if ($(this).val() != null && $(this).val() != '') {
        var text = $(this).val().replace(/[^0-9]/g, '');
        $(this).val(numberWithCommas(text));
    }
});

/**
 * footer하단 관리사무소 정보 출력해줌
 * @author 이미정
 */
$(function(){
	let aptCode = '<c:out value="${authMember.aptCode }"/>';
	
	$.ajax({
		url:"${cPath }/office/employee/setting/apartView.do"
		,data : {"aptCode" : aptCode}
		,method : "get"
		,success : function(resp){
			if(resp.message){
				getNoty(resp);
				return;
			}else{
				let apart = resp.apart;
				$("#aptName").text(apart.aptName);
				$("#info").text("주소 : (" 
							  + apart.aptZip 
							  + ") " 
							  + apart.aptAdd1 
							  + " "
							  + apart.aptAdd2 
							  + " | 대표자 : " 
							  + apart.aptHead
							  + " | 연락처 : " 
							  + formatTel(apart.aptTel));
			}
		},error:function(xhr){
			console.log(xhr.status);
		}
	});
	
	
});

</script>


        