<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.  이경륜      최초작성
* 2021. 2.  9.  이경륜	js 파일 분리
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
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
<div id="top"> 
	<h2><strong>입주 관리</strong></h2>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#moveinInsertModal">입주 단건 등록</button>
	<button type="button" class="btn btn-success" data-toggle="modal" data-target="#moveinExcelUploadModal">엑셀 일괄 등록</button>
</div>

<div class="container">
	<div class="col-md-12" style="border-style: outset; border-radius: 8px;">
		<div class="row g-0">
			<div class="col-md-2" style="margin-top: 20px;">
				<img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon" style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">
				&nbsp;&nbsp;<strong>검색 조건</strong>
			</div>
		</div>
		<form id="searchForm" action="${cPath }/office/resident/moveinListAjax.do" method="get" class="form-inline">
			<input type="hidden" name="searchVO.searchAptCode">
			<input type="hidden" name="dongStart">
			<input type="hidden" name="hoStart">
			<input type="hidden" name="dongEnd">
			<input type="hidden" name="hoEnd">
			<input type="hidden" name="resMoveinStart">
			<input type="hidden" name="resMoveinEnd">
			<input type="hidden" name="sortType">
			<input type="hidden" name="moveYn">
			<input type="hidden" name="resName">
			<input type="hidden" name="screenSize" value="10">
			<input type="hidden" name="currentPage" value="1">
		</form>
		<div id="inputUI" class="card-body">
			<div class="row">
				<div class="col-md-2">
					동/호 선택
				</div>
				<div class="col-md-5">
					<form:select path="dongList" name="dongStart" cssClass="custom-select col-md-4 searchSelect">
		      			<form:option value="0000">전체</form:option>
						<form:options items="${dongList}" itemValue="dong" itemLabel="dong" />
					</form:select>
		      		<label>&nbsp;동&nbsp;</label>
		      		<form:select path="hoList" name="hoStart" cssClass="custom-select col-md-4 searchSelect">
		      			<form:option value="0000">전체</form:option>
						<form:options items="${hoList}" itemValue="ho" itemLabel="ho" />
					</form:select>
			 		<label>&nbsp;호 ~&nbsp;</label>
			 	</div>
			 	<div class="col-md-5">
					<form:select path="dongList" name="dongEnd" cssClass="custom-select col-md-4 searchSelect">
		      			<form:option value="9999">전체</form:option>
						<form:options items="${dongList}" itemValue="dong" itemLabel="dong" />
					</form:select>
		      		<label>&nbsp;동&nbsp;</label>
		      		<form:select path="hoList" name="hoEnd" cssClass="custom-select col-md-4 searchSelect">
		      			<form:option value="9999">전체</form:option>
						<form:options items="${hoList}" itemValue="ho" itemLabel="ho" />
					</form:select>
		      		<label>&nbsp;호&nbsp;</label>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-md-2">
					입주일
				</div>
				<div class="col-md-5">
					<input class="form-control col-md-5" type="date" name="resMoveinStart" style="display: inline-block;">
					&nbsp;~&nbsp;
					<input class="form-control col-md-5" type="date" name="resMoveinEnd" style="display: inline-block;">
				</div>
				<div class="col-md-2">
		      		<select class="custom-select mb-3 searchSelect" name="sortType">
		   				<option value="0">정렬</option>
		   				<option value="1">최신순</option>
						<option value="2">과거순</option>
		      		</select>
				</div>
				<div class="col-md-1">
					입주여부
				</div>
				<div class="col-md-2">
		      		<select class="custom-select mb-3 searchSelect" name="moveYn">
		   				<option value="0">전체</option>
		   				<option value="1">입주</option>
						<option value="2">미입주</option>
		      		</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2">
		      		세대주명
		      	</div>
		      	<div class="col-md-4">
					<input type="text" class="form-control col-md-12" placeholder="세대주명" name="resName">
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
	<option value="10">10</option>
	<option value="25">25</option>
	<option value="50">50</option>
	<option value="100">100</option>
