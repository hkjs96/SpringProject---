<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 1.      박지수      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<h4>
	페이지에 접근 권한이 없습니다.
</h4>

<security:authorize access="isAuthenticated()">
   	<security:authentication property="principal" var="principal" />
   	<c:set var="authMember" value="${principal.realMember }" />
   	<li data-menuanchor="page3"><a href="javascript:history.back();" class="link-success">뒤로가기</a></li>
</security:authorize>
<security:authorize access="isAnonymous()">
	<li data-menuanchor="page3"><a href="${cPath }/login">로그인</a></li>
</security:authorize>