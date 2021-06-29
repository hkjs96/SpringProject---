<%--
* [[개정이력(Modification Infomation)]]     
* 수정일              수정자                  수정내용             
* =========  ========  =================  
* 2021. 1. 29.    박정민         최초작성                      
* Copyright (c) 2021 by DDIT All right reserved 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%-- <link href="${cPath }/css/resident/remodelingList.css" rel="stylesheet"> --%>
<style>
#inputDiv{
	padding:8px;
	width: 80%;
	height: 180px;
	margin-top: 30px;
	margin-left: 10%;
	padding-top: 0px;
	border: 2px solid 
#054BBE;
	border-radius: 10px; 
}
#inputDiv table{
	width: 100%;
	margin-left: 10px;
}
#inputDiv th, #inputDiv td{
	padding: 5px;
}
#inputDiv th{
	color: #061C4E;
}
#inputDiv tr:first-child td{
	padding: 0px;
}
#insertBtn{
	margin-top: 10px;
	margin-left: 10%;
}
#insertH3 strong{
	margin-left: 40px;
	color: black;
	font-weight: 700;
}
#inputDiv textarea{
	border: 1px solid #357FF9;
	border-radius: 10px; 
}
/* 게시글 리스트 */
#listDiv{
	margin-top: 80px;
 	margin-left: 2%; 
}
#listDiv table{
	width: 95%;
	margin-left: 4%;
}
#listDiv tfoot td{
	text-align: center;
}
#listDiv tr:nth-child(3n) td{
	border-top: none;
	padding-bottom: 20px;
}
#listDiv tr:nth-child(even) td{
	text-align: left;
}
#listDiv tr:first-child {
	padding-bottom: 0;
}
#listDiv td:first-child {
	padding-left: 20px;
}
.listInfoTH{
	font-size: 0.9em;
}
.tdSpan{
	padding-left: 20px;
}
.writerSpan{
	font-weight: bolder;
}
.deleteBtn{
	margin-left: 93%;
	margin-bottom: 0px;
}
#searchDiv{
	padding-top: 100px;
	padding-left: 300px;
}
.badge-primary{
	background-color: #F6534E;	
}
.badge-default{
	background-color: #3ECFDE;
}
#rmdlContainer{
	margin-left: 0;
}
</style>
<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>
<h3 id="insertH3"><strong>리모델링 신청</strong></h3>
<div id="inputDiv">
	<form id="remodllingForm">
		<input type="hidden" name="memId" value="${authMember.memId }">
		<table class="table-borderless">
			<colgroup>
				<col width="80px;">
				<col width="220px;">
				<col width="120px;">
			</colgroup>
			<tbody>
				<tr>
					<th>시작일</th>
					<td>
						<input type="date" name="rmdlStart" id="rmdlStart" required>
						<span class="errors">${errors.rmdlStart }</span>
					</td>
					<th>종료예정일</th>
					<td>
						<input type="date" name="rmdlEnd" id="rmdlEnd" required>
						<span class="errors">${errors.rmdlEnd }</span>
					</td>
					<td>
						<input type="submit" id="insertBtn" value="등록" class="btn btn-default btn-sm mb20" >
					</td>
				</tr>
				<tr>
					<th colspan="5" style="display: inline;">
						내용
					</th>
					<td colspan="5">
						<textarea rows="3px;" cols="80px;" id="rmdlTitle" name="rmdlTitle" required></textarea>
						<span class="errors">${errors.rmdlTitle }</span>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<c:set var="paginationInfo" value="${paginationInfo }"/>
<div class="container" id="rmdlContainer">
<div id="listDiv">
<h3><strong style="color: black;">신청목록</strong></h3><br>
	<table class="table">
		<colgroup>
			<col width="20%;">
			<col width="50%;">
			<col width="20%;">
		</colgroup>
		<tbody id="listTbody"></tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<br>
					<form id="searchForm">
						<input type="hidden" name="currentPage" value="1" /> 
						<input type="hidden" name="searchVO.searchType" /> 
						<input type="hidden" name="searchVO.searchWord" value="${paginationInfo.pagingVO.searchVO.searchWord}"/> 
					</form>
					<div id="inputUI" class="row">
						<div class="col col-md-2 float-right">
							<select name="searchVO.searchType" class="form-control">
								<option value>전체</option>
								<option value="title">제목</option>
								<option value="memId">작성자</option>
							</select>
						</div>	
						<div class="col-sm-4 float-right">
							<input type="text" name="searchVO.searchWord" value="${paginationInfo.pagingVO.searchVO.searchWord}" class="form-control">
						</div>							
						<div class="col-sm-2 float-right">	
							<input type="button" class="btn btn-primary" id="searchBtn" value="검색">
						</div>
					</div>
					<div id="pagingDiv">
						<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsResident"/>
					</div>
				</td>
			</tr>
		</tfoot>
	</table>
	<form id="deleteForm">
		<input type="hidden" name="rmdlNo" id="formRmdlNo">
	</form>
