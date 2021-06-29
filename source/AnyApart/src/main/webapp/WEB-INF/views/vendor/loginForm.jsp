<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
${sessionScope['SPRING_SECURITY_LAST_EXCEPTION']['message'] }
<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
<script type="text/javascript">
	$(function() {
// 		$("#loginForm").on("submit", function() {
// 			let valid = true;
// 			$(":input[name]").each(function(index, element) {
// 				if ($(this).prop("required")) {
// 					let value = $(this).val();
// 					if (!value || value.trim().length == 0) {
// 						valid = valid && false;
// 					}
// 					// 					let ptrn = $(this).attr("pattern");
// 					// 					if(ptrn){
// 					// 						console.log(ptrn);
// 					// 						let regex = new RegExp(ptrn);
// 					// 						valid = valid && regex.test(value);
// 					// 					}
// 				}
// 			});
// 			return valid;
// 		});
	});
</script>
<c:if test="${empty sessionScope.authMember }">
<form id="loginForm" action="${pageContext.request.contextPath }/login/loginProcess.do" method="post">
	<div class="mb-3 mt-3 row g-3">
		<label for="mem_id" class="col-sm-1 col-form-label">아이디</label>
		<div class="col-auto">
			<input type="text" id="mem_id" name="mem_id" value="${cookie.idCookie.value }" required class="form-control" />
			<c:remove var="mem_id" scope="session"/>
		</div>
		<div class="form-check col-auto">
			<input class="form-check-input" type="checkbox" value="saveId" name="saveId" id="saveId"
				${not empty cookie.idCookie ? "checked":""}
			>
			<label class="form-check-label" for="saveId">아이디 기억하기</label>
		</div>
		<div class="form-check col-auto">
			<input type="checkbox" value="on" name="rememberMe">
			<lable for="rememberMe">RememberMe</lable>
		</div>
	</div>
	<div class="mb-3 row g-3">
		<label for="mem_pass" class="col-sm-1 col-form-label">비밀번호</label>
		<div class="col-auto">
<!-- 		pattern="^(?=.*[0-9]+)(?=.*[a-z]+)(?=.*[A-Z]+).{5,12}$" -->
			<input type="text" name="mem_pass" required  class="form-control" />
		</div>
		<div class="col-auto">
			<button type="submit" class="btn btn-primary mb-3">로그인</button>
		</div>
	</div>
</form>
</c:if>







