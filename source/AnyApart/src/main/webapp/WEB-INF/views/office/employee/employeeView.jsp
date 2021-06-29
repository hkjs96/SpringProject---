<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 2.      이미정      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
	.card {
	  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	  max-width: 850px;
	  height: 1250px;
	  margin: auto;
	  font-family: arial;
	}
	
	.title {
	  color: grey;
	  font-size: 18px;
	  background-color: #f1f3f4;
	}
	
	.menuBtn {
	  border: none;
	  outline: 0;
	  display: inline-block;
	  padding: 8px;
	  color: white;
	  background-color: #000;
	  text-align: center;
	  cursor: pointer;
	  width: 20%;
	  font-size: 18px;
	  margin-top:30px;
	}
	
	a {
	  text-decoration: none;
	  font-size: 22px;
	  color: black;
	}
	
	button:hover, a:hover {
	  opacity: 0.7;
	}
	
	#heading{
		margin-top:20px;
		font-size:25px;
	}
	
	#noticeSpan, #noImgNotice{
		color: blue;
		margin-bottom:10px;
	}
	
	#noImgNotice{
		background-color: #ebeef9;
	}
	
	#listViewDiv{
		margin-left: 50em;
	}
	
	.table{
		font-size: 16px;
		margin-left:10em;
	}
	
	.menuBtn{
		margin-left: 10em;
	}
</style>

<div class="card mt-4">
<div class="d-flex justify-content-end mr-3 mt-3">

	<!-- 리스트 조회 시 상태유지 위해 값 넘김 (직원조회)---------------------------------------------------------------->
	<c:if test="${empty changeFlag }">
	<form id="infoListForm" action="${cPath }/office/employee/employeeList.do" method="GET">
			<input type="hidden" name="page" value="${param.page }"/>
	<%-- 		<input type="hidden" name="memId" value="${pagingVO.searchDetail.memId }"/> --%>
			<input type="hidden" name="positionCode" value="${pagingVO.searchDetail.positionCode }"/>
			<input type="hidden" name="empName" value="${pagingVO.searchDetail.empName }"/>
			<input type="submit" value="목록" class="btn btn-dark">
		</form>
	</c:if> 
	
	<!-- 리스트 조회 시 상태유지 위해 값 넘김 (입퇴사자 조회)----------------------------------------------------------------------->
	<c:if test="${not empty changeFlag }">
		<form id="changeListForm" action="${cPath }/office/employee/employeeChangeList.do" method="GET">
			<input type="hidden" name="page" value="${param.page }"/>
			<input type="hidden" name="empRetire" value="${pagingVO.searchDetail.empRetire }" />
			<input type="hidden" name="empName" value="${pagingVO.searchDetail.empName }" />
			<input type="hidden" name="searchStartS" value="${pagingVO.searchDetail.searchStartS }" />
			<input type="hidden" name="searchStartE" value="${pagingVO.searchDetail.searchStartE }" />
			<input type="hidden" name="searchEndS" value="${pagingVO.searchDetail.searchEndS }" />
			<input type="hidden" name="searchEndE" value="${pagingVO.searchDetail.searchEndE }" />
			<input type="submit" value="목록" class="btn btn-warning d-flex">
		</form>
	</c:if>
</div>
  <p class="mt-3 text-center" id="heading">${employee.empName }님의 정보</p>
  <div id="d-flex justify-content-center" class="mb-4">
	  <p class="title mb-4 text-center">사용자코드 : ${employee.memId } &nbsp;&nbsp;/&nbsp;&nbsp;아파트코드 : ${employee.aptCode }</p>
  </div>
  	<div id="empImgDiv" class="d-flex justify-content-center mb-4">
		<c:if test="${not empty employee.empImg }">
