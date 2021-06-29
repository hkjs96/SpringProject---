<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	
	input[type=password] {font-family:'Malgun gothic', dotum, sans-serif;}

</style>
<div class="container col-sm-5 mt-3">
<br>
<h4><strong>본인확인</strong></h4>
<br>
</div>
 <form method="post">
	<div class="container col-sm-5 card-header card-footer " style='margin-bottom: 5pt;'>
		  <div class="row mb-4 ml-4">
			    <label for="department" class="col-sm-3 col-form-label text-center ">비밀번호 확인</label>
<!-- 			    <div class="col-sm-6"> -->
			    <div class="col-sm-5">
			      <input type="password" class="form-control" name="memPass" id="memPass" required maxlength="12" pattern="^(?=.*[0-9]+)(?=.*[a-z]+)(?=.*[A-Z]+).{5,12}$">
			    </div>
			   <button class="btn btn-dark">확인</button>
			   <button id="pwInject" type="button" class="btn btn-warning">시연용 확인</button>
		  </div>
	 </div>
</form>


<script>
// 시연용 확인
	let passBtn = $("#pwInject").on("click", function(){
		let memPass = $("#memPass");
		memPass.val("aA!!1234");
		let fm = $("form");
		fm.submit();
	});
</script>