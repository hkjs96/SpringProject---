<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />

<style>
	#payDetailTb tr{
		height: 3em;
	}
	
	#payDetailTb {
		width: 50em;
	}
	
	#modalBodyDiv{
		width: 61.5em;
	}
	
	.smileIcon{
		width: 25px;
		height: 25px;
	}
	
	#detailTitle{
		margin-top: px;
		font-size: 30px;
	}
	
	.searchDiv{
		margin-left: 45px;
	}
	
	#noticeSpan{
		color:blue;
	}
</style>


<form id="searchForm">
	<input type="hidden" name="searchVO.searchAptCode" value="${authMember.aptCode}">
	<input type="hidden" name="page" />
	<input type="hidden" name="payYear" value="${pagingVO.searchDetail.payYear }"/>
	<input type="hidden" name="payMonth" value="${pagingVO.searchDetail.payMonth }"/>
	<input type="hidden" name="positionCode" value="${pagingVO.searchDetail.employee.positionCode }"/>
	<input type="hidden" name="empName" value="${pagingVO.searchDetail.employee.empName }"/>
</form>
<br>
<h2><strong>급여지급대장</strong></h2>
<br>
<div class="container">
	<div class="col-md-12 " style="border-style:outset;border-radius: 8px;">
	  <div class="row g-0 searchDiv">
		    <div class="col-md-2" style="margin-top:20px;">
		      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
		        style="width:30px;height:30px;margin-left:10px;margin-top:10px;">&nbsp;&nbsp;<strong>검색 조건</strong>
		    </div>
		    <div id="inputUI" class="col-md-11">
		    <form class="form-inline" id="searchForm">
			      <div class="card-body ">
			        	&nbsp;&nbsp;지급연도&nbsp;&nbsp;
			        	<select class="custom-select col-md-3 searchSelect" name="payYear">
			        		<option value="">전체</option>
							<c:forEach begin="2019" end="2050" var="year">
							<option value="${year }" ${pagingVO.searchDetail.payYear eq year ? 'selected':''}>${year }</option>
						</c:forEach>
						</select>
						&nbsp;&nbsp;지급월&nbsp;&nbsp;
			        	<select class="custom-select col-md-3 searchSelect" name="payMonth">
			        		<option value="">전체</option>
							<c:forEach begin="1" end="12" var="month">
							<option value="${month }" ${pagingVO.searchDetail.payMonth eq month ? 'selected':''}>${month }</option>
						</c:forEach>
						</select>
			        	&nbsp;&nbsp;직책&nbsp;&nbsp;
			        	<select id="positionCode" name="positionCode" class="custom-select col-md-3">
			        				<option value="">전체</option>
							<c:forEach items="${positions }" var="position" varStatus="vs">
								<c:if test="${not empty position.positionCode }">
									<option value="${position.positionCode }" ${pagingVO.searchDetail.employee.positionCode eq position.positionCode ? 'selected':''}>"${position.positionName }"</option>
								</c:if>
							</c:forEach>
						</select>
			        	&nbsp;&nbsp;성명&nbsp;&nbsp;
				       	<input type="text" name="empName" class="form-control col-md-3" value="${pagingVO.searchDetail.employee.empName }"> 
						 <button class="btn btn-dark" style='margin:5pt;' id="searchBtn">검색</button>
						 <button class="btn btn-secondary" id="resetBtn">초기화</button>
					</div>
		      </form>
		    </div>
	  </div>
	</div>
	<div class="d-flex justify-content-between mb-3 mt-3">
	 	 <div><span id="noticeSpan">* 각 행을 더블클릭하면 급여명세서를 조회할 수 있습니다.</span></div>
	</div>
	
	  <div class="col-sm-12">
	  <form id="tmpForm" action="${cPath }/office/payment/tmp.do" method="post">
	<input type="hidden" id="htmlVal" name="htmlVal" value="" >
</form>
		  <table class="table table-bordered table-hover " id="tmpDiv">
			  <thead class="thead-light text-center">
			    <tr >
			      <th>지급연월</th>
			      <th>직원ID</th>
			      <th>성명</th>
			      <th>지급총액</th>
			      <th>공제합계</th>
			      <th>실수령액</th>
			    </tr>
			  </thead>
			  <tbody id="listBody" class="text-center">
			  <c:set var="payList" value="${pagingVO.dataList }"/>
			    <c:if test="${not empty payList }">
			    	<c:forEach items="${payList }" var="pay">
			    		<tr data-pay-no='${pay.payNo }'>
			    			<td>${pay.payYear }/${pay.payMonth }</td>
			    			<td>${pay.employee.memId }</td>
			    			<td>${pay.employee.empName }</td>
			    			<td class="text-right"> <fmt:formatNumber 
			    			value="${pay.payBase
				 					 +pay.payPlus
				 					 +pay.payMeal
				 					}" pattern="#,###"/>&nbsp;원
				 			</td>
			    			<td class="text-right"><fmt:formatNumber 
			    			value="${pay.payHealth
			 					 +pay.payPension
			 					 +pay.payEmployee
			 					 +pay.payIncometax
			 					 +pay.payLocalIncometax }" pattern="#,###"/>&nbsp;원
			    			</td>
			    			<td class="text-right"><fmt:formatNumber 
			    			value="${pay.payBase
			 					 +pay.payPlus
			 					 +pay.payMeal
			 					 -pay.payHealth
			 					 -pay.payPension
			 					 -pay.payEmployee
			 					 -pay.payIncometax
			 					 -pay.payLocalIncometax }" pattern="#,###"/>&nbsp;원
			    			</td>
			    		</tr>
			    	</c:forEach>
			    </c:if>
			    <c:if test="${empty payList }">
			    	<tr>
			    		<td colspan="7">조회 결과가 없습니다.</td>
			    	<tr>
			    </c:if>
			  </tbody>
		</table>
		<div id="pagingArea">
			<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
		</div>
	</div>
