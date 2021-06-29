<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
#hidden-xs2{
	display: grid;
}

</style>
	<div class="tableDiv">
		<!--PC 테블릿 -->
			<div id="hidden-xs2">
				<table class="table-bordered">
					<thead style="text-align: center;">
						<tr >
							<td>결제일자</td>
							<td>결제금액</td>
							<td>관리비 날짜</td>
							<td>납부마감일</td>
							<td>결제방법</td>
						</tr>
					</thead>
					<tbody style="text-align: right;">
				
				<c:choose>
					<c:when test="${not empty receiptList }">
						<c:forEach items="${receiptList }" var="List">
							<tr>
								<c:choose>
									<c:when test="${List.receiptDate eq '-'}">
									<td style="text-align: center;"> (미결제) - </td>
									</c:when>
									<c:when test="${List.receiptDate ne '-'}">
									<td style="color: blue; text-align: center;">(결제 완료)${List.receiptDate }</td>
									</c:when>
								</c:choose>
								<td><fmt:formatNumber value="${List.costTotal}" groupingUsed="true"/>원</td>
								<td>${List.costYear }년/${List.costMonth }월분 관리비 </td>
								<td>${List.costDuedate }</td>
								<c:choose>
								<c:when test="${List.receiptMethod eq 'AUTO' }">
									<td style="color: blue;">자동이체</td>
								</c:when>
								
								<c:when test="${List.receiptMethod eq 'KAKAO' }">
								<td style="color: #539608;">카카오 페이</td>
								</c:when>
								<c:when test="${List.receiptMethod eq '-'}">
								<td style="color:red;">미결제</td>
								</c:when>							
								
								</c:choose>
							</tr>					
							
						
						</c:forEach>
					</c:when>
					<c:when test="${empty receiptList }">
						<tr>
							<td class="bRn t_center" colspan="9" align="center">조회된 내역이 없습니다.</td>		
						</tr>
				</c:when>
				</c:choose>
				
					</tbody>
				</table>
			</div>

		<!--모바일 -->
		
			</div>
