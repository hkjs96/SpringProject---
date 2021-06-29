<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 27. 이경륜      최초작성
* 2021. 2. 10. 이경륜      모달에서 별도 페이지로 분리
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container">
	<br>
	<h4>
		<strong>전출등록</strong>
	</h4>
	<br>
	<form id="searchForm" action="${cPath }/office/resident/moveoutFormAjax.do" method="get" class="form-inline">
		<input type="hidden" name="searchVO.searchAptCode">
		<input type="hidden" name="currentPage" value="1">
		<input type="hidden" name="resMoveout">
		<input type="hidden" name="dong">
		<input type="hidden" name="ho">
	</form>
	<table class="table table-bordered">
		<thead>
			<tr>
				<td class="table-secondary text-center" colspan="4">
					전출세대를 입력 후 조회해 주세요.
				</td>
			</tr>
			<tr>
				<th class="text-center table-dark">전출 세대</th>
				<td colspan="3" id="inputUI">
					<input type="text" name="dong">&nbsp;동&nbsp;
					<input type="text" name="ho">&nbsp;호&nbsp;
					<button type="button" class="btn btn-dark" id="searchBtn">조회</button>
				</td>
			</tr>
			<tr>
				<th class="text-center table-dark">전출일</th>
				<td class="text-center" colspan="3">
					<input type="date" name="resMoveout">
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th class="text-center table-dark">입주민코드</th>
				<td class="text-center"></td>
				<th class="text-center table-dark">세대주명</th>
				<td class="text-center"></td>
			</tr>
			<tr>
				<th class="text-center table-dark">연락처</th>
				<td class="text-center"></td>
				<th class="text-center table-dark">비상연락처</th>
				<td class="text-center"></td>
			</tr>
			<tr>
				<th class="text-center table-dark">등록된 차량</th>
				<td class="text-center" colspan="3">
					<span>* 전출 등록 즉시 차량 등록이 해지됩니다. </span>
					<br/>
					<table style="margin-left: auto; margin-right: auto;">
						<thead>
							<tr class="table-secondary">
								<th>순번</th>
								<th>차량번호</th>
								<th>차종</th>
							</tr>
						</thead>
						<tbody id="carBody">
<!-- 							<tr> -->
<!-- 								<td>1</td> -->
<!-- 								<td>28가3920</td> -->
<!-- 								<td>소나타</td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td>2</td> -->
<!-- 								<td>35라4587</td> -->
<!-- 								<td>아반떼</td> -->
<!-- 							</tr> -->
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<th class="text-center table-dark">당월 관리비</th>
				<td class="text-center" colspan="3">
					<span><strong>* 1일~전출일까지의 검침량에 따른 관리비는 등록된 이메일로 별도 고지될 예정입니다.</strong></span>
				</td>
			</tr>
			<tr>
				<th class="text-center table-dark">관리비 미납 내역</th>
				<td class="text-center" colspan="3">
					<span>* 관리비 미납 내역 존재시 전출 처리가 불가합니다. </span>
					<br/>
					<span>* 즉시 수납 후 전출 처리시 수납버튼을 누른 후 관리자 비밀번호를 입력해 주세요. </span>
					<br>
					<span><strong>수납내역에 등록되어야함</strong></span>
					<br>
					<span><strong>연체료 계산되어야함</strong></span>
					<table style="margin-left: auto; margin-right: auto;" id="costTable">
						<thead>
							<tr class="table-secondary">
								<th>순번</th>
								<th>부과년</th>
								<th>부과월</th>
								<th>공동관리비</th>
								<th>개별관리비</th>
								<th>연체료</th>
								<th>총액</th>
								<th>수납처리</th>
							</tr>
						</thead>
						<tbody id="costBody">
<!-- 							<tr> -->
<!-- 								<td>202012</td> -->
<!-- 								<td>125,000</td> -->
<!-- 								<td>175,000</td> -->
<!-- 								<td>30,000</td> -->
<!-- 								<td>330,000</td> -->
<!-- 								<td><input type="button" class="btn btn-success" value="수납완료"/></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td>202011</td> -->
<!-- 								<td>125,000</td> -->
<!-- 								<td>175,000</td> -->
<!-- 								<td>30,000</td> -->
<!-- 								<td>300,000</td> -->
<!-- 								<td> -->
<!-- 									<button type="button" class="btn btn-warning" style='margin:5pt;' data-toggle="modal" data-target="#moveoutAuthModal">즉시수납</button> -->
<!-- 								</td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td>202010</td> -->
<!-- 								<td>125,000</td> -->
<!-- 								<td>175,000</td> -->
<!-- 								<td>30,000</td> -->
<!-- 								<td>300,000</td> -->
<!-- 								<td> -->
<!-- 									<button type="button" class="btn btn-warning" style='margin:5pt;' data-toggle="modal" data-target="#moveoutAuthModal">즉시수납</button> -->
<!-- 								</td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td>202009</td> -->
<!-- 								<td>125,000</td> -->
<!-- 								<td>175,000</td> -->
<!-- 								<td>30,000</td> -->
<!-- 								<td>300,000</td> -->
<!-- 								<td> -->
<!-- 									<button type="button" class="btn btn-warning" style='margin:5pt;' data-toggle="modal" data-target="#moveoutAuthModal">즉시수납</button> -->
<!-- 								</td> -->
<!-- 							</tr> -->
						</tbody>
						<tfoot>
							<tr>
								<td colspan="8">
									<div id="pagingArea"></div>
								</td>
							</tr>
						</tfoot>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4" class="text-center pt-2">
					<input data-command="insert" type="button" value="저장" class="btn btn-primary" id="insertBtn" />
					<input data-command="list" type="button" value="목록" class="btn btn-dark" id="listBtn" />
				</td>
			</tr>
		</tbody>
	</table>
</div>

<form id="moveoutCommandForm">

</form>

<!-- 전출 즉시수납 처리시 관리자 비밀번호 인증 모달 -->
<div class="modal fade" id="moveoutAuthModal" tabindex="-1" aria-labelledby="moveoutAuthModalLabel" aria-hidden="true"  style=”z-index:1050;”>
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="moveoutAuthModalLabel">관리자 인증</h3>
			</div>
			<form action="" method="post">
				<input type="hidden" name="" required/>
				<input type="hidden" name="" required/>
				<div class="modal-body">
					<table class="table table-bordered">
						<tr>
							<th>비밀번호</th>
							<td><input type="password"/></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">등록</button>
					<button type="reset" class="btn btn-warning" data-bs-dismiss="modal">초기화</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="${cPath }/js/office/resident/moveoutForm.js"></script>

