<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 26.      박지수      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container col-sm-5 mt-3">
<br>
<h4><strong>아파트 정보 변경 </strong></h4>
<br>
</div>
<!-- <table class="table"> -->
<!-- 	<thead class="thead-dark"> -->
<!-- 		<tr> -->
<!-- 			<th scope="row">아파트코드</th> -->
<!-- 			<td></td> -->
<!-- 		</tr> -->
<!-- 	</thead> -->
<!-- </table> -->
<div class="container col-sm-5 card-header card-footer">
	 <form action="${cPath }/office/setting/ApartUpdate.do" method="post">
	 	<input type="hidden" name="_method" value="put">
		  <div class="row mb-4 mt-5 ml-4">
			    <label for="nowPass" class="col-sm-3 col-form-label ">아파트명</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="department">
			    </div>
		  </div>
		  <div class="row mb-4 ml-4">
			    <label for="department" class="col-sm-3 col-form-label ">아파트이미지</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="department">
			    </div>
		  </div>
		  <!-- 난방 정책은 공통 코드를 불러다가 select 로 보여주고 원래 선택되어있는 부분 보여주기? -->
		  <div class="row mb-4 ml-4">
			    <label for="department" class="col-sm-3 col-form-label ">난방정책</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="department">
			    </div>
		  </div>
		  <div class="row mb-4 ml-4">
			    <label for="department" class="col-sm-3 col-form-label ">관리사무소 전화번호</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="department">
			    </div>
		  </div>
		  <div class="row mb-4 ml-4">
			    <label for="department" class="col-sm-3 col-form-label ">관리소장명</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="department">
			    </div>
		  </div>
		  <div class="d-flex justify-content-end">
			   <button class="btn btn-dark" style='margin:5pt;'>정보 변경</button>
		  </div>
	</form>
 </div>

