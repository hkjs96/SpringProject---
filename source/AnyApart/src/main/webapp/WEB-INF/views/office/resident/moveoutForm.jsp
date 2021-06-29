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
	<h2>
		<strong>전출등록</strong>
	</h2>
	<br>
	<table class="table table-bordered">
		<colgroup>
			<col width="20%"/>
			<col width="30%"/>
			<col width="20%"/>
			<col width="30%"/>
		</colgroup>
		<thead>
			<tr>
				<td class="table-secondary text-center" colspan="4">
					전출세대를 입력 후 조회해 주세요.
				</td>
			</tr>
			<tr>
				<th class="text-center table-dark">전출 세대</th>
				<td colspan="3">
					<form id="searchForm" action="${cPath }/office/resident/moveoutFormAjax.do" method="get" class="form-inline">
						<input type="hidden" name="searchVO.searchAptCode">
						<input type="hidden" name="currentPage" value="1">
						<input type="hidden" name="houseCode"/>
						<input type="text" name="dong" id="dong" required onkeypress="return onlyNumber(event)" maxlength="4">&nbsp;동&nbsp;
						<input type="text" name="ho"  id="ho" required onkeypress="return onlyNumber(event)" maxlength="4">&nbsp;호&nbsp;
						<button type="submit" class="btn btn-dark" id="searchBtn">조회</button>&nbsp;
						<button type="button" class="btn btn-secondary" id="resetBtn">초기화</button>
					</form>
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th class="text-center table-dark">전출일</th>
				<td class="text-center" colspan="3">
					<form id="moveoutForm" action="${cPath }/office/resident/moveoutInsert.do" method="post">
						<input type="hidden" name="flag" id="flag">
						<input type="hidden" name="aptCode" value="${param['searchVO.searchAptCode'] }">
						<input type="hidden" name="dongStart" value="${param.dongStart }">
						<input type="hidden" name="hoStart" value="${param.hoStart }">
						<input type="hidden" name="dongEnd" value="${param.dongEnd }">
						<input type="hidden" name="hoEnd" value="${param.hoEnd }">
						<input type="hidden" name="resMoveoutStart" value="${param.resMoveoutStart }">
						<input type="hidden" name="resMoveoutEnd" value="${param.resMoveoutEnd }">
						<input type="hidden" name="sortType" value="${param.sortType }">
						<input type="hidden" name="resName" value="${param.resName }">
						<input type="hidden" name="screenSize" value="${not empty param.screenSize ? param.screenSize : 10  }">
						<input type="hidden" name="currentPage" value="${not empty param.currentPage ? param.currentPage : 1  }">
						<input type="hidden" name="memId">
						<input type="hidden" name="houseCode">
						<input type="date" name="resMoveout" required>
				</td>
			</tr>
			<tr>
				<th class="text-center table-dark">입주민코드</th>
				<td class="text-center"><span id="memId"></span></td>
				<th class="text-center table-dark">세대주명</th>
				<td class="text-center"><span id="resName"></span></td>
			</tr>
			<tr>
				<th class="text-center table-dark">연락처</th>
				<td class="text-center"><span id="resHp"></span></td>
				<th class="text-center table-dark">비상연락처</th>
				<td class="text-center"><span id="resTel"></span></td>
			</tr>
			<tr>
				<th class="text-center table-dark">등록된 차량</th>
				<td class="text-center" colspan="3">
					<span class="reddot">* </span><span>전출 등록 즉시 차량 등록이 해지됩니다. </span>
					<br/>
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
							<!-- 세대조회후 비동기로 조회 -->
							<tr>
								<td colspan="3" class="text-center">전출하고자하는 세대를 조회해 주세요.</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<th class="text-center table-dark">당월 관리비</th>
				<td class="text-center" colspan="3">
					<span class="reddot">* </span><span>1일~전출일까지의 검침량에 따른 관리비는 고지 후 별도로 안내됩니다.</span>
				</td>
			</tr>
			<tr>
				<th class="text-center table-dark">관리비 미납 내역</th>
				<td class="text-center" colspan="3">
					<span class="reddot">* </span><span>관리비 미납 내역 존재시 전출 처리가 불가합니다. </span>
					<br/>
					<span class="reddot">* </span><span>즉시 수납 후 전출 처리시 수납버튼을 누른 후 관리자 비밀번호를 입력해 주세요. </span>
					<br/>
					<br/>
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
							<!-- 세대조회후 비동기로 조회 -->
							<tr>
								<td colspan="8" class="text-center">전출하고자하는 세대를 조회해 주세요.</td>
							</tr>
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
					<input type="submit" class="btn btn-primary" value="저장">
					<input type="button" class="btn btn-dark" value="목록" id="listBtn">
					</form>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<form id="moveoutListForm" action="${cPath }/office/resident/moveoutList.do" method="get">

</form>

<!-- 전출 즉시수납 처리시 관리자 비밀번호 인증 모달 -->
<div class="modal fade" id="moveoutPayAuthModal" tabindex="-1" aria-labelledby="moveoutPayAuthModalLabel" aria-hidden="true"  style=”z-index:1050;”>
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="moveoutPayAuthModalLabel"><strong>관리자 인증</strong></h4>
			</div>
			<form id="moveoutPayAuthForm" action="${cPath }/office/resident/moveoutPayCost.do" method="post">
				<input type="hidden" name="memId" required/>
				<input type="hidden" name="costNo" required/>
				<input type="hidden" name="costTotal" required/>
				<input type="hidden" name="lateFee" required/>
				<div class="modal-body">
					<table class="table table-bordered">
						<tr>
							<th class="table-secondary text-center" colspan="2">즉시 수납처리를 위해<br>비밀번호를 입력해 주세요.</th>
						</tr>
						<tr>
							<th class="text-center table-light" style="width:25%">비밀번호</th>
							<td><input class="form-control" type="password" name="memPass" required/></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">저장</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="${cPath }/js/office/resident/moveoutForm.js"></script>
