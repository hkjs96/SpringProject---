<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<head>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/asyncForm.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath }/css/css/gotham-book.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/css/gotham-medium.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/css/minimal.bundle.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/css/shims.min.css" />
<link rel="stylesheet" href="${cPath }/js/noty-3.1.4/noty.css">

<script type="text/javascript" src="${cPath }/js/noty-3.1.4/noty.min.js"></script>
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/jquery.validate.min.js"></script>
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/additional-methods.min.js"></script>
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/localization/messages_ko.min.js"></script>

<!-- 이경륜: h에만 폰트추가 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<style>
h1, h2, h3, h4, h5, h6, thead, th{
    font-family: 'Nanum Gothic', sans-serif;
	font-weight: bold;
}
</style>
<title>로그인</title>
</head>
<!-- 이경륜: jquery validator 끝 -->
<script type="text/javascript">
	$.getContextPath = function(){
		return "${cPath }";
	}
</script>

${sessionScope['SPRING_SECURITY_LAST_EXCEPTION']['message'] }
<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
<script type="text/javascript">
	$(function() {
		$("#loginForm").on("submit", function() {
			let valid = true;
			$(":input[name]").each(function(index, element) {
				if ($(this).prop("required")) {
					let value = $(this).val();
					if (!value || value.trim().length == 0) {
						valid = valid && false;
					}
					let ptrn = $(this).attr("pattern");
					if(ptrn){
						console.log(ptrn);
						let regex = new RegExp(ptrn);
						valid = valid && regex.test(value);
					}
				}
			});
			return valid;
		});
	});
</script>

