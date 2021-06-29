<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 29.  박 찬      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="${pageContext.request.contextPath }/js/main/js/front.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/js/main/css/front_20200803.css" />
<link rel="shortcut icon" href="${pageContext.request.contextPath }/js/main/img/favicon/favicon.ico">
<div id="container">
    <div class="inner">
        <!-- 공지사항 -->
     <div class="board-view">
         <div class="title">
             <strong>${board.boTitle }</strong>
             <div align="left">
                 <span><img src="${cPath }/js/main/img/common/ico_user.png" alt=""> By 관리자</span>
                 <span><img src="${cPath }/js/main/img/common/ico_date.png" alt="">${board.boDate }</span>
                 <span>조회수:${board.boHit }</span>
             </div>
         </div>
	
			<c:if test="${not empty board.attachList }">
				<c:forEach items="${board.attachList }" var="attach" varStatus="vs">
					<c:choose>
					
					<c:when test="${attach.attFilesize eq 0 }">
					
					</c:when>
					
					<c:when test="${attach.attFilesize ne 0 }">
					<div align="right">
					첨부파일
					<c:url value="/board/download.do" var="downloadURL">
						<c:param name="attSn" value="${attach.attSn }" />
						<c:param name="boNo" value="${attach.boNo }" />
					</c:url>
					
					<img src="${cPath }/js/main/img/common/file.png"/>
					<a href="${downloadURL }">
						<span title="다운로드:">${attach.attFilename }</span>
						${not vs.last?"|":"" }
					</a>
					</div>
					</c:when>
					
					
					</c:choose>
				</c:forEach>		
			</c:if>
			
	</div>
         <div class="txt-box">${board.boContent }</div>
            </div>
     <div class="board-btns">
         <a href="${cPath }/office/notice/noticeList.do" class="btn-list">목록보기</a>
     </div>
     <!-- // 공지사항 -->
 </div>
