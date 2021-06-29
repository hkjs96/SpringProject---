<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	

<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/asyncForm.js"></script>
<link rel="stylesheet" href="${cPath }/js/noty-3.1.4/noty.css">
<script type="text/javascript" src="${cPath }/js/noty-3.1.4/noty.min.js"></script>
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/jquery.validate.min.js"></script>
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/additional-methods.min.js"></script>
<script type="text/javascript" src="${cPath }/js/jquery-validation-1.19.2/localization/messages_ko.min.js"></script>
<!-- 이경륜: jquery validator 끝 -->
<script type="text/javascript">
	$.getContextPath = function(){
		return "${cPath }";
	}
</script>
${sessionScope['SPRING_SECURITY_LAST_EXCEPTION']['message'] }
<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="Session"/>
<script>
	$(function(){
		$("#loginForm").on("submit", funtion() {
			let valid = true;
			$(":input[name]").each(function(index, element)){
				if($(this).prop("required")){
					let value = $(this).val();
					if(!value || value=.trim().length == 0){
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
	})
</script>
<c:if test="${empty sessionScope.authMember }">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Login</title>
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body class="bg-primary">
    <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-5">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                                <div class="card-body">
                                    <form id="loginForm" action="${cPath }/login/loginProcess.do" method="post">
                                        <div class="form-group">
                                            <label class="small mb-1" for="memId">아이디</label>
                                            <input class="form-control py-4" id="memId" name="memId" value="${cookie.idCookie.value }" type="text" placeholder="Enter id" />
                                            <c:remove var="mem_id" scope="session" />
                                        </div>
                                        <div class="form-group">
                                            <label class="small mb-1" for="memPass">Password</label>
                                            <input class="form-control py-4" id="memPass" type="memPass" placeholder="Enter password" />
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" value="saveId" name="saveId" id="saveId" type="checkbox" 
                                                	${not empty cookie.idCookie ? "checked":"" }
                                                />
                                                <label class="custom-control-label" for="saveId">아이디 기억하기</label>
                                            </div>
                                        </div>
                                        <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
                                            <a class="small" href="password.html">Forgot Password?</a>
                                            <a class="btn btn-primary" href="index.html">Login</a>
                                        </div>
                                    </form>
                                </div>
                                <div class="card-footer text-center">
                                    <div class="small"><a href="register.html">Need an account? Sign up!</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <div id="layoutAuthentication_footer">
            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">Copyright &copy; Your Website 2021</div>
                        <div>
                            <a href="#">Privacy Policy</a>
                            &middot;
                            <a href="#">Terms &amp; Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

</body>
</c:if>
