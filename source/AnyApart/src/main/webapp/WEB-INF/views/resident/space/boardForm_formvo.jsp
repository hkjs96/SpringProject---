<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>	
<form:form modelAttribute="boardFormVO" id="boardForm" method="post" enctype="multipart/form-data">
	<!-- 작성자 session 에서 id 꺼내와야함 -->
	<input type="hidden" name="boardVO.boNo" value="${board.boNo }"/>
	<input type="hidden" name="boardVO.boParent" value="${param.parent }" />
	<input type="hidden" name="boardVO.boWriter" value="A0001R00001" />
	<table class="table table-bordered">
		<tr>
			<th class="text-center">제목</th>
			<td class="pb-1">
				<form:input path="boardVO.boTitle" id="boTitle" cssClass="form-control"/>
				<form:errors path="boardVO.boTitle" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="text-center">첨부파일</th>
			<td class="pb-1" id="fileArea">
				<div>
					<c:if test="${not empty boardFormVO.boardVO.attachList }">
						<c:forEach items="${boardFormVO.boardVO.attachList }" var="attach" varStatus="vs">
							<span title="다운로드" class="attatchSpan">
									<img src="${cPath }/js/main/img/common/file.png" class="delAtt" data-att-no="${attach.attSn }"/>
									${attach.attFilename } &nbsp; ${not vs.last?"|":"" }
							</span>
						</c:forEach>	
					</c:if>
				</div>
				<div class="input-group">
					<input type="file" class="form-control" name="boardVO.boFiles" value="파일"/>
					<form:errors path="boardVO.boFiles" element="span" cssClass="error" />
					<span class="btn btn-primary plusBtn">+</span>
				</div>
			</td>
		</tr>
		<tr>
			<th class="text-center">내용</th>
			<td colspan="pb-1">
				<form:textarea path="boardVO.boContent" id="boContent" cssClass="form-control"/>
				<form:errors path="boardVO.boContent" element="span" cssClass="error" />
			</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center pt-2">
				<input type="submit" id="insertBtn" class="btn btn-primary ml-5" value="저장" />
				<input type="reset" id="resetBtn" class="btn btn-secondary" value="취소" />
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
				"type":"text"
				, "name":"delAttNos"
			}).val(attNo)
		);
		$(this).parent("span:first").hide();
	});
</script>