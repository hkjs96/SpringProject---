<!-- 관리비-이번달 관리비 납부 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="//cdnw.tworld.co.kr/poc/inc/css/common.css" rel="stylesheet"
	type="text/css">
<link href="//cdnw.tworld.co.kr/poc/inc/css/myt.css" rel="stylesheet"
	type="text/css">
<style>
.paydiv {
	float: left;
	width: 48%;
	padding: 15px;
	background-color: rgb(3 60 12 / 43%);
	margin: 1%;
	height: 250px;
}

.paydivlow {
	float: left;
	width: 50%;
	padding: 15px;
}

.payday {
	margin-top: 25%;
	font-size: 20px;
	color: white;
}

.payMonth {
	width: 150px;
	height: 150px;
	border-radius: 58%;
	align-content: center;
	background: #f9f9f9;
	margin: 6%;
}

.payMonth2 {
	width: 130px;
	height: 130px;
	border-radius: 58%;
	align-content: center;
	background: red;
	margin: 6%;
}

.Month {
	font-size: 18px;
	text-align: center;
	margin-top: 50%;
	margin-left: 0%;
}

.number {
	color: #53a4ea;
	font-size: 45px;
    margin-left: 34%;
}

.costomTd {
	text-align: center;
	height: 185px;
	background-color: white;
}
.pay{
    margin-right: 5px;
    font-weight: normal;
    font-size: 40px;
    line-height: 48px;
    letter-spacing: -3px;
    vertical-align: -4px;
	color: black;
}

.mainTitle{
  	display: block;
    height: 60px;
    background: #00a49a;
    color: #fff;
    font-size: 25px;
    line-height: 58px;
    text-align: center;
}
.payChoise{
 	display: block;
    height: 60px;
    background: #00a49a;
    color: #fff;
    font-size: 18px;
    line-height: 58px;
    text-align: center;
}
.emCustom{
	font-size: 25px;
}


.table-bordered{

-webkit-tap-highlight-color: rgba(0,0,0,0);
-webkit-font-smoothing: antialiased;
text-rendering: optimizeLegibility;
font-size: 18px;
color: #4c4c4c;
line-height: 1.6;
letter-spacing: -1px;
font-family: 'Nanum Gothic', sans-serif;
font-weight: bold;
box-sizing: border-box;
border-spacing: 0;
border-collapse: collapse;
background-color: transparent;
margin: 0;
padding: 0;
width: 100%;
max-width: 100%;
margin-bottom: 20px;
border: 1px solid #ddd;
}
</style>

	<strong class="mainTitle">관리비 고지서</strong>
