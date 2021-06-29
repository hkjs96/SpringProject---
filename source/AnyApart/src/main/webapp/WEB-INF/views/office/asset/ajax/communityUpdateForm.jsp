<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<form:form commandName="community" id="communityUpdateForm" method="post" action="${cPath }/office/community/communityUpdateForm.do">
	<form:hidden path="cmntNo"/>
	<form:hidden path="aptCode"/>
<h4 style="margin-top: 20px;">
	<strong>커뮤니티시설수정</strong>
</h4>
<br>
<div id="toggleDiv" class="card text-center col-auto" style="width: 600px; margin: auto;">
	<div class="card-body row">
		<div class="col-sm-12">
			<table class="table">
				<tbody class="thead-light">
						<tr>
							<th class="text-left" scope="col">시설명</th>
							<td class="text-left">
								<form:input path="cmntName" cssClass="form-control" maxlength="15"/>
								<form:errors path="cmntName" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="text-left" scope="col">분류코드</th>
							<td class="text-left">
								<form:select path="cmntCode" cssclass="custom-select col-md-4">
									<option value>선택하세요</option>
								</form:select>
								<form:errors path="cmntCode" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="text-left" scope="col">규모</th>
							<td class="text-left">
								<form:input path="cmntSize" maxlength="4" placeholder="0000"/>
								<form:errors path="cmntSize" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="text-left" scope="col">수용인원</th>
							<td class="text-left">
								<form:input path="cmntCapa" maxlength="4" placeholder="0000"/>
								<form:errors path="cmntCapa" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="text-left" scope="col">예약제한인원</th>
							<td class="text-left">
								<form:input path="cmntLimit" maxlength="4" placeholder="0000"/>
								<form:errors path="cmntLimit" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="text-left" scope="col">여는시간</th>
							<td class="text-left">
								<form:input path="cmntOpen" maxlength="4" placeholder="0900"/>
								<form:errors path="cmntOpen" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="text-left" scope="col">닫는시간</th>
							<td class="text-left">
								<form:input path="cmntClose" maxlength="4" placeholder="1700"/>
								<form:errors path="cmntClose" element="span" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="text-left" scope="col">시설설명</th>
							<td class="text-left" colspan="3">
								<form:textarea path="cmntDesc" cssClass="form-control"/>
								<form:errors path="cmntDesc" element="span" cssClass="error" />
							</td>
						</tr>
				</tbody>
			</table>
		</div>
		<div  >
			<input id="updateSubmitBtn" type="submit" class="btn btn-primary" role="alert" value="저장" style="margin-left: 400px;">
			<button type="button" class="btn btn-dark" data-dismiss="modal" style="margin-right: auto;">닫기</button>
		</div>
	</div>
<!-- 	<div align="right" class="col-md-1"> -->
</div>
</form:form>
<script>
openTimeInput = $("#communityUpdateForm").find("[name=cmntOpen]");
closeTimeInput = $("#communityUpdateForm").find("[name=cmntClose]");
openTimeInput.val(openTimeInput.val().substr(0,2)+openTimeInput.val().substr(3,5));
closeTimeInput.val(closeTimeInput.val().substr(0,2)+closeTimeInput.val().substr(3,5));

// $("#updateSubmitBtn").on("click", function(){
// 	openTimeInput.val(openTimeInput.val().substr(0,2)+openTimeInput.val().substr(3,5));
// 	closeTimeInput.val(closeTimeInput.val().substr(0,2)+closeTimeInput.val().substr(3,5));
// 	$("#communityUpdateForm").submit();
// });

optTag2 = $(":input[name=cmntCode]");
$.ajax({
	url : "${cPath }/community/getOption.do",
	method : "get",
	dataType : "json",
	success : function(resp) {
		let opts = [];
		// 옵션을 동적으로 구성
		$(resp.option).each(function(idx, opt){
			opts.push(
				// type을 그대로 유지하기 위해서 prop 를 사용
				$("<option>").text(opt.codeName)
							 .attr("value", opt.codeId)
							 .prop("selected", "${community.cmntCode}"==opt.codeId || "${community.cmntCode}"==opt.codeName)
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		optTag2.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});
</script>