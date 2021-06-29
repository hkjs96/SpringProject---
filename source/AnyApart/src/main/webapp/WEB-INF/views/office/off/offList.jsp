<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 2.      이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />

<style>
	.delBtn{
		font-size:16px;
		width: 80px;
		height: 30px; 
		margin: 2px;
		line-height: 10px;
	}
	
	#searchDiv{ 
		margin-left:10px; 
	} 
	
	.noticeP{
		color: blue;
		text-align: left;
	}
	
</style>

<br>
<h2><strong>휴가 현황</strong></h2>
<br>
<div class="container">
	<!-- 서버 ---------------------------------------->
	<form id="searchForm">
		<input type="hidden" name="searchVO.searchAptCode" value="${authMember.aptCode}">
		<input type="hidden" name="page" />
		<input type="hidden" name="offCode" value="${pagingVO.searchDetail.offCode }"/>
		<input type="hidden" name="searchOffS" value="${pagingVO.searchDetail.searchOffS }"/>
		<input type="hidden" name="searchOffE" value="${pagingVO.searchDetail.searchOffE }"/>
	</form>
	<!-- 클라이언트 ----------------------------------->
	<div class="col-md-12 " style="border-style:outset;border-radius: 8px;">
		  <div class="row g-0" id="searchDiv">
			    <div class="col-md-2" style="margin-top:20px;">
			      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
			        style="width:30px;height:30px;margin-left:10px;margin-top:10px;">&nbsp;&nbsp;<strong>검색 조건</strong>
			    </div>
			    <!-- 검색 form ----------------------------------->
			    <div id="inputUI" class="col-md-12 mb-2">
				    <form class="form-inline">
					      <div class="card-body ">
					        	&nbsp;&nbsp;휴가분류&nbsp;&nbsp;
					        	<select class="custom-select col-md-2 searchSelect" id="offCode" name="offCode">
					        		<option value="">전체</option>
				        			<c:forEach items="${offSelectList }" var="off" varStatus="vs">
										<c:if test="${not empty off.codeId }">
											<option value="${off.codeId }" ${pagingVO.searchDetail.offCode eq off.codeId ? 'selected':''}>"${off.codeName }"</option>
										</c:if>
									</c:forEach>
					        	</select> 
						       	&nbsp;&nbsp; 휴가시작일&nbsp;&nbsp;
						       	<input type="date" id="searchOffS" name="searchOffS" class="form-control col-md-3" value="${pagingVO.searchDetail.searchOffS }"> 
						       	&nbsp;&nbsp; 휴가종료일&nbsp;&nbsp;
						       	<input type="date" id="searchOffE" name="searchOffE" class="form-control col-md-3" value="${pagingVO.searchDetail.searchOffE }"> 
								<button class="btn btn-dark" style='margin:5pt;'>검색</button>
								<button class="btn btn-secondary" id="resetBtn">초기화</button>
						  </div>
				      </form>
			    </div>
			    <!-- 검색 form 끝 --------------------------------->
		  </div>
	</div>
	<br>
	<!-- 휴가신청 등록 버튼 -------------------------------->
	
	<div class="d-flex justify-content-between mb-2">
		<div class="d-flex justify-content-start"><p class="noticeP" >* 각 행을 더블클릭하면 휴가 정보를 수정할 수 있습니다.</p></div>
   		 <div class="d-flex justify-content-end"><button class="btn btn-primary" style='margin:5pt;' data-toggle="modal" data-target="#offInsertModal">휴가 신청</button></div>
	</div>
	<!-- 휴가 신청 리스트  --------------------------------->
	  <div class="text-center col-sm-12">
		  <table class="table table-bordered table-hover">
			  <thead class="thead-light">
			    <tr>
			      <th width="5%">No</th>
			      <th width="10%">분류</th>