<%-- 			<img style="width: 200px; height: 200px;" src="${cPath }/images/noImage.png" /> --%>
			<img style="width: 150px; height: 200px;" src="${cPath }/saveFiles/${employee.empImg}" />
		</c:if>
		<c:if test="${empty employee.empImg }">
			<div>
				<img id="proImg" style="width: 200px; height: 200px;" src="${cPath }/images/noImage.png" />
			</div>
		</c:if>
  	</div> 
 	<c:if test="${empty employee.empImg }">
		<p id="noImgNotice" class="text-center">프로필 사진이 없습니다. 사진을 등록해주세요.</p>
	</c:if>
	<table class="table table-borderless ">
		  <COLGROUP>
			  <COL width="80px"/>
			  <COL width="120px"/>
		  </COLGROUP>
		<tr>
			<th>◈ 사원명</th>
			<td>${employee.empName }</td>
		</tr>
		<tr>
			<th>◈ 이메일</th>
			<td>${employee.empMail }</td>
		</tr>
		<tr>
			<th>◈ 핸드폰번호</th>
			<td>${employee.empHp }</td>
		</tr>
		<tr>
			<th>◈ 우편번호</th>
			<td>${employee.empZip }</td>
		</tr>
		<tr>
			<th>◈ 주소</th>
			<td>${employee.empAdd1 } ${employee.empAdd2 }</td>
		</tr>
		<tr>
			<th>◈ 직책</th>
			<td>${employee.position.positionName }</td>
		</tr>
		<tr>
			<th>◈ 생년월일</th>
			<td>${employee.empBirth }</td>
		</tr>
		<tr>
			<th>◈ 자택번호</th>
			<td>${employee.empTel } </td>
		</tr>
		<tr>
			<th>◈ 입사일</th>
			<td>${employee.empStart }</td>
		</tr>
		<tr>
			<th>◈ 퇴사일</th>
			<td>
				 <c:if test="${not empty employee.empEnd }">
		 		 	 ${employee.empEnd }
		 		  </c:if>
		 		  <c:if test="${empty employee.empEnd }">
		 		 	 -
		 		  </c:if>
			</td>
		</tr>
		<tr>
			<th>◈ 휴가일수</th>
			<td>${employee.empOff }일</td>
		</tr>
		<tr>
			<th>◈ 자격증</th>
			<c:if test="${empty employee.licenseList }">
		 	  <td>
			 	   <p>등록된 자격증 정보 없음</p>
		 	  </td>
		 	</c:if>
		 	<c:if test="${not empty employee.licenseList }">
			<td class="form-inline">
				
				<div>
				<c:forEach items="${employee.licenseList }" var="licemployee" varStatus="vs">
					<input type="button" class="alert alert-warning mr-3 viewImage" value="${licemployee.licName }" 
						data-memid="${licemployee.memId }" 
						data-code="${licemployee.licCode }" 
						data-name="${licemployee.licName }"
						data-date="${licemployee.licDate }"
					/>
				</c:forEach>
				</div>
			</td>
		<tr>
		<td></td>
		<td><span id="noticeSpan">* 자격증명을 클릭하면 사본을 확인할 수 있습니다.</span></td>
		</tr>
			</c:if>
		</tr>
		<tr>
			<td colspan="2">
			<c:if test="${ empty changeFlag }">
				<input type="button" value="수정" class="btn btn-dark menuBtn" id="updateBtn" />
			</c:if>
			<c:if test="${ not empty changeFlag }">
				<c:if test="${empty employee.empEnd }">
					<input type="button" value="퇴직처리"  class="btn btn-dark menuBtn" id="retireBtn" data-toggle="modal" data-target="#retireModal"/>
				</c:if>
				<c:if test="${not empty employee.empEnd }">
					<input type="button" value="퇴직처리 취소"  class="btn btn-dark menuBtn" id="retireCancelBtn"/>
				</c:if>
			</c:if>	
			<input type="button" value="삭제"  class="btn btn-dark menuBtn " id="deleteBtn"/>
			</td>
		</tr>
	 </table>
</div>

<!-- 자격증 조회 모달   ---------------------------------------------------------------->
<div class="modal fade" id="imageViewModal" tabindex="-1" role="dialog" aria-labelledby="imageViewModalTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="imageViewModalTitle">자격증 사본</h5>
        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 서버 ------------------------------------------------------------------------->
