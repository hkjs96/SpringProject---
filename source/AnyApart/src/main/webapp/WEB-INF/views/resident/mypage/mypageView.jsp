<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<table class="table table-bordered">
	<tbody>
		<tr>
			<th>사용자 코드</th>
			<td>${member.memId }</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${member.memNick }</td>
		</tr>
		<tr>
			<th>세대주명</th>
			<td>${resident.resName }</td>
		</tr>
		<tr>
			<th>핸드폰 번호</th>
			<td class="telNum">${resident.resHp }</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td class="telNum">${resident.resTel }</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${resident.resMail }</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>${resident.resBirth }</td>
		</tr>
		<tr>
			<th>직업</th>
			<td>${resident.resJob }</td>
		</tr>
	</tbody>	
</table>
<!-- 비밀번호 변경 모달 버튼 -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#passUpdateModal">
  비밀번호 변경
</button>

<!-- 비밀번호 변경 Modal -->
<div class="modal fade" id="passUpdateModal" data-backdrop="static" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="passUpdateModalLabel" data-keyboard="false" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="passUpdateModalLabel">비밀번호 변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="fm" method="post" action="${cPath }/resident/mypage/passUpdate.do">
		 	<security:authentication property="principal" var="principal" />
	        <c:set var="authMember" value="${principal.realMember }" />
        	<input type="hidden" name="memId" value="${authMember.memId }"/>
		  <div class="row mb-4 mt-5 ml-4">
			    <label for="currentPass" class="col-sm-6 col-form-label text-right">현재 비밀번호</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="currentPass" name="currentPass">
			    </div>
		  </div>
		  <div class="row mb-4 ml-4 text-left">
		  	<span style="color: blue; padding-left:10px;">**비밀번호 변경시 영문자, 숫자, 특수문자 포함해 8~12 까지 가능합니다.</span>
		  	<br>
		  	<span style="color: red; padding-left:10px;">**변경 성공시에는 로그아웃 처리됩니다.</span>
			    <label for="memPass" class="col-sm-6 col-form-label text-right ">새 비밀번호</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="memPass" name="memPass">
			    </div>
		  </div>
		  <div class="row mb-4 ml-4">
			    <label for="checkPass" class="col-sm-6 col-form-label text-right ">비밀번호 확인</label>
			    <div class="col-sm-6">
			      <input type="password" class="form-control" id="checkPass" name="checkPass">
			    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button  id="submitBtn" type="button" class="btn btn-primary">변경</button>
      </div>
    </div>
  </div>
</div>

<script>
	let telNum = $(".telNum");
	telNum.each(function(){
		let tdText = $(this).text();
		tdText = formatTel(tdText);
		$(this).text(tdText);
	});
	
	let checkPass;
	let updatePass;
	let fm = $("#fm");
	 
	$("#submitBtn").on("click", function(){
		checkPass = $("#checkPass");
		updatePass = $("#memPass");
		
		if(checkPass.val() != updatePass.val()) {
		     alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
		     checkPass.focus();
		     return false;
		}else{
			fm.serialize();
			fm.method = "post";
			fm.submit();
		}
	});
</script>