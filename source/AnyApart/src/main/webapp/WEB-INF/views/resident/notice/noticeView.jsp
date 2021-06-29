<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 26.      이미정       최초작성
* 2021. 2. 15.      이미정       기존 코드 보완
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	tr:last-child{
		height: 300px;
	}
	
	.content{
		height:200px;
	}
	
	.title{
		text-align: center;
		font-weight: bold;
		color: #4C4C4C;
	}
</style>
<table class="table">
		<tr>
			<td width="25%" class="title">글번호</td>
			<td width="25%">${board.boNo }</td>
			<td width="25%" class="title" >작성자</td>
			<td width="25%">${board.boWriter }</td>
		</tr>
		<tr>
			<td class="title">조회수</td>
			<td>${board.boHit }</td>
			<td class="title">작성일</td>
			<td>${board.boDate }</td>
		</tr>
		<tr>
			<td class="title">제목</td>
			<td colspan="3">${board.boTitle }</td>
		</tr>
		<tr>
			<td class="title">내용</td>
			<td colspan="3" class="content">${board.boContent }</td>
		</tr>
				<tr>
			<td class="title">첨부파일</td>
			<td colspan="3">
				<c:if test="${not empty board.attachList }">
					<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
						<c:url value="/board/download.do" var="downloadURL">
							<c:param name="attSn" value="${attach.attSn }" />
							<c:param name="boNo" value="${attach.boNo }" />
						</c:url>
						<a href="${downloadURL }">
							<span title="다운로드:">${attach.attFilename }</span>
							${not vs.last?"|":"" }
						</a>
					</c:forEach>		
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="4" class="text-center">
				<form id="listForm" action="${cPath }/resident/notice/noticeList.do" method="GET">
					<input type="hidden" class="form-control" name="page" value="${param.page }"/>
					<input type="hidden" class="form-control" name="searchType" value="${param.searchType }"/>
					<input type="hidden" class="form-control" name="searchWord" value="${param.searchWord }"/>
					<input type="submit" value="목록" class="btn btn-success" id="listBtn">
				</form>
			</td>
		</tr>
	</table>   
