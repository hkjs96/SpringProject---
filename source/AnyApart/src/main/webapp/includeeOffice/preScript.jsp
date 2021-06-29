<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.  박정민      최초작성
* 2021. 2.  9.  이경륜	aptCode -> loginAptCode 상수명변경
* 2021. 2.  9.  박지수     데이터테이블 추가
* 2021. 2.  9.  이경륜     데이터테이블 주석처리, css추가
* 2021. 2. 20.  이경륜   이중모달 닫았을때 기존모달 정상작동하게하는코드 추가
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 박정민: bootstrap 시작-->
<link href="${pageContext.request.contextPath }/js/startbootstrap-sb-admin-gh-pages/dist/css/styles.css" rel="stylesheet" />
<!-- <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" /> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
<!-- 박정민: bootstrap 끝 -->

<!-- 이경륜: jquery, ajaxForm, asyncForm 추가 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/asyncForm.js"></script>
<!-- 이경륜: jquery 관련파일 끝 -->

<!-- 이경륜: noty 추가 -->
<link rel="stylesheet" href="${cPath }/js/noty-3.1.4/noty.css">
<script type="text/javascript" src="${cPath }/js/noty-3.1.4/noty.min.js"></script>
<!-- 이경륜: noty 끝 -->

<!-- 이경륜: jquery validator 추가 -->
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/jquery.validate.min.js"></script>
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/additional-methods.min.js"></script>
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/localization/messages_ko.min.js"></script>
<!-- 이경륜: jquery validator 끝 -->

<!-- 이경륜: 공통 js 함수 -->
<script type="text/javascript" src="${cPath }/js/anyapartUtil.js"></script>
<!-- 이경륜: 공통js 함수 끝 -->

<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal"/>
	<c:set var="authMember" value="${principal.realMember }" />
</security:authorize>
<style>
/* 이경륜: noty 사이즈 키울 예정*/
/* .noty_layout > .noty_bar { */
/*     height: 150px; */
/*     font-size: 15px; */
/* } */

/* 이경륜: 페이징 스타일 통일 */
.pagination li.active span.page-link {
	border-color:#dee2e6;
	background-color:#343a40;
}
.pagination li.page-item a.page-link {
	border-color:#dee2e6; color:gray;
	background-color: #ffffff;
}
</style>
<script type="text/javascript">
	// 이경륜: 별도 js파일에서 cPath 사용하기 위한 함수
	$.getContextPath = function(){
		return "${cPath }";
	}
   
	// 이경륜: authMember에서 불러온 아파트코드 얻는 함수
	$.getAptCode = function() {
		let memId = "${authMember.memId}";
		return memId.substr(0,5);
	}
   
	const loginAptCode = $.getAptCode();
	// 이경륜: jquery validator 사용시 한국어 나오게 하는 설정..이 잘 안되서 우선 ko로 위에서 로딩시킴
// 	const language = "${pageContext.response.locale.language }";
// 	if(language != "en")
// 	$.getScript($.getContextPath()+`/js/jquery-validation-1.19.2/localization/messages_\${language}.min.js`);

	// 이경륜: 이중으로 뜬 모달 닫았을 때 기존 모달 정상적으로 작동하게하는 코드
	$(document).on('hidden.bs.modal', function (event) {
		if ($('.modal:visible').length) {
			$('body').addClass('modal-open');
		}
	});
	
	// 이경륜 : 카드탭 a링크이벤트방지
	$('a[href="#"]').click(function(e) {
		e.preventDefault();
	});
</script>

<!-- 박지수 : 데이터 테이블 / 이경륜: 해당페이지에서 로드시키기로해서 주석함 -->
<%-- <link rel="stylesheet" type="text/css" href="${cPath }/js/DataTables/datatables.min.css"/> --%>
<%-- <script type="text/javascript" src="${cPath }/js/DataTables/datatables.min.js"></script> --%>

<style>
	/* 이경륜: 필수입력값 *표시 빨간글씨, 에러 빨간글씨 */
	.reddot, .error{
		color: red;
	}

	/* 이경륜: readonly 백그라운드 컬러 */
	input:read-only, textarea:read-only {
		background-color: #ccc;
	}
</style>