<div class="feePayMent">
	<div class="paydiv">
		<div class="paydivlow">
			<div class="payMonth">
			<c:if test="${not empty affter.costMonth}">
				<b class="number">${affter.costMonth }</b> <label class="Month">월분</label>
			</c:if>
			</div>
		</div>
		<div class="paydivlow">
			<div class="payday">
				<h2
					style="font-weight: bold; font: small-caps bold 24px/1 sans-serif; color: white;">${user.dong }동
					${user.ho} 호</h2>
					<c:if test="${not empty affter.costDuedate }">
				<br> 납부마감일: ${affter.costDuedate }
				</c:if>
			</div>

		</div>
	</div>
	<div class="paydiv">
		<table class="table-bordered" style="margin: auto; width: 100%;">
			<thead>
				<tr>
					<th class="text-center" style="background-color: #00a49a;color: white;font-size: 20px;
    						font-weight: revert; height: 40px;">납기내</th>
					<th class="text-center" style="background-color: #ea5353; color: white; font-size: 20px;
   							font-weight: revert; height: 40px;">납기후</th>
				</tr>
			<thead>
			<tbody>
				<tr>
					<td class="costomTd"><strong style="color: black;"><span class="pay" id="costPayAF"></span>원</strong></td>
					<td class="costomTd"><strong style="color: black;"><span class="pay" id="costPayBF"></span>원</strong></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="paymentCon">
		<dl>
		<c:if test="${not empty affter.costCommon}">
			<dt class="titDep2" style="color: white;">요금 항목별 상세내역</dt>
			<dd>
				<div class="amountList">
					<strong class="dtTit1_1">항목별 상세요금</strong>
					<dl>
						<dt>
							<span> <em class="emCustom">공동관리비</em> <strong><span class="en" id="comCost">
							${affter.costCommon + 
							affter.costCleaning+
							affter.costDisinfect+
							affter.costSecurity+
							affter.costElevator+
							affter.costAs+
							affter.costCouncil+
							affter.costLas+
							affter.costPark
							}</span>원</strong>
							</span>
						</dt>
						<dd>
							<ul>
								<li><strong>일반관리비</strong>
									<ul>
										<li><strong>일반관리비</strong> <em><fmt:formatNumber value="${affter.costCommon }" groupingUsed="true"/>원</em></li>
									</ul></li>
								<li><strong>용역업체비</strong>
									<ul>
										<li><strong>청소비</strong> <em><fmt:formatNumber value="${affter.costCleaning }" groupingUsed="true"/>원</em></li>
										<li><strong>소독비</strong> <em><fmt:formatNumber value="${affter.costDisinfect }" groupingUsed="true"/>원</em></li>
										<li><strong>경비비</strong> <em><fmt:formatNumber value="${affter.costSecurity }" groupingUsed="true"/>원</em></li>
									</ul></li>
								<li><strong>공동사용비</strong>
									<ul>
										<li><strong>승강기유지비</strong> <em><fmt:formatNumber value="${affter.costElevator }" groupingUsed="true"/>원</em></li>
										<li><strong>수선유지비</strong> <em><fmt:formatNumber value="${affter.costAs }" groupingUsed="true"/>원</em></li>
										<li><strong>입주자 대표회의 운영비</strong> <em><fmt:formatNumber value="${affter.costCouncil }" groupingUsed="true"/>원</em></li>
									</ul></li>
								<li><strong>기타</strong>
									<ul>
										<li><strong>장기수선충당금</strong> <em><fmt:formatNumber value="${affter.costLas }" groupingUsed="true"/>원</em></li>
										<li><strong>주차비</strong> <em><fmt:formatNumber value="${affter.costPark }" groupingUsed="true"/>원</em></li>
									</ul></li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>
							<span> <em class="emCustom">에너지 사용비</em> 
									<strong><span class="en" id="engCost">${affter.costCommHeat+
									affter.costCommHotwater+
									affter.costCommElec+
									affter.costCommWater+
									affter.costIndvHeat+
									affter.costIndvHotwater+
									affter.costIndvElec+
									affter.costIndvWater
									}</span>원</strong>
							</span>
						</dt>
						<dd>
							<ul>
								<li><strong>공용사용비</strong>
									<ul>
										<li><strong>난방 공용</strong> <em>	<fmt:formatNumber value="${affter.costCommHeat }" groupingUsed="true"/>원</em></li>
										<li><strong>급탕 공용</strong> <em><fmt:formatNumber value="${affter.costCommHotwater }" groupingUsed="true"/>원</em></li>
										<li><strong>전기 공용</strong> <em><fmt:formatNumber value="${affter.costCommElec }" groupingUsed="true"/>원</em></li>
										<li><strong>수도 공용</strong> <em><fmt:formatNumber value="${affter.costCommWater }" groupingUsed="true"/>원</em></li>
									</ul></li>
									<li><strong>전용사용비</strong>
									<ul>
										<li><strong>난방 전용</strong> <em><fmt:formatNumber value="${affter.costIndvHeat }" groupingUsed="true"/>원</em></li>
										<li><strong>급탕 전용</strong> <em><fmt:formatNumber value="${affter.costIndvHotwater }" groupingUsed="true"/>원</em></li>
										<li><strong>전기 전용</strong> <em><fmt:formatNumber value="${affter.costIndvElec }" groupingUsed="true"/>원</em></li>
										<li><strong>수도 전용</strong> <em><fmt:formatNumber value="${affter.costIndvWater }" groupingUsed="true"/>원</em></li>
									</ul></li>
							</ul>
						</dd>
					</dl>
				</div>
				<!-- 할인내역 -->
				<div class="amountList discount">
					<!-- 할인내역 class="discount" 추가 -->
					<strong class="dtTit1_2">미납 요금 상세내역</strong>
					<dl>
						<dt>
						<c:forEach items="${unpaid}" var="unpaid">
							<c:if test="${unpaid.receiptYn eq 'N' }">
							<c:set var ="sum" value="${sum+unpaid.lateFee }"/>
							</c:if>
						</c:forEach>
							<c:choose>
							<c:when test="${not empty sum}">
							<span> <em class="emCustom">미납금액</em> <strong><span class="en" id="unpaidCost">
							<c:out value="${sum}"/>
							</span>원</strong>
							</span>
							</c:when>
							<c:when test="${empty sum}">
							</c:when>
							</c:choose>
						</dt>
						<dd>
							<ul>
							<c:choose>
							<c:when test="${not empty sum}">
								<li><strong>미납 일</strong>
									<ul>
									<c:set var = "sum" value="0"/>
									<c:forEach items="${unpaid}" var="unpaid">
										<c:if test="${unpaid.receiptYn eq 'N' }">
										<li><strong>${unpaid.costYear }년${unpaid.costMonth }월</strong><em class="unpaid"><fmt:formatNumber value="${unpaid.lateFee }" groupingUsed="true"/>원</em></li>
										<c:set var ="sum" value="${sum+unpaid.lateFee }"/>
										</c:if>
									</c:forEach>
									</ul></li>
									</c:when>
							<c:when test="${empty sum}">
								<strong style="font-size: 20px;">미납금액이 없습니다.</strong>
							</c:when>
							</c:choose>
							</ul>
						</dd>
					</dl>
				</div>
				<div>
						<form method="post" action="${cPath }/resident/mainenanceCost/kakaopay.do">
							<strong class="payChoise">관리비 납부 하기
							<button style="margin: 6px;"><img alt="" src="${cPath }/images/payment_icon_yellow_medium.png"></button>
							</strong>
							<input type="hidden" name="costMonth" value="${affter.costMonth}">
							<input type="hidden" name="costYear" value="${affter.costYear }">
						</form>
				</div>
				<!-- //할인내역 -->
				<div class="txtInfo h20">
					<ul>
						<li>*소수점 금액은 절감하여 표시합니다.</li>
						<li><strong><em class="fColor1">(#)</em>해당 관리비 금액은 관리사무소에서 통계하여 부과한 금액입니다.</strong></li>
					</ul>
				</div>
				<div class="txtInfo h15">
					<ul>
						<li><strong>주차비 기본월정액 이용안내</strong></li>
						<li>새대당 2개 이상일 경우 한 차의 기준 한달의 1만원 씩 부과 됩니다.</li>
					</ul>
				</div>
			</dd>
		</c:if>
		</dl>
	</div>
</div>

<input type="hidden" value="${Math.abs(affter.count)}" id="count">
<script type="text/javascript">
	var unpaidCost = $.trim($("#unpaidCost").text());
	var comCost = $.trim($("#comCost").text());
	var engCost = $.trim($("#engCost").text());
	var sumCost = Number(unpaidCost)+Number(engCost)+Number(comCost);
	var unpaidCost = $("#unpaidCost").text();
	var countNumber = $("#count").val();
	var sumCostBF= ((sumCost-Number(unpaidCost))* 0.15*countNumber/365).toFixed(0);
	var sumCostBFpay = Number(sumCost)+Number(sumCostBF);
	console.log(sumCostBF);
	$("#unpaidCost").text()
	sumCostBFpay = sumCostBFpay.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#costPayBF").text(sumCostBFpay);
	sumCost=sumCost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#costPayAF").text(sumCost);
	$("#comCost").text(comCost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	$("#engCost").text(engCost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	$("#unpaidCost").text(unpaidCost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
</script>