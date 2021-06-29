<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
#enegyView{
	margin-left: 80px;
}
.card-header{
	height: 30px;
	padding-top : 10px;
	background-color: #EBEFF0;
	text-align: center;
/* 	display: inline; */
}
.cardt{
	width : 900px;
	border: 2px solid #F1F3EB;
	margin-top: 30px;
	margin-bottom: 30px;
}
.carde{
	width: 440px;
	border: 2px solid #F1F3EB;
	margin-top: 30px;
	margin-bottom: 30px;
	float: left;
	margin-right: 20px;
}
strong{
	color: black;
}
.cardw{
	float: left;
	width: 440px;
	border: 2px solid #F1F3EB;
	margin-top: 30px;
	margin-bottom: 30px;
}
.card-body{
	height: 180px;
}
.bodyText{
	background-color: #F1F3EB;
	text-align: center;
	width: 418px;
	height: 60px;
	margin-left: 10px;
	padding-top: 15px;
	margin-top: 10px;
	font-size: 0.8em;
}
</style>
<div id="enegyView">
	<div class="cardt">
	  <div class="card-header">
	    <span>1월분 에너지 사용</span>50,560원
	  </div>
	  <div class="card-body">
	  	<div>
	  		<img src="${pageContext.request.contextPath }/images/energyBar.png">
	  	</div>
	  	<div>
		    <p class="card-text">
		    	우리집 에너지 사용 분석
		    </p>
	  	</div>
	  </div>
	</div> 
	<br><br>
	<div class="carde">
	  <div class="card-header">
	    전기  사용량229.00 | 28,280원
	  </div>
	  <div class="card-body">
	    <div>
	  		<img src="${pageContext.request.contextPath }/images/energystick.png">
	    </div>
	    <div class="bodyText">
	    	아파트고가 드리는 전기요금 절약 노하우!<br><br>
	    	<strong>우리집이 평균 요금보다 2,171원 적게 사용했습니다.</strong>
	    </div>
	  </div>
	</div> 
	<div class="cardw">
	  <div class="card-header">
	    수도  사용량229.00 | 28,280원
	  </div>
	  <div class="card-body">
	    <div>
	  		<img src="${pageContext.request.contextPath }/images/energystick.png">
	    </div>
	    <div class="bodyText">
	    	아파트고가 드리는 수도요금 절약 노하우!<br><br>
	    	<strong>우리집이 평균 요금보다 7,781원 많이 사용했습니다.</strong>
	    </div>
	  </div>
	</div> 
</div>

