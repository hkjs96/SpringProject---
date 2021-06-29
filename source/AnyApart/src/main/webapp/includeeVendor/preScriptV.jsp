<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 박정민: Bootstrap 시작-->
<link href="${pageContext.request.contextPath }/js/startbootstrap-sb-admin-gh-pages/dist/css/styles.css" rel="stylesheet" />
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

<!-- 박찬: 디자인관련 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/js/main/css/front_20200803.css" />
<link rel="shortcut icon" href="${pageContext.request.contextPath }/js/main/img/favicon/favicon.ico">
<!-- 박찬: 디자인관련 끝-->

<style>
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
<!-- 이경륜: 공통 js 함수 -->
<script type="text/javascript" src="${cPath }/js/anyapartUtil.js"></script>
<!-- 이경륜: 공통js 함수 끝 -->

<script type="text/javascript">
	// 이경륜: 별도 js파일에서 cPath 사용하기 위한 함수
	$.getContextPath = function(){
		return "${cPath }";
	}
	// 이경륜: jquery validator 사용시 한국어 나오게 하는 설정..이 잘 안되서 우선 ko로 위에서 로딩시킴
// 	const language = "${pageContext.response.locale.language }";
// 	if(language != "en")
// 	$.getScript($.getContextPath()+`/js/jquery-validation-1.19.2/localization/messages_\${language}.min.js`);
</script>



