<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<!-- footer close -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${pageContext.request.contextPath }/js/digitalmarketing/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/js/digitalmarketing/js/menumaker.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/digitalmarketing/js/jquery.sticky.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/digitalmarketing/js/sticky-header.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/digitalmarketing/js/owl.carousel.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/digitalmarketing/js/slider.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script> -->
<!-- 이미정 : 입주민 사이트 폰트 적용  -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<!-- 입주민 사이트 폰트 적용 끝 -->

<style>
#footer{
	background-color: #FBFAF8;
	padding-top: 15px;
	margin-bottom: 0px;
	padding-bottom: 0px;
	margin-left: 0;
	width: 100%;
}

.footer-title{
	margin-bottom: 25px;
	color: #F8A998;
	font-size: 16px;
	font-weight: bold;
}
.footer-widget ul {
    margin-bottom: 0px;
    font-weight: bold;
}
.footer-widget ul li {
	margin-top: 5em;
    margin-bottom: 15px;
	font-size: 16px;
	float: left;
	margin-left: 100px;
}
.col-lg-12{
	background-color: #F8F9FA;
}

.footer-widget{
	margin-left: 8em;
}
/*
입주민 사이트 폰트 적용 
Nanum Gothic', sans-serif
 */
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, details, figcaption, figure, dialog,
footer, header, hgroup, menu, nav, section {margin: 0; padding: 0; border: 0;}
article, aside, details, figcaption, figure, dialog,
footer, header, hgroup, menu, nav, section {display: block;}
html, body {
    font-family: 'Nanum Gothic', sans-serif;
}

h1, h2, h3, h4, h5, h6, thead, th{
	font-weight: bold;
}
/* 입주민 사이트 폰트 적용 끝  */

</style>

<div class="footer" id="footer">
<div class="containerDiv ">
		<!-- footer-useful links-start -->
		<div class=" col-lg-12 ">
			<div class="footer-widget">
				<div id="aptInfo">
					<ul>
						<li><span id="aptName" class="footer-title mr-4"></span></span></li> 
						<li><i class="fa fa-map-marker"></i><span id="aptAddr"></span></li> 
						<li><i class="fa fa-phone"></i><span id="aptTel"></span></li>
						<li><i class="glyphicon glyphicon-user"></i><span id="aptHead"></span></li>
						<li>Copyright 2021 AnyApart CORP. ALL RIGHTS RESERVED.</li>
					</ul>
				</div>
			</div>
		
<!-- 		footer-contactinfo-close -->
<!-- 		footer-about-start -->
<!-- 		<div class="col-lg-5 col-md-5 col-sm-5 col-xs-12 "> -->
<!-- 			<div class="footer-widget" style="margin-left: 50px;"> -->
<!-- 				<h3 class="footer-title">관련 사이트</h3> -->
<!-- 				<div class=""> -->
<!-- 					<ul> -->
<%-- 						<li><i class="glyphicon glyphicon-cloud"></i><a href="${cPath}/vendor">벤더사이트</a></li> --%>
<%-- 						<li><i class="glyphicon glyphicon-user"></i><a href="${cPath}/office">관리사무소 사이트</a></li> --%>
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
</div>
</div>
	
	
<script>
/**
 * footer하단 관리사무소 정보 출력해줌
 * @author 이미정
 */
$(function(){
	let aptCode = '<c:out value="${authMember.aptCode }"/>';
	
	$.ajax({
		url:"${cPath }/resident/employee/setting/apartView.do"
		,data : {"aptCode" : aptCode}
		,method : "get"
		,success : function(resp){
			if(resp.message){
				getNoty(resp);
				return;
			}else{
				let apart = resp.apart;
				$("#aptName").text(apart.aptName);
				$("#aptAddr").text("("
							  + apart.aptZip 
							  + ") " 
							  + apart.aptAdd1 
							  + " "
							  + apart.aptAdd2);
				$("#aptTel").text(formatTel(apart.aptTel));
				$("#aptHead").text(" 대표자 : " 
						  	+ apart.aptHead
				);
			}
		},error:function(xhr){
			console.log(xhr.status);
		}
	});
	
	
});

</script>	
