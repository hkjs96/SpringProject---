<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
#insertAccountDiv input {
	border: 0.5px solid #DEE2E6;
	width: 250px;
}

#insertAccountDiv {
	width: 1300px;
	margin-left: 100px;
	margin-top: 80px;
}

#insertAccountDiv td {
	text-align: left;
}
#listDiv{
	
	width: 1500px;
}
</style>
<form:form commandName="accountVO" id="accountForm" method="post">
<div id="insertAccountDiv">
	<div class="container">
		<div class="row">
			<div class="col-md-11">
				 <h1 class="display-6 font-weight-bold">계좌 등록</h1>
			</div>
		</div>
	</div>
	<div class="card text-center col-auto">
		<div class="card-body row">
			<div class="col-sm-12">
				<table class="table">
					<tbody class="thead-dark">
						<tr>
							<th scope="col">계좌 분류</th>
							<td><select name="acctCode">
								<c:if test="${not empty accountVO.acctRecode }">
								<option value="${accountVO.acctRecode }" >${accountVO.acctCode }</option>
								</c:if>
								<c:forEach items="${codeList}" var="account">
								<option value="${account.codeId }" >${account.codeName }</option>
								</c:forEach>
							</select></td>
							<th scope="col">계좌번호</th>
							<td><input type="text" name="acctNo" value="${accountVO.acctNo }" required ></td>
							<form:errors path="acctNo" element="span" cssClass="error"/>
							
						</tr>
						<tr>
							<th scope="col">은행명</th>
							<td>
							<select name="bankCode" >
							<c:if test="${not empty accountVO.bankRecode}">
								<option value="${accountVO.bankRecode}">${accountVO.bankCode}</option>
							</c:if>
							<c:forEach items="${bankCodeList}" var="bank">
								<option value="${bank.bankCode }">${bank.bankName}</option>
							</c:forEach>							
							</select>
							</td>
							<th scope="col">예금주</th>
							<td>
							<input type="text" name="acctUser" value="${accountVO.acctUser }" required >
							
							</td>
						</tr>
						<tr>
							<th scope="col">사용목적</th>
							<td><input  name ="acctComent" type="text" placeholder="20글자 이내로 입력" value="${accountVO.acctComent }"  required></td>
							<form:errors path="acctComent" element="span" cssClass="error"/>
							<td><span class="error">${errors.acctComent }</span></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<div align="center">
			<input type="submit" class="btn btn-dark" role="alert" value="저장"
				style="display: inline; ">
</div>
</form:form>


<script type="text/javascript">

const validateOptions = {
        onsubmit:true
        ,onfocusout:function(element, event){
           return this.element(element);
        }
        ,errorPlacement: function(error, element) {
        //    error.appendTo( $(element).parents("div:first") );
			element.tooltip({
				title: error.text()
				, placement: "right"
				, trigger: "manual"
				, delay: { show: 500, hid: 100 }
			}).on("shown.bs.tooltip", function() {
				let tag = $(this);
				setTimeout(() => {
					tag.tooltip("hide");
				}, 3000)
			}).tooltip('show');
          }
 }

let validator = $("#accountForm").validate(validateOptions);

</script>



