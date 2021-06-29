<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	.top {
		display: inline;
	}
	
	.wrapper {
	height:700px;
	overflow: auto;
	}

	.fixedHeader {
	   position: sticky;
	   top: 0;
	}
</style>
<security:authentication property="principal" var="principal"/>
<c:set var="authMember" value="${principal.realMember }"/>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }"/>
<br>
<div id="top"> 
	<h2><strong>세대별 조회</strong></h2>
</div>
<br>
<form:form commandName="pagingVO" id="searchForm" method="get">
<div class="container">
	<div class="col-md-12" style="border-style: outset; border-radius: 8px;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png"
					alt="searchIcon" style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">
				&nbsp;&nbsp;<strong>검색조건</strong>
			</div>
		</div>
		<div class="card-body">
				<form:hidden path="currentPage"/>
				<div class="row">
					<div class="col-md-2">
						동/호 선택
					</div>
					<div class="col-md-5">
						<select	name="searchDetail.dongStart" class="custom-select col-md-4 searchSelect">
						    <option value="0000" selected>전체</option>
						    <c:forEach items="${pagingVO.searchDetail.dongList}" var="dong" varStatus="status">
						        <c:choose>
						            <c:when test="${dong.dong eq param['searchDetail.dongStart']}">
						                <option value="${dong.dong}" selected>${dong.dong}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${dong.dong}">${dong.dong}</option>
						            </c:otherwise>
						        </c:choose> 
						    </c:forEach>
						</select>
			      		<label>&nbsp;동&nbsp;</label>
						<select	name="searchDetail.hoStart" class="custom-select col-md-4 searchSelect">
						    <option value="0000" selected>전체</option>
						    <c:forEach items="${pagingVO.searchDetail.hoList}" var="ho" varStatus="status">
						        <c:choose>
						            <c:when test="${ho.ho eq param['searchDetail.hoStart']}">
						                <option value="${ho.ho}" selected>${ho.ho}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${ho.ho}">${ho.ho}</option>
						            </c:otherwise>
						        </c:choose> 
						    </c:forEach>
						</select>
				 		<label>&nbsp;호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~</label>
					</div>
					
					<div class="col-md-5">
						<select	name="searchDetail.dongEnd" class="custom-select col-md-4 searchSelect">
						    <option value="9999" selected>전체</option>
						    <c:forEach items="${pagingVO.searchDetail.dongList}" var="dong" varStatus="status">
						        <c:choose>
						            <c:when test="${dong.dong eq param['searchDetail.dongEnd']}">
						                <option value="${dong.dong}" selected>${dong.dong}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${dong.dong}">${dong.dong}</option>
						            </c:otherwise>
						        </c:choose> 
						    </c:forEach>
						</select>
			      		<label>&nbsp;동&nbsp;</label>
						<select	name="searchDetail.hoEnd" class="custom-select col-md-4 searchSelect">
						    <option value="9999" selected>전체</option>
						    <c:forEach items="${pagingVO.searchDetail.hoList}" var="ho" varStatus="status">
						        <c:choose>
						            <c:when test="${ho.ho eq param['searchDetail.hoEnd']}">
						                <option value="${ho.ho}" selected>${ho.ho}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${ho.ho}">${ho.ho}</option>
						            </c:otherwise>
						        </c:choose> 
						    </c:forEach>
						</select>
				 		<label>&nbsp;호&nbsp;</label>
					</div>
				</div>
				
				<br>
				
				<div class="row">
					<div class="col-md-2">
						부과년월
					</div>
					<div class="col-md-3">
						<form:input path="searchDetail.costYear" placeholder="부과년" cssClass="form-control col-md-5" required="required" cssStyle="display: inline-block;" maxlength="4" onkeypress="return onlyNumber(event)"/>
						<form:input path="searchDetail.costMonth" placeholder="부과월" cssClass="form-control col-md-5" required="required" cssStyle="display: inline-block;" maxlength="2" onkeypress="return onlyNumber(event)"/>
					</div>
					<div class="col-md-4">
						<button class="btn btn-dark" id="searchBtn" onclick="goSearch()">검색</button>
						<button class="btn btn-secondary" id="resetBtn">초기화</button>
					</div>
				</div>
		</div>
	</div>
</div>
<br>
<form:select path="screenSize" cssClass="custom-select col-md-1 searchSelect" onchange="goSearch()">
	<form:option value="10" label="10"/>
	<form:option value="25" label="25"/>
	<form:option value="50" label="50"/>
	<form:option value="100" label="100"/>
</form:select>
<span>개 씩 보기</span>
<a id="downExcelJxls" class="btn btn-success" href="#">엑셀 다운로드</a>
</form:form>

