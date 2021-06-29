<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.		박지수	최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h4>
	<strong>커뮤니티시설관리</strong>
</h4>
<br>
<!-- <div class="container"> -->
<!-- 	<div class="col-md-12" style="border-style: outset; border-radius: 8px;"> -->
<!-- 		<div class="row g-0"> -->
<!-- 			<div class="col-md-2" style="margin-top: 20px;"> -->
<%-- 				<img src="${pageContext.request.contextPath}/images/searchIcon.png" --%>
<!-- 					alt="searchIcon" -->
<!-- 					style="width: 30px; height: 30px; margin-left: 10px; margin-top: 10px;">&nbsp;&nbsp;<strong>검색 -->
<!-- 					조건</strong> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->
<div class="card text-center col-auto" style="width: 600px; margin: auto;">
<!-- 	<div align="right" class="mb-2 mr-5" style="margin-top: 10px;"> -->
<!-- 		<input type="button" class="btn btn-danger" role="alert" value="인쇄"> -->
<!-- 	</div> -->
	<div class="card-body row" >
		<div class="col-sm-12">
			<table class="table">
				<thead class="thead-light">
					<tr>
						<th scope="col">커뮤니티 번호</th>
						<td>${community.cmntNo }</td>
					</tr>
					<tr>
						<th scope="col">커뮤니티명</th>
						<td>${community.cmntName }</td>
					</tr>
					<tr>
						<th scope="col">분류</th>
						<td>${community.cmntCode }</td>
					</tr>
					<tr>
						<th scope="col">규모</th>
						<td>${community.cmntSize }㎡</td>
					</tr>
					<tr>
						<th scope="col">수용인원</th>
						<td>${community.cmntCapa } 명</td>
					</tr>
					<tr>
						<th scope="col">예약제한인원</th>
						<td>${community.cmntLimit } 명</td>
					</tr>
					<tr>
						<th scope="col">여는시간</th>
						<td>${community.cmntOpen }</td>
					</tr>
					<tr>
						<th scope="col">닫는시간</th>
						<td>${community.cmntClose }</td>
					</tr>
					<tr>
						<th scope="col">시설설명</th>
						<td>${community.cmntDesc }</td>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div align="right" class="mb-2 mr-5">
	<input id="updateBtn" type="button" class="btn btn-primary" role="alert" value="변경">
	<!-- 삭제는 따로 없었당 -->
<!-- 	<input type="button" class="btn btn-warning" role="alert" value="삭제"> -->
	<!-- 변경은 list에 있는 등록 폼을 가져와서 모달로 처리할 예정 -->
	<input type="button" class="btn btn-dark" role="alert" value="뒤로가기" onclick="window.history.back();">
</div>

<script>
	let updateBtn = $("#updateBtn");
	updateBtn.on("click", function(){
		location.href="${cPath }/office/community/communityUpdateForm.do?cmntNo=${community.cmntNo }&aptCode=${community.aptCode }";
	});
</script>