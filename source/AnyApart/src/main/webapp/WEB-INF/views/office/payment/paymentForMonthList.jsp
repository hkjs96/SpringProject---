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
	 #empIdSel, #basePaySel{
	 	display:none;
	 }
	 
	 
	#viewBtn, #deleteBtn{
		font-size:14px;
		width: 70px;
		height: 25px; 
		margin: 2px;
		line-height: 10px;
	}
	
	#searchBorderDiv{
		height: 5.5em;
	}
	
	.leftDiv{
		float: left;
	}
	
	.inputPayDiv{
		height: 350px;
		width: 43.8em;
		
	}
	
	.inputUpdatePayDiv{
		height: 350px;
		width: 45em;
	}
	
	.inputInsertPayTb{
		margin-top: 5px;
	}
	.inputInsertPayTb tr{
		height:30px;
		
	}
	
	.inputUpdatePayTb{
		margin-top: 50px;
		width: 40em;
	}

	.payLawDiv, .mainTbDiv, .searchDiv, #inputUI{
		float: left;
	}
	
	.mainTbDiv{
		margin-top: 3em;
	}
	
	#payLawDiv{
		font-size: 14px;
	}
	
	.lawP{
		color: blue;
	}
	
	#payLawTitleSpan{
		font-size: 18px;
	}
	
	#payLawTitleDiv{
		margin: 0 auto;
	}
	
	#searchImg{
		width:30px;
		height:30px;
		float:left;
		margin:15px;
	}
	
</style>

<!-- 서버 ----------------------------------------------->
<form id="searchForm">
	<input type="hidden" name="searchVO.searchAptCode" value="${authMember.aptCode}">
	<input type="hidden" name="page" />
	<input type="hidden" name="payYear" value="${pagingVO.searchDetail.payYear }"/>
	<input type="hidden" name="payMonth" value="${pagingVO.searchDetail.payMonth }"/>
	<input type="hidden" name="positionCode" value="${pagingVO.searchDetail.employee.positionCode }"/>
	<input type="hidden" name="empName" value="${pagingVO.searchDetail.employee.empName }"/>
	<input type="hidden" name="flag" value="${flag }">
</form>

<!-- 클라이언트 ------------------------------------------->
<br>
<h2 class="ml-2"><strong>급여산출</strong></h2>
<br>
<!-- 급여 지급 기준 Div -->
<div class="p-2 mr-4">
	<div class="col-sm-4 card-header payLawDiv" id="payLawDiv">
		<div class="card p-5">
		
		<div id="payLawTitleDiv">
			<span id="payLawTitleSpan" class="badge badge-info mb-4">급여 산출 기준</span>
		</div>
		
		<p class="lawP">* 국민연금</p>
		<table class="table table-sm table-bordered text-center align-self-center  ">
			<thead class="thead-light">
				<tr>
					<th>구분</th>
					<th>연금보험료(전체)</th>
					<th>근로자</th>
					<th>사업주</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>기준<br>소득월액</td>
					<td class="align-middle">${2*frMap.R_PENSION }%</td>
					<td class="align-middle">${frMap.R_PENSION }%</td>
					<td class="align-middle">${frMap.R_PENSION }%</td>
				</tr>
			</tbody>
		</table>
		<p class="lawP">* 건강보험</p>
		<table class="table table-sm table-bordered text-center align-self-center">
			<thead class="thead-light">
				<tr>
					<th>구분</th>
					<th>기준액</th>
					<th>보험료율</th>
					<th>근로자</th>
					<th>사업주</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="align-middle">건강보험료</td>
					<td>보수<br>월액</td>
					<td class="align-middle"><fmt:formatNumber value="${2*frMap.R_HEALTH }" pattern="#.##"/>%</td>
					<td class="align-middle">${frMap.R_HEALTH }%</td>
					<td class="align-middle">${frMap.R_HEALTH }%</td>
				</tr>
				<tr>
					<td>장기요양<br>보험료</td>
					<td>건강<br>보험료</td>
					<td class="align-middle">${frMap.R_YOYANG }%</td>
					<td>가입자 부담 <br>50%</td>
					<td>사업자 부담 <br>50%</td>
				</tr>
			</tbody>
		</table>
		<p class="lawP">* 고용보험</p>
		<table class="table table-sm table-bordered text-center align-self-center">
			<thead class="thead-light">
				<tr>
					<th colspan="2">구분</th>
					<th>근로자</th>
					<th>사업자</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="2">실업급여</td>
					<td>${frMap.R_EMPLOYEE }%</td>
					<td>${frMap.R_EMPLOYEE }%</td>
				</tr>
			</tbody>
		</table>
		<p class="lawP">* 소득세/지방소득세</p>
		<table class="table table-sm table-bordered text-center align-self-center ">
			<thead class="thead-light">
				<tr>
					<th>구분</th>
					<th>기준액</th>
					<th>근로자</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>소득세</td>
					<td class="align-middle">보수월액</td>
					<td>${frMap.R_INCOME }%</td>
				</tr>
				<tr>
					<td>지방소득세</td>
					<td class="align-middle">소득세</td>
					<td>${frMap.R_LOC_INCOME }%</td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
