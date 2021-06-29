<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27.		박지수	최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h4 style="margin-top: 20px;">
	<strong>커뮤니티시설조회</strong>
</h4>
<br>
<div class="card text-center col-auto" style="width: 600px; margin: auto;">
<!-- 	<div align="right" class="mb-2 mr-5" style="margin-top: 10px;"> -->
<!-- 		<input type="button" class="btn btn-danger" role="alert" value="인쇄"> -->
<!-- 	</div> -->
	<div class="card-body row" >
		<div class="col-sm-12">
			<table class="table">
				<thead class="thead-light">
					<tr>
						<th class="text-left" scope="col">커뮤니티 번호</th>
						<td class="text-left">${community.cmntNo }</td>
					</tr>
					<tr>
						<th class="text-left" scope="col">커뮤니티명</th>
						<td class="text-left">${community.cmntName }</td>
					</tr>
					<tr>
						<th class="text-left" scope="col">분류</th>
						<td class="text-left">${community.cmntCode }</td>
					</tr>
					<tr>
						<th class="text-left" scope="col">규모</th>
						<td class="text-left">${community.cmntSize }㎡</td>
					</tr>
					<tr>
						<th class="text-left" scope="col">수용인원</th>
						<td class="text-left">${community.cmntCapa } 명</td>
					</tr>
					<tr>
						<th class="text-left" scope="col">예약제한인원</th>
						<td class="text-left">${community.cmntLimit } 명</td>
					</tr>
					<tr>
						<th class="text-left" scope="col">여는시간</th>
						<td class="text-left">${community.cmntOpen }</td>
					</tr>
					<tr>
						<th class="text-left" scope="col">닫는시간</th>
						<td class="text-left">${community.cmntClose }</td>
					</tr>
					<tr>
						<th class="text-left" scope="col">시설설명</th>
						<td class="text-left">${community.cmntDesc }</td>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div align="right" class="mb-2 mr-5">
	<input id="updateBtn" type="button" class="btn btn-warning" role="alert" value="수정">
	<!-- 삭제는 따로 없었당 -->
<!-- 	<input type="button" class="btn btn-warning" role="alert" value="삭제"> -->
	<!-- 변경은 list에 있는 등록 폼을 가져와서 모달로 처리할 예정 -->
	<button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
</div>

<script>
	let updateBtn = $("#updateBtn");
// 	updateBtn.on("click", function(){
	$("#communityView").on("click", "#updateBtn", function(){
		communityUpdate.find(".modal-content").load("${cPath }/office/community/communityUpdateForm.do?cmntNo=${community.cmntNo }&aptCode=${community.aptCode }", function(){
			communityUpdate.modal();
		});
// 		location.href="${cPath }/office/community/communityUpdateForm.do?cmntNo=${community.cmntNo }&aptCode=${community.aptCode }";
	});
</script>