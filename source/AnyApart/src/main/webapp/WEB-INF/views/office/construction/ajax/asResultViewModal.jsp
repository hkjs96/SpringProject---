<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 2. 9.  박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    

<c:set var="vo" value="${afterServiceVO }"/>

<!-- Modal Header -->
<div class="modal-header">
	<p class="modal-title" style="font-size: 15pt;">- 수리내역 처리결과</p>
	<button type="button" class="close" id="closeRusultBtn" data-dismiss="modal">&times;</button>
</div>
<!-- Modal body -->
<div class="modal-body ">
	<form id="resultForm" >
	<input type="hidden" name="asNo" value="${vo.asNo }">
	<table class="table table-bordered">
		<tbody>
			<tr>
				<th>처리일</th>
				<td>
					<input type='date' name="asSchedule" value="${vo.asSchedule }" required class="form-control" id="date">
				</td>
			</tr>
			<tr>
				<th>담당자</th>
				<td>
					<input type='text' name="asEmployee" value="${vo.asEmployee }" class="form-control">
				</td>
			</tr>
			<tr>	
				<th>비고</th>
				<td colspan='3'>
					<textarea name='asComment' id='resultInputTag' class="form-control">${vo.asComment }</textarea>
				</td>
			</tr>
		</tbody>
	</table>
	</form>
</div>
<!-- Modal footer -->
<div class="modal-footer">
	<div id="saveBtnDiv">
		<input type='button' value='저장' class='updateCommentBtn btn btn-primary' data-dismiss='modal' data-asno='${vo.asNo }'>
		<input type='button' value='취소' class='btn btn-secondary' id='cancleCommentBtn' data-dismiss='modal' data-asno='${vo.asNo }'>
	</div>
</div>

<script>
// input date 오늘 날짜로 초기화
var date = new Date();
var yyyy = date.getFullYear();
var mm = date.getMonth()+1 > 9 ? date.getMonth()+1 : '0' + (date.getMonth()+1);
var dd = date.getDate() > 9 ? date.getDate() : '0' + date.getDate();
document.getElementById("date").value=yyyy+"-"+mm+"-"+dd;

$(".updateCommentBtn").on("click", function(){
	$.ajax({
		url:"${cPath}/office/construction/afterServiceUpdateResult.do"
		,method:"post"
		,data:$("#resultForm").serialize()
		,dataType:"json"
		,success:function(resp){
			alert(resp.message);
			if(resp.message=='변경되었습니다.'){
				$("#repairView").modal('hide');
				location.reload();
			}
		},error:function(xhr){
			console.log("에러:"+xhr.status);
			console.log("에러:"+xhr.statusText);
		}
	});
});
</script>
