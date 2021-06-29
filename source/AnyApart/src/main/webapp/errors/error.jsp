<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 6.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<c:set var="statusCode" value="${pageContext.errorData.statusCode  }"/>   	

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>${statusCode } Error - SB Admin</title>
        <link href="${pageContext.request.contextPath }/js/startbootstrap-sb-admin-gh-pages/dist/css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body>
    <div style="color: white;">
		<h4>개발자 영역</h4>
		요청주소 : ${pageContext.errorData.requestURI }
		<br>상태코드 : ${statusCode }
		<br>throwable: ${pageContext.errorData.throwable }
	</div>
        <div id="layoutError">
            <div id="layoutError_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <div class="text-center mt-4">
                                	<img alt="" src="${cPath }/images/cryingSmile.jpg" width="200px" height="200px">
                                    <h1 class="display-1">${statusCode }</h1>
                                    <p class="lead">
                                    	<c:choose>
	                                    	<c:when test="${statusCode eq 404  }">
	                                    		요청받은 페이지를 찾을 수 없습니다.
	                                    	</c:when>
	                                    	<c:when test="${statusCode eq 500  }">
	                                    		해당 요청을 처리할 수 없습니다.
	                                    	</c:when>
	                                    	<c:when test="${fn:substring(statusCode,0,1) eq 5  }">
	                                    		관리자에게 문의하세요.
	                                    	</c:when>
                                    		<c:otherwise>
                                    			잘못된 요청입니다.
                                    		</c:otherwise>
                                    	</c:choose>
                                    </p>
	                                    <a href="javascript:history.back();">
	                                        <i class="fas fa-arrow-left mr-1"></i>
	                                        뒤로 가기
	                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutError_footer">
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; AnyApart 2021</div>
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
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </body>
</html>

