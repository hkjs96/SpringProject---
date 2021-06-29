<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Bootstrap -->
<link href="${pageContext.request.contextPath }/js/digitalmarketing/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/js/digitalmarketing/css/bootstrap-table.css" rel="stylesheet"> <!-- 이경륜: table용 부트스트랩 -->
<!-- Style CSS -->
<link href="${pageContext.request.contextPath }/js/digitalmarketing/css/style.css" rel="stylesheet">
<!-- Google Fonts -->
<!-- <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet"> -->
<!-- FontAwesome CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/digitalmarketing/css/fontello.css">
<link href="${pageContext.request.contextPath }/js/digitalmarketing/css/font-awesome.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/js/digitalmarketing/css/owl.carousel.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/js/digitalmarketing/css/owl.theme.default.css" rel="stylesheet">

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


<!-- 박찬: 입주민 홈페이지  -->
<link rel="shortcut icon" type="image/x-icon" href="../ico/ico.ico">
<link rel="apple-touch-icon" href="../ico/ico.ico">

<link rel="stylesheet" type="text/css" href="${cPath }/css/resident/maincss/theartpixel.css">
<link rel="stylesheet" type="text/css" href="${cPath }/css/resident/maincss/menu.css">

<link rel="stylesheet" type="text/css" href="${cPath }/css/resident/maincss/motion.css">
<link rel="stylesheet" href="${cPath }/css/resident/maincss/swiper.min.css">

<!--제이쿼리 설치 CDN-->
<script src="${cPath }/js/resident/min.js"></script>
<script type="text/javascript" charset="UTF-8" src="${cPath }/js/resident/gnb-main.js"></script>
<script type="text/javascript" charset="UTF-8" src="${cPath }/js/resident/gnb-main2.js"></script>
<script src="${cPath }/js/resident/global.js"></script>
<script src="${cPath }/js/resident/app.js"></script>
<script src="${cPath }/js/resident/tm.min.js" type="text/javascript" charset="utf-8"></script>
<!-- 박찬: 입주민 홈페이지  end-->


<!-- 박찬: chartJs 시작-->
<script src="${pageContext.request.contextPath }/js/chartjs/Chart.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/js/chartjs/Chart.min.js"></script>
<!-- 박찬: chartJs 끝-->

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

<style type="text/css">
.residentContent{
	padding-top: 50px;
	padding-left: 200px;
	padding-right: 200px;
}	
.content-container{
	padding-top: 50px;
	padding-left: 200px;
	padding-right: 200px;
}
/* 박정민 
 * 검색조건 가운데정렬
*/
#inputUI{
	margin-left: 25%;
}
.table {
  width: 100%;
  margin-bottom: 1rem;
  color: #212529;
}
.table th,
.table td {
  padding: 0.75rem;
  vertical-align: top;
  border-top: 1px solid #dee2e6;
}
.table thead th {
  vertical-align: bottom;
  border-bottom: 2px solid #dee2e6;
}
.table tbody + tbody {
  border-top: 2px solid #dee2e6;
}

.table-sm th,
.table-sm td {
  padding: 0.3rem;
}

.table-bordered {
  border: 1px solid #dee2e6;
}
.table-bordered th,
.table-bordered td {
  border: 1px solid #dee2e6;
}
.table-bordered thead th,
.table-bordered thead td {
  border-bottom-width: 2px;
}

.table-borderless th,
.table-borderless td,
.table-borderless thead th,
.table-borderless tbody + tbody {
  border: 0;
}

.table-striped tbody tr:nth-of-type(odd) {
  background-color: rgba(0, 0, 0, 0.05);
}

.table-hover tbody tr:hover {
  color: #212529;
  background-color: rgba(0, 0, 0, 0.075);
}

.table-primary,
.table-primary > th,
.table-primary > td {
  background-color: #b8daff;
}
.table-primary th,
.table-primary td,
.table-primary thead th,
.table-primary tbody + tbody {
  border-color: #7abaff;
}

.table-hover .table-primary:hover {
  background-color: #9fcdff;
}
.table-hover .table-primary:hover > td,
.table-hover .table-primary:hover > th {
  background-color: #9fcdff;
}

.table-secondary,
.table-secondary > th,
.table-secondary > td {
  background-color: #d6d8db;
}
.table-secondary th,
.table-secondary td,
.table-secondary thead th,
.table-secondary tbody + tbody {
  border-color: #b3b7bb;
}

.table-hover .table-secondary:hover {
  background-color: #c8cbcf;
}
.table-hover .table-secondary:hover > td,
.table-hover .table-secondary:hover > th {
  background-color: #c8cbcf;
}