<!-- 			      <th>사용자코드</th> -->
			      <th width="10%">직책</th>
			      <th width="10%">이름</th>
			      <th width="15%">기간</th>
			      <th width="10%">사용일</th>
			      <th width="10%">잔여일</th>
			      <th width="20%">내용</th>
			      <th width="10%"></th>
			    </tr>
			  </thead>
			  <tbody id = "updateBody">
			     <c:set var="OffList" value="${pagingVO.dataList }" />
			  	<c:if test="${not empty OffList }">
			  		<c:forEach items = "${OffList }" var="off">
			  			<tr data-off-no=${off.offNo }>
				     		  <td>${off.offNo }</td>
				     		  <td>${off.codeVO.codeName}</td>
				     		  <td>${off.position.positionName }</td>
				     		  <td>${off.employee.empName }</td>
				     		  <td>${off.offStart } ~ <br>${off.offEnd }</td>
				     		  <td>${off.offUse }일</td>
				     		  <td>${off.offRemain }일</td>
				     		  <td class="text-left">${off.offContent }</td>
				     		  <td>
				     		  	  <input type="hidden" class="form-control" name="offNo" value="${off.offNo }"/>
					     		  <input type="button" class="btn btn-danger delBtn" name="deleteBtn" value="삭제">
				     		  </td>
						<tr>
					</c:forEach>
				</c:if>			
				<c:if test="${empty OffList }">
					<tr>
						<td colspan="11">조회 결과가 없습니다.</td>
					</tr>
				</c:if>			
			  </tbody>
		</table>
	</div>
	<!-- 휴가 신청 리스트 끝 -------------------------------->
	
	<!-- 페이징 처리 ------------------------------------->
	<div id="pagingArea">
		<ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsOffice"/>
	</div>
	<!-- 페이징 처리 끝 ----------------------------------->
</div>

<!-- 휴가 신청 모달 ------------------------------------->
<div class="modal" id="offInsertModal">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
    
    	  <!-- modal header -->
	      <div class="modal-header">
	        <p class="modal-title">- 휴가 신청</p>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      
	      <!-- modal body -->
	      <div class="modal-body" >
				<div>
	      		<!-- 휴가 등록 form -->
					<form id="insertForm" action="${cPath }/office/off/offInsert.do" method="POST">
						 <table class="table table-bordered text-center">
						    <tbody>
							    <tr>
							        <td width="30%" class="align-middle">신청인</td>
							        <td width="70%">
								        <select id="insertEmpSel" name="memId" class="custom-select ">
								      	    <option value="">전체</option>
								      	    <c:forEach items="${empSelectList }" var="empSel">
												<option value="${empSel.member.memId}">${empSel.empName }(${empSel.position.positionName })</option>
											</c:forEach>
										</select>
									</td>
							      </tr>
							      <tr>
							        <td class="align-middle">보유휴가일수
							        </td>
							        <td>
							        	<input type="text" id="insertEmpNowOff" class="form-control" value="" readonly>
									</td>
							      </tr>
							      <tr>
							        <td class="align-middle">휴가종류
								     </td>
							        <td>
								        <select id="insertOffSel" name="offCode" class="custom-select ">
								     	   <option value="">전체</option>
								      	    <c:forEach items="${offSelectList }" var="offSel">
												<option value="${offSel.codeId }">${offSel.codeName }</option>
											</c:forEach>
										</select>
									</td>
							      </tr>
							      <tr>
							      	<td>시작일 </td>
							        <td>
							      	 <input type="date" id="insertOffStart" class="form-control" name="offStart" value="" required/>
				   					 <form:errors path="offStart" element="span" cssClass="error"/>
							      	</td>
							      </tr>	
							      <tr>
							      	<td>종료일</td>
							        <td>
								      	 <input type="date" id="insertOffEnd" class="form-control" name="offEnd" value="" readonly/>
					   					 <form:errors path="offEnd" element="span" cssClass="error"/>
							      	</td>
							      	</tr>	
							      <tr>
							      	<td>사용휴가일수</td>
							        <td>
							      	 	<input type="text" id="insertEmpUseOff" name="offUse" class="form-control" value="" readonly>
							      	</td>
							      </tr>	
							      <tr>
							      	<td>잔여휴가일수</td>
							        <td>
							        	 <p id="insertUnpayP" class="noticeP">* 무급휴가의 경우 연차 사용하지 않음</p>
							      	 	<input type="text" id="insertEmpExpOff" name="offRemain" class="form-control" value="" readonly>
							      	</td>
							      </tr>	
							      <tr>
							      	<td>사유</td>
							        <td>
								         <p id="insertHalfP" class="noticeP">* 반차의 경우 사유에 오전/오후 입력</p>
								      	 <input type="text" required id="offContent" class="form-control" name="offContent" value="" required/>
					   					 <form:errors path="offContent" element="span" cssClass="error"/>
							      	</td>
							    </tr>
						    </tbody>
						  </table>
					  </form>
				<!-- 휴가 등록 form 끝 -->
				</div>
	      </div>
	      
	      <!-- modal footer -->
	      <div class="modal-footer">
	        <input type="button" class="btn btn-dark" value="등록" id="insertBtn">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
      	</div>
    </div>
 </div>
