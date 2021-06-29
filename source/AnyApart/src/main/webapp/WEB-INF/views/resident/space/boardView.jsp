<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%> 
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal" var="principal"/>
	<c:set var="authMember" value="${principal.realMember }" />
</security:authorize>
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
			<c:if test="${authMember.memId eq board.boWriterId }">
				<a class="btn btn-primary" href="${updateURL }">수정</a>
				<input type="button" value="삭제" class="btn btn-danger" id="removeBtn" />
			</c:if>
			<c:if test="${board.boDepth eq 1}">
				<input type="button" value="답글" class="btn btn-warning" id="answerBtn" data-bo-no="${board.boNo }"/>
			</c:if>
			<a class="btn btn-success" href="${cPath }/resident/space/boardList.do">목록</a>
		</td>
	</tr>
</table>
<form id="boardDeleteForm" method="post" action="${cPath }/resident/space/boardDelete.do">
	<input type="hidden" name="boNo" value="${board.boNo }" />
</form>
<h4><strong>댓글</strong></h4>
<br>
<!-- 리플 등록 -->
<form method="post" class="form-inline" id="replyInsertForm" action="${pageContext.request.contextPath }/resident/space/reply">
	<input type="hidden" name="boNo" value="${board.boNo }"/>
	<input type="hidden" name="repWriter" value="${authMember.memId }"/>
	<table class="table table-bordered">
		<tr>
			<th colspan="2" class="text-center">내용</th>
		</tr>
		<tr>
			<td style="width: 90%">
				<textarea name="repContent" class="form-control" required style="resize: none;" rows="3" cols="120"></textarea>
				<span class="error">${errorsRep.repContent }</span>
			</td>
			<td  style="width: 10%">
				<input type="submit" class="btn btn-primary" value="저장"/>
			</td>
		</tr>
	</table>
</form>

<table id="replyTable" class="table table-bordered">
	<thead class="thead-light">
		<tr>	
			<th class="text-center" style="width: 55%">내용</th>
			<th class="text-center" style="width: 10%">작성자</th>
			<th class="text-center" style="width: 15%">작성일</th>
			<th class="text-center" style="width: 25%">&nbsp;</th>
		</tr>
	</thead>
	<tbody id="listBody">
	
	</tbody>
	<tfoot>
		<tr>
			<td colspan="4">
				<div id="pagingArea" style="display: inline-block;"></div>
			</td>
		</tr>
	</tfoot>
</table>
<form id="searchForm" action="${pageContext.request.contextPath }/resident/space/reply" method="get">
	<input type="hidden" name="boNo" value="${board.boNo }" />
	<input type="hidden" name="page"  />
</form>

<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
 <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="replyModalLabel">댓글 수정</h5>
      </div>
      <form action="${pageContext.request.contextPath }/resident/space/reply" method="post">
      	<input type="hidden" name="_method" value="put">
      	<input type="hidden" name="repNo" required/>
      	<input type="hidden" name="boNo"  required value="${board.boNo }"/>
	      <div class="modal-body">
	      	<table class="table form-inline">
	      		<tr>
	      			<td>
						<div class="input-group">
						<textarea class="form-control" placeholder="내용 200자 이내" maxlength="200" name="repContent" required style="resize: none;" rows="3" cols="70"></textarea>
						</div>
					</td>
	      		</tr>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-primary">저장</button>
	        <button type="reset" class="btn btn-warning" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
      </form>
    </div>
  </div>
</div>
<div class="modal fade" id="replyChildModal" tabindex="-1" aria-labelledby="replyChildModalLabel" aria-hidden="true">
 <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="replyChildModalLabel">대댓글</h5>
      </div>
      <form action="${pageContext.request.contextPath }/resident/space/reply" method="post">
      	<input type="hidden" name="repWriter" value="${authMember.memId }"/>
      	<input type="hidden" name="repParent" required/>
      	<input type="hidden" name="boNo" required value="${board.boNo }"/>
	      <div class="modal-body">
	      	<table class="table form-inline">
	      		<tr>
	      			<td>
						<div class="input-group">
						<textarea class="form-control" placeholder="내용 200자 이내" maxlength="200" name="repContent" required style="resize: none;" rows="3" cols="70"></textarea>
						</div>
					</td>
	      		</tr>
	      	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-primary">저장</button>
	        <button type="reset" class="btn btn-warning" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
      </form>
    </div>
  </div>
