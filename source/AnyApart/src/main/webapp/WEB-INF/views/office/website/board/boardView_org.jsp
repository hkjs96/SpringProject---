<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 3.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style>
	.table td:nth-child(2n+1) {
/* 	  background-color: #f7f7e8; */
	  text-align:center;
	  font-weight: bold;
	  width:10em;
	}
	
	.table td:nth-child(2n) {
		width:10em;
	}
	
	.btn{
		margin:5px;
	}
</style>

<div class="container">
	<br>
	<h4><strong>자유게시판</strong></h4>
	<br>
	 <table class="table table-bordered">
		<tr>
			<td class="text-center table-dark">글번호</td>
			<td class="text-center">${board.boNo }</td>
			<td class="text-center table-dark">작성자</td>
			<td class="text-center">${board.boWriter }</td>
		</tr>
		<tr>
			<td class="text-center table-dark">조회수</td>
			<td class="text-center">${board.boHit }</td>
			<td class="text-center table-dark">작성일</td>
			<td class="text-center">${board.boDate }</td>
		</tr>
		<tr>
			<td class="text-center table-dark">제목</td>
			<td colspan="3">${board.boTitle }</td>
		</tr>
		<tr>
			<td class="text-center table-dark">첨부파일</td>
			<td colspan="3">
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
			<td class="text-center align-middle table-dark" style="height:500px;">내용</td>
			<td colspan="3">${board.boContent }</td>
		</tr>
	</table>   
	<div class="d-flex justify-content-center">
		<input type="button" value="삭제" class="btn btn-dark" id="removeBtn" />
		<a class="btn btn-dark" href="${cPath }/office/website/boardList.do">목록으로</a>
	</div>
</div>

<form id="boardDeleteForm" method="post" action="${cPath }/office/website/boardDelete.do">
	<input type="hidden" name="boNo" value="${board.boNo }" />
</form>

<div class="container">
	<h4><strong>댓글</strong></h4>
	<br>
	<table id="replyTable" class="table table-bordered">
		<thead class="table-boardered">
			<tr>	
				<th class="text-center table-dark">내용</th>
				<th class="text-center table-dark">작성자</th>
				<th class="text-center table-dark">작성일</th>
				<th class="text-center table-dark">&nbsp;</th>
			</tr>
		</thead>
		<tbody id="listBody">
		
		</tbody>
	</table>
</div>
<div id="pagingArea"></div>
<!-- 댓글 검색용 -->
<form id="searchForm" action="${pageContext.request.contextPath }/office/website/reply" method="get">
	<input type="hidden" name="boNo" value="${board.boNo }" />
	<input type="hidden" name="page"  />
</form>

<form id="replyDeleteForm" action="${pageContext.request.contextPath }/office/website/reply" method="post">
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
	
	//====================댓글 CRUD==========================
	function commonSuccess(resp){
		if(resp.result == "OK"){
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
	// 삭제
	function deleteReply(event){
		if(!confirm("정말 삭제하시겠습니까?")) return false;
		let reply = $(this).parents("tr:first").data("reply");
		$(replyDeleteForm).find("[name='repNo']").val(reply.repNo);
		replyDeleteForm.submit();
	}
	
	let listTable = $("#replyTable").on("click", ".delBtn", deleteReply)
									.find("#listBody");
	let options ={
		dataType : "json",
		success :commonSuccess
	}
	
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
					
					tr.append(
							$("<td>").html(reply.repContent)
									.addClass("text-left"),
							$("<td>").text(reply.repWriter)
									.addClass("text-center"),
							$("<td>").text(reply.repDate)
									.addClass("text-center"),	
							$("<td>").append(
									$("<input>").attr({
										type:"button",
										value:"삭제"
									}).addClass("btn btn-danger mr-2 delBtn")			
							).addClass("text-center")	
					).data("reply", reply);
					trTags.push(tr);
				});
			}else{
				trTags.push(
					$("<tr>").html(
						$("<td colspan='4'>").text("댓글이 없음.")									
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