<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<c:set var="pagingVO" value="${paginationInfo.pagingVO }" />
<security:authentication property="principal" var="principal" />
<c:set var="authMember" value="${principal.realMember }" />
    
<style>
	#draftDiv{
		height: 72em;
		width: 55em;
	}
	
	span{
		color: white;
	}
	
	.badge{
		font-size: 16px;
	}
	
	.statusDiv{
		font-size: 18px;
	}
	
	.btn{
		margin: 5px;
		width: 100px;
		height:40px;
		line-height: 20px;
	}
	
	#stampImg{
		width: 50px;
		height: 50px;
	}
	
	.butDiv{
		width: 67em;
	}
	
	.reddot{
		font-size: 14px;
	}
	
	.downP{
		color:black;
	}
	
	.title{
		text-align: center;
		background-color: #D3D3D3;
	}
</style>
<br>
<div class="container butDiv">
	<div class="float-right btnDiv container mr-5 mb-1">
		<c:if test="${flag eq 'sending' }">
			<form id="goSendingForm" action="${cPath }/office/approval/sendingList.do" method="GET">
			    <input type="submit" value="목록" class="btn alert-secondary float-right" id="goSendingBtn" />
			    <input type="hidden" class="form-control" name="page" value="${param.page }"/>
			    <input type="hidden" name="searchStart" value="${param.searchStart }" />
				<input type="hidden" name="searchEnd" value="${param.searchEnd }" />
				<input type="hidden" name="taskCode" value="${param.taskCode }" />
				<input type="hidden" name="draftTitle" value="${param.draftTitle }" />
				<input type="hidden" name="draftContent" value="${param.draftContent }" />
			</form>
		</c:if>
		<c:if test="${flag eq 'reception' }">
		    <form id="goReceptionForm" action="${cPath }/office/approval/receptionList.do" method="GET">
			    <input type="submit" value="목록" class="btn alert-secondary float-right" id="goReceptionBtn" />
			    <input type="hidden" class="form-control" name="page" value="${param.page }"/>
			    <input type="hidden" name="searchStart" value="${param.searchStart }" />
				<input type="hidden" name="searchEnd" value="${param.searchEnd }" />
				<input type="hidden" name="taskCode" value="${param.taskCode }" />
				<input type="hidden" name="draftTitle" value="${param.draftTitle }" />
				<input type="hidden" name="draftContent" value="${param.draftContent }" />
			</form>
		</c:if>
		<c:if test="${flag eq 'whole' }">
		     <form id="goWholeForm" action="${cPath }/office/approval/wholeApprovalList.do" method="GET">
			    <input type="submit" value="목록" class="btn alert-secondary float-right" id="goWholeBtn" />
			    <input type="hidden" class="form-control" name="page" value="${param.page }"/>
			    <input type="hidden" name="searchStart" value="${param.searchStart }" />
				<input type="hidden" name="searchEnd" value="${param.searchEnd }" />
				<input type="hidden" name="taskCode" value="${param.taskCode }" />
				<input type="hidden" name="draftTitle" value="${param.draftTitle }" />
				<input type="hidden" name="draftContent" value="${param.draftContent }" />
			</form>
		</c:if>
	    <c:if test="${((draft.approval.appStatus eq '대기중') or (draft.approval.appStatus eq '결재중')) and (draft.draftWriter eq authMember.memId)}">
		    <button class="btn alert-secondary float-right" id="draftCancelBtn">기안취소</button> 
	    </c:if>
	     <c:if test="${((draft.approval.appStatus eq '기안취소')or(draft.approval.appStatus eq '반려')) and (draft.draftWriter eq authMember.memId)}">
	    	<c:if test="${draft.approval.appStatus eq '기안취소' }">
	   			 <button class="btn alert-secondary float-right" id="deleteBtn">삭제</button>
	   	    </c:if> 
	    <form id="updateForm" action="${cPath }/office/approval/draftUpdate.do" method="get">
		    <input type="button" class="btn alert-secondary float-right" id="updateBtn" value="재기안">
		    <input type="hidden" name="draftId" value="${draft.draftId}">
	    </form>
	    </c:if>
	    <c:if test="${draft.approval.appNowemp eq authMember.memId}">
		    <button class="btn alert-secondary float-right" id="approvalBtn">승인</button>
		    <button class="btn alert-secondary float-right" id="rejectBtn">반려</button>
	    </c:if>
	</div>
