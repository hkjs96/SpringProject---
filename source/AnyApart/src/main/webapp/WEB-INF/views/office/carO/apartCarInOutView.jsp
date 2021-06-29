<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<style>
.widget-numbers {
    font-weight: bold;
    font-size: 2.5rem;
    display: block;
    line-height: 1;
    margin: 1rem auto;
    z-index: 3;
    background: #e9ecef;
    text-align: center;
}
.widget-subheading{
	text-align: center;
	background-color: #e9ecef;
}
.row {
  float: left;
  width: 48%;
  padding: 15px;
}
.selectDiv{
  float: left;
  width: 25%;
  padding: 15px;
}
.section{
	width: 100%;
}
.chart{
    margin-bottom: 2%;
}
.spanFont {
  display: block;
  color: red;
  font-size: 3em;
  text-align: center;
}

.spanFont:not(.light) {
  animation: flashText .5s ease-out alternate infinite;
}

.spanFont.light {
  position: relative;
  display: inline-block;
  
  &:before {
    position: absolute;
    left: 0;
    top: -10%;
    width: 100%;
    height: 120%;
    filter: blur(10px);
    content: "";
    opacity: 0;
    animation: flash .5s ease-out alternate infinite;
  }
}

@keyframes flash{
  to {
    opacity: 1;
  }
}

@keyframes flashText {
  to {
    opacity: 0.15;
  }
}
.totalNum{
    display: contents;
}


#searchForm{
	width: 100%;
}
</style>  

<div id="top"> 
<br>
	<h2><strong>입출차 현황</strong></h2>
</div>
<div class="row">
	<section class= "section">
	 <div class="chart">
	 <div class="widget-chart-content" >
                  <div class="widget-subheading">바리게이트 상태 </div>
        	<h2 id="h2live">
			  <span class="spanFont"style="color: blue;">대기상태</span>
			</h2>
              </div>
	 </div>
	 <div class="chart">
	 <div class="widget-chart-content" >
                  <div class="widget-subheading">통신 상태</div>
        	<h2 id="serverDiv">
			  <span class='spanFont' style='color:#1aef00;font-size: 30px;'>양호</span>
			</h2>
     </div>
	 <div class="widget-chart-content" >
                  <div class="widget-subheading">컨트롤러</div>
		<div style="text-align: center;">
		         <button type="button" onclick="openSocket();" class="btn btn-dark">서버 ON</button>
		        <button type="button" onclick="closeSocket();"class="btn btn-danger">서버 OFF</button>
        	</div>
     </div>
	 </div>
	 <div class="chart">
	 <div class="widget-chart-content" >
                  <div class="widget-subheading">입차한 차량 수</div>
                 <div class="widget-numbers" ><span id="totalNum" style="text-align: center;">-</span>대</div>
              </div>
	 </div>    
	 <div class="chart">
	 <div class="widget-chart-content" >
                  <div class="widget-subheading">입차한 차량 번호</div>
                 <div class="widget-numbers" ><span id="carNumber" style="text-align: center;">-</span></div>
              </div>
	 </div>  
	 
	 <div class="chart">
	 <div class="widget-subheading">테스트 영상</div>
	 	<video width="100%" height="50%" src="${cPath }/images/recode/sample.mp4" controls autoplay muted loop></video>
	 </div>      
	</section>
 </div>
<div class="row">
	<select class="custom-select" name="listUI" style="text-align: center;">
		<option value="Dday">D-day</option>
		<option value="search">날짜별 검색</option>
	</select>
	
	<div id="searchForm" >
	<form id="serachForm">
	<div class="selectDiv">
		<input type="number" name="year" placeholder="년도입력" style="text-align: center;" maxlength="4">
	</div>
	<div class="selectDiv">
		<input type="number" name="month" placeholder="월 입력" style="text-align: center;"maxlength="2">
	</div>
	<div class="selectDiv">	
		<input type="number" name="day" placeholder="일 입력" style="text-align: center;" maxlength="2">
	</div>
	<div class="slectDiv" style="float: right; margin-top: 1%;">	
		<input type="button" value="검색" class="btn btn-dark" id="searchAjax">
		<input type="reset" value="초기화" class="btn btn-secondary">
	</div>
	</form>
	</div>
	<table class="table table-hover" id="residentTable">
		<thead class="thead-light">
			<tr class="text-center">
				<th>상태 </th>
				<th>입/출차시간</th>
				<th>동  / 호</th>
				<th>차량 번호</th>
				<th>차량 명</th>
				<th>차량 크기</th>
				<th>용무 코드</th>
			</tr>
		</thead>
	</table>
	
<div class="table-responsive" style="width: 100%; height: 600px; overflow: auto" id="listDiv">
	<table class="table table-hover" id="residentTable">
		<tbody id="listBody">
		</tbody>
	</table>
	</div>
</div>


 	<div>
        <input type="text" id="sender" value="${sessionScope.member.m_id }" style="display: none;">
        <input type="hidden" id="messageinput">
    </div>
    <!-- Server responses get written here -->
<div id="messages"></div>

