<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>	
		(function (ns) {
			$(function(){	
				
				ns.right.init(); 
				
				var type = 'main';
				if(type == "main")
				{
					ns.main.init(); 
				}

			});
		})(APP || {});
</script>


<script>
if (navigator.userAgent.match(/iPhone|iPad|Mobile|UP.Browser|Android|BlackBerry|Windows CE|Nokia|webOS|Opera Mini|SonyEricsson|opera mobi|Windows Phone|IEMobile|POLARIS/) != null){
 top.location.href = "../m/";  //모바일용 인덱스파일을 띄어라
}
</script>


<!--전체레이어-->
<div id="k_popup" style="position: fixed; left:50%; margin-left:-960px; top:0px; z-index:9999; width:1920px; height:100%;  animation-duration:3s; animation-name:popup-bg; display: none;">
	
    <!--이미지 레이어-->

  <div class="popup">
	

<a href="javascript:closeWin();"><div class="black_overlay2"></div></a>
		
		
    <style>
		.black_overlay2 { /*top:73px;*/ z-index:1;
			position: absolute;
			width: 1920px;
			height:100%;
			background-color: black;
			-moz-opacity: 0.7;
			opacity: .70;
			filter: alpha(opacity=90);
		}
		
		@keyframes popup {

		  from { opacity:0; margin-top:-1000px; }
		  100% {opacity:0;  margin-top:-1000px;}
		  to { }
		  
		}
		
		@keyframes popup-bg {

		  from { opacity:0; }
		  80% {opacity:0;  }
		  to { }
		  
		}
		

		</style>

<map name="popup" id="popup">

   <area shape="rect" coords="1004,1,1055,80" href="javascript:closeWin();" /> 
  <area shape="rect" coords="725,442,996,495" href="https://pf.kakao.com/_xcXLtxb/chat" target="_blank" />
  
</map>

	</div>
	
    

</div>
<!--팝업 끝-->

</head>

<body style="overflow-x:hidden; overflow-y:auto;">

	<div id="main_wrap">
		<div id="visualArea1">
				<div id="vis"> 
				   <div class="roll">
						<div class="vis vis0">
							<img src="${cPath }/images/resident/main01.jpg" alt="BACKGROUND" class="bg">
							<div class="info">
									<div id="main_text01">
										<div id="main_txt01"><img src="${cPath }/images/resident/tit01-01.png" alt="" /></div>
										<div id="main_txt02"><img src="${cPath }/images/resident/tit01-02.png" alt="" /></div>	
									</div>				 
							</div>
						</div>


						<div class="vis vis1">
							<img src="${cPath }/images/resident/main02.jpg" alt="BACKGROUND" class="bg">
							<div class="info">
									<div id="main_text02">
										<div id="main_txt04"><img src="${cPath }/images/resident/tit02-02.png" alt="" /></div>
									</div>				 
							</div>
						</div>

						<div class="vis vis2">
							<img src="${cPath }/images/resident/main03.jpg" alt="BACKGROUND" class="bg">
							<div class="info">
									<div id="main_text03">
										<div id="main_txt05"><img src="${cPath }/images/resident/tit03-01.png" alt="" /></div>	
										<div id="main_txt06"><img src="${cPath }/images/resident/tit03-02.png" alt="" /></div>
									</div>				 
							</div>
						</div>
					</div>
				<script>vis.init();</script>
				</div>
<%-- 			<div id="qqq"><img src="${cPath }/images/resident/qqq.jpg" alt=""></div> --%>
		</div>
    </div>