</div>
<form id="replyDeleteForm" action="${pageContext.request.contextPath }/resident/space/reply" method="post">
	<input type="hidden" name="_method" value="delete" />
	<input type="hidden" name="repNo" required/>
   	<input type="hidden" name="boNo"  required value="${board.boNo }"/>
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
	

	//====================댓글 CRUD==========================
		function commonSuccess(resp){
			if(resp.result == "OK"){
				console.log("성공");
				replyInsertForm.get(0).reset();
				replyChildForm.get(0).reset();
				replyModal.modal("hide");
				replyChildModal.modal("hide");
				searchForm.submit();
			}else if(resp.message){
				new Noty({
					 text: resp.message.text, 
					 layout: resp.message.layout,
					 type: resp.message.type,
					 timeout: resp.message.timeout,
					 progressBar: true
				}).show();
			}
		}
		// 대댓글
		function childReply(event){
			let reply = $(this).parents("tr:first").data("reply");
			let repParent = reply.repNo;
			replyChildForm.get(0).repParent.value = repParent;
			replyChildModal.modal("show");
		}
		// 수정
		function updateReply(event){
			let reply = $(this).parents("tr:first").data("reply");
			for(let prop in reply){
				$(replyUpdateForm).find("[name='"+prop+"']").val(reply[prop]);
			}
			if(reply['repParent']!=null) { // re:제거
				$(replyUpdateForm).find("[name='repContent']").val(reply['repContent'].replace('&nbsp;&nbsp└re:',''));
			}
			replyModal.modal("show");
		}
		// 삭제
		function deleteReply(event){
			if(!confirm("정말 삭제하시겠습니까?")) return false;
			let reply = $(this).parents("tr:first").data("reply");
			$(replyDeleteForm).find("[name='repNo']").val(reply.repNo);
			replyDeleteForm.submit();
		}
		
		let listTable = $("#replyTable").on("click", ".replyBtn", childReply)
		 								.on("click", ".updateBtn", updateReply)
										.on("click", ".delBtn", deleteReply)
										.find("#listBody");
		
		let replyModal = $("#replyModal").on("hidden.bs.modal", function(){
			$(this).find("form").get(0).reset();
		});
		
		let replyChildModal = $("#replyChildModal").on("hidden.bs.modal", function(){
			$(this).find("form").get(0).reset();
		});
		
		let options ={
			dataType : "json",
			success :commonSuccess
		}
		
		let replyInsertForm = $("#replyInsertForm").ajaxForm(options);
		let replyUpdateForm = replyModal.find("form").ajaxForm(options);
		let replyChildForm = replyChildModal.find("form").ajaxForm(options);
		let replyDeleteForm = $("#replyDeleteForm").ajaxForm(options);
	//========================================================	
		
	//====================덧글 페이징=======================
		let pagingArea = $("#pagingArea");
		let pagingA = pagingArea.on('click', "a" ,function(){
			let page = $(this).data("page");
			searchForm.find("[name='page']").val(page);
			searchForm.submit();
			searchForm.find("[name='page']").val(1);
			return false;
		});
		
		let memId = '${authMember.memId }';
		
		let searchForm = $("#searchForm").ajaxForm({
			dataType : "json",
			success : function(resp) {
				listTable.find("tbody").empty();
				pagingArea.empty();
				let replyList = resp.dataList;
				let trTags = [];
				if(replyList.length>0){
					$(replyList).each(function(idx, reply){
						let tr = $("<tr>");
						
						// 댓글 관련 버튼
						let buttons = [];
						if(reply.repParent == null) {
							buttons.push($("<input>").attr({
								type:"button",
								value:"덧글"
							}).addClass("btn btn-primary mr-2 replyBtn"));
						}
						
						if (reply.repWriterId == memId) {
							buttons.push(
									$("<input>").attr({ // 접속자와 repWriterId와 같아야 수정이 보임
										type:"button",
										value:"수정"
									}).addClass("btn btn-info mr-2 updateBtn"),		
									$("<input>").attr({ // 접속자와 repWriterId와 같아야 수정이 보임
										type:"button",
										value:"삭제"
									}).addClass("btn btn-danger mr-2 delBtn")				
							);
						}
						
						tr.append(
								$("<td>").html(reply.repContent)
										.addClass("text-left"),
								$("<td>").text(reply.repWriter)
										.addClass("text-center"),
								$("<td>").text(reply.repDate)
										.addClass("text-center"),	
								$("<td>").append(
										buttons
								).addClass("text-center")	
						).data("reply", reply);
						trTags.push(tr);
					});
				}else{
					trTags.push(
						$("<tr>").html(
							$("<td colspan='4'>").text("등록된 댓글이 없습니다.").addClass("text-center")												
						)
					);
				}
				let remainRowCnt = resp.screenSize - trTags.length;
		  		for(let i=0; i<remainRowCnt; i++){
		  			trTags.push($("<tr>").html($("<td colspan='4'>").html("&nbsp;")));
		  		}
				listTable.html(trTags);
				if(replyList.length>0)
					pagingArea.html(resp.pagingHTML);
			},
			error : function(errResp) {
				console.log(errResp);
			}
		}).submit(); // 페이지 로드 후 1페이지의 댓글 요청.
	//========================================================
	
</script>