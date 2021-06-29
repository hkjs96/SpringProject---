<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 30.  이미정      최초작성
* 2021. 2. 15.  이미정      기존 코드 수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<style>
	.content{
		height:200px;
	}
	
	.formBtn{
		display: inline;
	}
	
	.title{
		text-align: center;
		font-weight: bold;
		color: #4C4C4C;
	}
</style>

	 <table class="table">
		<tr>
			<td width="25%" class="text-center title">글번호</td>
			<c:set var="answerChkBoNo" value="${board.boNo }" />
			<td width="25%" class="text-center ">${board.boNo }</td>
			<td width="25%" class="text-center title">작성자</td>
			<td width="25%" class="text-center">${board.boWriter }</td>
		</tr>
		<tr>
			<td class="text-center title">조회수</td>
			<td class="text-center">${board.boHit }</td>
			<td class="text-center title">작성일</td>
			<td class="text-center">${board.boDate }</td>
		</tr>
		<tr>
			<td class="text-center title">제목</td>
			<td colspan="3">${board.boTitle }</td>
		</tr>
		<tr>
			<td class="text-center align-middle content title">내용</td>
			<td colspan="3">${board.boContent }</td>
		</tr>
				<tr>
			<td class="text-center title">첨부파일</td>
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
				<c:if test="${board.boWriterId eq authMember.memId }">
					<form id="updateForm" class="formBtn" action="${cPath }/resident/officeQna/officeQnaUpdate.do" method="GET">
						<input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
						<input type="hidden" class="form-control" name="page" value="${param.page }"/>
						<input type="hidden" class="form-control" name="searchType" value="${param.searchType }"/>
						<input type="hidden" class="form-control" name="searchWord" value="${param.searchWord }"/>
						<input type="submit" value="수정" class="btn btn-primary" id="updateBtn"/>
					</form>
					<form id="deleteForm" class="formBtn" action="${cPath }/resident/officeQna/officeQnaDelete.do" method="POST">
						<input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
						<input type="hidden" class="form-control" name="boType" value="${board.boType }"/>
						<input type="hidden" class="form-control" name="boWriter" value="${board.boWriter }"/>
						<input type="hidden" class="form-control" name="boWriterId" value="${board.boWriterId }"/>
						<input type="hidden" class="form-control" name="boDelete" value="${board.boDelete }"/>
						<input type="button" value="삭제" class="btn btn-danger" id="removeBtn" />
					</form>
				</c:if>
				<form id="listForm" class="formBtn" action="${cPath }/resident/officeQna/officeQnaList.do" method="GET">
					<input type="hidden" class="form-control" name="page" value="${param.page }"/>
					<input type="hidden" class="form-control" name="searchType" value="${param.searchType }"/>
					<input type="hidden" class="form-control" name="searchWord" value="${param.searchWord }"/>
					<input type="submit" value="목록" class="btn btn-success" id="listBtn">
				</form>
			</td>
		</tr>
	</table>   
	
<script>
	$(function(){
		$.ajax({
			url:"${cPath }/office/officeQna/repChk.do"
			,data : {"boNo" : "${answerChkBoNo}"} 
			,method : "get"
			,success : function(resp){
				if(resp.answerChk.boNo!=null){
					$('#answerBtn').hide();
				}
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
	})
	
	$("#removeBtn").on("click", function(){
		let comfirmChk = confirm("삭제하시겠습니까?");
		
		if(comfirmChk){
			$("#deleteForm").submit();
		}else{
			return;
		}

	});
</script>