</select>
<span>개 씩 보기</span>
<span><a id="downExcelJxls" class="btn btn-success" href="#">엑셀 다운로드</a></span>
<br>
<br>
<div class="wrapper">
	<table class="table table-hover" id="residentTable">
		<colgroup>
			<col width="4%">
			<col width="4%">
			<col width="6%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="12%">
			<col width="10%">
			<col width="10%">
			<col width="6%">
			<col width="10%">
			<col width="5%">
		</colgroup>
		<thead class="thead-light">
			<tr class="text-center">
				<th scope="col" class="fixedHeader">동</th>
				<th scope="col" class="fixedHeader">호</th>
				<th scope="col" class="fixedHeader">세대면적</th>
				<th scope="col" class="fixedHeader">입주민코드</th>
				<th scope="col" class="fixedHeader">세대주</th>
				<th scope="col" class="fixedHeader">연락처</th>
				<th scope="col" class="fixedHeader">비상연락처</th>
				<th scope="col" class="fixedHeader">메일</th>
				<th scope="col" class="fixedHeader">생일</th>
				<th scope="col" class="fixedHeader">직업</th>
				<th scope="col" class="fixedHeader">입주여부</th>
				<th scope="col" class="fixedHeader">입주일</th>
				<th scope="col" class="fixedHeader">편집</th>
			</tr>
		</thead>
		<tbody id="listBody">
		
		</tbody>
	</table>
</div>
<div class="d-flex justify-content-center">
	<div id="pagingArea"></div>
</div>


<!-- 입주 등록 모달 -->
<div class="modal fade" id="moveinInsertModal" tabindex="-1" aria-labelledby="moveinInsertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="moveinInsertModalLabel"><strong>입주 등록</strong></h3>
			</div>
			<form:form modelAttribute="resident" id="moveinInsertForm" action="${cPath }/office/resident/moveinInsert.do" method="post">
				<form:hidden path="aptCode"/>
				<form:hidden path="houseCode"/>
				<div class="modal-body">
					<table class="table">
						<tr>
							<td><span class="reddot">* </span>입주일</td>
							<td>
								<input type="date" name="resMovein" value="${resident.resMovein }" required>
								<form:errors path="resMovein" element="span" cssClass="error"/>
							</td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>동</td>
							<td>
								<select name="dong" required><!-- selected추가해야함 -->
									<c:forEach items="${dongList}" var="item">
									    <option value="${item.dong}">${item.dong}</option>
								    </c:forEach>
								</select>
								<form:errors path="dong" element="span" cssClass="error"/>
							</td>
							<td><span class="reddot">* </span>호</td>
							<td>
								<form:input path="ho" required="required" maxlength="4" onkeypress="return onlyNumber(event)"/>
<!-- 								<input type="text" name="ho" required maxlength="4" onkeypress="return onlyNumber(event)"> -->
								<form:errors path="ho" element="span" cssClass="error"/>
							</td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>세대주명</td>
							<td>
								<form:input path="resName" required="required" maxlength="5" value="최희연"/>
<!-- 								<input type="text" name="resName" required> -->
								<form:errors path="resName" element="span" cssClass="error"/>
							</td>
							<td><span class="reddot">* </span>휴대폰번호</td>
							<td>
								<form:input path="resHp" required="required" maxlength="11" onkeypress="return onlyNumber(event)" value="01055727833"/>
<!-- 								<input type="text" name="resHp" required maxlength="11" onkeypress="return onlyNumber(event)"> -->
								<form:errors path="resHp" element="span" cssClass="error"/>
							</td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>비상연락처</td>
							<td>
								<form:input path="resTel" required="required" maxlength="11" onkeypress="return onlyNumber(event)" value="01024013403"/>
<!-- 								<input type="text" name="resTel" required maxlength="11" onkeypress="return onlyNumber(event)"> -->
								<form:errors path="resTel" element="span" cssClass="error"/>
							</td>
							<td><span class="reddot">* </span>이메일</td>
							<td>
								<form:input path="resMail" value="chy123@naver.com"/>
