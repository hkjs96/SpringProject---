<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<table class="table">
	<tr>
		<th class="text-center">제목</th>
		<td class="pb-1">${board.boTitle }</td>
	</tr>
	<tr>
		<th class="text-center">작성자</th>
		<td class="pb-1">${board.boWriter }</td>
	</tr>
	<tr>
		<th class="text-center">작성일</th>
		<td class="pb-1">${board.boDate }</td>
	</tr>
	<tr>
		<th class="text-center">조회수</th>
		<td class="pb-1">${board.boHit }</td>
	</tr>
	<tr>
		<th class="text-center">첨부파일</th>
		<td class="pb-1">
			<c:if test="${not empty board.attachList }">
				<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
					<c:choose>
						<c:when test="${attach.attFilesize eq 0 }">
							등록된 파일이 없습니다.
						</c:when>
						<c:when test="${attach.attFilesize ne 0 }">
							<c:url value="/board/download.do" var="downloadURL">
								<c:param name="attSn" value="${attach.attSn }" />
								<c:param name="boNo" value="${attach.boNo }" />
							</c:url>
							
							<img src="${cPath }/js/main/img/common/file.png"/>
							<a href="${downloadURL }">
								<span title="다운로드:">${attach.attFilename }</span>
								${not vs.last?"|":"" }
							</a>
						</c:when>
					</c:choose>
				</c:forEach>		
			</c:if>
		</td>
	</tr>
	<tr>
		<th class="text-center">내용</th>
		<td class="pb-1">${board.boContent }</td>
	</tr>
	<tr>
		<td colspan="2" class="text-center">
			<c:url value="/resident/space/boardUpdate.do" var="updateURL">
				<c:param name="boNo" value="${board.boNo }" />
			</c:url>
			<a class="btn btn-primary" href="${updateURL }">수정</a>
			<input type="button" value="삭제" class="btn btn-danger" id="removeBtn" />
			<c:if test="${board.boDepth eq 1}">
			<input type="button" value="답글쓰기" class="btn btn-warning" id="answerBtn" data-bo-no="${board.boNo }"/>
			</c:if>
			<a class="btn btn-success" href="${cPath }/resident/space/boardList.do">목록으로</a>
		</td>
	</tr>
</table>
<h4>댓글</h4>
<!-- 리플 등록 -->
<form:form commandName="reply" id="replyInsertForm" method="post">
	<!-- 세션아이디로 수정 -->
	<input type="hidden" name="boNo" value="${board.boNo }"/>
	<input type="hidden" name="repWriter" value="A0001R00001"/>
	<table class="table table-bordered">
		<tr>
			<th colspan="2" class="text-center">내용</th>
		</tr>
		<tr>
			<td class="pb-1">
				<textarea class="form-control" required name="repContent">${reply.repContent}</textarea>
				<span class="error">${errorsRep.repContent }</span>
			</td>
			<td class="pb-1">
				<input type="button" id="replyInsertBtn" class="btn btn-primary" value="등록"/>
			</td>
		</tr>
	</table>
</form:form>

<table id="replyTable" class="table table-bordered">
	<thead class="thead-light">
		<tr>	
			<th class="text-center">내용</th>
			<th class="text-center">작성자</th>
			<th class="text-center">작성일</th>
			<th class="text-center">&nbsp;</th>
		</tr>
	</thead>
	<tbody id="listBody">
		<c:set var="replyList" value="${board.replyList }" />
		<c:if test="${not empty replyList }" >
			<c:forEach items="${replyList }" var="reply" varStatus="vs">
				<tr>
		  			<td>${reply.repContent }</td>
		  			<td>${reply.repWriter }</td>
		  			<td>${reply.repDate }</td>
		  			<td>버튼들어갈자리</td>
		  		</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty replyList }">
			<tr>
				<td colspan="4">등록된 댓글이 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<form id="boardDeleteForm" method="post" action="${cPath }/resident/space/boardDelete.do">
	<input type="hidden" name="boNo" value="${board.boNo }" />
</form>



<script>
	//삭제
	let boardDeleteForm = $("#boardDeleteForm");
	let removeBtn = $("#removeBtn").on("click", function(){
		if(confirm("정말 삭제하시겠습니까?"))	boardDeleteForm.submit();
	});

	//답글쓰기
	let answerBtn = $("#answerBtn").on("click", function(){
		let boNo = $(this).data("boNo");
		location.href="${cPath}/resident/space/boardInsert.do?parent="+boNo;
	});
</script>