</div>
  <!-- The Modal -->
  <div class="modal fade" id="detailModal">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <p class="modal-title">- 급여명세서</p>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div id="modalBodyDiv" class="modal-body d-flex justify-content-end">
	        <input type="button" class="btn btn-dark" onclick="printBt()" value="인쇄">
        </div>
        <div id="printDiv">
        <p class="text-center" id="detailTitle">급여명세서</p>
        <div class="modal-body d-flex justify-content-center ">
          <table class="table table-bordered text-center" id="payDetailTb">
			<thead class="thead-light">
				<tr>
					<th class="text-left" id="payDayMd" colspan="4"></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="2" id="nameMd"></td>
					<td colspan="2" id="positionMd"></td>
				</tr>
				<tr>
					<td class="table-active ">지급항목</td>
					<td class="table-active ">지급액</td>
					<td class="table-active ">공제항목</td>
					<td class="table-active ">공제액</td>
				</tr>
				<tr>					
					<td >기본급</td>
					<td id="payBaseMd" class="text-right"></td>
					<td >건강보험</td>
					<td id="payHealthMd" class="text-right"></td>
				</tr>
				<tr>
					<td >직책수당</td>
					<td id="payPlusMd" class="text-right"></td>
					<td >국민연금</td>
					<td id="payPensionMd" class="text-right"></td>
				</tr>
				<tr>
					<td >식대</td>
					<td id="payMealMd" class="text-right"></td>
					<td >고용보험</td>
					<td id="payEmployeeMd" class="text-right"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td >소득세</td>
					<td id="payIncometaxMd" class="text-right"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td >지방소득세</td>
					<td id="payLocalIncometaxMd" class="text-right"></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr >
					<td></td>
					<td></td>
					<td class="table-active ">공제합계</td>
					<td id="tmpSumMd" class="text-right"></td>
				</tr>
				<tr>
					<td class="table-active ">급여계</td>
					<td id="deductSumMd" class="text-right"></td>
					<td class="table-active ">차감수령액</td>
					<td id="realSumMd" class="text-right" ></td>
				</tr>
				<tr class="table-primary">
					<td colspan="4">
					<img class="smileIcon" src="${cPath}/images/smile.png" alt="smile">
						귀하의 노고에 감사드립니다.
					<img class="smileIcon" src="${cPath}/images/smile.png" alt="smile">
			        </td>
				</tr>
			</tbody>
		</table>
        </div>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
        </div>
		   
      </div>
    </div>
  </div>


<script>
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		return false;
	}
	
	let searchForm = $("#searchForm");
	$("#searchBtn").on("click", function(){
		let inputs = $(this).parents("div#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val();
			let hidden = searchForm.find("[name='"+name+"']");
			hidden.val(value);
		});
		searchForm.submit();
	});
	
	$("#resetBtn").on("click", function() {
		// input 박스 비우도록
		let inputs = $(this).parents("div#inputUI").find(":input[name]");
		$(inputs).each(function(index, input){
			let name = $(this).attr("name");
			let value = $(this).val(null);
		});

		// select 박스 첫번째 옵션이 선택되도록
		let selects = $("div#inputUI .searchSelect"); 
		$(selects).each(function(index, select) {
			$(select).children(":eq(0)").prop("selected", true);
		});

		syncFormWithUI(inputs);
	});
	
	
	function printBt() {
		var initBody = document.body.innerHTML;
		window.onbeforeprint = function () {
			document.body.innerHTML = document.getElementById("printDiv").innerHTML;
		}
		window.onafterprint = function () {
			window.location.reload()
			
		}
		window.print();
	}
	
	let listBody = $("#listBody");
	listBody.on("dblclick", "tr", function() {
		let payNo = this.dataset.payNo;
		
		$.ajax({
			url:"${cPath }/office/payment/paymentDetailView.do"
			,data : {"payNo" : payNo }
			,method : "get"
			,success : function(resp){
				
				console.log(resp);
				if(resp.message){
					getNoty(resp);
					return;
				}else{
					 $("#payBaseMd").text(numberWithCommas(resp.payDetail.payBase));
					 $("#payPlusMd").text(numberWithCommas(resp.payDetail.payPlus));
					 $("#payMealMd").text(numberWithCommas(resp.payDetail.payMeal));
					 $("#payHealthMd").text(numberWithCommas(resp.payDetail.payHealth));
					 $("#payPensionMd").text(numberWithCommas(resp.payDetail.payPension));
					 $("#payEmployeeMd").text(numberWithCommas(resp.payDetail.payEmployee));
					 $("#payIncometaxMd").text(numberWithCommas(resp.payDetail.payIncometax));
					 $("#payLocalIncometaxMd").text(numberWithCommas(resp.payDetail.payLocalIncometax));				
					 $("#payDayMd").text(String(resp.payDetail.payYear)+"년 "+String(resp.payDetail.payMonth)+"월 급여명세서");	
					 $("#tmpSumMd").text(numberWithCommas(resp.payDetail.payTmpsum));
					 $("#deductSumMd").text(numberWithCommas(resp.payDetail.payDeductsum));	
					 $("#realSumMd").text(numberWithCommas(resp.payDetail.payRealsum));
					 $("#nameMd").text("성명 : "+String(resp.empDetail.empName));	
					 $("#positionMd").text("직책 : "+String(resp.empDetail.position.positionName));	
					 
				}
				$('#detailModal').modal("show");
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
	});	

</script>
