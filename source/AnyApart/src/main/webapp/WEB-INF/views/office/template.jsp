<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.  박정민      최초작성
* 2021. 2. 18.  이경륜      footer copyright AnyApart로 변경함
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리사무소</title>
	<tiles:insertAttribute name="preScript" />
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<style>
		*{
		    font-family: 'Nanum Gothic', sans-serif;
			font-weight: bold;
		}
		.btn{
		    font-family: 'Nanum Gothic', sans-serif;
			font-weight: bold;
		}
		a:hover, a:link, a{
			color:black;
		}
	</style>
</head>
<body class="sb-nav-fixed">
	<tiles:insertAttribute name="topMenu" />

	<tiles:insertAttribute name="leftMenu" />

	<!------------------  content  ---------------------------->
	<div id="layoutSidenav_content">
		<main>
		<div class="container-fluid">

			<tiles:insertAttribute name="contents" />
		</div>
		</main>
	</div>
	</div>
	<tiles:insertAttribute name="footer" />
	<!-- 이경륜: noty 띄우기 위한 코드 -->
	<c:if test="${not empty message }">
		<script type="text/javascript">
					new Noty({
						 text:'${message.text }', 
						 layout: '${message.layout }',
						 type: '${message.type }',
						 timeout: ${message.timeout },
						 progressBar: true
					}).show();
				</script>
	</c:if>
	<!-- 이경륜: noty 코드 끝 -->
</body>
</html>


