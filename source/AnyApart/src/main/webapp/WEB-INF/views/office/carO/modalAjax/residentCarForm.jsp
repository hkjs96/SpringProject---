<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<style>
th {
    background-color: lightgray;
    text-align: center;
}

</style>
<div class="card text-center col-auto">
<div class="card-body row">
	<div class="col-sm-12">
		<table class="table">
			<tr>
				<th colspan="9">입주민 / 방문차량 등록 </th>
			</tr>
			<tr>
				<td colspan="9">
				동<input type ="text" value = "" id="dong">
				호<input type ="text" value = "" id="ho">
				<input type="button" class="btn btn-dark" value="조회" id="searchBtn">
				</td>
			</tr>
			<tr>
				<th>회원 아이디</th>		
				<th>회원 이름</th>		
				<th>회원 전화번호</th>		
				<th>동</th>		
				<th>호</th>		
				<th>등록 완료된 소유 차량 수 </th>		
				<th colspan="3">비고 </th>		
			</tr>
			<tr id="userInfo">
				<td><input type="text" disabled="disabled"></td>
				<td><input type="text" disabled="disabled"></td>
				<td><input type="text" disabled="disabled"></td>
				<td><input type="text" disabled="disabled"></td>
				<td><input type="text" disabled="disabled"></td>
				<td><input type="text" disabled="disabled"></td>
			</tr>
			<tr>
				<th colspan="9">보유 차량 리스트</th>
			</tr>
			<tbody id="carlist">
			</tbody>
			<tr>
			</tr>
			</table>
			<form id="carAddForm">
				<table class="table">
				<tr>
					<th colspan="9">차량 등록</th>
				</tr>
				<tr>
					<th>차량번호</th>
					<td><input type="text" name="carNo"></td>
					<th>차량명</th>
					<td><input type="text" name="carType"></td>
					<th>차량 크기</th>
					<td><select name="carSize" required="required" class="custom-select">
						<option selected="selected" disabled="disabled">==선택==</option>
					<c:forEach items="${carCodeList}" var="carSize">
						<option value="${carSize.codeId }">${carSize.codeName }</option>
					</c:forEach>
				</select></td>
				<th>등록사유</th>
				<td><select name="carCode">
				 <option>==선택==</option>
				 <option value="CR">입주민 차량 등록</option>
				 <option value="CV">방문차량 등록 </option>
				</select></td>
				</tr>
			</table>
			<input type ="hidden" name="memId" value="" id="userIdI">
		</form>
		</div>
	</div>
</div>
<script>
$("#addBtn").on("click",function(){
	var is_empty = false;

    if(!$("#userIdI").val()) {
        is_empty = true;
    }else{
    	is_empty = false;
    }
	if(is_empty) {
		new Noty({
			 text: "입주민 회원 조회를 먼저 해야합니다.", 
			 layout: "topCenter" ,
			 type: "error" ,
			 timeout: 3000,
			 progressBar: true
		}).show();
		
	}else{
		$.ajax({
			url:"${cPath}/office/carO/residentCarAdd.do"
			,method: "post"
			,data:$("#carAddForm").serialize()
			,dataType:"json"
			,success: function(res){
				let message = res.message;
				if(res.message != null){
					new Noty({
						 text: message.text, 
						 layout: message.layout ,
						 type: message.type ,
						 timeout: message.timeout,
						 progressBar: true
					}).show();
					}
				if(message.type=="success"){
					userCarSearch();
				}
			}
			,error:function(xhr){
				
			}
		})	
	}
})
$("#searchBtn").on("click",function(){
	userCarSearch();
});


function userCarSearch(){
	
var dong = $("#dong").val();
var ho = $("#ho").val();
let userInfo = $("#userInfo");
let carlist = $("#carlist");

$.ajax({
	url:"${cPath}/office/carO/residentInfo.do?dong="+dong+"&ho="+ho
	,method: "get"
	,dataType:"json"
	,success: function(res){
		let message = res.message;
		let residentInfo = res.residentInfo;
		if(res.message != null){
			console.log(res.message);
		new Noty({
			 text: message.text, 
			 layout: message.layout ,
			 type: message.type ,
			 timeout: message.timeout,
			 progressBar: true
		}).show();
		}
		if(res.residentInfo != null){
			var createCarCount = 0;
			var userIn = residentInfo.resCarCount;
			createCarCount = 5- Number(userIn);
			console.log(residentInfo);
			userInfo.html(
				"<td><input type='text' disabled='disabled' value='"+residentInfo.memId+"'></td>"+
				"<td><input type='text' disabled='disabled' value='"+residentInfo.resName+"'></td>"+
				"<td><input type='text' disabled='disabled' value='"+residentInfo.resHp+"'></td>"+
				"<td><input type='text' disabled='disabled' value='"+residentInfo.dong+"'></td>"+
				"<td><input type='text' disabled='disabled' value='"+residentInfo.ho+"'></td>"+
				"<td><input type='text' disabled='disabled' value='"+residentInfo.resCarCount+"'></td>"+
				"<td colspan='2'><input id='carAddCount' type='text' disabled='disabled' value=''></td>"
				);
			
			if(createCarCount <= 0){
				$("#carAddCount").css("color","red");
				$("#carAddCount").val("등록이 불가능함.");
				$("#addBtn").hide();
				
			}else if(createCarCount => 0){
				$("#carAddCount").css("color","blue");
				$("#carAddCount").val(createCarCount+"개 가능");
				$("#addBtn").show();
			}
			let trTags =[];
			if(residentInfo.carList!=null){
				let residentCar = residentInfo.carList;
				$(residentCar).each(function(idx,carList){
					let tr = $("<tr>");
					console.log(carList.carNo);
					tr.append(
						"<th>차량번호</td>"+
						"<td>"+carList.carNo+"</td>"+
						"<th>차량명</td>"+
						"<td>"+carList.carType+"</td>"+
						"<th>차량 크기</td>"+
						"<td>"+carList.carSizeName+"</td>"+
						"<th>등록사유</td>"+
						"<td>"+carList.carCodeName+"</td>"+
						"<td><input type='button' value='삭제' onclick ='delCar(this)' data-carno='"+carList.carNo+"'></td>"
					),
					trTags.push(tr);
				});
				carlist.html(trTags);
			}
			$("#userIdI").val(residentInfo.memId);
		}
	 }
	,error: function (res){
		
	}

});
};

function delCar(e){
	var carNo = $(e).data('carno');
	$.ajax({
		url:"${cPath}/office/carO/residentCarDel.do?carNo="+carNo
		,method: "get"
		,dataType:"json"
		,success: function(res){
			let message = res.message;
			if(res.message != null){
				console.log(res.message);
			new Noty({
				 text: message.text, 
				 layout: message.layout ,
				 type: message.type ,
				 timeout: message.timeout,
				 progressBar: true
			}).show();
			}
			if(message.type=="success"){
				userCarSearch();
			}
		}
	});
}
</script>