<!-- 								<input type="text" name="resMail" required> -->
								<form:errors path="resMail" element="span" cssClass="error"/>
							</td>
						</tr>
						<tr>
							<td>생일</td>
							<td>
								<input type="date" name="resBirth" value="${resident.resBirth }">
								<form:errors path="resBirth" element="span" cssClass="error"/>
							</td>
							<td>직업</td>
							<td>
								<form:input path="resJob" value="척척박사님"/>
<!-- 								<input type="text" name="resJob"> -->
								<form:errors path="resJob" element="span" cssClass="error"/>
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">저장</button>
<!-- 					<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button> -->
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form:form>
		</div>
	</div>
</div>

<!-- 세대 정보 수정 모달 -->
<div class="modal fade" id="moveinUpdateModal" tabindex="-1" aria-labelledby="moveinUpdateModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="moveinUpdateModalLabel"><strong>세대 정보 수정</strong></h3>
			</div>
			<form id="moveinUpdateForm" action="${cPath }/office/resident/moveinUpdate.do" method="post">
				<input type="hidden" name="memId"/>
				<input type="hidden" name="houseCode"/>
				<div class="modal-body">
					<table class="table">
						<tr>
							<td><span class="reddot">* </span>입주일</td>
							<td>
								<input type="date" name="resMovein" value="${resident.resMovein }" required>
<%-- 								<form:errors path="resMovein" element="span" cssClass="error"/>	 --%>
							</td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>동</td>
							<td>
								<input type="text" name="dong" required readonly maxlength="4" onkeypress="return onlyNumber(event)">
							</td>
							<td><span class="reddot">* </span>호</td>
							<td>
								<input type="text" name="ho" required readonly maxlength="4" onkeypress="return onlyNumber(event)">
							</td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>세대주명</td>
							<td>
								<input type="text" name="resName" required>
<%-- 								<form:errors path="resName" element="span" cssClass="error"/> --%>
							</td>
							<td><span class="reddot">* </span>휴대폰번호</td>
							<td>
								<input type="text" name="resHp" required maxlength="11" onkeypress="return onlyNumber(event)">
<%-- 								<form:errors path="resHp" element="span" cssClass="error"/> --%>
							</td>
						</tr>
						<tr>
							<td><span class="reddot">* </span>비상연락처</td>
							<td>
								<input type="text" name="resTel" required maxlength="11" onkeypress="return onlyNumber(event)">
<%-- 								<form:errors path="resTel" element="span" cssClass="error"/> --%>
							</td>
							<td><span class="reddot">* </span>이메일</td>
							<td>
								<input type="email" name="resMail" required>
<%-- 								<form:errors path="resMail" element="span" cssClass="error"/> --%>
							</td>
						</tr>
						<tr>
							<td>생일</td>
							<td>
								<input type="date" name="resBirth" value="${resident.resBirth }">
							</td>
							<td>직업</td>
							<td>
								<input type="text" name="resJob">
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">저장</button>
<!-- 					<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button> -->
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- 엑셀 일괄 등록 모달 -->
<div class="modal fade" id="moveinExcelUploadModal" tabindex="-1" aria-labelledby="moveinExcelUploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="moveinExcelUploadModalLabel">엑셀 일괄 등록</h3>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr>
						<td>샘플 양식 다운로드</td>
						<td><button class="btn btn-dark" id="sampleDownBtn">샘플양식다운로드</button></td>
					</tr>
					<tr>
						<td>엑셀 업로드</td>
						<td>
							<form method="POST" enctype="multipart/form-data" id="moveinExcelForm">
								<input type="hidden" name="aptCode" value="">
								<input type="file" id="excelFile" name="excelFile">
							</form>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="uploadExcelBtn">저장</button>
				<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript" src="${cPath }/js/office/resident/moveinList.js"></script>
