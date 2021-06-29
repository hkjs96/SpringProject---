<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />

<style>
	#modalBtn{
		font-size:14px;
		width: 80px;
		height: 30px; 
		margin: 2px;
		line-height: 10px;
	}
	
	.searchDiv{
		margin-left:15em;
		margin-bottom: 3em;
	}
	
</style>

<form id="searchForm">
	<input type="hidden" name="searchVO.searchAptCode" value="${authMember.aptCode}">
	<input type="hidden" name="page" />
	<input type="hidden" name="positionCode" value="${pagingVO.searchDetail.positionCode }"/>
	<input type="hidden" name="empName" value="${pagingVO.searchDetail.empName }"/>
</form>


<br>
<h2><strong>급여계좌정보</strong></h2>
<br>
<div class="container ">
	<div style="border-style:outset;border-radius: 8px;" class="col-sm-6 searchDiv">
		  <div class="row g-0 ml-3 ">
			    <div class="col-md-4 mt-4 ">
			      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
			        style="width:30px;height:30px;margin-left:20px;margin-top:10px;">&nbsp;&nbsp;<strong>검색 조건</strong>
			    </div>
			    <div id="inputUI" class="col-sm-12 mb-2">
				    <form class="form-inline">
					      <div class="card-body ">
				        	&nbsp;&nbsp;직책&nbsp;&nbsp;
				        	<select id="positionCode" name="positionCode" class="custom-select col-md-3">
				        				<option value="">전체</option>
								<c:forEach items="${positions }" var="position" varStatus="vs">
									<c:if test="${not empty position.positionCode }">
										<option value="${position.positionCode }" ${pagingVO.searchDetail.positionCode eq position.positionCode ? 'selected':''}>"${position.positionName }"</option>
									</c:if>
								</c:forEach>
							</select>
				        	&nbsp;&nbsp;성명&nbsp;&nbsp;
					       	<input type="text" name="empName" class="form-control col-md-3" value="${pagingVO.searchDetail.empName }"> 
							 <button class="btn btn-dark" style='margin:5pt;' id="searchBtn">검색</button>
						</div>
			      </form>
			    </div>
		  </div>
	</div>
	<br>
	<div class="d-flex justify-content-end">
	</div>
	  <div class="text-center col-sm-12">
		  <table id="payInfoTb" class="table table-bordered table-hover">
			  <thead class="thead-light">
			    <tr>
			      <th>직원번호</th>
			      <th>성명</th>
			      <th>직급</th>
			      <th>은행</th>
			      <th>계좌번호</th>
			      <th></th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
			  <c:set var="payInfoList" value="${pagingVO.dataList }" />
			   <c:if test="${not empty payInfoList }">
			   <c:forEach items ="${payInfoList }" var="payInfo">
			   	<tr>
			   		<c:url value="/office/paymentInfoView.do?memId=${payInfoList }" var="viewURL"/>
			   		<td class="tdMemId">${payInfo.member.memId}</td>
			   		<td>${payInfo.empName}</td>
			   		<td >${payInfo.position.positionName}</td>
			   		<td class="tdBank">${payInfo.empBank}</td>
			   		<td class="tdAcct">${payInfo.empAcct}</td>
			   		<td>
			   			<div>
				   			<button type="button" id="modalBtn" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#payInfoModal">수정</button>
			   			</div>
			   		</td>
			    </tr>
			   </c:forEach>
			   </c:if>
			   <c:if test="${empty payInfoList }">
			   		<tr>
			   			<td colspan="5">조회 결과가 없습니다.</td>
			   		</tr>
			   </c:if>
			  </tbody>
		</table>
	</div>
	<div id="pagingArea">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
	</div>
</div>


<!-- 급여계좌 변경 모달 -->
<!-- The Modal -->
<div class="modal" id="payInfoModal">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <p class="modal-title" style="font-size:15pt;">- 급여계좌 변경</p>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	    <div class="modal-body" >
			<form method="post" id="updateForm">
	    		<div class="row mb-3">
					<label for="empBank" class="col-sm-2 col-form-label">급여은행</label>
					<input type="hidden" name="memId" id="memId" value="">
					<div class="col-sm-4">
						<select id="empBank" name="empBank" class="form-control">
							<c:forEach items="${banks }" var="bank" varStatus="vs">
								<c:if test="${not empty bank.bankCode }">
									<option value="${bank.bankName }" ${employee.empBank eq bank.bankName ? 'selected':''}>"${bank.bankName }"</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<label for="empAcct" class="col-sm-2 col-form-label">계좌번호</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="empAcct"
							name="empAcct" value="${employee.empAcct}">
					</div>
				</div>
			</form>
	    </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-dark" id="updateBtn">수정</button>
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
	      
	      
      	</div>
    </div>
 </div>

<script>
function pageLinkMove(event){
	event.preventDefault();
	let page = $(event.target).data("page");
	searchForm.find("[name='page']").val(page);
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

$("#payInfoTb tr").on("click", function(){
	var empBank = $(this).find(".tdBank").text();
	var empAcct = $(this).find(".tdAcct").text();
	var memId = $(this).find(".tdMemId").text();
	$("#empBank").val(empBank);
	$("#empAcct").val(empAcct);
	$("#memId").val(memId);
});

// $("#modalBtn").on("click", function(){
// 	console.log($('#modalMemId').text());
	
// 	$.ajax({
// 		url:"${cPath }/office/payment/paymentBasicInfoUpdate.do"
// 		,data : {"memId":"$('#modalMemId').text()"}
// 		,method : "get"
// 		,success : function(resp){
// 			if(resp.message){
// 				getNoty(resp);
// 				return;
// 			}else{
// 				$('#updateModal').modal("show");
// 			}
// 		},error:function(xhr){
// 			console.log(xhr.status);
// 		}
// 	});
// });

$("#updateBtn").on("click", function(){
	
	let confirmChk = confirm("급여기본정보를 수정하시겠습니까?");
	
	if(confirmChk){
		let updateForm = $("#updateForm");
		
		$.ajax({
			url:"${cPath }/office/payment/paymentBasicInfoUpdate.do"
			,data : updateForm.serialize()
			,method : "post"
			,success : function(resp){
				if(resp.message){
					getNoty(resp);
					
					return;
				}else{
					alert("수정되었습니다.");
				}
				$('#updateModal').modal("hide");
				location.reload();
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
	}else{
		return;
	}
});

</script>