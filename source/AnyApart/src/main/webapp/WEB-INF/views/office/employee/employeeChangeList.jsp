<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 2.      이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<style>
	#searchImg{
		width:30px;
		height:30px;
		margin-left:20px;
	}
	
	#searchBtn{
		margin:5px;
	}
	
	.searchIconDiv{
		margin-left:5em;
	}
	
	#searchImgDiv{
		margin-top:1em;
	}
	
	#noticeSpan{
		color:blue;
	}
</style>

<!-- 상세조회 시 상태유지위해 값 넘기는 폼  -->
<form id="viewForm" method="get" action="${cPath }/office/employee/employeeInfoView.do">
	<input type="hidden" name="memId"  />
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="empRetire" value="${pagingVO.searchDetail.empRetire }" />
	<input type="hidden" name="empName" value="${pagingVO.searchDetail.empName }" />
	<input type="hidden" name="searchStartS" value="${pagingVO.searchDetail.searchStartS }" />
	<input type="hidden" name="searchStartE" value="${pagingVO.searchDetail.searchStartE }" />
	<input type="hidden" name="searchEndS" value="${pagingVO.searchDetail.searchEndS }" />
	<input type="hidden" name="searchEndE" value="${pagingVO.searchDetail.searchEndE }" />
	<input type="hidden" name="changeFlag" value="Y" />
</form>
	
