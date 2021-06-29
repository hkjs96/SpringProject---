<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 09.  박지수      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div id="container">
	<div class="inner">
		<!-- 공지사항 -->
		<div class="board-view">
			<div class="title">
				<strong>${board.boTitle }</strong>
				<div align="left">
					<span><img src="${cPath }/js/main/img/common/ico_user.png" alt="">
<%-- 							${board.boWriter } --%>
							${board.aptName }
					</span>
					<span><img src="${cPath }/js/main/img/common/ico_date.png" alt="">${board.boDate }</span>
					<span>조회수:${board.boHit }</span>
				</div>
			</div>

			<c:if test="${not empty board.attachList }">
				<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
					<c:choose>

						<c:when test="${attach.attFilesize eq 0 }">

						</c:when>

						<c:when test="${attach.attFilesize ne 0 }">
							<div align="right">
								첨부파일
								<c:url value="/board/download.do" var="downloadURL">
									<c:param name="attSn" value="${attach.attSn }" />
									<c:param name="boNo" value="${attach.boNo }" />
								</c:url>

								<img src="${cPath }/js/main/img/common/file.png" />
								<a href="${downloadURL }">
									<span title="다운로드:">${attach.attFilename }</span>
									${not vs.last?"</br>":"" }
								</a>
							</div>
						</c:when>


					</c:choose>
				</c:forEach>
			</c:if>

		</div>
		<div class="txt-box">${board.boContent }</div>
	</div>
	<div class="board-btns">
		<c:url value="/vendor/qna/qnaList.do" var="listURL">
			<c:param name="page" value='${pagingVO.currentPage}' />
			<c:param name="boType" value='${pagingVO.searchDetail.boType}' />
			<c:param name="searchType" value='${pagingVO.searchVO.searchType }' />
			<c:param name="searchWord" value='${pagingVO.searchVO.searchWord }' />
		</c:url>
		<c:if test="${1 eq board.boDepth and empty board.answerFlag}">
			<c:url value="/vendor/qna/qnaInsert.do" var="insertURL">
				<c:param name="boNo" value="${board.boNo }" />
			</c:url>
			<input class="btn btn-green" type="button" value="답글" onclick="location.href='${insertURL}'">
		</c:if>
		<c:if test="${2 eq board.boDepth }">
			<c:url value="/vendor/qna/qnaUpdate.do" var="updateURL">
				<c:param name="boNo" value="${board.boNo }" />
			</c:url>
			<input class="btn btn-blue" type="button" value="수정" onclick="location.href='${updateURL}'">
		</c:if>
		<c:url value="/vendor/qna/qnaDelete.do" var="deleteURL">
			<c:param name="boNo" value="${board.boNo }" />
			<c:param name="page" value='${pagingVO.currentPage}' />
			<c:param name="boType" value='${pagingVO.searchDetail.boType}' />
			<c:param name="searchType" value='${pagingVO.searchVO.searchType }' />
			<c:param name="searchWord" value='${pagingVO.searchVO.searchWord }' />
		</c:url>
		<input id="deleteBtn" class="btn btn-red" type="button" value="삭제" onclick="deleteBoard('${deleteURL}')">
		<%-- 		<a href="${cPath }/vendor/qna/qnaList.do?" class="btn-list">목록보기</a> --%>
		<a href="${listURL }" class="btn btn-dark">목록</a>
	</div>
	<!-- // 공지사항 -->
</div>


<script>
function deleteBoard(deleteUrl) {
	var result = confirm("삭제하시겠습니까 ?");
    
    if(result)
    {
        location.href=deleteUrl;
    }
    else
    {
        
    }
}
</script>
