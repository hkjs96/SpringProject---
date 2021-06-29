<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  이경륜      최초작성
* 2021. 2. 17.  이경륜	하드코딩 되어있던 작성자id 로그인id로 수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%> 
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal"/>
	<c:set var="authMember" value="${principal.realMember }" />
</security:authorize>
<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>	
<form:form modelAttribute="board" id="boardForm" method="post" enctype="multipart/form-data">
	<input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
	<input type="hidden" name="boParent" value="${param.parent }" />
	<input type="hidden" class="form-control" required name="boWriter" value="${authMember.memId}" />
	<table class="table table-bordered">
		<tr>
			<th class="text-center">제목</th>
			<td class="pb-1">
				<form:input path="boTitle" cssClass="form-control"/>
				<form:errors path="boTitle" element="span" cssClass="error" />
<%-- 				<input type="text" class="form-control"	required name="boTitle" value="${board.boTitle}" /> --%>
<%-- 				<span class="error">${errors.boTitle }</span> --%>
			</td>
		</tr>
		<tr>
			<th class="text-center">첨부파일</th>
			<td class="pb-1" id="fileArea">
				<div>
					<c:if test="${not empty board.attachList }">
						<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
							<span title="다운로드" class="attatchSpan">
									<img src="${cPath }/js/main/img/common/file.png" class="delAtt" data-att-no="${attach.attSn }"/>
									${attach.attFilename } &nbsp; ${not vs.last?"|":"" }
							</span>
						</c:forEach>	
					</c:if>
				</div>
				<div class="input-group">
					<input type="file" class="form-control" name="boFiles" value="파일"/>
					<form:errors path="boFiles" element="span" cssClass="error" />
					<span class="btn btn-primary plusBtn">+</span>
				</div>
				<span class="error">${errors.boFiles }</span>
			</td>
		</tr>
		<tr>
			<th class="text-center">내용</th>
			<td colspan="pb-1">
				<form:textarea path="boContent" cssClass="form-control"/>
				<form:errors path="boContent" element="span" cssClass="error" />
<%-- 				<textarea class="form-control" name="boContent" id="boContent">${board.boContent}</textarea> --%>
				<span class="error">${errors.boContent }</span>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center pt-2">
				<input type="submit" id="insertBtn" class="btn btn-primary ml-5" value="저장" />
<!-- 				<input type="reset" id="resetBtn" class="btn btn-secondary" value="취소" /> -->
				<a class="btn btn-success" href="${cPath }/resident/space/boardList.do">목록</a>
			</td>
		</tr>
	</table>
</form:form>

<script>
	CKEDITOR.replace("boContent",{
		filebrowserImageUploadUrl: '${cPath}/resident/space/imageUpload.do?command=QuickUpload&type=Images'
	});
	
	let boardForm =$("#boardForm");
	boardForm.validate({
		onsubmit:true,
		onfocusout:function(element, event){
			return this.element(element);
		},
		errorPlacement: function(error, element) {
			error.appendTo( $(element).parents("td:first") );
	  	}
	});
	
	$("#fileArea").on("click", ".plusBtn", function(){
		let clickDiv = $(this).parents("div.input-group");
		let newDiv = clickDiv.clone();
		let fileTag = newDiv.find("input[type='file']");
		fileTag.val("");
		clickDiv.after(newDiv);		
	});
	
	$(".delAtt").on("click", function(){
		let attNo = $(this).data("attNo");
		boardForm.append(
			$("<input>").attr({
				"type":"hidden"
				, "name":"delAttNos"
			}).val(attNo)
		);
		$(this).parent("span:first").hide();
	});
</script>