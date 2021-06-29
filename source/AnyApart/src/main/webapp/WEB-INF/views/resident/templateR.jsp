<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Digital marketing courses website template that can help you boost your business courses website and its completely free.">
    <meta name="keywords" content="seo,free website template, free responsive website template, seo marketing, search engine optimization, web analytics">
    <title>입주민 사이트</title>
		<tiles:insertAttribute name="preScript"/>  
	<style type="text/css">
	/* 	상단 색상 변경 */
	.bg-default{
		background-color: #FDA28F;
	}
	#navigation ul ul li:hover > a, #navigation ul ul li a:hover {
	    color: #fff;
	    background-color: #FB8F78;
	}
	.counter-title {
	    font-weight: 600;
	}
	.container{
		margin: 0 15%;
		width: 100%;
	}
	.row{
		width: 80%;
	}
	#quickMenuDiv tr{
		height: 80px;
		text-align: center;
		font-size: 0.8em;
		font-weight: bolder;
		background-color: #FAFAFA;
	}
	#quickMenuDiv tr:nth-child(1){
		height: 15px;
		background-color: #535353;
		color: #F8F8F8;
	}
	#quickMenuDiv img{
		width: 70px;
		height: 65px;
	}
	</style>	
    </head>
    <body>
	<tiles:insertAttribute name="topMenu"/>  
		<!------------------  content  ---------------------------->
		<div class="space-medium">
			<div class="container">
				<div class="row" id="rowDiv">
					<div class="col-md-10">
			            <tiles:insertAttribute name="contents"/>  
					</div>
					<div class="col-md-1"></div>
				<!--------------------------	퀵메뉴 ------------------------------>
					<div class="col-md-1" id="quickMenuDiv" style="padding-left: 0;">
						<table class="table table-bordered">
							<tr>
								<td>퀵메뉴</td>
							</tr>
							<tr>
								<td>관리비 조회
									<a href="${cPath }/resident/maintenanceCost/feeView.do"><img src="${cPath }/images/quickApart.png"></a>
								</td>
							</tr>
							<tr>
								<td>공지사항
									<a href="${cPath }/resident/notice/noticeList.do"><img src="${cPath }/images/quickNotice.png"></a>
								</td>
							</tr>
							<tr>
								<td>문의하기
									<a href="${cPath }/resident/officeQna/officeQnaList.do"><img src="${cPath }/images/quickQna.png"></a>
								</td>
							</tr>
							<tr>
								<td>아파트소식
									<a href="${cPath }/resident/notice/apartNewsList.do"><img src="${cPath }/images/quickCalendar.png"></a>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
           
	<tiles:insertAttribute name="footer"/>
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