</div>
<!-- 급여 계산 내역 테이블 -->
<div class="col-sm-7 mainTbDiv ml-4" id="mainTbDiv">
	<div class="col-md-12 p-3" id="searchBorderDiv" style="border-style:outset;border-radius: 8px;">
	    <div class="col-sm-12 row g-0 searchDiv d-flex justify-content-start mt" >
	        <div class="row g-0 searchDiv justify-content-center col-sm-12 mb-2 ">
			    <div id="inputUI " >
			     <img id="searchImg" src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon">
			     <form class="form-inline ">
				      <div>
				      		<!-- 테이블 open 여부 확인하는 flag값 함께 넘기기 -->
			    			<input type="hidden" name="flag" id="flag" value="${flag }">
				        	지급연도&nbsp;&nbsp;
				        	<select class="custom-select col-sm-3 searchSelect" name="payYear">
				        		<option value="">전체</option>
								<c:forEach begin="2018" end="2050" var="year">
									<option value="${year }" ${pagingVO.searchDetail.payYear eq year ? 'selected':''}>${year }</option>
								</c:forEach>
							</select>
							&nbsp;&nbsp;지급월&nbsp;&nbsp;
				        	<select class="custom-select col-sm-3 searchSelect" name="payMonth">
				        		<option value="">전체</option>
								<c:forEach begin="1" end="12" var="month">
									<option value="${month }" ${pagingVO.searchDetail.payMonth eq month ? 'selected':''}>${month }</option>
								</c:forEach>
							</select>
				        	&nbsp;&nbsp;직책&nbsp;&nbsp;
				        	<select id="positionCode" name="positionCode" class="custom-select col-sm-2">
				        	   <option value="">전체</option>
								<c:forEach items="${positions }" var="position" varStatus="vs">
									<c:if test="${not empty position.positionCode }">
										<option value="${position.positionCode }" ${pagingVO.searchDetail.employee.positionCode eq position.positionCode ? 'selected':''}>"${position.positionName }"</option>
									</c:if>
								</c:forEach>
							</select>
				        	&nbsp;&nbsp;성명&nbsp;&nbsp;
					       	<input type="text" name="empName" class="form-control col-sm-2" value="${pagingVO.searchDetail.employee.empName }"> 
							<button class="btn btn-dark" style='margin:5pt;' id="searchBtn">검색</button>
							<button class="btn btn-secondary" id="resetBtn">초기화</button>
			  		  </div>
			      </form>
			    </div>
		  </div>
	    </div>
	</div>
	<!-- 급여 계산 테이블 open, close Button -->
	<div class="col-sm-2" style="float:left;">
		<input type="button" id="showLawDivBtn" class="btn btn-info mb-1 mr-1 mt-5" value="◀ 자세히">
	    <input type="button" id="hideLawDivBtn" class="btn btn-info mb-1 mr-1 mt-5" value="▶ 간단히">
	</div>	
	<div class="col-sm-10 d-flex justify-content-end" style="float:left;">
	  <!-- 새 급여자료 등록 -->
	  <input type="button" class="btn btn-primary mb-1 mr-1 mt-5" role="alert" value="등록" data-toggle="modal" data-target="#insertModal">
	  <!-- 현재 화면 인쇄 -->
	  <input type="button" class="btn btn-dark mb-1 mr-1 mt-5" role="alert" value="인쇄">
	</div>		
	<table id = "mainTb" class="table text-center align-self-center table-hover">
	  <!-- thead ------->
	  <thead class="thead-light ">
	    <tr>
	      <th class="align-middle" rowspan="2">직원번호</th>
	      <th class="align-middle " rowspan="2">성명</th>
	      <th class="align-middle " rowspan="2">지급연도</th>
	      <th class="align-middle" rowspan="2">지급월</th>
	      <th class="align-middle hideEle" rowspan="2">기본급</th>
	      <th class="align-middle hideEle" rowspan="2">직책 수당</th>
	      <th class="align-middle hideEle" rowspan="2">식대</th>
	      <th class="align-middle hideEle" colspan="3">공제항목</th>
	      <th class="align-middle hideEle" rowspan="2">소득세</th>
	      <th class="align-middle hideEle" rowspan="2">지방소득세</th>
	      <th class="align-middle " rowspan="2">수령액<br>(단위 : 원)</th>
	      <th class="align-middle " rowspan="2"></th>
	    </tr>
	    <tr>
	      <th class="align-middle hideEle">건강보험</th>
	      <th class="align-middle hideEle">국민연금</th>
	      <th class="align-middle hideEle">고용보험</th>
	    </tr>
	  </thead>
	  <!-- tbody ------->
	  <tbody id="listBody" >
	  <c:set var="payList" value="${pagingVO.dataList }"/>
	  	<c:if test="${not empty payList }">
	  		<c:forEach items="${payList }" var="pay">
	  			<tr data-pay-no=${pay.payNo }>
	 			  <td class="align-middle">${pay.employee.memId }</td>
			      <td class="align-middle ">${pay.employee.empName }</td>
			      <td class="align-middle ">${pay.payYear }</td>
			      <td class="align-middle ">${pay.payMonth }</td>
			      <td class="align-middle text-right hideEle">
			      <fmt:formatNumber value="${pay.payBase }" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right hideEle">
			      <fmt:formatNumber value="${pay.payPlus }" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right hideEle">
			      <fmt:formatNumber value="${pay.payMeal }" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right hideEle">
			      <fmt:formatNumber value="${pay.payHealth }" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right hideEle">
			      <fmt:formatNumber value="${pay.payPension }" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right hideEle">
			      <fmt:formatNumber value="${pay.payEmployee}" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right hideEle">
			      <fmt:formatNumber value="${pay.payIncometax }" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right hideEle">
			      <fmt:formatNumber value="${pay.payLocalIncometax }" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right">
			      <fmt:formatNumber value="${pay.payRealsum }" pattern="#,###"/>
			      </td>
			      <td class="align-middle text-right form-inline justify-content-center">
			      	<input type="hidden" class="form-control" name="payNo" value="${pay.payNo }"/>
		     		<input type="button" name="viewBtn" class="btn btn-warning mr-2" value="수정" >
		     		<input type="button" class="btn btn-danger deleteBtn" value="삭제">
			      </td>
	  			</tr>
	  		</c:forEach> 
	  	</c:if>
	  	<c:if test="${empty payList }">
	  		<tr>
	  			<td colspan="14">조회 결과가 없습니다.</td>
	  		</tr>
	  	</c:if>
	  </tbody>
	</table>
	
	<!-- 페이징 처리 -->
	<div id="pagingArea">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
	</div>
