<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 3. 4.      이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<style>
	.delBtn{
		width: 90px;
		height: 30px;
		line-height: 10px;
	}
	
	.noticeP{
		color: blue;
	}
	
	#searchDiv{
		margin-top: 30px;
		margin-left: 10em;
		margin-bottom: 30px;
	}
</style>
<div class="container">
	<br>
	<div class="d-flex justify-content-between mb-3">
		<h4><strong>정산내역 조회</strong></h4>
		<input type="button" class="btn btn-primary" style='margin:5pt;' id="svrcSumBtn" value="계산하기">
	</div>
	<!-- 서버 ---------------------------------------->
	<form id="searchForm">
		<input type="hidden" name="searchVO.searchAptCode" value="${authMember.aptCode}">
		<input type="hidden" name="page" />
		<input type="hidden" name="searchSvrcS" value="${pagingVO.searchDetail.searchSvrcS }"/>
		<input type="hidden" name="searchSvrcE" value="${pagingVO.searchDetail.searchSvrcE }"/>
	</form>
	<!-- 클라이언트 ----------------------------------->
	<div class="col-md-8 " id="searchDiv" style="border-style:outset;border-radius: 8px;">
		  <div class="row g-0" >
			    <div class="col-md-3" style="margin-top:20px;">
			      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
			        style="width:30px;height:30px;margin-left:10px;margin-top:10px;">&nbsp;&nbsp;<strong>검색 조건</strong>
			    </div>
			    <div id="inputUI" class="col-md-12 mb-2">
				    <form class="form-inline">
					      <div class="card-body ">
						       	&nbsp;&nbsp; 지급일&nbsp;&nbsp;
						       	<input type="date" id="searchSvrcS" name="searchSvrcS" class="form-control col-md-4" value="${pagingVO.searchDetail.searchSvrcS }"> 
						         ~
								<input type="date" id="searchSvrcE" name="searchSvrcE" class="form-control col-md-4" value="${pagingVO.searchDetail.searchSvrcE }"> 
								<button class="btn btn-dark" style='margin:5pt;'>검색</button>
								<button class="btn btn-secondary" id="resetBtn">초기화</button>
						  </div>
				      </form>
			    </div>
		  </div>
	</div>
	<br>
	<!-- 지급내역 등록 버튼 -------------------------------->
	
	<div class="d-flex justify-content-between mb-2">
		<p class="noticeP" >* 각 행을 더블클릭하면 지급내역을 수정할 수 있습니다.</p>
   		 <div class="d-flex justify-content-end"><input type="button" class="btn btn-dark" style='margin:5pt;' id="insertModalBtn" value="등록" 
   		 data-toggle="modal" data-target="#svrcModal"></div>
	</div>
	<!-- 지급 리스트  --------------------------------->
	  <div class="text-center col-sm-12">
		  <table class="table table-bordered table-hover">
			  <thead class="thead-light">
			    <tr>
			      <th width="10%">No</th>
			      <th width="10%">성명</th>
			      <th width="10%">직책</th>
			      <th width="20%">지급일</th>
			      <th width="20%">금액(원)</th>
			      <th width="20%">비고</th>
			      <th width="10%"></th>
			    </tr>
			  </thead>
			  <tbody id = "listBody">
			     <c:set var="svrcList" value="${pagingVO.dataList }" />
			  	<c:if test="${not empty svrcList }">
			  		<c:forEach items = "${svrcList }" var="svrc" varStatus="vs">
			  			<tr data-svrc-no = ${svrc.svrcNo }>
				     		  <td>${svrc.rnum }</td>
				     		  <td>${svrc.employee.empName }</td>
				     		  <td>${svrc.employee.positionCode }</td>
				     		  <td>${svrc.svrcDate }</td>
				     		  <td class="text-right"><fmt:formatNumber value="${svrc.svrcCost }" pattern="#,###"/></td>
				     		  <td class="text-left">${svrc.svrcComment }</td>
				     		  <td>
					     		  <input type="button" class="btn btn-primary delBtn" name="deleteBtn" value="삭제">
				     		  </td>
						<tr>
					</c:forEach>
				</c:if>			
				<c:if test="${empty svrcList }">
					<tr>
						<td colspan="7">검색 조건에 맞는 내역이 없습니다.</td>
					</tr>
				</c:if>			
			  </tbody>
		</table>
	</div>
	<!-- 정산 리스트 끝 -------------------------------->
	
	<!-- 페이징 처리 ------------------------------------->
	<div id="pagingArea">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
	</div>
	<!-- 페이징 처리 끝 ----------------------------------->
</div>

<!-- 정산내역 등록, 수정 모달 ----------------------------------- -->
<div class="modal" id="svrcModal">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
    
<!--     	  modal header -->
	      <div class="modal-header">
	        <p class="modal-title">- 정산 내역</p>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      