<!-- 휴가 신청 모달 끝 ---------------------------------->


<!-- 휴가 수정 모달 -->
<div class="modal" id="offUpdateModal">
  <div class="modal-dialog modal-md">
    <div class="modal-content">

	      
    	  <!-- modal header -->
	      <div class="modal-header">
	        <p class="modal-title">- 휴가 수정</p>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      
	      <!-- modal body -->
	      <div class="modal-body" >
				<div>
	      		<!-- 휴가 수정 form -->
					<form id="updateForm" action="${cPath }/office/off/offUpdate.do" method="POST">
						 <table class="table table-bordered text-center">
						    <tbody>
							    <tr>
							        <td width="30%" class="align-middle">신청인</td>
							        <td width="70%">
								        <input type="hidden" id="updateOffNo" name="offNo" class="form-control" value="" readonly>
								        <select id="updateEmpSel" name="memId" class="custom-select " disabled>
								      	    <option value="">전체</option>
								      	    <c:forEach items="${empSelectList }" var="empSel">
												<option value="${empSel.member.memId}">${empSel.empName }(${empSel.position.positionName })</option>
											</c:forEach>
										</select>
									</td>
							      </tr>
							      <tr>
							        <td class="align-middle">보유휴가일수
							        </td>
							        <td>
							        	<input type="text" id="updateOriOff" class="form-control" value="" readonly>
									</td>
							      </tr>
							      <tr>
							        <td class="align-middle">+ 기존 신청한 <br> 휴가일수
							        </td>
							        <td>
							        	<input type="text" id="updatePlusOff" class="form-control" value="" readonly>
									</td>
							      </tr>
							      <tr>
							        <td class="align-middle">총 보유휴가일수
							        </td>
							        <td>
							        	<input type="text" id="updateEmpNowOff" class="form-control" value="" readonly>
									</td>
							      </tr>
							      <tr>
							        <td class="align-middle">휴가종류
								     </td>
							        <td>
								        <select id="updateOffSel" name="offCode" class="custom-select ">
								     	   <option value="">전체</option>
								      	    <c:forEach items="${offSelectList }" var="offSel">
												<option value="${offSel.codeId }">${offSel.codeName }</option>
											</c:forEach>
										</select>
									</td>
							      </tr>
							      <tr>
							      	<td>시작일 </td>
							        <td>
							      	 <input type="date" id="updateOffStart" class="form-control" name="offStart" value="" required/>
				   					 <form:errors path="offStart" element="span" cssClass="error"/>
							      	</td>
							      </tr>	
							      <tr>
							      	<td>종료일</td>
							        <td>
								      	 <input type="date" id="updateOffEnd" class="form-control" name="offEnd" value="" readonly/>
					   					 <form:errors path="offEnd" element="span" cssClass="error"/>
							      	</td>
							      	</tr>	
							      <tr>
							      	<td>사용휴가일수</td>
							        <td>
							      	 	<input type="text" id="updateEmpUseOff" name="offUse" class="form-control" value="" readonly>
							      	</td>
							      </tr>	
							      <tr>
							      	<td>잔여휴가일수</td>
							        <td>
							        	 <p id="updateUnpayP" class="noticeP">* 무급휴가의 경우 연차 사용하지 않음</p>
							      	 	<input type="text" id="updateEmpExpOff" name="offRemain" class="form-control" value="" readonly>
							      	</td>
							      </tr>	
							      <tr>
							      	<td>사유</td>
							        <td>
								         <p id="updateHalfP" class="noticeP">* 반차의 경우 사유에 오전/오후 입력</p>
								      	 <input type="text" required id="updateOffContent" class="form-control" name="offContent" value="" required/>
					   					 <form:errors path="offContent" element="span" cssClass="error"/>
							      	</td>
							    </tr>
						    </tbody>
						  </table>
					  </form>
				<!-- 휴가 등록 form 끝 -->
				</div>
	      </div>
	      
	      <div class="modal-footer">
	        <input type="button" class="btn btn-dark" value="수정" id="updateBtn">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
      	</div>
    </div>
 </div>
<!-- 모달 끝 -->