</div>
<div class="container">
	<div class="card container" id="draftDiv" style="border: 5px solid lightgray;">
		<div>
			<div class="float-left statusDiv">
			    <p class="float-left mt-2">결재상태 : <span class="badge bg-dark ">${draft.approval.appStatus }</span></p>
			</div>
			
		</div>
		  <div class="card-img-top">
				  <div class="container">
					  <div class=" d-flex justify-content-center mb-3 align-middle col-sm-12" style='height:1.5em;'>
					  			 <p class="ml-3" style="font-size:20pt;float:left;"><img alt="draftimage" src="${pageContext.request.contextPath}/images/draftimage.png"
					  			style="width:40px;height:30px;">${apart.aptName } 관리사무소</p>  
					  </div>
				</div>  	
		  </div>
		  <hr>
		  <div class="card-body">
			 <form>
				 <table class="table table-bordered table-sm">
					  <tr>
					    <td width="20%" class="title">기안문서번호</td>
					    <td width="10%">${draft.draftId }</td>
					    <td width="15%" class="title">단위업무</td>
					    <td width="15%">${draft.taskCode}</td>
					    <td width="15%" class="title">기안일자</td>
					    <td width="25%">${draft.draftDate }</td>
					  </tr>
					  <tr>
					    <td class="title">제목</td>
					    <td colspan='6'>${draft.draftTitle}</td>
					  </tr>
					  <tr>
					  	<td class="title">지출계좌</td>
					  	<td colspan='6'>
						  	<c:if test="${not empty draft.draftAcct}">
							  	${draft.draftAcct}
						  	</c:if>
						  	<c:if test="${empty draft.draftAcct}">
							  	
						  	</c:if>
					  	</td>
					  </tr>
				</table>
				  <div>
					  <div class="mt-2" style="height:33em;overflow: auto">
					  	${draft.draftContent}
					  </div>
					  	<div class="d-flex align-items-end col-sm-12">
	<!-- 					  	<p>붙임 민원 처리사항 1부.  끝.</p> -->
					  </div>
				  </div>
				  <div>
	<!-- 			  	<p style="font-size:25pt; text-align:center;">관리사무소장</p>   -->
				  </div>
				  <table class="table table-borderless">
				  	<tr>
						<td width="20%">* 첨부파일 :</td>
						<td width="80%" colspan="3" class="text-left">
							<c:if test="${not empty draft.draftAttList }">
								<c:forEach items="${draft.draftAttList }" var="attach" varStatus="vs">
									<c:url value="/draftAttDown.do" var="downloadURL">
										<c:param name="attSn" value="${attach.attSn }" />
										<c:param name="draftId" value="${draft.draftId }" />
									</c:url>
									<a href="${downloadURL }">
										<span class="downP" title="다운로드:">${attach.attFilename }</span>
										${not vs.last?"|":"" }
									</a>
								</c:forEach>		
							</c:if>
							<c:if test="${empty draft.draftAttList }">
							없음
							</c:if>
						</td>
					</tr>
					</table>
					<hr>
					<table class="table table-borderless text-center">
					  <tr>
					    <td width=10%><h4><span class="badge bg-dark ">기안</span></h4></td>
					    <td width=10%>${draft.memId}</td>
					    <c:forEach items="${ldList }" var="ld" varStatus="vs">
					    	<c:if test="${not empty ld.memId }">
					    			<td width=10%><h4><span class="badge ${ld.appCode eq '검토' ? 'bg-primary' : 'bg-success' }">${ld.appCode }</span></h4></td>
					    		<td width=10%>${ld.memId }</td>
					    	</c:if>
					    </c:forEach>
					  </tr>
					  <tr height=140px;>
					  	<td colspan="2"></td>
					     <c:forEach items="${ldList }" var="ld" varStatus="vs">
					    	<c:if test="${not empty ld.memId }">
					    		<c:if test="${ld.applinedeId < draft.approval.applinedeId}">
								    <td colspan='2'>
								    	<img id="stampImg" alt="stamp" src="${cPath }/images/stamp.png">
								    	승인
								    </td>
					    		</c:if>
					    	</c:if>
					    </c:forEach>
					    <td colspan="2"><c:if test="${not empty draft.approval.appDate }">
					    	<img id="stampImg" alt="stamp" src="${cPath }/images/stamp.png">
					    	승인
					    	<p class="reddot mt-2" >최종 결재일시 : <br>${draft.approval.appDate }</p>
				    	</c:if></td>
					  </tr>
				  </table>
				 <table class="table table-borderless">	  
					  <tr>
					  	<td colspan='2'>시행 : 우 ${apart.aptZip} ${apart.aptAdd1} ${apart.aptAdd2} </td>
					  	<td colspan='2'> 전화번호 : ${apart.aptTel}  </td>
					  	<td colspan='2'> 대표자 : ${apart.aptHead}</td>
					  </tr>
				</table>
				  
			  	
			</form>
		  </div>
	</div>
