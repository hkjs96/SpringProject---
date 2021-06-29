<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<style type="text/css">
.counter-content{
	margin-left: 100px;
}
.counter-text{
	font-size: 1.2em;
	padding-left: 20px;
	color: black;
}
.col-lg-6 {
    width: 55%;
}
#barImg{
	display: inline-block;
	width: 120px;
	height: 80px;
}
.space-small {
    padding-top: 25px;
    padding-bottom: 0px;
}
</style>    
 <div class="header-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-lg-1 col-md-2 col-sm-2 col-xs-12" style="width: 16%; height: 10%;">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/resident"><img src="${pageContext.request.contextPath}/images/residentLogo.png" ></a>
                </div>
            </div>
            <div class="col-lg-6 col-md-10 col-sm-8 col-xs-12">
            
            <!-- 메뉴(대분류) -->
                <div class="navigation-wrapper">
                    <div id="navigation" >
                        <ul>
                            <li class="active"><a href="#">관리비</a>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/resident/maintenanceCost/feeView.do" name="feeView.do">관리비 조회</a></li>
                                    <li><a href="${pageContext.request.contextPath}/resident/maintenanceCost/feePayment.do" name="feePayment.do">관리비 납부</a></li>
                                    <li><a href="${pageContext.request.contextPath}/resident/maintenanceCost/paymentView.do" name="paymentView.do">납부내역 조회</a></li>
		                              
                                </ul>
                            </li>
                            <li class="has-sub"><a href="#">차량관리</a>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/resident/car/residentCar.do" name="residentCar.do">내 차량 관리</a></li>
                                </ul>
                            </li>
                            <li class="has-sub"><a href="#">생활지원</a>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/resident/support/afterServiceList.do" name="afterServiceList.do">수리신청</a></li>
                                    <li><a href="${pageContext.request.contextPath}/resident/support/remodelingList.do" name="remodelingList.do">리모델링 신고</a></li>
                                </ul>
                            </li>
                            <li class="has-sub"><a href="#">입주민 공간</a>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/resident/space/boardList.do" name="boardList.do">자유게시판</a></li>
                                    <li><a href="${pageContext.request.contextPath}/resident/officeQna/officeQnaList.do" name="officeQnaList.do">문의하기</a></li>
                                </ul>
                            </li>
                            <li class="has-sub"><a href="#">알림마당</a>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/resident/notice/noticeList.do" name="noticeList.do">공지사항</a></li>
                                    <li><a href="${pageContext.request.contextPath}/resident/notice/apartNewsList.do" name="apartNewsList.do">아파트 소식</a></li>
                                </ul>
                            </li>
                            <li class="has-sub"><a href="#">커뮤니티센터</a>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/resident/community/reservation.do" name="reservation.do">시설예약</a></li>
                                    <li><a href="${pageContext.request.contextPath}/resident/community/myReservation.do" name="myReservation.do">나의 예약조회</a></li>
                                </ul>
                            </li>
                            <li class="has-sub"><a href="#">MY</a>
			                    <ul>
			          			<security:authorize access="isAuthenticated()">
			                   		<security:authentication property="principal" var="principal" />
			                   		<c:set var="authMember" value="${principal.realMember }" />
<%-- 			                   		<li><a class="me-2 link-primary" href="${pageContext.request.contextPath }/resident/mypage/view.do" name="view.do">${authMember.memNick }</a></li><!-- ${principal.authorities} --> --%>
			                   		<li><a class="me-2 link-primary" href="${pageContext.request.contextPath }/resident/mypage/view.do" name="view.do">내 정보</a></li><!-- ${principal.authorities} -->
			                   		<li><a href="${cPath }/login/logout.do" class="link-success" name="logout.do">로그아웃</a></li>
			                   	</security:authorize>
			                   	<security:authorize access="isAnonymous()">
			                   		<li><a href="${cPath }/login" name="login">로그인</a></li>
			                   	</security:authorize>
		                   		</ul>
		                   	</li>
                        </ul>
                            
                    </div>
                </div>
                <diV class="navigation-wrapper" id="navigation">
                	
                </diV>
            </div>
        </div>
    </div>
</div>
<div id="indexDiv">
<div class="space-small bg-default" id="menuDiv">
    <div class="counter-block">
        <div class="counter-content">
	        <div class="container">
	        	<div class="row">
	        		<div class="col-md-8">
			            <span class="counter-title" style="padding-left: 70px" id="residentTitle"></span>
			            <span class="counter-text"id="residentSubTitle"></span>
			        </div>
	        		<div class="col-md-3">
			            <img src="${cPath }/images/residentBar2.png" id="barImg">
	        		</div>
	        	</div>
	        </div>
	    </div>
	</div>
</div>
</div>
<script>
/*
 * 탑메뉴 20210303
 * 박정민
 */
$(document).ready(function(){
	var url = window.location.pathname;
	var cutURL = url.substring(url.lastIndexOf("/")+1)
	let smenu = $("#navigation").find("[name='"+cutURL+"']");
	$("#residentSubTitle").html(smenu.text());	
	
	let parenta = smenu.parent().parent().parent();  //li < ul < li.has-sub
// 	let middleMenu = parenta.find("[name='middleMenu']")
	let bmenu = parenta.find('a[href="#"]');
// 	let middleChild = middleMenu.find('a[href="#"]'); 
// 	console.log(middleChild.text());
	bmenu.css("background-color", "#2f62d5");
	bmenu.css("color", "white");
	$("#residentTitle").html(bmenu.text());	
});
</script>
