<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 11.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<table class="table table-bordered">
	<thead>
		<tr>
			<th class="text-center table-dark">입주일</th>
			<td class="text-center">${resident.resMovein }
			</td>
			<th class="text-center table-dark">전출일</th>
			<td class="text-center">${resident.resMoveout }</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th class="text-center table-dark">입주민코드</th>
			<td class="text-center">${resident.memId }</td>
			<th class="text-center table-dark">세대주명</th>
			<td class="text-center">${resident.resName }</td>
		</tr>
		<tr>
			<th class="text-center table-dark">동</th>
			<td class="text-center">${resident.dong }</td>
			<th class="text-center table-dark">호</th>
			<td class="text-center">${resident.ho }</td>
		</tr>
		<tr>
			<th class="text-center table-dark">연락처</th>
			<td class="text-center resHpArea"></td>
			<th class="text-center table-dark">비상연락처</th>
			<td class="text-center resTelArea"></td>
		</tr>
		<tr>
			<th class="text-center table-dark">메일</th>
			<td class="text-center">${resident.resMail }</td>
			<th class="text-center table-dark">생일</th>
			<td class="text-center">${resident.resBirth }</td>
		</tr>
		<tr>
			<th class="text-center table-dark">직업</th>
			<td class="text-center">${resident.resJob }</td>
			<td class="text-center table-light" colspan="2"></td>
		</tr>
		<tr>
			<th class="text-center table-dark">차량</th>
			<td class="text-center" colspan="3">
				<div class="container d-flex justify-content-center">
					<table>
						<thead>
							<tr class="table-secondary">
								<th>순번</th>
								<th>차량번호</th>
								<th>차종</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty resident.carList }">
								<c:forEach items="${resident.carList }" var="car" varStatus="vs">
								<tr>
									<td>${vs.count }</td>
									<td>${car.carNo }</td>
									<td>${car.carType }</td>
								</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty resident.carList }">
								<tr>
									<td colspan="3">등록된 차량이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<th class="text-center table-dark">관리비 납부 내역</th>
			<td class="text-center" colspan="3">
				<div class="container d-flex justify-content-center">
					<table id="receiptTable">
						<thead>
							<tr class="table-secondary">
								<th>No.</th>
								<th>부과년월</th>
								<th>공동관리비</th>
								<th>개별관리비</th>
								<th>총액</th>
								<th>수납일</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
						<tfoot>
							<tr>
								<td colspan="7">
									<div class="feePagingArea"></div>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<!-- 수납내역 페이징 -->
<form id="feeSearchForm" action="${cPath }/office/resident/moveoutViewReceipt.do" method="get">
	<input type="hidden" name="currentPage" value="1" />
	<input type="hidden" name="memId" value="${resident.memId }" />
</form>
<script>
	$(".resHpArea").text(formatTel("${resident.resHp }"));
	$(".resTelArea").text(formatTel("${resident.resTel }"));
</script>