<script>

	//== 공통 ========================================================================================
	
	//페이지 이동
	function pageLinkMove(event){
		event.preventDefault();
		let page = $(event.target).data("page");
		searchForm.find("[name='page']").val(page);
		searchForm.submit();
		return false;
	}
	
	//검색 Form submit
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
	
	//모달 닫으면 값 초기화 
	$('.modal').on('hidden.bs.modal', function (e) {
		  $(this).find('form')[0].reset();
		  
		  $("#insertOffStart").val(today);
			$("#insertOffEnd").val(today);
	});
	
	//각 form들 정의
	let insertForm =  $("#insertForm");
	let updateForm =  $("#updateForm");
	
	//validation Check(tooltip)
	const validateOptions = {
        onsubmit:true
        ,onfocusout:function(element, event){
           return this.element(element);
        }
        ,errorPlacement: function(error, element) {
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
	
	insertForm.validate(validateOptions);
	updateForm.validate(validateOptions);
	
	//검색 시 초기화버튼 클릭하면 검색값 비워지게
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
	
	//오늘 날짜 'YYYY-MM-DD'형으로 변환하는 함수
	function getTimeStamp() {
	
	    var d = new Date();
	    var s =
	        leadingZeros(d.getFullYear(), 4) + '-' +
	        leadingZeros(d.getMonth() + 1, 2) + '-' +
	        leadingZeros(d.getDate(), 2);
	
	    return s;
	}
	
	function leadingZeros(n, digits) {
	    var zero = '';
	    n = n.toString();
	
	    if (n.length < digits) {
	        for (i = 0; i < digits - n.length; i++)
	            zero += '0';
	    }
	    return zero + n;
	}
	
	//'오늘' 의미하는 변수 정의
	let today = getTimeStamp();
	
	//== 휴가 등록, 수정 form 미리 setting ==================================================================
	let insertUse = $("#insertEmpUseOff");
	let insertExp = $("#insertEmpExpOff");
	let insertStart = $("#insertOffStart");
	let insertEnd = $("#insertOffEnd");
	let insertNow = $("#insertEmpNowOff");
		
	$(function(){
		$("#insertHalfP").hide();
		$("#insertUnpayP").hide();
		$("#updateHalfP").hide();
		$("#updateUnpayP").hide();
	})
	
	//== 휴가 등록 ========================================================================================

	//신청인 선택 시
	$("#insertEmpSel").change(function() {

		//선택한 신청인의 현재 휴가일수 체크
		$.ajax({
			url:"${cPath }/office/off/nowOffView.do"
			,data : {"memId" : $("#insertEmpSel").val()}
			,method : "post"
			,success : function(resp){
				if(resp.message){ //실패
					getNoty(resp);
					return;
				}else{ //성공
					//현재 휴가일수 값 입력
					insertNow.val(parseFloat(resp.nowOff)); 
				}
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
		
		//신청인 선택 시 휴가종류는 자동으로 0번째 경우로 재선택되게
		$("#insertOffSel option:eq(0)").prop("selected", true);
		
		//시작일, 종료일 오늘로 setting
		insertStart.val(today);
		insertEnd.val(today);
		insertUse.val("");
		insertExp.val("");
	});
	
	//휴가종류 선택 시 
	$("#insertOffSel").change(function() {
		
		if($("#insertEmpSel").val()==""){
			getErrorNotyDefault("휴가 신청인을 선택해 주세요.");	
			$("#insertOffSel option:eq(0)").prop("selected", true);
			return;
		}
		
		if($("#insertOffSel").val()=="HALFOFF"){
			$("#insertHalfP").show();
			$("#insertUnpayP").hide();
			insertUse.val("0.5");
			insertEnd.attr("readonly", true);
			insertExp.val(parseFloat(insertNow.val())-parseFloat(insertUse.val()));
		}else{
			$("#insertUnpayP").show();
			$("#insertHalfP").hide();
			insertUse.val("");
			insertEnd.attr("readonly", false);
			insertExp.val("");
			
			if($("#insertOffSel").val()=="UNPAYOFF"){
				insertExp.val(insertNow.val());
				insertUse.val(0);
			}
			
			
		}
	});
	
	//휴가시작일 선택 시 
	insertStart.change(function() {
		//신청인이 선택되지 않았을 경우 return		
		if($("#insertEmpSel").val()==""||$("#insertOffSel").val()==""){
			getErrorNotyDefault("휴가 신청인 및 종류를 선택해 주세요.");	
			$(this).val("");
			return;
		}

		//시작일이 현재 날짜보다 이전일 경우 return
		if($(this).val()<today){
			getErrorNotyDefault("시작일은 현재 날짜보다 이전일 수 없습니다.");	
			insertStart.val(today);
			return;
		}
		
		//반차 사용 시 종료일은 시작일과 같아야 함. 종료일 변경 불가
		if($("#insertOffSel").val()=="HALFOFF"){
			//종료일 변경 불가
			insertEnd.attr("readonly", true);
			//종료일 = 시작일
			insertEnd.val(insertStart.val());
			insertExp.val(parseFloat(insertNow.val())-parseFloat(insertUse.val()));
		}else{
			insertEnd.val(insertStart.val());
			insertEnd.attr("readonly", false);
		}
	});
	
	//휴가종료일 선택시
	insertEnd.change(function() {
		//신청인이 선택되지 않았을 경우 return	
		if($("#insertEmpSel").val()==""){
			getErrorNotyDefault("휴가 신청인을 선택해 주세요.");	
			$(this).val("");
			return;
		}
		
		//종료일이 시작일보다 이전일 경우 return
		if($(this).val()<insertStart.val()){
			getErrorNotyDefault("종료일은 시작일보다 이전일 수 없습니다.");	
			insertEnd.val(insertStart.val());
			return;
		}
		
		let start = document.getElementById("insertOffStart").value;
	    let end = document.getElementById("insertOffEnd").value;
	    
	    let arr1 = start.split('-');
	    let arr2 = end.split('-');
	    
	    let date1 = new Date(arr1[0], arr1[1], arr1[2]);
	    let date2 = new Date(arr2[0], arr2[1], arr2[2]);
	    
	    let sub = date2 - date1;
	    let day = 24 * 60 * 60 * 1000;
	    
	    //무급휴가, 연차 사용 시 
	    if($("#insertOffSel").val()!="HALFOFF"){
		    if(start && end){
		       document.getElementById("insertEmpUseOff").value = parseInt(sub/day+1)
		    }
		    
		    //연차 사용 시 
		    if($("#insertOffSel").val()=="YEAROFF"){
		    	insertExp.val(parseFloat(insertNow.val())-parseFloat(insertUse.val()));
			//무급휴가 사용 시 
		    }else{
				insertExp.val(insertNow.val());
				insertUse.val(0);
			}
	    }
	});
	
	//등록 버튼 클릭 
	$("#insertBtn").on("click", function(){
		if($("#insertEmpExpOff").val()<0){
			getErrorNotyDefault("잔여휴가일이 없습니다. 다시 선택해 주세요.");	
			return;
		}
		
		insertUse.val(String(insertUse.val()));
		insertExp.val(String(insertExp.val()));
		
		insertForm.submit();
	});
	
	//== 휴가 수정 ========================================================================================
	function updateCntCal(){
		let start = document.getElementById("updateOffStart").value;
	    let end = document.getElementById("updateOffEnd").value;
	    
	    let arr1 = start.split('-');
	    let arr2 = end.split('-');
	    
	    let date1 = new Date(arr1[0], arr1[1], arr1[2]);
	    let date2 = new Date(arr2[0], arr2[1], arr2[2]);
	    
	    let sub = date2 - date1;
	    let day = 24 * 60 * 60 * 1000;	
			
	    if(start && end){
		       document.getElementById("updateEmpUseOff").value = parseInt(sub/day+1)
		}
	    
	    updateExp.val(parseFloat(updateNow.val())-parseFloat(updateUse.val()));
	}
	    	
	let updateUse = $("#updateEmpUseOff");
	let updateOri = $("#updateOriOff");
	let updatePlus = $("#updatePlusOff");
	let updateExp = $("#updateEmpExpOff");
	let updateStart = $("#updateOffStart");
	let updateEnd = $("#updateOffEnd");
	let updateNow = $("#updateEmpNowOff");
	let updateNo = $("#updateOffNo");
	let updateCont = $("#updateOffContent");
	//각 행 더블클릭하면 수정 모달 출력
	let updateBody = $("#updateBody");
	updateBody.on("dblclick", "tr", function() {
		let offNo = this.dataset.offNo;
		
		$.ajax({
			url:"${cPath }/office/off/offView.do"
			,data : { "offNo": offNo }
			,success : function(resp){
				updateNo.val(resp.off.offNo);
				$("#updateEmpSel").val(resp.off.employee.memId);
				$("#updateOffSel").val(resp.off.offCode);
				updatePlus.val(resp.off.offUse);
				updateUse.val(resp.off.offUse);
				updateNow.val(parseFloat(resp.off.offRemain)+parseFloat(resp.off.offUse))
				updateExp.val(resp.off.offRemain);
				updateStart.val(resp.off.offStart);
				updateEnd.val(resp.off.offEnd);
				updateCont.val(resp.off.offContent);
				//선택한 신청인의 현재 휴가일수 체크
				$("#updateEmpSel").attr("disabled", false);
				$.ajax({
					url:"${cPath }/office/off/nowOffView.do"
					,data : {"memId" : $("#updateEmpSel").val()}
					,method : "post"
					,success : function(resp){
						if(resp.message){ //실패
							getNoty(resp);
							return;
						}else{ //성공
							//보유한 휴가일수 값 입력
							updateOri.val(parseFloat(resp.nowOff)); 
						}
					},error:function(xhr){
						console.log(xhr.status);
					}
				});
				
				$("#offUpdateModal").modal();
				$("#updateEmpSel").attr("disabled", true);
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
	});
	
	//휴가종류 선택 시 
	$("#updateOffSel").change(function() {
		
		if($("#updateOffSel").val()=="HALFOFF"){
			$("#updateHalfP").show();
			$("#updateUnpayP").hide();
			updateUse.val("0.5");
			updateEnd.attr("readonly", true);
			updateExp.val(parseFloat(updateNow.val())-parseFloat(updateUse.val()));
		}else{
			$("#updateUnpayP").show();
			$("#updateHalfP").hide();
			updateUse.val("");
			updateEnd.attr("readonly", false);
			updateExp.val("");
			
			if($("#updateOffSel").val()=="YEAROFF"){
		    	updateCntCal();
			}else{
				updateExp.val(updateNow.val());
				updateUse.val(0);
			}
		}
	});
	
	//휴가시작일 선택 시 
	updateStart.change(function() {

		//시작일이 현재 날짜보다 이전일 경우 return
		if($(this).val()<today){
			getErrorNotyDefault("시작일은 현재 날짜보다 이전일 수 없습니다.");	
			updateStart.val(today);
			return;
		}
		
		//반차 사용 시 종료일은 시작일과 같아야 함. 종료일 변경 불가
		if($("#updateOffSel").val()=="HALFOFF"){
			//종료일 변경 불가
			updateEnd.attr("readonly", true);
			//종료일 = 시작일
			updateEnd.val(updateStart.val());
			updateExp.val(parseFloat(updateNow.val())-parseFloat(updateUse.val()));
		}else{
			updateEnd.val(updateStart.val());
			updateEnd.attr("readonly", false);
			if($("#updateOffSel").val()=="YEAROFF"){
		    	updateCntCal();
			}
			
		}
	});
	
	//휴가종료일 선택시
	updateEnd.change(function() {

		//종료일이 시작일보다 이전일 경우 return
		if($(this).val()<updateStart.val()){
			getErrorNotyDefault("종료일은 시작일보다 이전일 수 없습니다.");	
			updateEnd.val(updateStart.val());
			return;
		}
		
	    //무급휴가, 연차 사용 시 
	    if($("#updateOffSel").val()!="HALFOFF"){
		  
		    //연차 사용 시 
		    if($("#updateOffSel").val()=="YEAROFF"){
		    	updateCntCal();
			//무급휴가 사용 시 
		    }else{
		    	updateExp.val(parseFloat(updateNow.val()));
			}
		    
	    }
	});
	
	$("#updateBtn").on("click", function(){
		if($("#insertEmpExpOff").val()<0){
			getErrorNotyDefault("잔여휴가일이 없습니다. 다시 선택해 주세요.");	
			return;
		}
		
		let updateForm = $("#updateForm");
		$("#updateEmpSel").attr("disabled", false);

		$.ajax({
			url:"${cPath }/office/off/offUpdate.do"
			,data : updateForm.serialize()
			,method : "post"
			,success : function(resp){
				if(resp.message){
					getNoty(resp);
					return;
				}
				$('#updateModal').modal("hide");
				$("#updateEmpSel").attr("disabled", true);
				location.reload();
			},error:function(xhr){
				console.log(xhr.status);
			}
		});
		
		
	});
	
	//== 휴가 삭제 ========================================================================================
	
	$(":input[name=deleteBtn]").on("click", function(){
		let comfirmChk = confirm("삭제하시겠습니까?");
		let offNo = this.closest("tr").dataset.offNo;
		if(comfirmChk){
			$.ajax({
				url:"${cPath }/office/off/offDelete.do"
				,data : {"offNo" : offNo}
				,method : "post"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						return;
					}else{
						alert("삭제되었습니다.");
						location.reload();
					}
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}else{
			return;
		}
	});
</script>
