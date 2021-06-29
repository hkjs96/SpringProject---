<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 6.      박지수      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/asyncForm.js"></script>

<title>패스워드 변경</title>
<div>
	변경할 패스워드 입력하세요, 8~12 글자
</div>
<form id="fm" method="post"> 
	<input type="hidden" name="memId" value="${memId }" />
	비밀번호<input type="text" id="memPass" name="memPass" required maxlength="12" pattern="^(?=.*[0-9]+)(?=.*[a-z]+)(?=.*[A-Z]+).{5,12}$" />
	<br>
	비밀번호 확인<input type="text" id="passCh" required maxlength="12" pattern="^(?=.*[0-9]+)(?=.*[a-z]+)(?=.*[A-Z]+).{5,12}$" />
	<input type="button" id="btn" value="변경" />
</form>
<script>
	let memPass = $("#memPass");
	let passCh = $("#passCh");
	let fm = $("#fm");
	let data
	
	$("#btn").on("click", function(){
		if(memPass.val().length > 0 && passCh.val().length > 0 && memPass.val()==passCh.val()){
			data = fm.serialize();
			$.ajax({
				url : "${pageContext.request.contextPath }/login/modifyPass"
				, data : data
				, method : "post"
				, success:function(data){
					alert("비밀번호가 변경되었습니다.");
				}
				, errors:function(xhr){
					console.log(xhr);
				}
			});
// 			fm.method = "post";
// 			fm.action = "${pageContext.request.contextPath }/login/modifyPass"
// 			fm.submit();
		}else{
			alert("일치하지 않습니다.");
		}
	});
</script>