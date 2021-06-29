<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 31.  이미정      최초작성
* 2021. 2. 15.  이미정      기존 코드 수정
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />

<table class="table table-bordered">
   <form:form commandName="board" id="qnaForm" method="post" enctype="multipart/form-data">
	    <input type="hidden" class="form-control" name="boNo" value="${board.boNo }"/>
	    <input type="hidden" name="boType" value="${board.boType }"/>
	    <input type="hidden" name="boDelete" value="${board.boDelete }"/>
	    <input type="hidden" name="boWriter" value="${authMember.memId }" />
	<tbody>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="boTitle" class="form-control" value="${board.boTitle }" maxlength="200" required >
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea id="boContent" rows="7px" cols="70px" name="boContent" maxlength="4000" >
					${board.boContent}
				</textarea>
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
			<div class="custom-file">
		    	<span>
		    		<c:if test="${not empty board.attachList }">
						<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
							<span title="다운로드" class="attatchSpan">
								<img src="${cPath }/js/main/img/common/file.png" class="delAtt" data-att-no="${attach.attSn }"/>
								${attach.attFilename } &nbsp; ${not vs.last?"|":"" }
							</span>
						</c:forEach>		
					</c:if>
		    	</span>
		    	<div class="input-group">
					<input type="file" class="form-control col-sm-11" name="boFiles" value="파일" />
					<span id="plusBtn" class="btn btn-dark plusBtn">파일 추가</span>
				</div>
	    </div>
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2">
				<input type="button" class="btn btn-dark" id="insertBtn" value="저장" />
				<input type="button" class="btn btn-dark" onclick="goBack()" value="취소" />
			</td>
		</tr>
	</tfoot>
	</form:form>
</table>	


<script type="text/javascript" src="${cPath }/js/ckeditor/ckeditor.js"></script>
<script>

function goBack(){
	window.history.back();
}

$("#insertBtn").on("click", function() {
	$("#qnaForm").submit();
});

var editor = CKEDITOR.replace("boContent", {
	 filebrowserImageUploadUrl: '${cPath }/qna/imageUpload.do?command=QuickUpload&type=Images'
});

editor.on( 'required', function( evt ) {
    editor.showNotification( '필수 항목을 입력해주세요.', 'info' );
    evt.cancel();
} );

$("#fileArea").on("click", ".plusBtn", function() {
	let clickDiv = $(this).parents("div.input-group");
	let newDiv = clickDiv.clone();
	newDiv.find("#plusBtn").remove();
	let fileTag = newDiv.find("input[type='file'], .custom-file-label");
	fileTag.val("");
	clickDiv.after(newDiv);
});

let qnaForm =$("#qnaForm");
$(".delAtt").on("click", function(){
	let attNo = $(this).data("attNo");
	qnaForm.append(
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

let validator = $("#qnaForm").validate(validateOptions);
</script>