<style>
	.loginSelector {
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>

<c:if test="${empty sessionScope.authMember }">
<main id="main-content" class="tmp-shell-row tmp-shell-row--stretch">
<div class="tds-content_container tds-content_container--small">
<div class="d-flex justify-content-center" style="text-align: center;">
	<img alt="" src="${pageContext.request.contextPath }/js/main/img/common/logo.png"></a>
		    <br><h3>함께 사는 즐거움, 애니아파트</h3>
</div>
<h1 class="tds-text--h1-alt" data-i18n-key="login:pageHeader">Log In</h1>
        <div class="tds-status_msg tds-status_msg--enclosed tds--is_hidden" role="alert" data-field="_">
		  <div class="tds-status_msg-text">
		    <div class="tds-status_msg-body">
		    </div>
		  </div>
		</div>
	<form id="loginForm" action="${pageContext.request.contextPath }/login/loginProcess.do" method="post">
		  <div class="tds-form-item">
              <label class="tds-form-item-label" for="form-input-identity">
                <span data-i18n-key="login:formIdentityLabel1">아이디</span>
                <div class="tds-tooltip">
                  <button type="button" class="tds-tooltip-trigger" aria-label="Email Address Tooltip">
                    <i class="tds-tooltip-icon"></i>
                  </button>
                  <div class="tds-tooltip-content">
                    <p data-i18n-key="login:formIdentityTooltipText1">
                     
                    </p>
                    <p data-i18n-key="login:formIdentityTooltipText2" data-i18n-data="{&#34;link&#34;:{&#34;start&#34;:&#34;&lt;a href=\&#34;https://www.tesla.com/support/account-support\&#34; target=\&#34;_blank\&#34;&gt;&#34;,&#34;end&#34;:&#34;&lt;/a&gt;&#34;}}">
                		 로그인 성공시 입주민 회원은 입주민 사이트로, 관리사무소 회원은 관리사이트로 이동합니다.
                    </p>
                  </div>
                </div> <!-- tds-tooltip -->
              </label>
              
<%--               <c:set target="${sessionScope.memId}" scope="session" var="memId" /> --%>
              <div class="tds-text-input--wrapper" data-field="identity">
                <input type="text" id="form-input-identity" name="memId" value="${sessionScope.memId}" required class="tds-text-input" autocomplete="username" maxlength="11"/>
                <div class="tds-form-item-feedback"></div>
              </div>
              
              <div class="tds-form-item tds-form-item--password" data-showlabel="Show Password" data-hidelabel="Hide Password" data-showicon="tds-eye-show" data-hideicon="tds-eye-hide">
              <label class="tds-form-item-label" for="password-input">
                <span data-i18n-key="login:formPasswordLabel">Password</span>
              </label>
              
               <div class="tds-text-input--wrapper" data-field="password">
                <input class="tds-text-input" id="form-input-credential" type="password"  name="memPass" autocomplete="current-password" aria-label="credentials-input" maxlength="12"
                 required/>
<!--                 pattern="^(?=.*[0-9]+)(?=.*[a-zA-Z]+).{5,12}$" -->
<!--                 pattern="^(?=.*[0-9]+)(?=.*[a-z]+)(?=.*[A-Z]+).{5,12}$" required/> -->
                <button class="tds-password-input--toggle" type="button">
                  <svg class="tds-icon">
                    <title>Show Password</title>
                    <use xlink:href="#tds-eye-show"></use>
                  </svg>
                </button>
              </div>
              </div>
              <div class="chekDiv">
				<input class="form-check-input" type="checkbox" value="saveId" name="saveId" id="saveId"
						${not empty sessionScope.memId ?"checked":"" }>
<%-- 						${not empty cookie.idCookie ?"checked":"" }> --%>
				<label class="form-check-label" for="saveId">아이디 기억하기</label>
				<c:remove var="memId" scope="session"/>
				
				<input class="form-check-input" type="checkbox" value="on" name="rememberMe" id="rememberMe">
				<label class="form-check-label" for="rememberMe">Remember me</label>
				</div>
		</div>
		<button type="submit" class="tds-btn tds-btn--blue tds-btn--full" id="form-submit-continue">
              Sign In
            </button>
            <p class="need-help tds-text--center">
              <a class="tds-link" href="${cPath }/login/findId"
              	 onClick="openId(this.href);  return false;">아이디 찾기</a>
              <span class="tmp-link-separator">|</span>
              
              <a class="tds-link" href="${cPath }/login/findPass"
              	 onClick="openId(this.href);  return false;">비밀번호 찾기</a>
            </p>
	</form>
	<div class="loginSelector">
		<button data-memid='ADMIN' data-mempass='aA!!1234' class="tds-btn tds-btn--blue autoLogin" id="vendor-login">벤더 관리자</button>
		<button data-memid='A0024E001' data-mempass='aA!!1234' class="tds-btn tds-btn--blue autoLogin" id="head-login">소장 로그인</button>
		<button data-memid='A0024E002' data-mempass='aA!!1234' class="tds-btn tds-btn--blue autoLogin" id="emp-login">과장 로그인</button>
		<button data-memid='A0024R00001' data-mempass='aA!!1234' class="tds-btn tds-btn--blue autoLogin" id="res-login">입주민 로그인</button>
	</div>
</div>
</main>


<div class="tds--is_visually_hidden">
  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <symbol xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" id="tds-eye-hide--inverted"><g fill="#fff" fill-rule="evenodd" transform="translate(6 7)"><path fill-rule="nonzero" d="M17.51 7.81c0 1.48-4.1 5.75-8.77 5.75a8.5 8.5 0 01-2.49-.4l1.23-1.22c.42.08.84.12 1.26.12 1.8 0 3.62-.76 5.2-2.01 1.14-.9 2.04-2.05 2.04-2.24 0-.2-.89-1.34-2.02-2.24l-.06-.05 1.07-1.07c1.56 1.23 2.55 2.63 2.54 3.36zm-5.27 0a3.5 3.5 0 01-4.08 3.45l4.03-4.03c.04.19.05.38.05.58zm-3.5-5.75c.88 0 1.74.15 2.56.4L10.07 3.7a6.89 6.89 0 00-1.33-.13c-1.82 0-3.64.76-5.21 2-1.14.9-2 2.05-2 2.25 0 .19.87 1.34 2.01 2.24l.1.07-1.07 1.08C1 9.95 0 8.54 0 7.8c0-1.48 4.08-5.73 8.74-5.75zm0 2.25c.23 0 .44.02.65.06L5.3 8.46a3.52 3.52 0 013.44-4.15z"/><rect width="1.5" height="19.62" x="8.01" y="-2" rx=".75" transform="scale(-1 1) rotate(-45 0 28.95)"/></g></symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" id="tds-eye-hide"><g fill="#000" fill-rule="evenodd" transform="translate(6 7)"><path fill-rule="nonzero" d="M17.51 7.81c0 1.48-4.1 5.75-8.77 5.75a8.5 8.5 0 01-2.49-.4l1.23-1.22c.42.08.84.12 1.26.12 1.8 0 3.62-.76 5.2-2.01 1.14-.9 2.04-2.05 2.04-2.24 0-.2-.89-1.34-2.02-2.24l-.06-.05 1.07-1.07c1.56 1.23 2.55 2.63 2.54 3.36zm-5.27 0a3.5 3.5 0 01-4.08 3.45l4.03-4.03c.04.19.05.38.05.58zm-3.5-5.75c.88 0 1.74.15 2.56.4L10.07 3.7a6.89 6.89 0 00-1.33-.13c-1.82 0-3.64.76-5.21 2-1.14.9-2 2.05-2 2.25 0 .19.87 1.34 2.01 2.24l.1.07-1.07 1.08C1 9.95 0 8.54 0 7.8c0-1.48 4.08-5.73 8.74-5.75zm0 2.25c.23 0 .44.02.65.06L5.3 8.46a3.52 3.52 0 013.44-4.15z"/><rect width="1.5" height="19.62" x="8.01" y="-2" rx=".75" transform="scale(-1 1) rotate(-45 0 28.95)"/></g></symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" id="tds-eye-show--inverted"><g fill="none" fill-rule="evenodd" stroke="#fff" transform="translate(7 10)"><circle cx="8" cy="5" r="2.31" stroke-width="2.37"/><path stroke-width="1.5" d="M8 0c4.49 0 8 4.13 8 5 0 .87-3.56 5-8 5-4.44 0-8-4.12-8-5 0-.88 3.51-5 8-5z"/></g></symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" id="tds-eye-show"><g fill="none" stroke="#000" fill-rule="evenodd" transform="translate(7 10)"><circle cx="8" cy="5" r="2.31" stroke-width="2.37"/><path stroke-width="1.5" d="M8 0c4.49 0 8 4.13 8 5 0 .87-3.56 5-8 5-4.44 0-8-4.12-8-5 0-.88 3.51-5 8-5z"/></g></symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" id="tds-error"><g fill="none" fill-rule="evenodd"><circle cx="10" cy="10" r="10" fill="#ED4E3B"/><path fill="#fff" d="M10.075 4.5c.65 0 1.179.528 1.179 1.179v4.714a1.179 1.179 0 11-2.358 0V5.679A1.18 1.18 0 0110.075 4.5zm0 8.25a1.375 1.375 0 110 2.75 1.375 1.375 0 010-2.75z"/></g></symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 18" id="tds-warning"><g fill="none" fill-rule="evenodd"><path d="M0-1h20v20H0z"/><path fill="#FBB01B" d="M12.825 1.627l6.663 11.077C20.875 15.009 19.28 18 16.663 18H3.337C.72 18-.875 15.01.512 12.704L7.175 1.627a3.266 3.266 0 015.65 0z"/><path d="M10.075 4c.65 0 1.179.528 1.179 1.179v4.714a1.179 1.179 0 11-2.358 0V5.179A1.18 1.18 0 0110.075 4zm0 8.25a1.375 1.375 0 110 2.75 1.375 1.375 0 010-2.75z" fill="#FFF"/></g></symbol>
  </svg>
</div>
</c:if>

<script src="${pageContext.request.contextPath }/js/tds-text-inputs--password.js" type="application/javascript"></script>



<script>
	$(".autoLogin").on("click", function(){
		let btn = $(this);
		let memId = btn.data("memid");
		let memPass = btn.data("mempass");
		
		console.log(memId);
		console.log(memPass);
		
		let loginForm = $("#loginForm");
		let inputId = loginForm.find("[name=memId]").val(memId);
		let inputPass = loginForm.find("[name=memPass]").val(memPass);
		console.log(loginForm);
		console.log(inputId);
		console.log(inputPass);
		loginForm.submit();
	});
	
	
	let popupWidth = 400;
	let popupHeight = 750;

	let popupX = (window.screen.width / 2) - (popupWidth / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

	let popupY= (window.screen.height / 2) - (popupHeight / 2);
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
	
	
	 function openId(url){
		window.open(url, '', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY); return false;
	}
	
	 function openPass(url){
		 window.open(url, '', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY); return false;
	}
	 
	 
	 document.onkeydown = fkey;
	 document.onkeypress = fkey;
	 document.onkeyup = fkey;
	  
	 var wasPressed = false;
	  
	 function fkey(e){
	     e = e || window.event;
	     if(wasPressed) return;
	  
	     if(e.keyCode == 116){
	         location.href = "${pageContext.request.contextPath }/login";
	     }
	 }


	 
</script>>

<!-- 박지수: noty 띄우기 위한 코드 -->
<c:if test="${not empty message }">
	<script type="text/javascript">
		new Noty({
			 text:'${message.text }', 
			 layout: '${message.layout }',
			 type: '${message.type }',
			 timeout: ${message.timeout },
			 progressBar: true
		}).show();
	</script>
</c:if>
<!-- 박지수: noty 코드 끝 -->