</div>

<script>
	//결재자 승인 버튼 클릭
	$("#approvalBtn").on("click", function(){
		confirmChk = confirm("승인하시겠습니까?");
		
		if(confirmChk){
			let draftId = '<c:out value="${draft.draftId }"/>';
			
			$.ajax({
				url:"${cPath }/office/approval/approvalSuccess.do"
				,data : {"draftId" : draftId}
				,method : "post"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						
						return;
					}
					alert("승인되었습니다.");
					location.reload();
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}
	});
	
	
	//반려버튼 클릭
	$("#rejectBtn").on("click", function(){
		confirmChk = confirm("반려하시겠습니까?");
		
		if(confirmChk){
			let draftId = '<c:out value="${draft.draftId }"/>';
			
			$.ajax({
				url:"${cPath }/office/approval/approvalReject.do"
				,data : {"draftId" : draftId}
				,method : "post"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						
						return;
					}
					alert("반려되었습니다.");
					location.reload();
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}
	});
	
	//재기안버튼 클릭
	$("#updateBtn").on("click", function(){
		confirmChk = confirm("재기안하시겠습니까?");
		if(confirmChk){
			$("#updateForm").submit();
		}else{
			return;
		}
	});
	
	
	//기안취소버튼 클릭
	$("#draftCancelBtn").on("click", function(){
		confirmChk = confirm("기안취소하시겠습니까?");
		
		if(confirmChk){
			let draftId = '<c:out value="${draft.draftId }"/>';
			
			$.ajax({
				url:"${cPath }/office/approval/draftCancel.do"
				,data : {"draftId" : draftId}
				,method : "post"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						
						return;
					}
					alert("기안취소 처리되었습니다.");
					location.reload();
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}
		
	});
	//삭제버튼 클릭
	$("#deleteBtn").on("click", function(){
		confirmChk = confirm("삭제하시겠습니까?");
		
		if(confirmChk){
			let draftId = '<c:out value="${draft.draftId }"/>';
			
			$.ajax({
				url:"${cPath }/office/approval/draftDelete.do"
				,data : {"draftId" : draftId}
				,method : "post"
				,success : function(resp){
					if(resp.message){
						getNoty(resp);
						
						return;
					}
					alert("삭제되었습니다.");
					location.href = "${cPath }/office/approval/sendingList.do";
				},error:function(xhr){
					console.log(xhr.status);
				}
			});
		}
	});

</script>