</div>
</div>	

<script type="text/javascript">
	
	$("#remodllingForm").validate({
		onsubmit:true,
		onfocusout:function(element, event){
			return this.element(element);
		},
		errorPlacement: function(error, element) {
			error.appendTo( $(element).parents("td:first") );
	  	},
		rules: {
			rmdlStart: 
	    	{
		        required: true
	        }
			,rmdlEnd: 
			{
		        required: true
		    }
	        ,rmdlTitle:{maxlength: 200}
	    }
	});
<%--========================== 리모델링 list 받아와서 뿌려주는 함수=============================--%>
	function retreiveList(){
		$.ajax({
			dataType : "json",
			success : function(resp) {
				let pagingVO = resp.paginationInfo.pagingVO;
				let rmdlList = pagingVO.dataList;
				let trTags = [];
				if(rmdlList){
					$(rmdlList).each(function(idx, rmdl){
						let tr1 = $("<tr>");
						let tr2 = $("<tr>");
						let tr3 = $("<tr>");
						let rmdlYnText = null;
						let deleteBtnText = "";
<%---------------------------- 접수상태 뱃지 --------------------------------------------%>
						if('Y'==rmdl.rmdlYn){
							rmdlYnText = $("<td>").append(
								$("<span>").text("접수완료").addClass("badge badge-default")
							).css("backgroundColor","#F5F9FE")
						}else{
							rmdlYnText = $("<td>").append(
								$("<span>").text("접수중").addClass("badge badge-primary")
							).css("backgroundColor","#F5F9FE")
						}
<%---------------------------- 로그인한 아이디와 같은 글은 삭제버튼 나오게 -------------------------%>
						if('${authMember.memId }'==rmdl.memId){
							deleteBtnText = $("<input type='submit' class='btn btn-default btn-xs mb20 deleteBtn' data-rmdlno='"+rmdl.rmdlNo+"' value='신청취소'>");
						}
						tr1.append(
							$("<th>").text("No. "+rmdl.rmdlNo).addClass("listInfoTH").css("backgroundColor","#F5F9FE"),
							$("<th>").text("작성자:").append(
								$("<span>").text(rmdl.memNick).addClass("listInfoTH").addClass("tdSpan").addClass("writerSpan")		
							).addClass("listInfoTH").css("backgroundColor","#F5F9FE"),
							$("<th>").text("작성일:").append(
								$("<span>").text(rmdl.rmdlDate).addClass("listInfoTH").addClass("tdSpan")		
							).addClass("listInfoTH").css("backgroundColor","#F5F9FE"),
							rmdlYnText
						)
						tr2.append(
							$("<td colspan='4'>").text(rmdl.rmdlTitle)
						);
						tr3.append(
							$("<td colspan='4'>").append(
								deleteBtnText
							)	
						);
						trTags.push(tr1);
						trTags.push(tr2);
						trTags.push(tr3);
					});
				}
				$("#listTbody").html(trTags);
			},
			error : function(xhr) {
				console.log(xhr);
			}
		});
	}
	
	<%--처음 화면 로딩할때 리스트 조회.--%>
	$(document).ready(function(){
		retreiveList();
	})

	<%-- insert후에 리스트만드는함수 호출하는데 insert를 비동기로 하고 리다이렉트안했기 때문에 
		기존 검색어 포함된 url이 그대로 남아있어서 insert후에도 검색어가 유지됨.--%>
	$("#insertBtn").on("click", function(event){
		event.preventDefault();
		if(confirm("신청하시겠습니까?")){
			$.ajax({
				url: "${cPath}/resident/support/insertRemodeling.do"
				, data: $("#remodllingForm").serialize()
				, method : "post" 
				, dataType : "json"
				, success : function(resp) {
					alert(resp.message.text);
					$("#remodllingForm")[0].reset();
					retreiveList();
				}
				, error : function(xhr){
					console.log(xhr.status);
				}
			});
		}
		return false;
	});
	
	$("#listTbody").on("click", ".deleteBtn", function(event){
		event.preventDefault();
		if(confirm("신청을 취소하시겠습니까?")){
			let what = $(this).data("rmdlno");
			$("#formRmdlNo").val(what);
			$.ajax({
				url: "${cPath}/resident/support/deleteRemodeling.do"
				, data: $("#deleteForm").serialize()
				, method : "post" 
				, dataType : "json"
				, success : function(resp) {
					alert(resp.message.text);
					retreiveList();
				}
			});
		}
		return false;
	});
	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='currentPage']").val(page);
		searchForm.submit();
		return false;
	}
	
	let searchForm = $("#searchForm");
	$("#searchBtn").on("click", function(){
		let inputs = $(this).parents("div#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val();
			let hidden = searchForm.find("[name='"+name+"']");
			hidden.val(value);
		});
		searchForm.submit();
	});
</script>
