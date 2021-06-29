<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
table{
	width: 100%;
}
th{
	width: 80px;
	text-align: center;
	background-color: #EBF4F1;
}
td{
	width: 120px;
}
p{
	font-size: 1.5em;
}

.carList {
  float: left;
  width: 33.33%;
  padding: 15px;
}
.imgDiv{
    width: 300px;
    height: 200px;
    border: solid #e6c6c6;
    text-align: center;
}
.imgDiv img{
	max-width:100%;
    max-height:180px;
}
</style>

<p>등록된 차량수 : <label id="carNum"></label>대  &nbsp;&nbsp;<input type="button" id="insertBtn" value="등록" class="btn btn-default"></p> <br>
<table class="table">
	<tbody>
  		<tr>
  			<th>세대정보</th>
  			<td id="userDongHo" style="text-align: center;"></td>
  			<th>세대주</th>
  			<td id="userName" style="text-align: center;"></td>
  		</tr>
  		<tr>
  			<th colspan="4">보유차량 리스트</th>
  		</tr>
	</tbody>
	<tfoot>
		<tr>
		</tr>
	</tfoot>
</table>

<div id="carInfoList">
</div>

<table class="table">
	<thead>
  		<tr>
  			<th colspan="5">신청 리스트</th>
  		</tr>
  		<tr>
  			<th>순번</th>
  			<th>차량번호</th>
  			<th>등록신청일</th>
  			<th>등록승인일</th>
  			<th>상태코드</th>
  		</tr>
	</thead>
	<tbody id="enrollCar" style="text-align: center;">
		
	</tbody>
	<tfoot>
		<tr>
		</tr>
	</tfoot>
</table>

 
<script type="text/javascript">
var carFoList = $("#carInfoList");
	$.ajax({
		url:"${cPath}/resident/car/residentCarList.do"
		,method: "get"
		,dataType:"json"
		,success: function(res){
			var carList = res.inPoCarList;
			var userInfo = res.userInfo;
			var carNum=0;
			var enrollList =res.enrollList;
			
			let carFo=[];
			$("#userDongHo").text(userInfo.dong+"동"+""+userInfo.ho+"호");
			$("#userName").text(userInfo.resName);
			//입주미니 차량 등록 신청 한 리스트
			let trTags = [];
			console.log(enrollList.length)
// 			if(enrollList.length == 0){
// 				$("#enrollCar").html("<td colspan='5'>신청한 차량 결과가 업습니다.</td>")
// 			}else{
				
			$(enrollList).each(function (idx,enroll){
				let approvalDate = enroll.approvalDate;
				if(approvalDate ==null){
					approvalDate = "대기중";
				}
				let tr  = $("<tr>");
				tr.append(
						$("<td>").text(idx+1),		
						$("<td>").text(enroll.carNo),		
						$("<td>").text(enroll.applyDate),		
						$("<td>").text(approvalDate),		
						$("<td>").text(enroll.enrollFlag)		
				),
				trTags.push(tr);
			})
			$("#enrollCar").html(trTags);
// 			}
			
// 			if(carList.length==0){
// 				$("#enrollCar").html("보유중인 차량이 없습니다.").css("text-align","center");
// 			}else{
				
			//입주민이 차량등록 신청 완료 되어 소유하고 있는 차량 리스트
			$(carList).each(function (idx,car){
				carNum++;
				let divForm =$("<div class='carList'>") ;
				let imgDiv ="";				
				if(car.carSize == 'LIGHT' && car.carCode =='CR'){
					imgDiv ="<img alt='경차' src='${cPath }/images/car/LIGHT.png'>";
				}else if(car.carSize == 'LARGE'&& car.carCode =='CR'){
					imgDiv ="<img alt='대형차' src='${cPath }/images/car/LARGE.png'>";
				}
				else if(car.carSize == 'MIDSIZE'&& car.carCode =='CR'){
					imgDiv ="<img alt='중형차' src='${cPath }/images/car/MIDSIZE.png' style='margin-top: 14%;'>";
				}
				else if(car.carSize == 'SEDAN'&& car.carCode =='CR'){
					imgDiv ="<img alt='준대형차' src='${cPath }/images/car/SEDAN.png'>";
				}
				else if(car.carSize == 'SEMIMEDIUM'&& car.carCode =='CR'){
					imgDiv ="<img alt='준중형차' src='${cPath }/images/car/SEMIMEDIUM.png'>";
				}
				else if(car.carSize == 'SMALL'&& car.carCode =='CR'){
					imgDiv ="<img alt='소형차' src='${cPath }/images/car/SMALL.png'>";
				}else if(car.carCode =='CV'){
					imgDiv ="<img alt='소형차' src='${cPath }/images/car/guest.png' style='margin-top: 3%;'>";
				}
				else{
					imgDiv="아직 등록되지 않았습니다."
				}
				
				divForm.append(
						$("<div class='imgDiv'>").html(imgDiv),
						$("<div>").text("차량번호 ["+car.carNo+"]"),
						$("<div>").text("차량명   ["+car.carType+"]")
				),
				carFo.push(divForm);
			});
			$("#carNum").text(carNum);
			carFoList.html(carFo)
// 			}
		
		},error :function(xhr){
			console.log("오류"+xhr)
		}
		
	});
// 	"<img alt='' src='${cPath }/images/car/LIGHT.png'>"

	$("#insertBtn").on("click", function(){
		location.href="${pageContext.request.contextPath}/resident/car/registRCar.do";
	});
</script>