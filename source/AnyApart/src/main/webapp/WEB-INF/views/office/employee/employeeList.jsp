<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 2.      이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<style>
	* {box-sizing: border-box;}
	
	.memPictureUpdate {
	  position: relative;
	  width: 50%;
	  max-width: 300px;
	}
	
	.image {
	  display: block;
	  width: 100%;
	  height: auto;
	}
	
	.overlay {
	  position: absolute; 
	  bottom: 0; 
	  background: rgb(0, 0, 0);
	  background: rgba(0, 0, 0, 0.5); /* Black see-through */
	  color: #f1f1f1; 
	  width: 100%;
	  transition: .5s ease;
	  opacity:0;
	  color: white;
	  font-size: 20px;
	  padding: 20px;
	  text-align: center;
	}
	
	.memPictureUpdate:hover .overlay {
	  opacity: 1;
	}
	
	.employeeDetailTb td:nth-child(2n+1) {
	  background-color: #ffcccc;
	}
	
	.employeeDetailTb{
	   text-align:center;
	  text-align:center;
	  font-weight: bold;
	  font-size:15pt;
	  border-color: 1px solid black; 
	}
		
	#noticeSpan{
		color:blue;
	}
</style>

<!-- 상태유지시 상태값 넘김-------------------------------------------------------------------------------------------->
<form id="viewForm" method="get" action="${cPath }/office/employee/employeeInfoView.do">
	<input type="hidden" name="page" value="${param.page }"/>
	<input type="hidden" name="memId"  />
	<input type="hidden" name="positionCode" value="${pagingVO.searchDetail.positionCode }" />
	<input type="hidden" name="empName" value="${pagingVO.searchDetail.empName }" />
</form>
<br>
<h2><strong>직원조회</strong></h2>
<br>

<!-- 서버 --------------------------------------------------------------------------------------------------------->
<form id="searchForm">
	<input type="hidden" name="searchVO.searchAptCode" value="${authMember.aptCode}">
	<input type="hidden" name="page" />
	<input type="hidden" name="positionCode" value="${pagingVO.searchDetail.positionCode }"/>
	<input type="hidden" name="empName" value="${pagingVO.searchDetail.empName }"/>
</form>

<!-- 클라이언트 ----------------------------------------------------------------------------------------------------->
<div class="container d-flex justify-content-center" >
	<div class="col-md-6  " style="border-style:outset;border-radius: 8px;">
		  <div class="row g-0 ml-3">
			    <div class="col-md-4 mt-4 ">
			      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
			        style="width:30px;height:30px;margin-left:10px;margin-top:10px;">&nbsp;&nbsp;<strong>검색 조건</strong>
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
</div>
<br>
	
<div class="d-flex justify-content-between mb-3">
   <div><span id="noticeSpan" >* 각 행을 더블클릭하면 상세 정보를 조회할 수 있습니다.</span></div>
   <div class="d-flex justify-content-end"><button class="btn btn-dark" style='margin:5pt;' onclick="printBt()">인쇄</button></div>
</div>
 <div class="card text-center col-auto">
	   <div class="card-header">
	    <ul class="nav nav-tabs card-header-tabs">
	      <li class="nav-item">
	        <a class="nav-link text-dark active" href="#"><strong>관리사무소직원</strong></a>
	      </li>
	    </ul>
	  </div>
	  <div class="card-body row">
		  <div class="col-sm-12" id="printDiv">
			<table class="table table-hover">
			  <thead class="thead-light">
			    <tr>
			      <th scope="col">사용자코드</th>
			      <th scope="col">사원명</th>
			      <th scope="col">직책</th>
			      <th scope="col">생년월일</th>
			      <th scope="col">핸드폰번호</th>
			      <th scope="col">입사일/계약일</th>
			    </tr>
			  </thead>
			  <tbody id="listBody">
			  <c:set var="employeeList" value="${pagingVO.dataList }" />
			  	<c:if test="${not empty employeeList }">
			  		<c:forEach items = "${employeeList }" var="employee">
			  			<tr data-mem-id='${employee.member.memId }'>
				     		  <td>${employee.member.memId }</td>
				     		  <td>${employee.empName }</td>
				     		  <td>${employee.position.positionName}</td>
				     		  <td>${employee.empBirth }</td>
				     		  <td>${employee.empHp }</td>
				     		  <td>${employee.empStart }</td>
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
		</div>	
	</div>
	<div id="pagingArea">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
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
</script>
