<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 1.      박지수      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="${pageContext.request.contextPath }/js/startbootstrap-sb-admin-gh-pages/dist/css/styles.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${cPath }/js/noty-3.1.4/noty.css">

<script type="text/javascript" src="${cPath }/js/noty-3.1.4/noty.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/asyncForm.js"></script>

<title>아이디 찾기</title>


<body class="bg-warning">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header text-center">
                                    	<img alt="" src="${pageContext.request.contextPath }/js/main/img/common/logo.png"></a>
		    							<br><h5 class="text-center font-weight-light my-4">함께 사는 즐거움, 애니아파트</h5>
                                    	<h3 class="text-center font-weight-light my-4">아이디 찾기</h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="small mb-3 text-muted">** 본인확인 이메일과 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</div>
                                        <form id="fm">
                                            <div class="form-group">
                                                <label class="small mb-1" for="memName">이름</label>
                                                <input class="form-control py-4" id="memName" type="text" name="memName" required aria-describedby="emailHelp" placeholder="이름" />
                                                <label class="small mb-1" for="memEmail">이메일</label>
                                                <input class="form-control py-4" id="memEmail" name="memEmail" type="email" aria-describedby="emailHelp" placeholder="이메일" />
                                            </div>
                                            <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
                                                <a class="btn btn-warning" id="numBtn">인증번호 받기</a>
                                            </div>
                                        </form>
                                    </div>
                                    <div id="showId">
	
									</div>
                                    <div class="card-footer text-center">
                                        <div class="small">
<!--                                         	<a href="register.html"> -->
                                        	애니 아파트 
<!--                                         	</a> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutAuthentication_footer">
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Any Apart 2021</div>
<!--                             <div> -->
<!--                                 <a href="#">Privacy Policy</a> -->
<!--                                 &middot; -->
<!--                                 <a href="#">Terms &amp; Conditions</a> -->
<!--                             </div> -->
                        </div>
                    </div>
                </footer>
            </div>
        </div>
</body>

<script>
	let fm = $("#fm");
	let data;
	let numChkBtn = $("#numChkBtn"); 
	let certNum = $("#certNum");
	let showId = $("#showId");
	
	numChkBtn.attr("disabled", true);
	certNum.attr("disabled", true);
	
	
	$("#numBtn").on("click", function(){
		data = fm.serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/login/findId/checkMember"
			, data : data
			, method : "post"
			, success : function(data){
				alert(data.message);
			}
			, errors : function(xhr){
				alert(xhr.message);
// 				console.log(xhr);
			}
		});
		numChkBtn.removeAttr("disabled");
		certNum.removeAttr("disabled");
	});
	
	numChkBtn.on("click", function(){
// 		fm.method="post"
// 		fm.action="${pageContext.request.contextPath}/login/findId/checkCert"
// 		fm.serialize();
// 		fm.submit();
		
		data = fm.serialize();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/login/findId/checkCert"
			, data : data
			, method : "post"
			, success : function(data){
				let memId = data.member.memId;
				showId.html(memId);
			}
			, errors : function(xhr){
				console.log(xhr);
				alert("인증번호가 틀렸습니다.");
			}
		});
	});
	
</script>

<!-- 박지수: noty 띄우기 위한 코드 -->
<c:if test="${not empty message }">
	<script type="text/javascript">
		new Noty({
			 text:'${message.text }', 
			 layout: '${message.layout }',
			 type: '${message.type }',
			 timeout: ${message.timeout },
			 progressBar: true
		}).show();
	</script>
</c:if>
<!-- 박지수: noty 코드 끝 -->