</div>

<!-- 급여자료 등록 모달 -->
<div class="modal" id="insertModal">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

	      <!-- Modal Header -->
	      <div class="modal-header">
	        <p class="modal-title" style="font-size:15pt;">- 월별 급여자료 등록</p>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body" >
				<div>
					<form id="insertForm" method="POST">
					<div class="col-sm-12">
					 <table class="table table-bordered text-center ">
					    <tbody>
					      <tr>
					        <td class="align-middle table-secondary">지급연도</td>
					        <td class="align-middle">
								<select name="payYear" class="custom-select">
									<option value="">전체</option>
									<c:forEach begin="2018" end="2050" var="year">
									<option>${year }</option>
									</c:forEach>
								</select>
							</td>
					        <td class="align-middle table-secondary">지급월</td>
					         <td class="align-middle">
					        <select name="payMonth" class="custom-select">
					      	    <option value="">전체</option>
					      	    <c:forEach begin="1" end="12" var="month">
									<option>${month }</option>
								</c:forEach>
							</select>
							</td>
					        <td class="align-middle table-secondary">직원이름</td>
					        <td class="align-middle">
								<input type="text" id="insertModalempName" class="form-control" value="" readonly> 
								<input type="hidden" id="insertModalmemId" name="memId" class="form-control" value=""> 
							</td>
							<td>
								<input type="button" value="급여 계산" class="btn btn-primary" id="insertPaySumBtn">
							</td>
					      </tr>
					    </tbody>
					  </table>
				  		 <select id="empIdSel">
				      	    <c:forEach items="${empSelectList }" var="empSel">
								<option value="${empSel.member.memId }">${empSel.member.memId }</option>
							</c:forEach>
						</select>
						<select id="basePaySel">
				      	    <c:forEach items="${empSelectList }" var="empSel">
								<option value="${empSel.position.positionPay }">${empSel.position.positionPay }</option>
							</c:forEach>
						</select>
					  </div>
					 <div class="leftDiv col-sm-4" id="insertDiv">
					  <div class="form-inline mb-2">					  
					  	<input type="text" id="insertEmpSearch" name="insertEmpSearch" class="form-control" value="${pagingVO.searchDetail.employee.empName }" placeholder="이름으로 검색"> 
					  	<input type="button" value="검색" class="btn btn-dark ml-2" id="searchEmpBtn" >
					  	<input type="button" value="초기화" class="btn btn-secondary ml-2" id="insertPayEmpResetBtn">
					  </div>
						<select id="insertModalEmpSearch" name="insertModalEmpSearch" class="form-control leftDiv insertModalEmpSearch" size="15">
							<c:forEach items="${empSelectList }" var="empSel">
								<option value="${empSel.member.memId}">${empSel.member.memId} / ${empSel.empName }(${empSel.position.positionName })</option>
							</c:forEach>
						</select> 
					</div>
					 <div class="leftDiv ml-4 card card-header inputPayDiv">
					  <table class="inputInsertPayTb table-sm">
						 <tr>
		   					 <th style="width: 25%">기본급</th>
						  	<th style="width: 25%"><input type="text" required id="insertPayBase" name="payBase" class="form-control" value="${payment.payBase }"/>
		   					 <form:errors path="payBase" element="span" cssClass="error"/></th>
		   					 <th style="width: 25%" class="ml-2">&nbsp;&nbsp;&nbsp;건강보험</th>
						  	<th style="width: 25%"><input type="text" required id="insertPayHealth" name="payHealth" class="form-control" value="${payment.payHealth }"/>
		   					 <form:errors path="payHealth" element="span" cssClass="error"/></th>
						  </tr>
						  <tr>
						  	<td>직책수당</td>
						  	<td><input type="text" required id="insertPayPlus" name="payPlus" class="form-control" value="${payment.payPlus }"/>
		   					 <form:errors path="payPlus" element="span" cssClass="error"/></td>
		   					 <td>&nbsp;&nbsp;&nbsp;국민연금</td>
						  	<td><input type="text" required id="insertPayPension" name="payPension" class="form-control" value="${payment.payPension }"/>
		   					 <form:errors path="payPension" element="span" cssClass="error"/></td>
						  </tr>
						  <tr>
						  	<td>식대</td>
						  	<td><input type="text" required id="insertPayMeal" name="payMeal" class="form-control" value="${payment.payMeal }"/>
		   					 <form:errors path="payMeal" element="span" cssClass="error"/></td>
		   					 <td>&nbsp;&nbsp;&nbsp;고용보험</td>
						  	<td><input type="text" required id="insertPayEmployee" name="payEmployee" class="form-control" value="${payment.payEmployee }"/>
		   					 <form:errors path="payEmployee" element="span" cssClass="error"/></td>
						  </tr>
						  <tr>
						    <td>소득세</td>
						  	<td><input type="text" required id="insertPayIncometax" name="payIncometax" class="form-control" value="${payment.payIncometax }"/>
		   					 <form:errors path="payIncometax" element="span" cssClass="error"/></td>
						  	<td>&nbsp;&nbsp;&nbsp;지방소득세</td>
					  		<td><input type="text" required id="insertPayLocalIncometax" name="payLocalIncometax" class="form-control" value="${payment.payLocalIncometax }"/>
	   					    <form:errors path="payLocalIncometax" element="span" cssClass="error"/></td>
						  </tr>
						  <tr>
						  	<td></td>
						  	<td></td>
						    <td>&nbsp;&nbsp;&nbsp;급여계</td>
					  		<td><input type="text" required id="insertPayTmpsum" class="form-control" value="${payment.paySum }"/>
						  </tr>
						  <tr>
						  	<td></td>
						  	<td></td>
						    <td>&nbsp;&nbsp;&nbsp;공제합계</td>
					  		<td><input type="text" required id="insertPayDeductsum" class="form-control" value="${payment.payDeductsum }"/>
						  </tr>
						  <tr>
						  	<td></td>
						  	<td></td>
						    <td>&nbsp;&nbsp;&nbsp;실수령액</td>
					  		<td><input type="text" required id="insertPayRealsum" class="form-control" value="${payment.payRealsum }"/>
						  </tr>
					 </table>
					</div>
					  </form>
				</div>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" id="insertBtn">저장</button>
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
      	</div>
    </div>
 </div>
