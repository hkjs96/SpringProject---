<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 1.  이경륜        최초작성
* 2021. 2. 10. 이경륜		리스트조회
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
<br>
<div id="contentArea">
	<div id="top"> 
		<h2><strong>전출 관리</strong></h2>
		<c:url value="/office/resident/moveoutForm.do" var="formURL"/>
		<form id="goToInsertForm" action="${formURL }" method="get">
			<button type="button" class="btn btn-primary" id="insertBtn">전출 세대 등록</button>
		</form>
<%-- 		<a class="btn btn-primary" href="${formURL }">전출 세대 등록</a> --%>
	</div>
	<div class="container">
		<div class="col-md-12" style="border-style: outset; border-radius: 8px;">
			<div class="row g-0">
				<div class="col-md-2" style="margin-top: 20px;">
					<img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon" style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">
					&nbsp;&nbsp;<strong>검색 조건</strong>
				</div>
			</div>
			<form id="searchForm" action="${cPath }/office/resident/moveoutListAjax.do" method="get" class="form-inline">
				<input type="hidden" name="searchVO.searchAptCode">
				<input type="hidden" name="dongStart">
				<input type="hidden" name="hoStart">
				<input type="hidden" name="dongEnd">
				<input type="hidden" name="hoEnd">
				<input type="hidden" name="resMoveoutStart">
				<input type="hidden" name="resMoveoutEnd">
				<input type="hidden" name="sortType">
				<input type="hidden" name="resName">
				<input type="hidden" name="screenSize" value="${not empty param.screenSize ? param.screenSize : 10}">
				<input type="hidden" name="currentPage" value="${not empty param.currentPage ? param.currentPage : 1}">
			</form>
			<div id="inputUI" class="card-body">
				<div class="row">
					<div class="col-md-2">
						동/호 선택
					</div>
					<div class="col-md-5">
<%-- 						<form:select path="dongList" name="dongStart" cssClass="custom-select col-md-4 searchSelect"> --%>
<%-- 			      			<form:option value="0000">전체</form:option> --%>
<%-- 							<form:options items="${dongList}" itemValue="dong" itemLabel="dong" /> --%>
<%-- 						</form:select> --%>
						<form:select path="dongList" name="dongStart" cssClass="custom-select col-md-4 searchSelect">
						    <form:option value="0000">전체</form:option>
						    <c:forEach items="${dongList}" var="dong" varStatus="status">
						        <c:choose>
						            <c:when test="${dong.dong eq param.dongStart}">
						                <option value="${dong.dong}" selected="true">${dong.dong}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${dong.dong}">${dong.dong}</option>
						            </c:otherwise>
						        </c:choose> 
						    </c:forEach>
						</form:select>
			      		<label>&nbsp;동&nbsp;</label>
<%-- 			      		<form:select path="hoList" name="hoStart" cssClass="custom-select col-md-4 searchSelect"> --%>
<%-- 			      			<form:option value="0000">전체</form:option> --%>
<%-- 							<form:options items="${hoList}" itemValue="ho" itemLabel="ho" /> --%>
<%-- 						</form:select> --%>
						<form:select path="hoList" name="hoStart" cssClass="custom-select col-md-4 searchSelect">
						    <form:option value="0000">전체</form:option>
						    <c:forEach items="${hoList}" var="ho" varStatus="status">
						        <c:choose>
						            <c:when test="${ho.ho eq param.hoStart}">
						                <option value="${ho.ho}" selected="true">${ho.ho}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${ho.ho}">${ho.ho}</option>
						            </c:otherwise>
						        </c:choose> 
						    </c:forEach>
						</form:select>
				 		<label>&nbsp;호 ~&nbsp;</label>
				 	</div>
				 	<div class="col-md-5">
<%-- 						<form:select path="dongList" name="dongEnd" cssClass="custom-select col-md-4 searchSelect"> --%>
<%-- 			      			<form:option value="9999">전체</form:option> --%>
<%-- 							<form:options items="${dongList}" itemValue="dong" itemLabel="dong"/> --%>
<%-- 						</form:select> --%>
						<form:select path="dongList" name="dongEnd" cssClass="custom-select col-md-4 searchSelect">
						    <form:option value="9999">전체</form:option>
						    <c:forEach items="${dongList}" var="dong" varStatus="status">
						        <c:choose>
						            <c:when test="${dong.dong eq param.dongEnd}">
						                <option value="${dong.dong}" selected="true">${dong.dong}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${dong.dong}">${dong.dong}</option>
						            </c:otherwise>
						        </c:choose> 
						    </c:forEach>
						</form:select>
			      		<label>&nbsp;동&nbsp;</label>
