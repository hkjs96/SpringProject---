<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
	.leftDiv{
		float: left;
	}
	.tableP{
		font-size: 18px;
		color: blue;
		margin-top:23px;
	}
	
	#svrcEmpSearch{
		font-size: 17px;
	}
	
	#lawTitle{
		font-size: 15px;
	}
	
	#lawTitleSpan{
		margin-left:7em;
	}
	
	#svrcLawTb{
		font-size: 14px;
	}
	
	.titleP{
		font-size:20px;
	}
</style>

<div class="container">
	<br>
	<div class="d-flex justify-content-between mb-3">
		<h2><strong>퇴직정산 </strong></h2>
		<input type="button" class="btn btn-dark" value="전체보기" id="svrcListBtn">
	</div>
	<br>
	<div>
		<div class="col-sm-12 mb-5">
		<p class="titleP">- 퇴직금 조회</p>
		 <table class="table table-bordered text-center col-sm-12 ">
		    <tbody>
		      <tr>
		        <td class="align-middle table-secondary">직원코드</td>
		        <td class="align-middle">
		        	<input type="text" id="memId" name="memId" class="form-control" value="" readonly> 
				</td>
		        <td class="align-middle table-secondary">성명(직책)</td>
		        <td class="align-middle">
					<input type="text" id="empInfo" class="form-control" value="" readonly> 
				</td>
				<td>
					<input type="button" value="정산" class="btn btn-primary" id="sumSvrcBtn">
				</td>
				<td>
					<form id="tmpForm" action="${cPath }/office/severance/tmp.do" method="post">
						<input type="hidden" id="htmlVal" name="htmlVal" value="" >
						<input type="button" id="goDraftBtn" value="내역 상신" class="btn btn-info" disabled>
					</form>
				</td>
		      </tr>
		    </tbody>
		  </table>
		  </div>
			 <div class="leftDiv col-sm-4" id="insertDiv">
			  <div class="form-inline mb-2">					  
			  	<input type="text" id="searchInput" name="searchInput" class="form-control" value="${pagingVO.searchDetail.employee.empName }" placeholder="직원코드/성명/직책"> 
			  	<input type="button" value="검색" class="btn btn-dark ml-2" id="searchEmpBtn" >
			  	<input type="button" value="초기화" class="btn btn-secondary ml-2" id="resetBtn">
			  </div>
				<select id="svrcEmpSearch" name="svrcEmpSearch" class="form-control leftDiv mb-4" size="7">
					<c:forEach items="${empSelectList }" var="empSel">
						<option value="${empSel.member.memId}">${empSel.member.memId} / ${empSel.empName }(${empSel.position.positionName })</option>
					</c:forEach>
				</select> 
				
				<!-- 퇴직금 정산 규정 ----------------------------------------------------------------------------------------->
				<div id="lawTitleSpan">
					<span id="lawTitle" class="badge badge-info align-center">퇴직금 지급 기준</span>
				</div>
				 <table id="svrcLawTb" class="table table-bordered table-hover table-sm col-sm-12 mt-2" >
					  <thead class="thead-light text-center ">
					    <tr>
					      <th width="40%">항목</th>
					      <th width="60%">산정방법</th>
					    </tr>
					  </thead>
					  <tbody>
					  </tbody>
					    <tr>
					      <td class="align-middle text-center">시간당 통상임금</td>
					      <td>월급(3개월간 임금총액/3)<br>/ 209(월 근로시간)</td>
					    </tr>
					  </tbody>
					    <tr>
					      <td class="align-middle text-center">일 통상임금</td>
					      <td>시간당 통상임금 <br>* 8시간(일 근로시간)</td>
					    </tr>
					  </tbody>
					    <tr>
					      <td class="align-middle text-center">연차수당</td>
					      <td >일 통상임금 <br>* 미사용 연차일수</td>
					    </tr>
					  </tbody>
					    <tr>
					      <td class="align-middle text-center">연차수당 가산액</td>
					      <td>연차수당 * (3/12)</td>
					    </tr>
					  </tbody>
					    <tr>
					      <td class="align-middle text-center">1일 평균임금</td>
					      <td>퇴직일 이전 3개월간 <br>지급받은 임금총액(A+B)<br>/ 퇴직일 이전 <br>3개월간의 총 일수</td>
					    </tr>
					  </tbody>
					    <tr>
					      <td class="align-middle text-center">퇴직금</td>
					      <td>1일 평균임금 * 30(일)<br>* (재직일수/365)]</td>
					    </tr>
					  </tbody>
				</table>
			</div>
			
			<!-- 최근 3개월 임금내역 (기안문 전송 시 ckeditor로 outerHTML 사용하기 위해 inline style로 스타일 지정) ------------------->
			<div class="leftDiv col-sm-8">
				<div class="col-sm-12" id="goDraftDiv">
					 <div class="leftDiv card card-header inputPayDiv col-sm-12">
					 	<table border="1" class="table table-bordered table-sm col-sm-12">
						  <thead class="thead-light">
						    <tr>
						      <th width="50%" style="text-align: center;">성명(직급)</th>
						      <td width="50%" style="text-align: center;"><span id="inputDraftEmpName"></span></td>
						    </tr>
						    </thead>
					   </table>
					 	<p class="tableP ">* 최근 3개월 임금내역</p>
					 	<table border="1" id="threeMonthPayTb" class="table table-bordered table-sm col-sm-12">
						  <thead class="thead-light">
						    <tr>
						      <th width="25%" style="text-align: center;">항목</th>
						      <th width="25%" style="text-align: center;"></th>
						      <th width="25%" style="text-align: center;"></th>
						      <th width="25%" style="text-align: center;"></th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
						      <td style="text-align: center;">급여계</td>
						      <td style="text-align: right;"></td>
						      <td style="text-align: right;"></td>
						      <td style="text-align: right;"></td>
						    </tr>
						    <tr>
						      <td style="text-align: center;">제수당</td>
						      <td style="text-align: right;"></td>
						      <td style="text-align: right;"></td>
						      <td style="text-align: right;"></td>
						    </tr>
						    <tr>
						      <td style="text-align: center;">실수령액</td>
						      <td style="text-align: right;"></td>
						      <td style="text-align: right;"></td>
						      <td style="text-align: right;"></td>
						    </tr>
						    <tr>
						      <td style="text-align: center;">근무일수</td>
						      <td style="text-align: center;"></td>
						      <td style="text-align: center;"></td>
						      <td style="text-align: center;"></td>
						    </tr>
						  </tbody>
					</table>
					
			  <!-- 퇴직금 정산 내역 (기안문 전송 시 ckeditor로 outerHTML 사용하기 위해 inline style로 스타일 지정)------------------->	
					<p class="tableP">* 정산내역</p>
					 <table border="1" id="svrcPayTb" class="table table-bordered table-hover table-sm col-sm-12" >
						  <thead class="thead-light">
						    <tr>
						      <th width="80%" style="text-align: center;">항목</th>
						      <th width="20%" style="text-align: center;">금액(단위:원)</th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
						      <td>최근 3개월 임금총액(세전)</td>
						      <td style="text-align: right;"></td>
						    </tr>
						  </tbody>
						    <tr>
						      <td>시간당 통상임금</td>
						      <td style="text-align: right;"></td>
						    </tr>
						  </tbody>
						    <tr>
						      <td>일 통상임금</td>
						      <td style="text-align: right;"></td>
						    </tr>
						  </tbody>
						    <tr>
						      <td>연차수당</td>
						      <td style="text-align: right;"></td>
						    </tr>
						  </tbody>
						    <tr>
						      <td>연차수당 가산액</td>
						      <td style="text-align: right;"></td>
						    </tr>
						  </tbody>
						    <tr>
						      <td>1일 평균임금</td>
						      <td style="text-align: right;"></td>
						    </tr>
						  </tbody>
						    <tr>
						      <td class="reddot">퇴직금 [1일 평균임금 * 30(일) * (재직일수/365)]</td>
						      <td style="text-align: right;" class="text-right reddot"></td>
						    </tr>
						  </tbody>
					</table>
					</div>
				</div>
			</div>
	  </div>