<!-- 	      modal body -->
	      <div class="modal-body" >
				<div>
				 	<c:url value="/office/severance/svrcInsert.do" var="insertURL"/>
					<c:url value="/office/severance/svrcUpdate.do" var="updateURL"/>
					<form id="svrcForm" action="${cPath }/office/severance/svrcInsert.do" method="POST" data-insert="${insertURL }" data-update="${updateURL }"> 
						 <table class="table table-bordered text-center">
						    <tbody>
							    <tr>
							        <td width="30%" class="align-middle">성명</td>
							        <td width="70%">
							        	<input type="hidden" id="svrcNo" name="svrcNo" class="form-control" value="">
								        <select id="memId" name="memId" class="custom-select " required>
								      	    <option value="">전체</option>
								      	    <c:forEach items="${empSelectList }" var="empSel">
												<option value="${empSel.member.memId}">${empSel.empName }(${empSel.position.positionName })</option>
											</c:forEach>
										</select>
									</td>
							      </tr>
							      <tr>
							      	<td class="align-middle">지급일 </td>
							        <td>
							      	 <input type="date" id="svrcDate" class="form-control" name="svrcDate" value="" required/>
				   					 <form:errors path="svrcDate" element="span" cssClass="error"/>
							      	</td>
							      </tr>	
							      <tr>
							      	<td>지급액<br>(단위 : 원)</td>
							        <td>
							      	 	<input type="text" id="svrcCost" name="svrcCost" class="form-control onlyNumber" value="" required>
							      	</td>
							      </tr>	
							      <tr>
							      	<td>비고<br>(관련 문서)</td>
							        <td>
							      	 	<input type="text" id="svrcComment" name="svrcComment" class="form-control" value="" required>
							      	</td>
							      </tr>	
						    </tbody>
						  </table>
					  </form>
<!-- 				정산 form 끝 -->
				</div>
	      </div>
	      
<!-- 	      modal footer -->
	      <div class="modal-footer">
	        <input type="button" class="btn btn-dark" value="등록" id="insertBtn">
	        <input type="button" class="btn btn-dark" value="수정" id="updateBtn">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
      	</div>
    </div>
 </div>
<!-- 정산 모달 끝 -------------------------------- -->
<script>

	//== 공통 ========================================================================================
	
	//페이지 이동
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		return false;
	}
	
	//검색 Form submit
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
	
	//모달 닫으면 값 초기화 
	$('.modal').on('hidden.bs.modal', function (e) {
		  $(this).find('form')[0].reset();
		  
		  $("#memId").attr("disabled", false);
	});
	
	//form 정의
	let svrcForm =  $("#svrcForm");
	
	//validation Check(tooltip)
	const validateOptions = {
        onsubmit:true
        ,onfocusout:function(element, event){
           return this.element(element);
        }
        ,errorPlacement: function(error, element) {
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
	
	svrcForm.validate(validateOptions);
	
	$("#svrcSumBtn").on("click", function(){
		location.href = "${cPath}/office/severance/severanceView.do";
	});
	
	/////
	 $(".onlyNumber").keypress(function (event) {
         if (event.which && (event.which < 48 || event.which > 57)) {   //숫자만 받기
             event.preventDefault();
         }
     }).keyup(function () {
         if ($(this).val() != null && $(this).val() != '') {
             var text = $(this).val().replace(/[^0-9]/g, '');
             $(this).val(numberWithCommas(text));
         }
     });
	
	 
	 function removeCommas(x){
	 	 return x.replace(/,/g, "");
	 }
	 
	 $("#insertBtn, #updateBtn").on("click", function(){
		 let flag = null;
		 let action = null;
		 
		 if($(this).prop("id")=="insertBtn"){
			 flag = confirm("등록하시겠습니까?");
			 action = svrcForm.data("insert");
		 }else{
			 flag = confirm("수정하시겠습니까?");
			 action = svrcForm.data("update");
		 }
		 if(flag){
			 $("#svrcCost").val(removeCommas($("#svrcCost").val()));
			 svrcForm.attr("action", action);
			 $("#memId").attr("disabled", false);
			 svrcForm.submit();		
			 $("#memId").attr("disabled", true);
		 }		 
	});
	
	$("#listBody").on("dblclick", "tr", function(){
		let svrcNo = this.dataset.svrcNo;
		console.log(svrcNo);
		$.ajax({
			url:"${cPath }/office/severance/svrcViewForUpdate.do"
			,data : {"svrcNo" : svrcNo}
			,method : "get"
			,success : function(resp){
				if(resp.message){
					getNoty(resp);
					return;
				}else{
					$("#memId").attr("disabled", true);
					$("#svrcNo").val(resp.svrc.svrcNo);
					$("#memId").val(resp.svrc.employee.memId);
					$("#svrcDate").val(resp.svrc.svrcDate);
					$("#svrcCost").val(numberWithCommas(resp.svrc.svrcCost));
					$("#svrcComment").val(resp.svrc.svrcComment);
					$("#svrcModal").modal("show");
				}
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
		
	})
	 
	$(".delBtn").on("click", function(){
		let tr = $(this).closest("tr");
		let svrcNo = tr[0].dataset.svrcNo;
		let confirmChk = confirm("정산내역을 삭제하시겠습니까?");
		
		if(confirmChk){
			 $.ajax({
				url:"${cPath }/office/severance/svrcDelete.do"
				,data : {"svrcNo" : svrcNo}
				,method : "get"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						return;
					}
					alert("삭제되었습니다.");
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
   