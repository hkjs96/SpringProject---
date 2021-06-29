<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.  박정민      최초작성
* 2021. 2. 23.  이경륜      대시보드 링크 변경
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<style>
	  .sb-sidenav-menu {
	    width: auto;
	    height: 140px;
 	    overflow: auto;
	  }
	  .sb-sidenav-menu::-webkit-scrollbar {
	    width: 15px;
	  }
	  .sb-sidenav-menu::-webkit-scrollbar-thumb {
	    background-color: #2f3542;
	    border-radius: 10px;
	    background-clip: padding-box;
	    border: 2px solid transparent;
	  }
	  .sb-sidenav-menu::-webkit-scrollbar-track {
	    background-color: #e9ecef;
	    border-radius: 10px;
	    box-shadow: inset 0px 0px 5px white;
	  }

	.leftMenuDiv a {
	    font-family: 'Nanum Gothic', sans-serif;
	    font-size: 18px;
	    font-weight: bold;
	}
	
	.sb-sidenav-menu-heading span{
		font-size: 1.5em;
	}
</style>
 <div id="layoutSidenav">
     <div id="layoutSidenav_nav">
         <nav class="sb-sidenav accordion sb-sidenav-light" id="sidenavAccordion">
             <div class="sb-sidenav-menu leftMenuDiv" id="navdiv">
                 <div class="nav">
                     <div class="sb-sidenav-menu-heading"><span>홈</span></div>
                     <a class="nav-link" href="${pageContext.request.contextPath}/office">
                         <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                         	대쉬보드
                     </a>
			
			
			<%-- 메뉴 클래스
				nav-link : 메뉴 링크
				collapsed : 뎁스구조 추가
			 --%>
			
                     <div class="sb-sidenav-menu-heading"><span>공통</span></div>
			<!-- ------------- 메뉴얼 ------------------->
				<!-- 대분류 -->
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMenual" aria-expanded="false" aria-controls="collapseMenual">
                         <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                         	매뉴얼
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
                <!-- 중분류 -->
                     <div class="collapse" id="collapseMenual" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/notice/noticeList.do">공지사항</a>
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/qna/qnaList.do">문의게시판</a>
                         </nav>
                     </div>
			<!-- ---------------- 계정설정 ---------------->                     
                     <a class="nav-link" href="${pageContext.request.contextPath }/office/setting/passUpdate.do">
                         <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                       	  계정설정
                     </a>
			<!-- ---------------- 단지설정 ---------------->                     
                     <security:authorize access="hasRole('ROLE_HEAD')">
                     <a class="nav-link" href="${pageContext.request.contextPath }/office/setting/ApartView.do">
                         <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                         	단지설정
                     </a>
                     </security:authorize>
			<!-- ---------------- 전자결재 ---------------->
				<!-- 대분류 -->			
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseApproval" aria-expanded="false" aria-controls="collapseApproval">
                         <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                         	전자결재
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseApproval" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/approval/draftForm.do">기안문 작성</a>
                             <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#approvalBox" aria-expanded="false" aria-controls="approvalBox">
                               	결재함
                                 <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                             </a>
				<!-- 소분류 -->                             
                             <div class="collapse" id="approvalBox" aria-labelledby="headingOne" data-parent="#sidenavAccordionPages">
                                 <nav class="sb-sidenav-menu-nested nav">
                                	 <a class="nav-link" href="${pageContext.request.contextPath}/office/approval/wholeApprovalList.do">전체문서함</a>
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/approval/receptionList.do">수신함</a>
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/approval/sendingList.do">상신함</a>
                                 </nav>
                             </div>
                         </nav>
                     </div>
             <!-- ---------------- 일반문서함 ---------------->
				<!-- 대분류 -->	             
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                         <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                         	문서함
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->				
                     <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/document/documentList.do">일반문서 관리</a>
                         </nav>
                     </div>        
                     
                     <div class="sb-sidenav-menu-heading"><span>아파트관리</span></div>
 			 <!-- ---------------- 입주민관리 ---------------->
				<!-- 대분류 -->			
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseResident" aria-expanded="false" aria-controls="collapseResident">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	입주민관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseResident" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/resident/moveinList.do">입주관리</a>
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/resident/moveoutList.do">전출관리</a>
                         </nav>
                     </div>        
                     
             <!-- ------------- 차량관리 ------------------->
				<!-- 대분류 -->
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCar" aria-expanded="false" aria-controls="collapseCar">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	차량관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
                <!-- 중분류 -->
                     <div class="collapse" id="collapseCar" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/carO/wholeCarList.do">신청 현황</a>
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/carO/residentCarList.do">차량 관리</a>
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/carO/carInOutList.do">입출차 현황</a>
                         </nav>
                     </div>
			 
             <!-- ---------------- 일정관리 ---------------->
				<!-- 대분류 -->	             
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCalendar" aria-expanded="false" aria-controls="collapseCalendar">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	일정관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->				
                     <div class="collapse" id="collapseCalendar" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${cPath}/office/calendar/wholeCalendar.do">아파트 일정</a>
                         </nav>
                     </div>  
                                   
 			 <!-- ---------------- 공사/수선관리 ---------------->
				<!-- 대분류 -->	             
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseConstruction" aria-expanded="false" aria-controls="collapseConstruction">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	공사/수선관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->				
                     <div class="collapse" id="collapseConstruction" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${cPath}/office/construction/afterServiceList.do">수선관리</a>
                         </nav>
                     </div>        
				<!-- 중분류 -->				
                     <div class="collapse" id="collapseConstruction" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${cPath}/office/construction/remodelingList.do">리모델링관리</a>
                         </nav>
                     </div>        
             <!-- ------------- 자산관리 ------------------->
				<!-- 대분류 -->
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAsset" aria-expanded="false" aria-controls="collapseAsset">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	자산관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
                <!-- 중분류 -->
                     <div class="collapse" id="collapseAsset" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/asset/prod/prodList.do">물품관리</a>
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/asset/repair/repairList.do">수리 이력</a>
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/asset/buy/buyList.do">사용 · 구매 이력</a>
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/community/communityList.do">커뮤니티 시설관리</a>
                         </nav>
                     </div>
             <!-- ------------- 회계관리 ------------------->
				<!-- 대분류 -->
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAccount" aria-expanded="false" aria-controls="collapseAccount">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	회계관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
                <!-- 중분류 -->
                     <div class="collapse" id="collapseAccount" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/account/accountList.do">계좌관리</a>
                         </nav>
                     </div>
             <!-- ------------- 계약관리 ------------------->
				<!-- 대분류 -->
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseContract" aria-expanded="false" aria-controls="collapseContract">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	계약관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
                <!-- 중분류 -->
                     <div class="collapse" id="collapseContract" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${pageContext.request.contextPath}/office/servicecompany/serviceList.do">용역업체관리</a>
                         </nav>
                     </div>
                     
 					<div class="sb-sidenav-menu-heading"><span>관리비</span></div>
 			 <!-- ---------------- 검침관리 ---------------->
				<!-- 대분류 -->			
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMeter" aria-expanded="false" aria-controls="collapseInspection">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	검침관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseMeter" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${cPath}/office/meter/meterAllList.do">검침 통계</a>
                             <a class="nav-link" href="${cPath}/office/meter/meterCommList.do">공동 검침</a>
                             <a class="nav-link" href="${cPath}/office/meter/meterIndvList.do">세대 검침</a>
                         </nav>
                     </div>
                     
 			 <!-- ---------------- 부과관리 ---------------->
				<!-- 대분류 -->			
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMaintenanceCost" aria-expanded="false" aria-controls="collapseInspection">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	부과관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseMaintenanceCost" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${cPath}/office/cost/costStandard.do">부과 처리</a>
                             <a class="nav-link" href="${cPath}/office/cost/costIndvList.do">세대별 조회</a>
                         </nav>
                     </div>
                     
 			 <!-- ---------------- 수납관리 ---------------->
				<!-- 대분류 -->			
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCostPayment" aria-expanded="false" aria-controls="collapseInspection">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	수납관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseCostPayment" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                             <a class="nav-link" href="${cPath}/office/receipt/paidReceiptList.do">수납 조회</a>
                             <a class="nav-link" href="${cPath}/office/receipt/unpaidReceiptList.do">미납 조회</a>
                         </nav>
                     </div>
                     
 			 <!-- ---------------- 인사/근태관리 ---------------->
				<!-- 대분류 -->			
                     <div class="sb-sidenav-menu-heading"><span>인사/급여</span></div>
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEmployee" aria-expanded="false" aria-controls="collapseEmployee">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	인사/근태
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseEmployee" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                             <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#employeeBox" aria-expanded="false" aria-controls="employeeBox">
                               	인사관리
                                 <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                             </a>
				<!-- 소분류 -->                             
                             <div class="collapse" id="employeeBox" aria-labelledby="headingOne" data-parent="#sidenavAccordionPages">
                                 <nav class="sb-sidenav-menu-nested nav">
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/employee/employeeForm.do">인사정보 등록</a>
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/employee/employeeChangeList.do">입/퇴사자 조회</a>
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/employee/employeeList.do">직원 조회</a>
                                 </nav>
                             </div>
                <!-- 중분류 -->                             
                             <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#attendanceBox" aria-expanded="false" aria-controls="attendanceBox">
                               	근태관리
                                 <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                             </a>
				<!-- 소분류 -->                             
                             <div class="collapse" id="attendanceBox" aria-labelledby="headingOne" data-parent="#sidenavAccordionPages">
                                 <nav class="sb-sidenav-menu-nested nav">
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/off/offList.do">휴가 현황</a>
                                 </nav>
                             </div>
                         </nav>
                     </div>
 
  			 <!-- ---------------- 급여/정산관리 ---------------->
				<!-- 대분류 -->			
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSalary" aria-expanded="false" aria-controls="collapseSalary">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	급여/정산
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseSalary" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                             <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#salaryBox" aria-expanded="false" aria-controls="salaryBox">
                               	급여관리
                                 <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                             </a>
				<!-- 소분류 -->                             
                             <div class="collapse" id="salaryBox" aria-labelledby="headingOne" data-parent="#sidenavAccordionPages">
                                 <nav class="sb-sidenav-menu-nested nav">
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/payment/paymentBasicInfoList.do">급여계좌정보</a>
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/payment/paymentForMonthList.do">급여산출</a>
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/payment/paymentBookList.do">급여지급대장</a>
                                 </nav>
                             </div>
                <!-- 중분류 -->                             
                             <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#severancePay" aria-expanded="false" aria-controls="severancePay">
                               	정산관리
                                 <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                             </a>
				<!-- 소분류 -->                             
                             <div class="collapse" id="severancePay" aria-labelledby="headingOne" data-parent="#sidenavAccordionPages">
                                 <nav class="sb-sidenav-menu-nested nav">
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/severance/severanceView.do">퇴직정산</a>
                                 </nav>
                             </div>
                         </nav>
                     </div>                    

 			 <!-- ---------------- 사이트관리 ---------------->
  			 		<div class="sb-sidenav-menu-heading"><span>입주민 사이트</span></div>
				<!-- 대분류 -->			
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSite" aria-expanded="false" aria-controls="collapseSite">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	게시판 관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseSite" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                              <a class="nav-link" href="${pageContext.request.contextPath}/office/website/officeNotice/officeNoticeList.do">공지사항</a>
                              <a class="nav-link" href="${pageContext.request.contextPath}/office/website/officeQna/officeQnaList.do">문의게시판</a>
                              <a class="nav-link" href="${pageContext.request.contextPath}/office/website/boardList.do">자유게시판</a>
                         </nav>
                     </div>

				<!-- 대분류 -->			
                     <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCommunity" aria-expanded="false" aria-controls="collapseCommunity">
                         <div class="sb-nav-link-icon"><i class="fa fa-building"></i></div>
                         	시설 예약 관리
                         <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                     </a>
                     
				<!-- 중분류 -->                     
                     <div class="collapse" id="collapseCommunity" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                         <nav class="sb-sidenav-menu-nested nav">
                                     <a class="nav-link" href="${pageContext.request.contextPath}/office/website/reservation/reservationList.do">예약 현황</a>
                         </nav>
                     </div>
				<!-- 소분류 -->                             
                 </div>
             </div>
         </nav>
 </div>    
 


