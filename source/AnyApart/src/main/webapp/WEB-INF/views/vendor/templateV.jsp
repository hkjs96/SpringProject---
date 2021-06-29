<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<style>
	.inimg {
		width: 60px;
		height: 40px;
	}
</style>
<html lang="ko">
	<head>
    <meta charset="utf-8">
    <title>AnyApart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="author" content="" />
	<tiles:insertAttribute name="preScriptV"/>
   </head>
	<body>
	<tiles:insertAttribute name="topMenuV"/>  
        	<tiles:insertAttribute name="contentsV"/>
    <tiles:insertAttribute name="footerV"/>
    
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
