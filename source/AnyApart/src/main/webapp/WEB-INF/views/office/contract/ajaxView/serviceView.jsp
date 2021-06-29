<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
#flip{
	background-image: url("${cPath }/css/office/folderImage.png");
	background-repeat:no-repeat;
	background-position: center;
	background-size: 100%;
	height: 60px;
}
#foter{
	background-image: url("${cPath }/css/office/folderfooter.png");
	background-repeat:no-repeat;
	background-position: center;
	background-size: 100%;
	height: 25px;
}
#panel, #flip {
	padding: 5px;
	background-color: white;
}

#panel {
	background-image: url("${cPath }/css/office/foldercenter.png");
	background-position: center;
	background-size: 100%;
	padding: 3px;
	display: none; . filebox input[type="file"] { position : absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

}
</style>

<c:set value="${serviceView }" var="service"></c:set>
<div style="width:80%; float: left;" >
<table class="table" id="listBody">
		<thead class="thead-light" >
				<tr id="svcId" data-contract="${serviceView.svcId}">
					<th style="text-align: center;" colspan="4"><h4>[${service.svcName }]의 계약 정보</h4></th>
				</tr>
			<tr>
				<th style="text-align: center;" colspan="4" >아파트</th>
			<tr>
			<tr>
				<th scope="col">아파트명</th>
				<td>${service.aptName }</td>
				<th scope="col">업종코드</th>
				<td>${service.svcCode}</td>
			</tr>
			<tr>
				<th style="text-align: center;" colspan="4" >계약정보</th>
			</tr>
			<tr>
				<th scope="col">계약금</th>
				<td>월 <fmt:formatNumber value="${service.svcDeposit}" pattern="#,###" />원</td>
			</tr>
			<tr>
			<th scope="col">계약 시작일</th>
				<td>${service.svcStart}</td>
				<th scope="col">계약 만료일</th>
				<td>${service.svcEnd}</td>
				</tr>
			<tr>
	        <tr>
	        	<th scope="col">은행</th>
		        <td>${service.svcBank }</td>
		        <th scope="col">계좌번호</th>
		        <td>${service.svcAcct }</td>
	        </tr>
	        <tr> 
  				<th style="text-align: center;" colspan="4" >업체 정보</th>
	        </tr>
			<tr>
		        <th scope="col">업체명</th>
		        <td>${service.svcName }</td>
		        <th scope="col">업체 우편번호</th>
		        <td>${service.svcZip }</td>
	        </tr>
	        <tr>
  				    <th scope="col">업체 주소</th>
		        <td colspan="2">${service.svcAdd1 } ${service.svcAdd2 }</td>
	        </tr>
            <tr>
  				    <th scope="col">업체 대리인</th>
		        <td>${service.svcHead }</td>
		        <th scope="col">업체 대리인 연락처</th>
		        <td id="telNumber">0<fmt:formatNumber value="${service.svcHeadTel }" pattern="###,####,####" /></td>
	        </tr>
		</thead>
		<tbody>
		</tbody>
</table>
</div>
<div style="width: 20%; float: right;">
	<c:set value="${fileList }" var="fileList"></c:set>
		<div>
			<div id="flip"></div>
			<div id="panel">
					<c:if test="${not empty fileList }">
					<c:forEach items="${fileList }" var="file" varStatus="vs">
						<div id="fileView">
						</div>
						<c:choose>
							<c:when test="${empty file.svcFilesize}">
							파일이 존재하지 않습니다.
							</c:when>					
							<c:when test="${not empty file.svcFilesize}">
									<c:url value="/office/servicecompany/servicedownload.do" var="downloadURL">
										<c:param name="svcFileNo" value="${file.svcFileNo }" />
										<c:param name="svcId" value="${file.svcId}" />
									</c:url>
									<img src="${cPath }/js/main/img/common/file.png" style="margin-left: 10%;"/>
									<a href="${downloadURL }">
										<span title="다운로드:">${file.svcFilename }</span>
									</a>
							</c:when>						
						</c:choose>
					</c:forEach>		
				</c:if>
			</div>
			<div id="foter"></div>
		</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#panel").slideDown("slow");
	
	$("#flip").click(function(){
	    $("#panel").slideToggle();
	  });
	});
	$("#uploadForm").submit(function(){
		$(this).ajaxSubmit(option);
		return false;
	});
	var telNumber = $("#telNumber").text();
	var telNumberReplace = telNumber.replaceAll(',','-');
	
	$("#telNumber").text(telNumberReplace);
	</script>