</div>

	

<script>

	//==퇴직정산 대상 직원 검색 ==============================================================================================
		
	//selectBox에서 클릭하면 대상직원 textBox에 자동 Input됨
	$("#svrcEmpSearch").on("click", function(){
		let selectedMemId = $("#svrcEmpSearch option:selected").val();
		let selectedEmpInfo = ($("#svrcEmpSearch option:selected").text()).split("/")[1];
		 $("#memId").val(selectedMemId);
		 $("#empInfo").val(selectedEmpInfo);
	});
	
	
	var delIdx = new Array();
	
	//검색 버튼 클릭하면 selectBox에 검색한 직원 목록만 출력
	$("#searchEmpBtn").on("click", function(){
		
		//=====selectBox 초기화(초기화버튼 누르지 않고 재검색 할 시에도 검색 범위는 전체여야 함)=========
		
		// delIdx 배열 내 인덱스값 option 보이게
		let selSize = delIdx.length;
		for(var i=0; i<selSize; i++){
			$("#svrcEmpSearch option:eq('"+delIdx[i]+"'"+")").show();
		}
		// delIdx 값 reset
		delIdx  = new Array();
		
		//=====초기화 끝=================================================================
		
			
		//검색 입력값 
		let searchVal = $("#searchInput").val();
	
		//검색 대상 selectBox의 전체 option 수
		let wholeSelSize = $("#svrcEmpSearch option").length;
		
		//검색값과 일치하지 않는 option의 index정보 delIdx배열에 넣고, hide처리
		for(var i=0; i<wholeSelSize ; i++){
		 	if($("#svrcEmpSearch option:eq('"+i+"'"+")").text().indexOf(searchVal) == -1) {
		 		delIdx.push($("#svrcEmpSearch option").index($("#svrcEmpSearch option:eq('"+i+"'"+")")));
		 		$("#svrcEmpSearch option:eq('"+i+"'"+")").hide();
		 	}
		}
		
	});
	
	//검색내역 초기화 버튼 클릭
	$("#resetBtn").on("click", function(){
		let selSize = delIdx.length;
		for(var i=0; i<selSize; i++){
			$("#svrcEmpSearch option:eq('"+delIdx[i]+"'"+")").show();
		}
			delIdx  = new Array();
		
		$("#searchInput").val("");
	});
	
	//== 퇴직금 계산 =======================================================================================================
	
	//예상 퇴직정산금 계산
	$("#sumSvrcBtn").on("click", function(){
		$.ajax({
			url:"${cPath }/office/severance/tmpSvrcView.do"
			,data : {"memId" : $('#memId').val()}
			,method : "get"
			,success : function(resp){
				if(resp.message){
					getNoty(resp);
					return;
				}else{
					
					if(resp.noResult!=null){
						getErrorNotyDefault("정산내역이 없습니다. 근무기간을 확인해주세요.");	
						return;
					}
					
					if(resp.threeMonthList.length<3){
						getErrorNotyDefault("최근 3개월의 정산내역이 없습니다. 근무기간을 확인해주세요.");	
						return;
					}
					//== 직원 정보 ====================================================
					$("#inputDraftEmpName").text($("#empInfo").val());
					
					//== 최근 3개월 급여내역 =============================================
					//연도, 월 
					$('#threeMonthPayTb tr th').each(function (index, item) {
						if(index>0){
							index -= 1;
							$(this).text(resp.threeMonthList[index]['payYear']
									+"년 "
									+resp.threeMonthList[index]['payMonth']
									+"월");
						}
					});
					
					//급여계
					$('#threeMonthPayTb tr:gt(0)').find('td').each(function (index, item) {
						if(index>3){
							return;
						}
						
						if(index>0){
							index -= 1;
							$(this).text(numberWithCommas(resp.threeMonthList[index]['payTmpsum']));
						}
						
						
					});

					//공제합계
					$('#threeMonthPayTb tr:gt(1)').find('td').each(function (index, item) {
						if(index>3){
							return;
						}
						
						if(index>0){
							index -= 1;
							$(this).text(numberWithCommas(resp.threeMonthList[index]['payDeductsum']));
						}
					});
					
					//실수령액
					$('#threeMonthPayTb tr:gt(2)').find('td').each(function (index, item) {
						if(index>3){
							return;
						}
						
						if(index>0){
							index -= 1;
							$(this).text(numberWithCommas(resp.threeMonthList[index]['payRealsum']));
						}
					});
					
					//근무일수
					$('#threeMonthPayTb tr:gt(3)').find('td').each(function (index, item) {
						if(index>3){
							return;
						}
						
						if(index>0){
							index -= 1;
							$(this).text(numberWithCommas(resp.threeMonthList[index]['payLastday']+"일"));
						}
					});
					
					//== 퇴직정산내역 =================================================
					console.log(resp.svrc);
					let svcrList = new Array();
					svcrList.push(numberWithCommas(resp.svrc.svrcThreetotal)); // 최근 3개월 임금총액(세전)
					svcrList.push(numberWithCommas(resp.svrc.svrcPayfortime)); // 시간당 통상임금
					svcrList.push(numberWithCommas(resp.svrc.svrcPayforday)); // 일 통상임금
					svcrList.push(numberWithCommas(resp.svrc.svrcNotuseoff)); // 연차수당
					svcrList.push(numberWithCommas(resp.svrc.svrcNotuseoffplus)); // 연차수당 가산액
					svcrList.push(numberWithCommas(resp.svrc.svrcAvgforday)); // 1일 평균임금
					svcrList.push(numberWithCommas(resp.svrc.svrcCost)); // 퇴직금 [1일 평균임금 * 30(일) * (재직일수/365)]
					
					$('#svrcPayTb tr').find('td:eq(1)').each(function (index, item) {
						$(this).text(svcrList[index]);
					});

					//== 기타 ===========================================================
					//정산 버튼 활성화
					$("#goDraftBtn").removeAttr("disabled");
				}
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
	});
	
	
	
	//== 퇴직정산 기안문 작성을 위해 내용을 outerHTML 내보냄 ====================================================================
	
	//outerHTML 함수

	
	//퇴직정산 테이블 내용 보내기
	$("#goDraftBtn").on("click", function(){
		//svrcTopContent: 퇴직정산 기안문 상단 내용
		
		$.fn.outerHTML = function() {
		  var el = $(this);
		  if( !el[0] ) return "";
		
		  if (el[0].outerHTML) {
		      return el[0].outerHTML;
		  } else {
		      var content = el.wrap('<p/>').parent().html();
		      el.unwrap();
		      return content;
		  }
		}
		let htmlVal = $("#goDraftDiv").outerHTML(); $("#goDraftDiv").clone().wrapAll("<div/>").parent().html();
		htmlVal = svrcTopContent + htmlVal;
	
		$("#htmlVal").val(htmlVal);
		$("#tmpForm").submit();
		
	});
	
	$("#svrcListBtn").on("click", function(){
		location.href = "${cPath}/office/severance/severanceList.do";
	});
</script>
<script type="text/javascript" src="${cPath }/js/office/approval/draft.js"></script>
