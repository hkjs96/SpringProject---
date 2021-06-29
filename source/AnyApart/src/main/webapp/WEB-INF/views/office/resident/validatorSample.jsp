<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 6.      작성자명      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <!-- sign up UI -->
         <div class="container container-signup container-transparent animated fadeIn">
                  <form:form modelAttribute="member" id="signUpForm" action="${pageContext.request.contextPath }/signup/signUp.do">
         <div class="container container-signup container-transparent animated fadeIn">
            <h3 class="text-center">회원가입</h3>
            <div class="login-form">
               <div class="form-group">
                  <label for="id" class="placeholder"><b>아이디</b></label>
                  <input id="fullname" name="memId" type="text" class="form-control input-border-bottom" 
                     pattern="^[a-zA-Z0-9]{5,15}$" required>
                  <form:errors path="memId" element="span" cssClass="error" />
               </div>
               <div class="form-group">
                  <label for="password" class="placeholder"><b>비밀번호</b></label>
                  <input id="passwordsignin" name="memPass" type="password" pattern="^([^가-힣]).{5,12}$"
                     class="form-control input-border-bottom" required>
                  <div class="show-password">
                        <i class="icon-eye"></i>
                  </div>
                  <form:errors path="memPass" element="span" cssClass="error" />
               </div>
               <div class="form-group">
                  <label for="name" class="placeholder"><b>이름</b></label>
                  <input id="inputName" name="memName" type="text"
                     class="form-control input-border-bottom" pattern="^([가-힣A-Za-z]){2,20}$" required> 
                  <form:errors path="memName" element="span" cssClass="error" />
               </div>
               <div class="form-group">
                  <label for="email" class="placeholder"><b>이메일</b></label>
                  <input id="memMail" name="memMail" type="email"   class="form-control input-border-bottom"
                     pattern="^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$" required>
                  <form:errors path="memMail" element="span" cssClass="error" />
               </div>
               <div class="form-group">
                  <label for="tel" class="placeholder"><b>휴대폰</b></label>
                  <input id="memTel" name="memHp" type="text"   class="form-control input-border-bottom"
                     pattern="^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$" required>
                  <form:errors path="memHp" element="span" cssClass="error" />
               </div>
<!--                <div class="row form-sub m-0"> -->
<!--                   <div class="custom-control custom-checkbox"> -->
<!--                      <input type="checkbox" class="custom-control-input" name="agree" id="agree"> -->
<!--                      <label class="custom-control-label" for="agree">I Agree the terms and conditions.</label> -->
<!--                   </div> -->
<!--                </div> -->
               <div class="row form-action">
                  <a href="#" id="show-signin" class="btn btn-danger mr-3">Cancel</a>
                  <input type="submit" class="btn btn-success ml-5" id="submitBtn" value="회원가입" />
               </div>
            </div>
         </div>
      </form:form>
         </div>
      </div>
   </div>
   
   <!-- jQuery -->
   <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.5.1.min.js"></script>
   <script src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
   
   <!-- jquery-validation-1.19.2 -->
   <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-validation-1.19.2/jquery.validate.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-validation-1.19.2/additional-methods.min.js"></script>
   
   <!-- 템플릿에 있던 기본 플러그인 -->
   <script src="${pageContext.request.contextPath }/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
   <script src="${pageContext.request.contextPath }/assets/js/core/popper.min.js"></script>
   <script src="${pageContext.request.contextPath }/assets/js/core/bootstrap.min.js"></script>
   <script src="${pageContext.request.contextPath }/assets/js/atlantis.min.js"></script>
   
   <!-- Nofity.js -->
   <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath }/js/module/notifyMessage.js"></script>
</body>
<script type="text/javascript">
   // 로그인 클릭 이벤트
   $("#loginBtn").on("click", function(){
      $("#loginForm").submit();
   });
   
   // 로그아웃 클릭 이벤트
   $("#logoutBtn").on("click", function() {
      window.location.href = "${pageContext.request.contextPath }/login/logout.do";
   })
   
   // bpms 페이지 이동
   $("#bpmsBtn").on("click", function() {
      window.location.href = "${pageContext.request.contextPath }";
   });
   
   $(function(){
      const validateOptions = {
            onsubmit:true
            ,onfocusout:function(element, event){
               return this.element(element);
            }
            ,errorPlacement: function(error, element) {
               error.appendTo( $(element).parents("div:first") );
              }
            
      }
      
      validateOptions.rules={
         memId : {
            remote : '${pageContext.request.contextPath}/signUp/idCheck.do'
         }
      }
      validateOptions.messages={
         memId : {
            required : 'ID는 필수입력 사항입니다. 숫자, 영문자를 이용하여 5~15글자 이내로 입력해야 합니다.'
            ,remote : '이미 존재하는 아이디입니다.'
         },
         
         memPass : {
            required : '비밀번호는 필수입력 사항입니다. 특수문자를 포함한 영어만 입력할 수 있으며 5~12글자 이내로 입력해야 합니다.'
         },
         
         memName : {
            required : '이름은 필수입력 사항입니다. 특수문자를 제외한 한글과 영어 모두 입력할 수 있으며 2~20글자 이내로 입력해야 합니다.'            
         },
         
         memMail : {
            required : '이메일은 필수입력 사항입니다. abc@defg.hij 형식으로 입력해야 합니다.'
         },
         
         memHp : {
            required : '휴대폰 번호는 필수입력 사항입니다. 01X-XXX(X)-XXXX 형식으로 입력해야 합니다.'
         }
         
      }
      
      let validator = $("#signUpForm").validate(validateOptions);
   });
</script>