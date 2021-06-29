<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 2.      박지수      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<style>
	.tableScroll {
		overflow-y: auto;
		max-height: 500px;
	}
	.tableScroll thead th{
		position: -webkit-sticky;
		position: sticky;
		top: 0;
	}
</style>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<div class="inner">
	    <div class="board-list">
			<div align="right">
				<input type="button" value="돌아가기" class="btn btn-dark" onclick="location.href='${cPath }/vendor/apartView.do?aptCode=${aptCode }';"/>	
			</div>
	    	<form id="houseForm" action="${cPath }/vendor/houseInsert.do" method="post">
	    		<input type="hidden" id="houseCode" name="houseCode" class="form-control"/>
	    		<input type="hidden" id="aptCode" name="aptCode" class="form-control" value="${aptCode }"/>
				<table class="table table-hover table-bordered">
					<tr>
						<th><label for="dong">동</label></th>
						<td>
							<input type="text" id="dong" name="dong" maxlength="4" class="form-control" />
	<!-- 						<form:errors path="aptName" element="span" cssClass="error" /> -->
						</td>
						<th><label for="ho">호</label></th>
						<td>
							<input type="text" id="ho" name="ho" maxlength="2" class="form-control" />
						</td>
						<th><label for="floor">층</label></th>
						<td>
							<input type="text" id="floor" name="floor" maxlength="2" class="form-control" />
						</td>
						<th><label for="area">면적</label></th>
						<td>
							<input type="text" id="houseArea" name="houseArea" maxlength="10" class="form-control" />
						</td>
						<td>
							<input type="button" id="createBtn" value="단지생성" class="btn btn-primary"/>	
						</td>
					</tr>
				</table>
			</form>
<!-- 			<input type="button" id="listBtn" value="조회하기" class="btn btn-dark"/>	 -->
		</div>
		<div class="board-list tableScroll" style="height: 800px;">
			<table class="table table-bordered">
				<thead class="thead-light">
					<tr>
						<th>동</th>
						<th>호</th>
						<th>면적</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody id="listBody">
<%-- 					<c:if test="${not empty houseList }"> --%>
<%-- 						<c:forEach var="house" items="${houseList }" > --%>
<!-- 							<tr> -->
<%-- 								<td>${house.dong}</td> --%>
<%-- 								<td>${house.ho}</td> --%>
<%-- 								<td>${house.houseArea}</td> --%>
<!-- 							</tr> -->
<%-- 						</c:forEach> --%>
<%-- 					</c:if> --%>
				</tbody>
			</table>
			<table id="exTable">
			
			</table>
		</div>
	</div>


<script>
	let deleteBtn;

	let aptCode = "${aptCode }";
	
	let listBtn = $("#listBtn");

	$("#listBtn").on("click", function(){
		
		// 아래 비동기 보내는 부분 함수나? 이런거로 만들어서 넣어 두기
		$.ajax({
			url: "${cPath}/vendor/houseList.do"
			, data : {
				aptCode : aptCode
			}		
			, dataType:"json"
			,success:ListFn
			,error:function(xhr){
				console.log(xhr);
			}
		});
	});

	let createBtn = $("#createBtn");
	let listBody = $("#listBody");
	let houseForm = $("#houseForm");
	let dong = $("input[name=dong]");
	let floor = $("#floor");
	let ho = $("#ho");
	let houseArea = $("#houseArea");

	let data;
	
	$("#createBtn").on("click", function(){
// 		dong = $("input[name=dong]").val();
// 		floor = $("#floor").val();
// 		ho = $("#ho").val();
// 		houseArea = $("#houseArea").val();
		
// 		let house = {
// 			aptCode : aptCode
// 			, dong : dong
// 			, floor : floor
// 			, ho : ho
// 			, houseArea : houseArea
// 		}
		data = $("#houseForm").serialize();
		console.log(data);
		
		$.ajax({
			url: "${cPath}/vendor/houseInsert.do"
			, method : "post"
			, data : data
			, dataType : "json"
			, success:ListFn
			, error:function(xhr){
				console.log(xhr);
			}	
		});
// 		ajaxForm
		
	});
	
	let ListFn = function(resp){
		let houseTrTags = [];
		$(resp.houseList).each(function(idx, house){
			houseTrTags.push(
				$("<tr>").append(
					$("<td>").text(house.dong)
					, $("<td>").text(house.ho)
					, $("<td>").text(house.houseArea+"㎡")
					, $("<td>").append($("<input>").attr({type : "button", name : "delete", value : "삭제" }).addClass("deleteBtn btn-danger btn"))
				).data("house", house)
			);
		});
		listBody.html(houseTrTags);	
// 		$('#exTable').DataTable( {
// 		    data: data
// 		} );
		deleteBtn = $("input[name=delete]");
	}
	
	
	
	
	listBody.on("click", ".deleteBtn", function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
			let tr = $(this).parent();
			deleteFn(tr);
		}else{
			return false;
		}
	});
	
	let deleteFn = function(trTag){
 		let houseCode = trTag.data("house").houseCode;
		$("#houseCode").val(houseCode);
		data = $("#houseForm").serialize();
		$.ajax({
			url : "${cPath }/vendor/houseDelete.do"
			, method : "post"
			, data : data
			, dataType : "json"
			, success : function(resp){
				ListFn;
				trTag.remove();	// 삭제 처리
			}
			, error:function(xhr){
				console.log(xhr);
			}	
		});
	}
 	
	
	/*-------------------------------------------------------------------------------*/
	
	
	$.ajax({
			url: "${cPath}/vendor/houseList.do"
			, data : {
				aptCode : aptCode
			}		
			, dataType:"json"
			,success:ListFn
			,error:function(xhr){
				console.log(xhr);
			}
		});
	
	
	
	
	
	
	
	
	
</script>