.table-success,
.table-success > th,
.table-success > td {
  background-color: #c3e6cb;
}
.table-success th,
.table-success td,
.table-success thead th,
.table-success tbody + tbody {
  border-color: #8fd19e;
}

.table-hover .table-success:hover {
  background-color: #b1dfbb;
}
.table-hover .table-success:hover > td,
.table-hover .table-success:hover > th {
  background-color: #b1dfbb;
}

.table-info,
.table-info > th,
.table-info > td {
  background-color: #bee5eb;
}
.table-info th,
.table-info td,
.table-info thead th,
.table-info tbody + tbody {
  border-color: #86cfda;
}

.table-hover .table-info:hover {
  background-color: #abdde5;
}
.table-hover .table-info:hover > td,
.table-hover .table-info:hover > th {
  background-color: #abdde5;
}

.table-warning,
.table-warning > th,
.table-warning > td {
  background-color: #ffeeba;
}
.table-warning th,
.table-warning td,
.table-warning thead th,
.table-warning tbody + tbody {
  border-color: #ffdf7e;
}

.table-hover .table-warning:hover {
  background-color: #ffe8a1;
}
.table-hover .table-warning:hover > td,
.table-hover .table-warning:hover > th {
  background-color: #ffe8a1;
}

.table-danger,
.table-danger > th,
.table-danger > td {
  background-color: #f5c6cb;
}
.table-danger th,
.table-danger td,
.table-danger thead th,
.table-danger tbody + tbody {
  border-color: #ed969e;
}

.table-hover .table-danger:hover {
  background-color: #f1b0b7;
}
.table-hover .table-danger:hover > td,
.table-hover .table-danger:hover > th {
  background-color: #f1b0b7;
}

.table-light,
.table-light > th,
.table-light > td {
  background-color: #fdfdfe;
}
.table-light th,
.table-light td,
.table-light thead th,
.table-light tbody + tbody {
  border-color: #fbfcfc;
}

.table-hover .table-light:hover {
  background-color: #ececf6;
}
.table-hover .table-light:hover > td,
.table-hover .table-light:hover > th {
  background-color: #ececf6;
}

.table-dark,
.table-dark > th,
.table-dark > td {
  background-color: #c6c8ca;
}
.table-dark th,
.table-dark td,
.table-dark thead th,
.table-dark tbody + tbody {
  border-color: #95999c;
}

.table-hover .table-dark:hover {
  background-color: #b9bbbe;
}
.table-hover .table-dark:hover > td,
.table-hover .table-dark:hover > th {
  background-color: #b9bbbe;
}

.table-active,
.table-active > th,
.table-active > td {
  background-color: rgba(0, 0, 0, 0.075);
}

.table-hover .table-active:hover {
  background-color: rgba(0, 0, 0, 0.075);
}
.table-hover .table-active:hover > td,
.table-hover .table-active:hover > th {
  background-color: rgba(0, 0, 0, 0.075);
}

.table .thead-dark th {
  color: #fff;
  background-color: #343a40;
  border-color: #454d55;
}
.table .thead-light th {
  color: #495057;
  background-color: #e9ecef;
  border-color: #dee2e6;
}

.table-dark {
  color: #fff;
  background-color: #343a40;
}
.table-dark th,
.table-dark td,
.table-dark thead th {
  border-color: #454d55;
}
.table-dark.table-bordered {
  border: 0;
}
.table-dark.table-striped tbody tr:nth-of-type(odd) {
  background-color: rgba(255, 255, 255, 0.05);
}
.table-dark.table-hover tbody tr:hover {
  color: #fff;
  background-color: rgba(255, 255, 255, 0.075);
}

@media (max-width: 575.98px) {
  .table-responsive-sm {
    display: block;
    width: 100%;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }
  .table-responsive-sm > .table-bordered {
    border: 0;
  }
}
@media (max-width: 767.98px) {
  .table-responsive-md {
    display: block;
    width: 100%;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }
  .table-responsive-md > .table-bordered {
    border: 0;
  }
}
@media (max-width: 991.98px) {
  .table-responsive-lg {
    display: block;
    width: 100%;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }
  .table-responsive-lg > .table-bordered {
    border: 0;
  }
}
@media (max-width: 1199.98px) {
  .table-responsive-xl {
    display: block;
    width: 100%;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }
  .table-responsive-xl > .table-bordered {
    border: 0;
  }
}
.table-responsive {
  display: block;
  width: 100%;
  overflow-x: auto;
  -webkit-overflow-scrolling: touch;
}
.table-responsive > .table-bordered {
  border: 0;
}

</style>