<c:url value="/office/employee/employeeUpdate.do" var="updateURL"/>
<c:url value="/office/employee/employeeDelete.do" var="deleteURL"/>
<form method="get" id="commonForm" data-update="${updateURL }" data-delete="${deleteURL }">
	<input type="hidden" name="memId" value="${employee.memId }" />
	<input type="hidden" name="empEnd" id="empEnd" value="" />
	<c:if test="${not empty changeFlag }">
		<input type="hidden" name="empRetire" value="${pagingVO.searchDetail.empRetire }" />
		<input type="hidden" name="empName" value="${pagingVO.searchDetail.empName }" />
		<input type="hidden" name="searchStartS" value="${pagingVO.searchDetail.searchStartS }" />
		<input type="hidden" name="searchStartE" value="${pagingVO.searchDetail.searchStartE }" />
		<input type="hidden" name="searchEndS" value="${pagingVO.searchDetail.searchEndS }" />
		<input type="hidden" name="searchEndE" value="${pagingVO.searchDetail.searchEndE }" />
		<input type="hidden" name="changeFlag" value="Y" />
	</c:if>
</form>


<!-- 퇴사일 처리 모달 ---------------------------------------------------------------->
<div class="modal fade" id="retireModal" tabindex="-1" role="dialog" aria-labelledby="retireModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <p class="modal-title" id="retireModalLabel">- 퇴사일 등록</p>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form method="get" id="retireForm">
      <div class="modal-body">
        <p>퇴사일 입력</p>
        <input type="date" class="form-control" name="empEndInput" id="empEndInput">
      </div>
      </form>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="$('#deleteBtn').trigger('click');">저장</button>
      </div>
    </div>
  </div>
</div>
<!-- 퇴사일 처리 모달 끝 -------------------------------------------------------------->


<script type="text/javascript">

	$(function(){
		$("#deleteBtn").hide();
		
		let commonForm = $("#commonForm");
		
		// 직원정보 수정 및 퇴직처리 (update-정보수정, delete-퇴직처리)
		$("#updateBtn,#deleteBtn").on("click", function(){
			//퇴사일 없으면 퇴직처리
			let empInputval = $("#empEndInput").val();
			$("#empEnd").val(empInputval);
			
			let flag = null;
			let action = null;
			
			//퇴직처리
			if($(this).prop("id")=="deleteBtn"){
				action = commonForm.data("delete");
				flag = confirm("퇴직처리하시겠습니까?");
				
				if(flag){
					commonForm.attr("action", action);
					$.ajax({
						url:"${cPath }/office/employee/employeeDelete.do"
						,data : commonForm.serialize()
						,method : "post"
						,success : function(resp){
							if(resp.message==null){
								alert("퇴직처리되었습니다.");
								location.reload();
							}else{
								getNoty(resp);
								return;
							}
						},error:function(xhr){
							console.log(xhr.status);
						}
					});		
				}
			//직원 정보 수정
			}else{
				flag = true;
				action = commonForm.data("update");
				
				if(flag){
					commonForm.attr("action", action);
					commonForm.submit();
				}
			}
		});
		
		// 자격증 사본 이미지 조회
		$(".viewImage").on("click", function(){
			var memId = "<c:out value='${employee.memId}'/>"; 
			var licCode = $(this).data("code");
			var licName = $(this).data("name");
			modalTag.find("#imageViewModalTitle").html(
				licName
			);
			
			$.ajax({
				url:"${cPath }/office/employee/licenseImage.do"
				,data : {"memId" : memId, "licCode" : licCode}
				,method : "get"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
					}else{
						modalTag.find(".modal-body").html(
							$("<img>").attr({
									src:"${cPath }/saveFiles/"+resp.license.licImg
									, style:"width:300px;height:200px;"		
								})	
						);
					}
				},
				error:function(xhr){
					console.log(xhr.status);
				}
			});
			
			
			modalTag.modal("show");
		});	
		
		// 자격증 사본 이미지 모달 hide 이벤트 처리
		var modalTag = $("#imageViewModal").on("hiden.bs.modal", function(){
			$(this).find(".modal-body").empty();
		});
		
	});
	
	//퇴직처리 취소
	$("#retireCancelBtn").on("click", function(){
		
		let confirmChk = confirm("재직 상태로 복구하시겠습니까?");
		
		if(confirmChk){
			$.ajax({
				url:"${cPath }/office/employee/employeeDeleteCancel.do"
				,data : {"memId":"${employee.memId}"}
				,method : "get"
				,success : function(resp){
					if(resp.message==null){ //성공
						alert("재직 상태로 변경되었습니다.");
						location.reload();
					}else{ //실패
						getNoty(resp);
						return;
					}
				},error:function(xhr){
					console.log(xhr.status);
				}
			});			
		}
	});
</script>