<br>
<div class="wrapper">
	<table class="table table-bordered">
		<thead class="thead-light text-center">
	    	<tr>
		        <th class="fixedHeader" scope="col" style="width:8%">더보기</th>
		        <th class="fixedHeader" scope="col" style="width:12%">부과년월</th>
		        <th class="fixedHeader" scope="col">동</th>
		        <th class="fixedHeader" scope="col">호</th>
		        <th class="fixedHeader" scope="col">세대주명</th>
		        <th class="fixedHeader" scope="col">세대면적</th>
		        <th class="fixedHeader" scope="col">공용관리비</th>
		        <th class="fixedHeader" scope="col">개별관리비</th>
		        <th class="fixedHeader" scope="col">총합</th>
	<!-- 	        <th scope="col">인쇄</th> -->
	    	</tr>
	    </thead>
	    <tbody>
	    	<c:set var="costList" value="${pagingVO.dataList }" />
	    	<c:if test="${not empty costList }">
	    		<c:forEach items="${costList }" var="cost" varStatus="vs">
		    		<tr class="text-center hover">
			        	<td><button class="btn btn-light expandBtn" data-toggle="collapse" data-target="#accordion${cost.memId }${vs.index}" ><i class="fa fa-plus-square fa-lg"></i></button></td>
			            <td>${cost.costYear } / ${cost.costMonth }</td>
			            <td>${cost.dong }</td>
			            <td>${cost.ho }</td>
			            <td>${cost.resName }</td>
			            <td class="text-right">${cost.houseArea }㎡</td>
			            <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCommTotal }" /> 원</td>
			            <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvTotal }" /> 원</td>
			            <td class="text-right"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costTotal }" /> 원</td>
	<!-- 		            <td><button class="btn btn-primary">인쇄</button></td> -->
			        </tr>
			        <tr class="text-center" style="display:none;">
	<!-- 		        <tr class="text-center"> -->
			            <td colspan="9">
			                <div id="accordion${cost.memId }${vs.index}" class="collapse">
								<table class="table table-sm">
									<tr>
										<th class="table-dark">공용관리비</th>
										<td>
											<table class="table table-bordered">
												<tr class="thead-light">
													<th>일반관리비</th>
													<th>청소비</th>
													<th>경비비</th>
													<th>소독비</th>
													<th>승강기유지비</th>
													<th>총합</th>
												</tr>
												<tr>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCommon }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCleaning }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costSecurity }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costDisinfect }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costElevator }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCommTotal }" /> 원</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th class="table-dark">개별사용료</th>
										<td>
											<table class="table table-bordered">
												<tr class="thead-light">
													<th>난방공용</th>
													<th>난방전용</th>
													<th>급탕공용</th>
													<th>급탕전용</th>
													<th>전기공용</th>
													<th>전기전용</th>
													<th>수도공용</th>
													<th>수도전용</th>
													<th>주차비</th>
													<th>수선유지비</th>
													<th>장기수선충당금</th>
													<th>입주자대표회의운영비</th>
													<th>총합</th>
												</tr>
												<tr>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCommHeat }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvHeat }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCommHotwater }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvHotwater }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCommElec }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvElec }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCommWater }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvWater }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costPark }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costAs }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costLas }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costCouncil }" /> 원</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${cost.costIndvTotal }" /> 원</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</div>
			            </td>
			        </tr>
				</c:forEach>
	    	</c:if>
	    	<c:if test="${empty costList }">
	    		<tr class="text-center">
	    			<td colspan="9">조회 결과가 없습니다.</td>
	    		</tr>
	    	</c:if>
	    </tbody>
	</table>
</div>
<c:if test="${not empty costList }">
	<div id="pagingArea" class="pagination justify-content-center">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice" />
	</div>
</c:if>
<script>
	let searchForm = $("#searchForm");
	
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='currentPage']").val(page);
		searchForm.submit();
		return false;
	}

	function goSearch() {
		console.log($("#searchDetail.dongStart"));
    	searchForm.attr("action", "<c:url value='/office/cost/costIndvList.do'/>");
    	searchForm.submit();
    }
	

	$(".expandBtn").on("click", function() {
		var targetId = $(this).data('target'); // 펼쳐질 아코디언의 id
		var target = $(targetId);

		var expanded = this.getAttribute("aria-expanded") == null || this.getAttribute("aria-expanded") === 'false' ? true : false;
		
		if(expanded) {
			$(this).children().removeClass("fa-plus-square");
			$(this).children().addClass("fa-minus-square");
			target.parents("tr").css('display','');
		}else {
			$(this).children().removeClass("fa-minus-square");
			$(this).children().addClass("fa-plus-square");
			target.parents("tr").css('display','none');
		}
	});
	
    // hover클래스의 tr 태그에 마우스를 올릴때 hover효과
    $('table tbody tr.hover').mouseover(function() {
        $(this).children().css({
            'backgroundColor' : '#F7F7F7', //	#DCDCDC or #F7F7F7
            'cursor' : 'default' // 'pointer'였는데 default로 변경함
        });
    }).mouseout(function() {
        $(this).children().css({
            'backgroundColor' : '#FFFFFF',
            'cursor' : 'default'
        });
    });
    
    // 검색조건 초기화
    $("#resetBtn").on("click", function() {
		// input 박스 비우도록
		let inputs = $('body').find(":input[type='text']");
		$(inputs).each(function(index, input){
			console.log(input);
			let value = $(this).val(null);
		});
	
		// select 박스 첫번째 옵션이 선택되도록 (onchage걸려있어서 오류남)
		let selects = $(".searchSelect"); 
		$(selects).each(function(index, select) {
			$(select).children(":eq(0)").prop("selected", true);
		});
	
    });
    
	//====================엑셀 다운로드==========================
	$("#downExcelJxls").on("click", function(){
		let queryString = searchForm.serialize();
		let requestURL = $.getContextPath() +"/office/cost/costIndvList/downloadExcel.do?" + queryString; 
		$(this).attr("href", requestURL);
		return true;
	});
</script>