<script>
$(function() {
	/*
	 * 메뉴 상태유지 210220
	 * @edit 메뉴 스크롤바 유지 210308
	 * @author  이경륜
	 */
	var url = window.location.pathname; 
	var cutURL = url.substring(0,url.lastIndexOf("/")+1); // /AnyApart/office/resident/

    urlRegExp = new RegExp(cutURL.replace(/\/$/, '') + "\/[a-z]+(\\w+\\W+\\w+)$"); // //AnyApart/office/resident/[a-z]+(\w+\W+\w+)$/
    																			// [a-z]: moveoutList, moveoutForm... 대문자 전까지 일치하면 메뉴 열려있게하는 정규식
	let navdiv = $("#navdiv");
	$('a').each(function() {
		let href = this.href.replace(/\/$/, ''); // http://localhost/AnyApart/office/resident/moveinList.do
		if (urlRegExp.test(href)) {
			$(this).parents("div.collapse").addClass('show'); // 아코디언 메뉴 오픈
			if(url === href) { // url과 a의 href가 정확히 일치할 때만 메뉴색을 파란색으로
				$(this).addClass('active');
			}
			
			// 메뉴 스크롤 유지
			var offset = $(this).parent().offset(); // 클릭된 메뉴의 상위 카테고리의 위치값
			if (offset.top > 900) { // 관리비 메뉴 이후일때만 스크롤 작동
				navdiv.animate({scrollTop : offset.top}, 800);
			}
		}
	});
});
</script>