<!-- 		<div id="content">	 -->
<!-- 			<div id="content-bg"></div> -->
<!-- 			<div id="pr-wrap"> -->
<%-- 				<div id="pr-tit"><img src="${cPath }/images/resident/pr-tit.png" alt=""> --%>
<!-- 					<div align="center"> -->
<!-- 						아파트 단지 구조도 -->
<%-- 						<a href=""><img src="${cPath}/images/resident/m_b1.png"></a> --%>
<!-- 						관리사무소 공지사항 -->
<%-- 						<a href=""><img src="${cPath}/images/resident/m_b2.png"></a> --%>
<!-- 						자유게시판 -->
<%-- 						<a href=""><img src="${cPath}/images/resident/m_b3.png"></a> --%>
<!-- 						관리비 조회 -->
<%-- 						<a href=""><img src="${cPath}/images/resident/m_b4.png"></a> --%>
<!-- 						자동차 조회 -->
<%-- 						<a href=""><img src="${cPath}/images/resident/m_b5.png"></a> --%>
<!-- 					</div> -->
				
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div id="premium-wrap"> -->
<%-- 				<div id="premium-tit"><img src="${cPath }/images/resident/premium-tit.png" alt=""></div> --%>
<!-- 					<div class="arrow"> -->
<%-- 						 <div class="swiper-button-next"><img src="${cPath }/images/resident/slide-right.jpg" alt="" /></div> --%>
<%-- 						 <div class="swiper-button-prev"><img src="${cPath }/images/resident/slide-left.jpg" alt="" /></div> --%>
<!-- 					</div> -->
<!-- 					<div class="swiper-container swiper1 swiper01" style=" width:1334px; top: 329px; opacity: 0;">  		 -->
<!-- 							<div class="swiper-wrapper"> -->
<%-- 								<div class="swiper-slide" ><img src="${cPath }/images/resident/premium01.png" alt=""></div>	 --%>
<%-- 								<div class="swiper-slide" ><img src="${cPath }/images/resident/premium02.png" alt=""></div> --%>
<%-- 								<div class="swiper-slide" ><img src="${cPath }/images/resident/premium03.png" alt=""></div> --%>
<%-- 								<div class="swiper-slide" ><img src="${cPath }/images/resident/premium04.png" alt=""></div> --%>
<%-- 								<div class="swiper-slide" ><img src="${cPath }/images/resident/premium05.png" alt=""></div> --%>
<%-- 								<div class="swiper-slide" ><img src="${cPath }/images/resident/premium06.png" alt=""></div> --%>
<!-- 							 </div> -->
<!-- 					</div>				 -->
<!-- 			</div> -->
<!-- 			<div id="landmark-wrap"> -->
<!-- 					<div class="arrow"> -->
<%-- 						 <div class="swiper-button-next2"><img src="${cPath }/images/resident/slide-right.jpg" alt="" /></div> --%>
<%-- 						 <div class="swiper-button-prev2"><img src="${cPath }/images/resident/slide-left.jpg" alt="" /></div> --%>
<!-- 					</div> -->
<!-- 					<div class="swiper-container swiper2 swiper02" style=" width:1920px; top: 143px; opacity: 0;">  		 -->
<!-- 							<div class="swiper-wrapper"> -->
<%-- 								<div class="swiper-slide" ><img src="${cPath }/images/resident/landmark01.jpg" alt=""></div>	 --%>
<%-- 								<div class="swiper-slide" ><img src="${cPath }/images/resident/landmark02.jpg" alt=""></div> --%>
<!-- 							 </div> -->
<!-- 					</div> -->
<!-- 			</div> -->
<!-- 			<div id="contact-wrap"> -->
<%-- 			    <div id="contact-bg"><img src="${cPath }/images/resident/contact-bg.jpg" alt=""></div> --%>
<!-- 				<div id="map" style="width:100%;height:100%;"></div> -->
<!-- 			</div> -->
				
<!--         </div> -->
        
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8328cb8bd34411d67e962449b9c6e6ec&libraries=services"></script>
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('대전 중구 중앙로 76', function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;"><img src="${cPath}/images/residentLogo.png"></div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
	</script>   
        
        
    <script src="${cPath }/js/resident/swiper.min.js"></script>
    <script>
    var swiper1 = new Swiper('.swiper1', {
		
        pagination: '.swiper-pagination',
        paginationClickable: true,
		spaceBetween:40,
		slidesPerView:3,
		autoplay: {
        delay: 5000,
        disableOnInteraction: false,
      },
		loop: true,
		speed:1000,
		
		navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
		
		},
		 
    });	

	 var swiper2 = new Swiper('.swiper2', {
       effect : 'fade', // 페이드 효과 사용

		loop : true, // 무한 반복
		pagination : { // 페이징 설정
			el : '.swiper-pagination',
			clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
		},
		navigation : { // 네비게이션 설정
			nextEl : '.swiper-button-next2', // 다음 버튼 클래스명
			prevEl : '.swiper-button-prev2', // 이번 버튼 클래스명
		},

		autoplay: {
			delay: 2500,
			disableOnInteraction: false,
		  },

		  speed:900,
		
		 
    });
	
	 /*
	  * 퀵메뉴 숨김 20210304
	  * 박정민
	  */
	$(document).ready(function(){
		$("#quickMenuDiv").hide(); 
	});
  </script>
<!-- <script type="text/javascript"> -->
<!-- // if(!wcs_add) var wcs_add = {}; -->
<!-- // wcs_add["wa"] = "112ff33cde64ac"; -->
<!-- // wcs_do(); -->
<!-- </script> -->
</body>
</html>