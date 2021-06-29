<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.gnb li a{
    font-size: 14px;
    position: relative;   /*부모는 상대위치*/
}

.gnb li a:before{
    content : '';
    position: absolute;  /*before를 절대위치*/
    background-color: orange;
    height: 4px;
    width : 0;
    bottom: -5px;       /*bottom을 주어, 글자 밑에 위치시킴*/       
    transition: 0.5s;    /*가상클래스에 이벤트 발생시 시간 지정*/
    
    
    left : 50%;         /*만약 왼쪽에서부터 커지게하려면-> left를 0으로 두면 됨*/
    transform: translateX(-50%);
}

.gnb li a:hover:before{ /*hover시 width:0 -> 100%가 됨*/
    width : 100%;
      
}

.gnb li a.active:link {
	background-color: orange;
	color: black;
	border-radius: 5px 5px;
}
</style>
<nav>
    <div id="head">
        <h1><a href="${pageContext.request.contextPath }/vendor"><img alt="" src="${pageContext.request.contextPath }/js/main/img/common/logo.png"></a></h1>
        <div id="gnb">
            <ul id="menu" class="gnb">
                <li><a href="${pageContext.request.contextPath }/vendor">홈</a></li>
                <li><a href="${pageContext.request.contextPath }/vendor/apartList.do">관리사무소 회원 관리</a></li>
                <li><a href="${pageContext.request.contextPath }/vendor/noticeList.do">공지사항 관리</a></li>
                <li><a href="${pageContext.request.contextPath }/vendor/qna/qnaList.do">문의글 관리</a></li>
                <security:authorize access="isAuthenticated()">
                   	<security:authentication property="principal" var="principal" />
                   	<c:set var="authMember" value="${principal.realMember }" />
<%--                    	<li data-menuanchor="page3"><a class="me-2 link-primary" href="${pageContext.request.contextPath }/mypage.do">${authMember.memNick }${principal.authorities}</a></li> --%>
                   	<li data-menuanchor="page3"><a href="${cPath }/login/logout.do" class="link-success">로그아웃</a></li>
                </security:authorize>
                <security:authorize access="isAnonymous()">
                	<li data-menuanchor="page3"><a href="${cPath }/login">로그인</a></li>
                </security:authorize>
            </ul>
        </div>
    </div>
</nav>
<script>
$(function() {
	/*
	 * 메뉴 상태유지 210308 작업중!
	 * @author  이경륜
	 */
	var url = window.location.pathname; 
	var cutURL = url.substring(0,url.lastIndexOf("/")+1); // /AnyApart/office/resident/

	urlRegExpForHome = new RegExp(cutURL.replace(/\/$/, '') + "\/[a-z]+$")
    urlRegExp = new RegExp(cutURL.replace(/\/$/, '') + "\/[a-z]+(\\w+\\W+\\w+)$"); // //AnyApart/office/resident/[a-z]+(\w+\W+\w+)$/
    																			// [a-z]: moveoutList, moveoutForm... 대문자 전까지 일치하면 메뉴 열려있게하는 정규식
	$('a').each(function() {
		let href = this.href.replace(/\/$/, '').replace('http://localhost',''); // http://localhost/AnyApart/office/resident/moveinList.do
		console.log(href);
		console.log(urlRegExp);
		if (urlRegExp.test(href) || urlRegExpForHome.test(href)) {
			console.log(url);
			console.log($(this));
			if(url === href) { // url과 a의 href가 정확히 일치할 때만 메뉴색을 파란색으로
				$(this).addClass('active');
				$(this).css('color', 'black');
				console.log($(this));
			}
		}
	});
});

</script>