<script type="text/javascript">
		carCountNewCarNumber();
		openSocket();
        var ws;
        var messages=document.getElementById("messages");
        function carCountNewCarNumber(){
        	$.ajax({
        		url:"${cPath}/office/carO/carNewCount.do"
        		,method: "get"
        		,dataType:"json"
        		,success: function(res){
        		console.log(res);
        		let carCount =res.carCount;
        		let newCarNumber= res.newCarNumber;
        		$("#totalNum").text(carCount);
        		$("#carNumber").text(newCarNumber);
        		}
        		,error:function(xhr){
        			}
        		});
        }
        
        function openSocket(){
            if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
                $("#serverDiv").html("<span class='spanFont' style='color:#1aef00;font-size: 30px;'>양호</span> ")
                return;
            }
            //웹소켓 객체 만드는 코드
            ws=new WebSocket("ws://localhost/AnyApart/Eco.do");
            
            ws.onopen=function(event){
                if(event.data===undefined) return;
            };
            ws.onmessage=function(event){
            	if(event.data=="InNotCar"){
            		$("#carNumber").text("미등록 차량 접근 시도");	
            		$("#h2live").html("<span class='spanFont' style='color: red; font-size: 1em;'>관리사무소 방문 요망</span> ")
            		carCountNewCarNumber();
            	}else{
                $("#carNumber").text(event.data);
                $("#h2live").html("<span class='spanFont' style='color: red;'>입차중</span> ")
                carCountNewCarNumber();
            	}
                
                carIOList('Dday');
                setTimeout(timeOut,ms); 
            };
            ws.onclose=function(event){
                $("#serverDiv").html("<span class='spanFont' style='color:red;font-size: 30px;'>중단</span> ")
            }
        }
        
        function send(){
            var text=document.getElementById("messageinput").value+","+document.getElementById("sender").value;
            ws.send(text);
            text="";
        }
        
        function closeSocket(){
            ws.close();
        }
        function writeResponse(text){
            messages.innerHTML+="<br/>"+text;
        }
        
        var timeOut = function(){
        	$("#h2live").html("<span class='spanFont' style='color: blue;'>대기중</span> ")
        }
        var ms = 2000;
  </script>

<script>
$("#h2live").on("click",function(){
	$("#h2live").html("<span class='spanFont' style='color: red;'>관리사무소 방문 요망</span> ")
})

var selectVal =$("select[name='listUI']").val();
//초기값 
selectEvent(selectVal);
$("select[name='listUI']").change(function(){
	selectVal = $("select[name='listUI']").val();
	selectEvent(selectVal);
})

function selectEvent(date){
	if(date == 'Dday'){
		$("#searchForm").hide();
		carIOList(date);
	}else if(date == 'search'){
		$("#searchForm").show();
		$("#searchForm").html();
		carIOList(date);
	}else{
		alert("잘못된 설정입니다.")
	}
}

function carIOList(type){
	let typeItem = "";
	if(type=='Dday'){
		typeItem ="DDAY"
			$.ajax({
				url:"${cPath}/office/carO/carInOutListTable.do"
				,method: "get"
				,dataType:"json"
				,success: function(res){
					var carIOList = res.carIOList;
					var listBody = $("#listBody");
					let trTags=[];
					console.log(carIOList);
					if(carIOList.length == 0){
						listBody.html("<td colspan='7' style='text-align: center;''> 입차 내역이 없습니다.</td>");
					}else{
						var IOCode = "오류";
						$(carIOList).each(function(idx,carIO){
							IOCode= carIO.carIochk;
							if(IOCode=="I"){
								IOCode="<td style='color: red;'>입차</td>";
							}else if(IOCode=="O"){
								IOCode= "<td style='color: blue;'>출차</td>";
							}
							let tr = $("<tr>");
							tr.append(
								$(IOCode),		
								$("<td>").text(carIO.carIoHh+":"+carIO.carIoMi),		
								$("<td>").text(carIO.dong+"동"+carIO.ho+"호"),		
								$("<td>").text(carIO.carNo),		
								$("<td>").text(carIO.carType),
								$("<td>").text(carIO.carSize),		
								$("<td>").text(carIO.carCodeNAME)		
							),
							trTags.push(tr);
							});
						listBody.html(trTags);
					}
					
				},error:function(xhr){
					
				}
			});
	}else if(type=="search"){
		$("#searchAjax").on("click",function(){
			$.ajax({
				url:"${cPath}/office/carO/carInOutListTable.do"
				,method: "post"
				,data: $("#serachForm").serialize()
				,dataType:"json"
				,success: function(res){
					var carIOList = res.carIOList;
					var listBody = $("#listBody");
					let trTags=[];
					console.log(carIOList);
					if(carIOList.length == 0){
						listBody.html("<td colspan='7' style='text-align: center;''> 입차 내역이 없습니다.</td>");
					}else{
						var IOCode = "오류";
						$(carIOList).each(function(idx,carIO){
							IOCode= carIO.carIochk;
							if(IOCode=="I"){
								IOCode="<td style='color: red;'>입차</td>";
							}else if(IOCode=="O"){
								IOCode= "<td style='color: blue;'>출차</td>";
							}
							let tr = $("<tr>");
							tr.append(
								$(IOCode),		
								$("<td>").text(carIO.carIoHh+":"+carIO.carIoMi),		
								$("<td>").text(carIO.dong+"동"+carIO.ho+"호"),		
								$("<td>").text(carIO.carNo),		
								$("<td>").text(carIO.carType),
								$("<td>").text(carIO.carSize),		
								$("<td>").text(carIO.carCodeNAME)		
							),
							trTags.push(tr);
							});
						listBody.html(trTags);
					}
				},error:function(xhr){
					
				}
			});
		})
	}
}
</script>