<!-- 모달 끝 -->

<!-- 급여자료 수정 모달 -->
<div class="modal" id="updateModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

	      <!-- Modal Header -->
	      <div class="modal-header">
	        <p class="modal-title" style="font-size:15pt;">- 월별 급여자료 수정</p>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body" >
				<div>
					<form id="updateForm" method="POST">
					<div class="col-sm-12">
					 <table class="table table-bordered text-center">
					    <tbody>
					      <tr>
					        <td class="align-middle">지급연도</td>
					        <td class="align-middle">
					       		<input type="hidden" id="updatePayNo" name="payNo" class="form-control" value=""> 
								<select id="updateYear" name="payYear" class="custom-select" >
									<c:forEach begin="2018" end="2050" var="year">
									<option >${year }</option>
									</c:forEach>
								</select>
							</td>
					        <td class="align-middle">지급월</td>
					         <td class="align-middle">
					        <select id="updateMonth" name="payMonth" class="custom-select">
					      	    <c:forEach begin="1" end="12" var="month">
									<option >${month }</option>
								</c:forEach>
							</select>
							</td>
					        <td class="align-middle">직원이름</td>
					        <td class="align-middle">
								<input type="text" id="updateEmpName" class="form-control" value="" readonly> 
								<input type="hidden" id="updateMemId" name="memId" class="form-control" value=""> 
							</td>
					      </tr>
					    </tbody>
					  </table>
					  </div>
					 <div class="leftDiv ml-4 card card-header inputUpdatePayDiv">
					  <table class="inputUpdatePayTb table-sm ">
						 <tr>
		   					 <th style="width: 25%">기본급</th>
						  	<th style="width: 25%"><input type="text" id="updateBase" name="payBase" class="form-control onlyNumber" value="${payment.payBase }" required/>
		   					 <form:errors path="payBase" element="span" cssClass="error"/></th>
		   					 <th style="width: 25%" class="ml-2">&nbsp;&nbsp;&nbsp;건강보험</th>
						  	<th style="width: 25%"><input type="text" required id="updateHealth" name="payHealth" class="form-control onlyNumber" value="${payment.payHealth }" required/>
		   					 <form:errors path="payHealth" element="span" cssClass="error"/></th>
						  </tr>
						  <tr>
						  	<td>직책수당</td>
						  	<td><input type="text" required id="updatePlus" name="payPlus" class="form-control onlyNumber" value="${payment.payPlus }"/>
		   					 <form:errors path="payPlus" element="span" cssClass="error"/></td>
		   					 <td>&nbsp;&nbsp;&nbsp;국민연금</td>
						  	<td><input type="text" required id="updatePension" name="payPension" class="form-control onlyNumber" value="${payment.payPension }"/>
		   					 <form:errors path="payPension" element="span" cssClass="error"/></td>
						  </tr>
						  <tr>
						  	<td>식대</td>
						  	<td><input type="text" required id="updateMeal" name="payMeal" class="form-control onlyNumber" value="${payment.payMeal }"/>
		   					 <form:errors path="payMeal" element="span" cssClass="error"/></td>
		   					 <td>&nbsp;&nbsp;&nbsp;고용보험</td>
						  	<td><input type="text" required id="updateEmployee" name="payEmployee" class="form-control onlyNumber" value="${payment.payEmployee }"/>
		   					 <form:errors path="payEmployee" element="span" cssClass="error"/></td>
						  </tr>
						  <tr>
						    <td>소득세</td>
						  	<td><input type="text" required id="updateIncometax" name="payIncometax" class="form-control onlyNumber" value="${payment.payIncometax }"/>
		   					 <form:errors path="payIncometax" element="span" cssClass="error"/></td>
						  	<td>&nbsp;&nbsp;&nbsp;지방소득세</td>
					  		<td><input type="text" required id="updateLocalIncometax" name="payLocalIncometax" class="form-control onlyNumber" value="${payment.payLocalIncometax }"/>
	   					    <form:errors path="payLocalIncometax" element="span" cssClass="error"/></td>
						  </tr>
					 </table>
					</div>
					  </form>
				</div>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-dark" id="updateBtn">수정</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
      	</div>
    </div>
 </div>
