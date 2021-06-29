<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  박지수	최초작성
* 2021. 2. 8.	박지수	Spring Form으로 변경
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>
<div class="container">
<br>
<h4><strong>Q&A</strong></h4>
<br>
<%-- <c:set var="memId" value="${sessionScope.member.memId }"/> --%>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />

<form:form commandName="board" id="boardForm" method="post" enctype="multipart/form-data">
	<input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
<%-- 	<input type="hidden" name="boParent" value="${board.boParent }" /> --%>
<%-- 	<input type="hidden" name="boDepth" value="${board.boDepth }" /> --%>
<%-- <form id="boardForm" method="post" enctype="multipart/form-data"> --%>
  <div class="form-group row">
    <label for="boTitle" class="col-sm-2 col-form-label">제목</label>
    <div class="col-sm-10">
      <form:input cssClass="form-control" path="boTitle" />
      <form:errors path="boTitle" element="span" cssClass="error" />
<!--       <input type="text" class="form-control" name="boTitle"> -->
    </div>
  </div>
  <c:if test="${empty board.boType }">
  <div class="form-group row">
    <label for="boType" class="col-sm-2 col-form-label">문의 선택</label>
    <div class="col-sm-10">
    	<form:select path="boType" cssClass="form-control" >
			<option value>문의 선택</option>
    	</form:select>
    	<form:errors path="boType" element="span" cssClass="error" />
<!-- 		<select name="boType" class="form-control" required> -->
<!-- 			<option value>문의 선택</option> -->
<!-- 		</select> -->
    </div>
  </div>
  </c:if>
<!--   <div class="form-group row"> -->
<!--     <label for="inputPassword" class="col-sm-2 col-form-label">작성자(나중에 로그인하면 사라질부분)</label> -->
<!--     <div class="col-sm-10"> -->
      <input type="hidden" class="form-control" name="boWriter" value="${authMember.memId }">
<!--     </div> -->
<!--   </div> -->
  <div class="form-group row">
    <label for="boContent" class="col-sm-2 col-form-label">내용</label>
    <div class="col-sm-10">
      <form:textarea path="boContent" cssClass="form-control" />
      <form:errors path="boContent" element="span" cssClass="error" />
      <span class="error">${errors.boContent }</span>
<!--       <input type="text" class="form-control" name="boContent"> -->
    </div>
  </div>
  <div class="form-group row">
     <label for="boFiles" class="col-sm-2 col-form-label">파일 첨부</label>
     <div class="col-sm-10" id="fileArea">
     	<div class="col-sm-12">
     		<c:if test="${not empty board.attachList }">
     			<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
     				<span title="다운로드" class="attachSpan">
     					<img src="${cPath }/js/main/img/common/file.png" class="delAtt" data-att-no="${attach.attSn }" />
     					${attach.attFilename } &nbsp; ${not vs.last?"|":"" }
     				</span>
     			</c:forEach>
     		</c:if>
     	</div>
<!-- 		<div class="col-sm-12"> -->
			<div class="input-group">
	   		 	<label class="custom-file-label" for="boFiles">파일 선택</label>
			    <input type="file" class="custom-file-input" id="boFiles" name="boFiles" value="파일">
			    <form:errors path="boFiles" element="span" cssClass="error" />
			    <span class="btn btn-primary plusBtn">+</span>
		    </div>
<!-- 	    </div> -->
	    <span class="error">${errors.boFiles }</span>
     </div>
  </div>
	<div class="d-flex justify-content-end">
		 <div class="d-flex justify-content-end"><input type="submit" class="btn btn-dark" style='margin:5pt;' value="저장"></div>
		 <div class="d-flex justify-content-end"><input id="reset" type="button" class="btn btn-dark" style='margin:5pt;' value="취소"></div>
	</div>
</div>
</form:form>
 
<script>
CKEDITOR.replace("boContent",{
	filebrowserImageUploadUrl: '${cPath}/vendorQna/imageUpload.do?command=QuickUpload&type=Images'
});

$("#reset").on("click", function(){
	window.history.back();
});

let boardForm = $("#boardForm");
boardForm.validate({
	onsubmit:true,
	onfocusout:function(element, event){
		return this.element(element);
	},
	errorPlacement:function(error, element){
		error.appendTo( $(element).parents("div:first") );
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

let optTag = $("[name='boType']");
$.ajax({
	url : "${cPath }/board/getOption.do ",
	method : "get",
	dataType : "json",
	success : function(resp) {
		let opts = [];
		// 옵션을 동적으로 구성
		$(resp.option).each(function(idx, opt){
			opts.push(
				// type을 그대로 유지하기 위해서 prop 를 사용
				$("<option>").text(opt.codeName)
							 .attr("value", opt.codeId)
							 .prop("selected", "${board.boType}"==opt.codeId)
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		optTag.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});


</script>
 