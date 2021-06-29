<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  박 찬      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>	
<form:form commandName="board" id="noticeForm" method="post" enctype="multipart/form-data">
	<input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
	<input type="hidden" name="boType" value="${board.boType }" />
	<input type="hidden" name="boDelete" value="${board.boDelete }" />
	<input type="hidden"name="boWriter" value="ADMIN">
<!-- 	<input type="hidden"name="" -->
	 <div class="board-form">
	<table>
		<tr>
			<th class="text-center">제목</th>
			<td class="pb-1">
				<input type="text" class="form-control"
				required name="boTitle" value="${board.boTitle}" />
				<form:errors path="boTitle" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<th class="text-center">첨부파일</th>
			<td class="pb-1" id="fileArea">
				<div>
					<c:if test="${not empty board.attachList }">
						<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
						<c:choose>
						<c:when test="${attach.attFilesize eq 0 }">
					
						</c:when>
						<c:when test="${attach.attFilesize ne 0 }">
							<span title="다운로드${attach.attSn }" class="attatchSpan" >
							<img src="${cPath }/js/main/img/common/file.png" class="delAtt" data-att-no="${attach.attSn }"/>
							<label class="delAtt" data-att-no="${attach.attSn }">${attach.attFilename } </label> &nbsp; ${not vs.last?"|":"" }
							</span>
						</c:when>
						</c:choose>
						</c:forEach>		
					</c:if>
				</div>
				<div class="input-group">
					<input type="file" class="form-control" name="boFiles" value="파일" />
					<span class="btn btn-primary plusBtn">+</span>
				</div>
				<span class="error">${errors.boFiles }</span>
			</td>
		</tr>
		<tr>
			<th class="text-center">내용</th>
			<td class="pb-1">
				<textarea name="boContent" id="boContent" class="form-control" required>${board.boContent }</textarea>
				<span class="error">${errors.boContent }</span>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center pt-2">
				<input type="submit" class="btn btn-primary ml-5" value="저장" />
				<input type="reset" class="btn btn-secondary" value="취소" />
			</td>
		</tr>
	</table>
	<div class="board-btns">
         <a href="${cPath }/vendor/noticeList.do">나가기</a>
     </div>
</div>
</form:form>
<script type="text/javascript">
	CKEDITOR.replace("boContent", {
		 filebrowserImageUploadUrl: '${cPath }/notice/imageUpload.do?command=QuickUpload&type=Images'
	});
	
	$("#fileArea").on("click", ".plusBtn", function(){
		let clickDiv = $(this).parents("div.input-group");
		let newDiv = clickDiv.clone();
		let fileTag = newDiv.find("input[type='file']");
		fileTag.val("");
		clickDiv.after(newDiv);		
	});
	
	let noticeForm =$("#noticeForm");
	$(".delAtt").on("click", function(){
		let attNo = $(this).data("attNo");
		noticeForm.append(
			$("<input>",{type:"text",name:"delAttNos",value:attNo}));
		
		$(this).parent("span:first").hide();
	});
	
	const validateOptions = {
            onsubmit:true
            ,onfocusout:function(element, event){
               return this.element(element);
            }
            ,errorPlacement: function(error, element) {
            //    error.appendTo( $(element).parents("div:first") );
				element.tooltip({
					title: error.text()
					, placement: "right"
					, trigger: "manual"
					, delay: { show: 500, hid: 100 }
				}).on("shown.bs.tooltip", function() {
					let tag = $(this);
					setTimeout(() => {
						tag.tooltip("hide");
					}, 3000)
				}).tooltip('show');
              }
     }
	
	let validator = $("#noticeForm").validate(validateOptions);
	
</script>