<%-- 			      		<form:select path="hoList" name="hoEnd" cssClass="custom-select col-md-4 searchSelect"> --%>
<%-- 			      			<form:option value="9999">전체</form:option> --%>
<%-- 							<form:options items="${hoList}" itemValue="ho" itemLabel="ho" /> --%>
<%-- 						</form:select> --%>
						<form:select path="hoList" name="hoEnd" cssClass="custom-select col-md-4 searchSelect">
						    <form:option value="9999">전체</form:option>
						    <c:forEach items="${hoList}" var="ho" varStatus="status">
						        <c:choose>
						            <c:when test="${ho.ho eq param.hoEnd}">
						                <option value="${ho.ho}" selected="true">${ho.ho}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${ho.ho}">${ho.ho}</option>
						            </c:otherwise>
						        </c:choose> 
						    </c:forEach>
						</form:select>
			      		<label>&nbsp;호&nbsp;</label>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-md-2">
						전출일
					</div>
					<div class="col-md-5">
						<input class="form-control col-md-5" type="date" name="resMoveoutStart" value="${param.resMoveoutStart }" style="display: inline-block;">
						&nbsp;~&nbsp;
						<input class="form-control col-md-5" type="date" name="resMoveoutEnd" value="${param.resMoveoutEnd }" style="display: inline-block;">
					</div>
					<div class="col-md-2">
			      		<select class="custom-select mb-3 searchSelect" name="sortType">
			   				<option value="0" ${"0" eq param.sortType?"selected":""  }>정렬</option>
			   				<option value="1" ${"1" eq param.sortType?"selected":""  }>최신순</option>
							<option value="2" ${"2" eq param.sortType?"selected":""  }>과거순</option>
			      		</select>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2">
			      		전출자명
			      	</div>
			      	<div class="col-md-4">
						<input type="text" class="form-control col-md-12" placeholder="전출자명" name="resName" value="${param.resName }">
					</div>
					<div class="col-md-4">
						<button class="btn btn-dark" id="searchBtn">검색</button>
						<button class="btn btn-secondary" id="resetBtn">초기화</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<select class="custom-select col-md-1" id="screenSize">
		<option value="10" ${"10" eq param.screenSize?"selected":""  }>10</option>
		<option value="25" ${"25" eq param.screenSize?"selected":""  }>25</option>
		<option value="50" ${"50" eq param.screenSize?"selected":""  }>50</option>
		<option value="100" ${"100" eq param.screenSize?"selected":""  }>100</option>
	</select>
	<span>개 씩 보기</span>
	<span><a id="downExcelJxls" class="btn btn-success" href="#">엑셀 다운로드</a></span>
	<br>
	<br>
	<span>* 전출취소는 해당 호실 상태가 미입주인 경우만 가능합니다.</span>
	<br>
	<br>
	<div class="wrapper">
		<table class="table table-hover" id="residentTable">
			<colgroup>
				<col width="6%">
				<col width="6%">
				<col width="6%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="5%">
			</colgroup>
			<thead class="thead-light">
				<tr class="text-center">
					<th scope="col">동</th>
					<th scope="col">호</th>
					<th scope="col">세대면적</th>
					<th scope="col">입주민코드</th>
					<th scope="col">전출자명</th>
					<th scope="col">연락처</th>
					<th scope="col">비상연락처</th>
					<th scope="col">입주일</th>
					<th scope="col">전출일</th>
					<th scope="col">상세 보기</th>
					<th scope="col">전출 취소</th>
				</tr>
			</thead>
			<tbody id="listBody">
				<!-- 비동기로 리스트 조회 -->
			</tbody>
		</table>
	</div>
</div>
<div class="d-flex justify-content-center">
	<div id="pagingArea"></div>
</div>
<style>
</style>
<!-- 전출자 상세보기 모달 -->
<div class="modal fade" id="moveoutViewModal" tabindex="-1" aria-labelledby="moveoutViewModalLabel" aria-hidden="true" style=”z-index:1060;”>
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="moveoutViewModalLabel"><strong>전출자 상세보기</strong></h3>
			</div>
			<div class="modal-body" id="moveoutViewModalBody">
				<!-- moveoutViewModal.jsp에서 읽어올 모달 바디 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 전출 취소 처리시 관리자 비밀번호 인증 모달 -->
<div class="modal fade" id="moveoutCancelAuthModal" tabindex="-1" aria-labelledby="moveoutCancelAuthModalLabel" aria-hidden="true"  style=”z-index:1050;”>
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="moveoutCancelAuthModalLabel">관리자 인증</h3>
			</div>
			<form id="moveoutCancelAuthForm" action="${cPath }/office/resident/moveoutCancel.do" method="post">
				<input type="hidden" name="memId" required/>
				<input type="hidden" name="houseCode" required/>
				<div class="modal-body">
					<table class="table table-bordered">
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="memPass" required/></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">등록</button>
					<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>


<script type="text/javascript" src="${cPath }/js/office/resident/moveoutList.js"></script>