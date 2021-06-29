<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  이미정      최초작성
* 2021. 2. 15.      이미정       기존 코드 보완
* Copyright (c) 2021 by DDIT All right reserved
 --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />

<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box;
}

input[type=text], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-top: 6px;
	margin-bottom: 16px;
	resize: vertical;
}

input[type=submit] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
	height: 48em;
}

.containerTitle {
	width: 100px;
}
</style>


<div class="containerTitle" style="margin-left: 15.7em;">
	<br>
	<h4>
		<strong>공지사항</strong>
	</h4>
</div>

<br>

<div class="container">
	<form:form commandName="board" id="noticeForm" method="post"
		enctype="multipart/form-data">
		<input type="hidden" class="form-control" name="boNo"
			value="${board.boNo }" />
		<input type="hidden" name="boType" value="${board.boType }" />
		<input type="hidden" name="boDelete" value="${board.boDelete }" />
		<input type="hidden" name="boWriter" value="${authMember.memId }" />
		<label for="boTitle">제목</label>
		<input type="text"  id="boTitle" name="boTitle "
			value="${board.boTitle }" maxlength="200" required />
		<form:errors path="boTitle" element="span" cssClass="error" />

		<label for="boContent">내용</label>
		<textarea id="boContent" name="boContent" maxlength="4000" style="height: 200px" required>${board.boContent }</textarea>

		<label for="boFiles">첨부파일</label>
		<div class="custom-file" id="fileArea">
			<span> <c:if test="${not empty board.attachList }">
					<span class="reddot"> * 파일 아이콘을 클릭하면 기존 파일을 삭제할 수 있습니다.</span>
					<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
						<span title="다운로드" class="attatchSpan"> <img
							src="${cPath }/js/main/img/common/file.png" class="delAtt"
							data-att-no="${attach.attSn }" /> ${attach.attFilename } &nbsp;&nbsp;&nbsp;
						</span>
					</c:forEach>
				</c:if>
			</span>
		<div class="input-group">
			<input type="file" class="form-control col-sm-11" name="boFiles" value="파일" />
			<span id="plusBtn" class="btn btn-dark plusBtn">파일 추가</span>
		</div>
		</div>
		<div class="float-right mt-5">
			<input type="button" class="btn btn-dark" id="insertBtn" value="저장" />
			<input type="button" class="btn btn-dark" onclick="goBack()" value="취소" />
		</div>
	</form:form>
</div>

<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>	
<script>


	function goBack(){
		window.history.back();
	}
	
	$("#insertBtn").on("click", function() {
		$("#noticeForm").submit();
	});
	
	CKEDITOR.replace("boContent", {
		 filebrowserImageUploadUrl: '${cPath }/notice/imageUpload.do?command=QuickUpload&type=Images'
	});

	$("#fileArea").on("click", ".plusBtn", function() {
		let clickDiv = $(this).parents("div.input-group");
		let newDiv = clickDiv.clone();
		newDiv.find("#plusBtn").remove();
		let fileTag = newDiv.find("input[type='file'], .custom-file-label");
		fileTag.val("");
		clickDiv.after(newDiv);
	});

	let noticeForm = $("#noticeForm");
	$(".delAtt").on("click", function() {
		let attNo = $(this).data("attNo");
		noticeForm.append($("<input>", {
			type : "hidden",
			name : "delAttNos",
			value : attNo
		}));

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


