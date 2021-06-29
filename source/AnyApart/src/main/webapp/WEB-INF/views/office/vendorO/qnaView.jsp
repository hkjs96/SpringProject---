<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<div class="container">
	<br>
	<h4><strong>Q&A</strong></h4>
	<br>
	 <table class="table table-bordered">
		<tr>
			<td class="text-center table-dark">글번호</td>
			<td class="text-center">${board.boNo }</td>
			<td class="text-center table-dark">작성자</td>
			<td class="text-center">${board.boWriter }</td>
		</tr>
		<tr>
			<td class="text-center table-dark">조회수</td>
			<td class="text-center">${board.boHit }</td>
			<td class="text-center table-dark">작성일</td>
			<td class="text-center">${board.boDate }</td>
		</tr>
		<tr>
			<td class="text-center table-dark">제목</td>
			<td colspan="3">${board.boTitle }</td>
		</tr>
		<tr>
			<td class="text-center align-middle table-dark" style="height:500px;">내용</td>
			<td colspan="3">${board.boContent }</td>
		</tr>
				<tr>
			<td class="text-center table-dark">첨부파일</td>
			<td colspan="3">
				<c:if test="${not empty board.attachList }">
					<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
						<c:url value="/board/download.do" var="downloadURL">
							<c:param name="attSn" value="${attach.attSn }" />
							<c:param name="boNo" value="${attach.boNo }" />
						</c:url>
						
						<img src="${cPath }/js/main/img/common/file.png"/>
						<a href="${downloadURL }">
							<span title="다운로드:">${attach.attFilename }</span>
							${not vs.last?"|":"" }
						</a>
					</c:forEach>		
				</c:if>
				
			</td>
		</tr>
	</table>   
	<div class="d-flex justify-content-center">
        <security:authentication property="principal" var="principal" />
        <c:set var="authMember" value="${principal.realMember }" />
		<c:if test="${board.boWriter eq authMember.memNick }">
			<input type="button" value="수정" class="btn btn-dark" id="updateBtn"/>
			<input type="button" value="삭제" class="btn btn-dark" id="removeBtn" />
		</c:if>
		<c:url value="/office/qna/qnaList.do" var="listURL">
			<c:param name="page" value='${pagingVO.currentPage}' />
			<c:param name="boType" value='${pagingVO.searchDetail.boType}' />
			<c:param name="searchType" value='${pagingVO.searchVO.searchType }' />
			<c:param name="searchWord" value='${pagingVO.searchVO.searchWord }' />
		</c:url>
		<input type="button" value="목록" class="btn btn-dark" id="ListBtn"
			onclick="location.href='${listURL }';">
<%-- 			onclick="location.href='${cPath }/office/qna/qnaList.do';"> --%>

		<c:url value="/office/qna/qnaDelete.do" var="deleteURL">
			<c:param name="boNo" value="${board.boNo }" />
			<c:param name="page" value='${pagingVO.currentPage}' />
			<c:param name="boType" value='${pagingVO.searchDetail.boType}' />
			<c:param name="searchType" value='${pagingVO.searchVO.searchType }' />
			<c:param name="searchWord" value='${pagingVO.searchVO.searchWord }' />
		</c:url>
	</div>
</div>
<form id="fm"></form>
<script>
// 	let fm = $("#fm");
	let updateBtn = $("#updateBtn").on("click", function() {
// 		fm.attr("action", "${cPath }/office/qna/qnaUpdate.do?boNo=${board.boNo }");
// 		fm.submit();
		location.href="${cPath }/office/qna/qnaUpdate.do?boNo=${board.boNo }";
	});
	
	let removeBtn = $("#removeBtn").on("click", function(){
		var result = confirm("삭제하시겠습니까 ?");
		
		if(result)
	    {
			location.href="${deleteURL }";
	    }
	});
</script>