<!-- 모달 끝 -->

<script>

	//== 공통 ==========================================================================
		
	//페이지 이동	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		return false;
	}
	
	//검색조건 입력 후 검색 버튼 클릭
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
	
	// 검색 초기화 버튼 클릭
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
	
	let updateForm = $("#updateForm");
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
	
	updateForm.validate(validateOptions);
	
	//시작할 때 테이블 setting
	$(function(){
		var flag = "<c:out value='${flag}'/>"; 
		//flag가 N이면 테이블 closed(간단히) 설정된 것
		if(flag == 'N'){
			$( '#payLawDiv' ).show();
			$('#mainTb thead, #mainTb tbody').find(".hideEle").hide();
			$( '#mainTbDiv' ).removeClass( 'col-sm-12' );
			$( '#mainTbDiv' ).addClass( 'col-sm-7' );
			$( '#flag' ).val('N');
			$( '#showLawDivBtn' ).show();
			$( '#hideLawDivBtn' ).hide();
		//flag가 Y이면 테이블 open(자세히) 설정된 것
		}else{
			$( '#payLawDiv' ).hide();
			$('#mainTb thead, #mainTb tbody').find(".hideEle").show();
			$( '#mainTbDiv' ).removeClass( 'col-sm-7' );
			$( '#mainTbDiv' ).addClass( 'col-sm-12' );
			$( '#flag' ).val('Y');
			$( '#hideLawDivBtn' ).show();
			$( '#showLawDivBtn' ).hide();
		}	
	});
	
	//자세히 버튼 클릭하면 테이블 open
	$("#showLawDivBtn").on("click", function(){
		//급여기준표 숨김
		$( '#payLawDiv' ).hide();
		
		$('#mainTb thead, #mainTb tbody').find(".hideEle").show();
		$( '#mainTbDiv' ).removeClass( 'col-sm-7' );
		$( '#mainTbDiv' ).addClass( 'col-sm-12' );
		$( '#flag' ).val('Y');
		$( '#hideLawDivBtn' ).show();
		$(this).hide();
	});

	//간단히 버튼 클릭하면 테이블 closed
	$("#hideLawDivBtn").on("click", function(){
		//급여기준표 표시
		$( '#payLawDiv' ).show();
	
		$('#mainTb thead, #mainTb tbody').find(".hideEle").hide();
		$( '#mainTbDiv' ).removeClass( 'col-sm-12' );
		$( '#mainTbDiv' ).addClass( 'col-sm-7' );
		$( '#flag' ).val('N');
		$( '#showLawDivBtn' ).show();
		$(this).hide();
	});
	
	//모달 닫으면 값 초기화 
	$('.modal').on('hidden.bs.modal', function (e) {
		  $(this).find('form')[0].reset();
	});
	
	//== 급여 등록 =====================================================================
		
	//모달창에서 직원 검색
	$("#searchEmpBtn").on("click", function(){
		
		let selSize = insertPayDelIdx.length;
		for(var i=0; i<selSize; i++){
			$("#insertModalEmpSearch option:eq('"+insertPayDelIdx[i]+"'"+")").show();
		}
			insertPayDelIdx  = new Array();
		
		//검색 입력값 
		let searchVal = $("#insertEmpSearch").val();
	
		//검색 대상 selectBox의 전체 option 수
		let wholeSelSize = $("#insertModalEmpSearch option").length;
		
	// 	console.log(selSize);
		for(var i=0; i<wholeSelSize ; i++){
		 	if($("#insertModalEmpSearch option:eq('"+i+"'"+")").text().indexOf(searchVal) == -1) {
		 		console.log($("#insertModalEmpSearch option:eq('"+i+"'"+")").val());
		 		console.log($("#insertModalEmpSearch option:eq('"+i+"'"+")").text());
		 		insertPayDelIdx.push($("#insertModalEmpSearch option").index($("#insertModalEmpSearch option:eq('"+i+"'"+")")));
		 		$("#insertModalEmpSearch option:eq('"+i+"'"+")").hide();
		 	}
		}
	});
	
	//급여 등록 모달에서 직원 이름 선택 시 
	$("select[name=empNameSel]").change(function(){
		  var idx = $("#empNameSel option").index( $("#empNameSel option:selected") );
		  $("#empIdSel option").eq(idx).prop("selected", true);
		  $("#basePaySel option").eq(idx).prop("selected", true);
		  
		  $('#insertModal').find('#insertForm').reset();
	});
	
	var insertPayDelIdx = new Array();
	
	$("#insertPayEmpResetBtn").on("click", function(){
		let selSize = insertPayDelIdx.length;
		for(var i=0; i<selSize; i++){
			$("#insertModalEmpSearch option:eq('"+insertPayDelIdx[i]+"'"+")").show();
		}
			insertPayDelIdx  = new Array();
			
			$("#insertEmpSearch").val("");
	});
	
	$("#insertModalEmpSearch").on("click", function(){
		let selectedMemId = $("#insertModalEmpSearch option:selected").val();
		console.log(selectedMemId);
		let seletedVal = $("#insertModalEmpSearch option:selected").text();
		console.log(seletedVal);
		
		 $("#insertModalempName").val(seletedVal);
		 $("#insertModalmemId").val(selectedMemId);
	});	
		
	 let insertForm = $("#insertForm");
	 $("#insertPaySumBtn").on("click", function(){
		 $.ajax({
			url:"${cPath }/office/payment/paySum.do"
			,data : insertForm.serialize()
			,method : "post"
			,success : function(resp){
				if(resp.message){
					getNoty(resp);
					return;
				}else{
					$("#insertPayBase").val(numberWithCommas(resp.payment.payBase));
					$("#insertPayPlus").val(numberWithCommas(resp.payment.payPlus));
					$("#insertPayMeal").val(numberWithCommas(resp.payment.payMeal));
					$("#insertPayHealth").val(numberWithCommas(resp.payment.payHealth));
					$("#insertPayPension").val(numberWithCommas(resp.payment.payPension));
					$("#insertPayEmployee").val(numberWithCommas(resp.payment.payEmployee));
					$("#insertPayIncometax").val(numberWithCommas(resp.payment.payIncometax));
					$("#insertPayLocalIncometax").val(numberWithCommas(resp.payment.payLocalIncometax));
					$("#insertPayTmpsum").val(numberWithCommas(resp.payment.payTmpsum));
					$("#insertPayDeductsum").val(numberWithCommas(resp.payment.payDeductsum));
					$("#insertPayRealsum").val(numberWithCommas(resp.payment.payRealsum));
				}
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
	 });
	 
	 function removeCommas(x){
	 	 return x.replace(/,/g, "");
	 }
	 
	 $("#insertBtn").on("click", function(){
		 $("#insertPayBase").val(removeCommas($("#insertPayBase").val()));
		 $("#insertPayPlus").val(removeCommas($("#insertPayPlus").val()));
		 $("#insertPayMeal").val(removeCommas($("#insertPayMeal").val()));
		 $("#insertPayHealth").val(removeCommas($("#insertPayHealth").val()));
		 $("#insertPayPension").val(removeCommas($("#insertPayPension").val()));
		 $("#insertPayEmployee").val(removeCommas($("#insertPayEmployee").val()));
		 $("#insertPayIncometax").val(removeCommas($("#insertPayIncometax").val()));
		 $("#insertPayLocalIncometax").val(removeCommas($("#insertPayLocalIncometax").val()));
		 
		 let confirmChk = confirm("등록하시겠습니까?");
		 
		 if(confirmChk){
			 $.ajax({
				url:"${cPath }/office/payment/payForMonthInsert.do"
				,data : insertForm.serialize()
				,method : "post"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						return;
					}
					alert("등록되었습니다.");
					$('#insertModal').modal("hide");
					location.reload();
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		 }
	});
	 
	//== 급여 수정 =====================================================================

	//===============
	$(":button[name=viewBtn]").on("click", function(){
		let tr = $(this).closest("tr");
		let payNo = tr[0].dataset.payNo;
		$.ajax({
			url:"${cPath }/office/payment/payForMonthView.do"
			,data : { "payNo": payNo}
			,success : function(resp){
				$("#updateMemId").val(resp.pay.memId);
				$("#updateEmpName").val(resp.pay.employee.empName+"("+resp.pay.employee.positionCode+")");
				$("#updatePayNo").val(resp.pay.payNo);
				$("#updateYear").val(resp.pay.payYear);
				$("#updateMonth").val(resp.pay.payMonth);
				$("#updateBase").val(numberWithCommas(resp.pay.payBase));
				$("#updatePlus").val(numberWithCommas(resp.pay.payPlus));
				$("#updateMeal").val(numberWithCommas(resp.pay.payMeal));
				$("#updateHealth").val(numberWithCommas(resp.pay.payHealth));
				$("#updatePension").val(numberWithCommas(resp.pay.payPension));
				$("#updateEmployee").val(numberWithCommas(resp.pay.payEmployee));
				$("#updateIncometax").val(numberWithCommas(resp.pay.payIncometax));
				$("#updateLocalIncometax").val(numberWithCommas(resp.pay.payLocalIncometax));
				$("#updateModal").modal();
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
	});
	
	$("#updateSumBtn").on("click", function(){
		$("#updateSum").val(
					 parseInt($("#updateBase").val())
					+parseInt($("#updatePlus").val())
					+parseInt($("#updateMeal").val())
					-parseInt($("#updateHealth").val())
					-parseInt($("#updatePension").val())
					-parseInt($("#updateEmployee").val())
					-parseInt($("#updateIncometax").val())
					-parseInt($("#updateLocalIncometax").val())
		);
	});

	$("#updateBtn").on("click", function(){
		
		let confirmChk = confirm("수정하시겠습니까?");
		
		 $("#updateBase").val(removeCommas($("#updateBase").val()));
		 $("#updatePlus").val(removeCommas($("#updatePlus").val()));
		 $("#updateMeal").val(removeCommas($("#updateMeal").val()));
		 $("#updateHealth").val(removeCommas($("#updateHealth").val()));
		 $("#updatePension").val(removeCommas($("#updatePension").val()));
		 $("#updateEmployee").val(removeCommas($("#updateEmployee").val()));
		 $("#updateIncometax").val(removeCommas($("#updateIncometax").val()));
		 $("#updateLocalIncometax").val(removeCommas($("#updateLocalIncometax").val()));
		
		if(confirmChk){
			$.ajax({
				url:"${cPath }/office/payment/payForMonthUpdate.do"
				,data : updateForm.serialize()
				,method : "post"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						return;
					}
					
					alert("수정되었습니다.");
					$('#updateModal').modal("hide");
					location.reload();
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}
	});
	
	//== 급여 삭제 =====================================================================
	$(".deleteBtn").on("click", function(){
		let tr = $(this).closest("tr");
		let payNo = tr[0].dataset.payNo;
		let confirmChk = confirm("급여자료를 삭제하시겠습니까?");
		if(confirmChk){
			 $.ajax({
				url:"${cPath }/office/payment/payForMonthDelete.do"
				,data : {"payNo" : payNo}
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
