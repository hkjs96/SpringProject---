<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
pre{
	padding-left: 200px;
	margin-top: 50px;
}
</style>    

<form action="${cPath}/resident/car/registRCar.do" method="post" id="carForm">
<table class="table table-bordered">
	<tbody>
		<tr>
			<th>세대정보</th>
			<td><input value="${userVO.dong}동 ${userVO.ho}호" readonly></td>
		</tr>
		<tr>
			<th>세대주</th>
			<td><input value="${userVO.resName }" readonly></td>
		</tr>
		<tr>
			<th>차종</th>
			<td><input type="text" name="carType" required value="${carVO.carType}"></td>
		</tr>
		<tr>
			<th>차량번호</th>
			<td><input type="text" name="carNo" required value="${carVO.carNo}"></td>
		</tr>
		<tr>
			<th>차량크기</th>
			<td><select name="carSize" required="required">
					<option selected="selected" disabled="disabled">==선택==</option>
				<c:forEach items="${carCode}" var="carSize">
					<option value="${carSize.codeId }">${carSize.codeName }</option>
				</c:forEach>
			</select></td>
		</tr>
	</tbody>	
</table>
<div>
<pre>
		 위와 같이 세대차량을 등록 신고하오니 주차스티커를 배부하여 주시기 바랍니다.
  다른 곳으로 이사를 가거나 차량을 타인에게 양도할 때는 관리사무소나 경비실로 반드시 말소 신청을 바랍니다.
	
	
	   	   ※ 주차시티커 미부착 차량의 불이익은 관리사무소에서 책임을 지지 않습니다.
			    주차스티커는 관리사무소에서 배부해 드립니다.
</pre>
</div>	
<br>
<br><input type="submit" value="신청">
</form>

<script>
const validateOptions = {
        onsubmit:true
        ,onfocusout:function(element, event){
           return this.element(element);
        }
        ,errorPlacement: function(error, element) {
//            error.appendTo( $(element).parents("div:first") );
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
  

let validator = $("#carForm").validate(validateOptions);
</script>