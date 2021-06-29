<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h4>
	<strong>커뮤니티시설 예약 신청현황</strong>
</h4>
<br>
<div class="card text-center col-auto">
	<div class="card-body row">
		<div class="col-sm-12">
			<table class="table">
				<thead class="thead-dark">
					<tr>
						<th scope="col">#</th>
						<th scope="col">동/호수</th>
						<th scope="col">커뮤니티시설이름</th>
						<th scope="col">예약자(인원수)</th>
						<th scope="col">사용시작시간</th>
						<th scope="col">사용종료시간</th>
						<th scope="col">예약날짜</th>
						<th scope="col">승인하기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">1</th>
						<!-- 제이쿼리로 정보 담아 줬다가 넣어주는 형태로 가야할듯하다.
							이전에 배운 곳 참고해서 집어 넣기
							  -> buyerList.jsp 부분 참고해서 집어 넣기
						 -->
						<td>108/601</td>
						<td>탁구장</td>
						<td>이경륜 외 2명</td>
						<td>1000</td>
						<td>1100</td>
						<td>20210127</td>
						<td><button class="btn btn-warning">승인하기</button></td>
					</tr>
				</tbody>
			</table>
			<ul class="pagination justify-content-center">
				<li class="page-item"><a
					class="page-link alert alert-secondary" href="#">Previous</a></li>
				<li class="page-item"><a
					class="page-link alert alert-secondary" href="#">1</a></li>
				<li class="page-item"><a
					class="page-link alert alert-secondary" href="#">2</a></li>
				<li class="page-item"><a
					class="page-link alert alert-secondary" href="#">3</a></li>
				<li class="page-item"><a
					class="page-link alert alert-secondary" href="#">Next</a></li>
			</ul>
		</div>
	</div>
</div>