<div class="container">
	<br>
	<h4>
		<strong>입/퇴사자 조회 </strong>
		<img id="questionImg" data-toggle="popover" data-content="입/퇴사한 직원을 조회할 수 있으며, 직원 상세 화면에서 재직상태를 변경할 수 있습니다." class="ml-2" style="width: 30px; height: 30px;" src="${cPath }/images/question.png" />
	</h4>
	<br>
	<div class="d-flex justify-content-end">
	    <div class="d-flex justify-content-end"></div>
	</div>
	<div style="border-style:outset;border-radius: 8px;">
		  <div class="row g-0 ml-2">
			    <div id="searchImgDiv">
			      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon" id="searchImg" >&nbsp;&nbsp;<strong>검색 조건</strong>
			    </div>
			    <form id="searchForm">
			 	    <input type="hidden" name="searchVO.searchAptCode" value="${authMember.aptCode}">
					<input type="hidden" name="page" />
					<input type="hidden" name="empRetire" value="${pagingVO.searchDetail.empRetire }"/>
					<input type="hidden" name="empName" value="${pagingVO.searchDetail.empName }"/>
					<input type="hidden" name="searchStartS" value="${pagingVO.searchDetail.searchStartS }"/>
					<input type="hidden" name="searchStartE" value="${pagingVO.searchDetail.searchStartE }"/>
					<input type="hidden" name="searchEndS" value="${pagingVO.searchDetail.searchEndS }"/>
					<input type="hidden" name="searchEndE" value="${pagingVO.searchDetail.searchEndE }"/>
				</form>
			    <div id="inputUI">
				    <form class="form-inline">
				      <div class="card-body ">
				        	&nbsp;&nbsp;재직구분&nbsp;&nbsp;
				        	<select class="custom-select searchSelect" name="empRetire" >
				        		<option value="">전체</option>
				        		<option value="N" ${pagingVO.searchDetail.empRetire eq "N" ? "selected" : "" }>재직</option>
				        		<option value="Y" ${pagingVO.searchDetail.empRetire eq "Y" ? "selected" : "" }>퇴직</option>
				        	</select> 
				        	&nbsp;&nbsp;성명&nbsp;&nbsp;
					       	<input type="text" name="empName" class="form-control" value="${pagingVO.searchDetail.empName }">
				      </div>
				      <div class="card-body">
			        		&nbsp;&nbsp;입사일&nbsp;&nbsp;
					       	<input type="date" name="searchStartS" class="form-control col-sm-2" value="${pagingVO.searchDetail.searchStartS }"> - 
					       	<input type="date" name="searchStartE" class="form-control col-sm-2" value="${pagingVO.searchDetail.searchStartE }">
					       	&nbsp;&nbsp;퇴사일&nbsp;&nbsp;
					       	<input type="date" name="searchEndS" class="form-control col-sm-2" value="${pagingVO.searchDetail.searchEndS }"> - 
					       	<input type="date" name="searchEndE" class="form-control col-sm-2" value="${pagingVO.searchDetail.searchEndE }">
				     	    <button class="btn btn-dark" id="searchBtn">검색</button>
				     	    <button class="btn btn-secondary" id="resetBtn">초기화</button>
				      </div>
				    </form>
			    </div>
		  </div>
		  
	</div>
	<br>
	<div class="d-flex justify-content-between mb-3">
	 	 <div><span id="noticeSpan">* 각 행을 더블클릭하면 상세 정보를 조회할 수 있습니다.</span></div>
   		 <div class="d-flex justify-content-end"><button class="btn btn-dark" style='margin:5pt;' onclick="printBt()">인쇄</button></div>
	</div>
	  <div class="text-center col-sm-12" id="printDiv">
		  <table class="table table-bordered table-hover" >
			  <thead class="thead-light">
			    <tr>
			      <th>사용자코드</th>
			      <th>성명</th>
			      <th>입사일자</th>
			      <th>퇴사일자</th>
			      <th>휴대폰번호</th>
			      <th>메일</th>
			    </tr>
			  </thead >
			  <tbody id="listBody">
			   <c:set var="employeeList" value="${pagingVO.dataList }" />
			  	<c:if test="${not empty employeeList }">
			  		<c:forEach items = "${employeeList }" var="employee">
			  			<tr data-mem-id='${employee.member.memId }'>
				     		  <td>${employee.member.memId }</td>
				     		  <td>${employee.empName }</td>
				     		  <td>${employee.empStart }</td>
				     		  <td>
					     		  <c:if test="${not empty employee.empEnd }">
					     		 	 ${employee.empEnd }
					     		  </c:if>
					     		  <c:if test="${empty employee.empEnd }">
					     		 	 -
					     		  </c:if>
				     		  </td>
				     		  <td>${employee.empHp }</td>
				     		  <td>${employee.empMail }</td>
						<tr>
					</c:forEach>
				</c:if>			
				<c:if test="${empty employeeList }">
					<tr>
						<td colspan="6">조회 결과가 없습니다.</td>
					</tr>
				</c:if>			
			  </tbody>
		</table>
	<div id="pagingArea">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
	</div>
	</div>
</div>

<script type="text/javascript">
	//더블클릭하면 상세조회 화면으로 이동
	let listBody = $("#listBody");
	listBody.on("dblclick", "tr", function() {
		let memId = this.dataset.memId;
		let viewForm = $("#viewForm");
		viewForm.find("[name='memId']").val(memId);
		viewForm.submit();
	});	
	
	//페이지 이동
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		return false;
	}

	//검색
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
	
	//리스트 인쇄
	function printBt() {
		var initBody = document.body.innerHTML;
		window.onbeforeprint = function () {
			document.body.innerHTML = document.getElementById("printDiv").innerHTML;
		}
		window.onafterprint = function () {
			window.location.reload()
		}
		window.print();
	}
	
	//검색내용 초기화
	$("#resetBtn").on("click", function() {
		// input 박스 비우도록
		let inputs = $(this).parents("div#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val(null);
		});

		// select 박스 첫번째 옵션이 선택되도록
		let selects = $("div#inputUI .searchSelect"); 
		$(selects).each(function(index, select) {
			$(select).children(":eq(0)").prop("selected", true);
		});

		syncFormWithUI(inputs);
	});
	
	//입퇴사자 조회 설명 팝업창
	$(document).ready(function(){
	    $('[data-toggle="popover"]').popover();   
	});

</script>