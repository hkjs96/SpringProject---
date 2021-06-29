<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<br>
<h2>
	<strong>계좌관리</strong>
</h2>
<br>
<div class="container">
	<div class="col-sm-6" style="border-style:outset;border-radius: 8px;margin-left:15em;">
	  <div class="row g-0">
		    <div>
	    	<form id="searchForm">
				<input type="hidden" name="page" />
				<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
				<input type="hidden" name="searchWord"  value="${pagingVO.searchVO.searchWord }"/>
			</form>
		    <form class="form-inline">
		      <div class="card-body inputUI">
		      		<div class="ml-3" style="float:left">
		      			 <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
					    style="width:30px;height:30px;">&nbsp;&nbsp;
			        	<select name="searchType" class="custom-select">
							<option value="acctCode" ${'acctCode' eq param.searchType?"selected":"" }>계좌명</option>
							<option value="bankCode"${'bankCode' eq param.searchType?"selected":"" }>은행명</option>
							</select> 
				       	<input type="text" name="searchWord" class="form-control col-sm-8" value="${pagingVO.searchVO.searchWord }">
		      		</div>
		      		<div class="ml-3" style="float:left">
					</div>
					    <div class="d-flex justify-content-end"><button class="btn btn-dark" id="searchBtn">검색</button></div>
					      	</div>
					    	</form>
					    </div>
				    </div>
				  </div>
				</div>    
<br>
<div align="right" class="mb-2 mr-5">
	<input type="button" class="btn btn-primary" role="alert" onclick="location.href='${cPath}/office/account/accountForm.do'" value="등록">
	<input type="button" class="btn btn-warning" role="alert" value="수정" onclick="cheakboxCK()">
	<input onclick="printBt()" type="button" class="btn btn-dark" role="alert" value="인쇄">
</div>
<div class="text-center col-sm-12" id="listDiv">
	<table class="table table-bordered" id ="checkboxTestTbl">
		<colgroup>
			<col width="50px">
		</colgroup>
		<thead class="thead-light">
			<tr>
				<th scope="col"><input type="checkbox"></th>
				<th scope="col">No.</th>
				<th scope="col">계좌명</th>
				<th scope="col">계좌번호</th>
				<th scope="col">은행명</th>
				<th scope="col">예금주</th>
				<th scope="col">사용목적</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<form:form>
		
		</form:form>
		<tbody>
			<c:set var="accountList" value="${pagingVO.dataList }"/>
              	<c:if test ="${empty accountList }">
              	<td colspan="8">등록된 계좌가 없습니다.</td>
              	</c:if>
              	<c:if test="${not empty accountList }">
              		<c:forEach items="${accountList }" var="account">
              		<tr id="trList" class="text-center">
              		<td><input type="checkbox" name="acctId" value="${account.acctId }"> </td>
              		<td>${account.acctrum } </td>
              		<td class="text-left">${account.acctCode } </td>
              		<td class="text-left">${account.acctNo } </td>
              		<td>${account.bankCode } </td>
              		<td>${account.acctUser } </td>
              		<td class="text-left">${account.acctComent } </td>
              		<td>${account.acctDate } </td>
              		</tr>
           			</c:forEach>
           		</c:if>
		</tbody>
		
	</table>

  <div id="pagingArea">
             <ui:pagination paginationInfo="${paginationInfo }" jsFunction="pageLinkMove" type="bsVendor"/>
   </div>
</div>
<div hidden="">
<div class="text-center col-sm-12" id="printDiv">
	<table class="table table-bordered">
	<colgroup>
			<col width="50px">
	</colgroup>
	<thead class="thead-dark">
			<tr>
				<th scope="col"><input type="checkbox"></th>
				<th scope="col">번호</th>
				<th scope="col">계좌명</th>
				<th scope="col">계좌번호</th>
				<th scope="col">은행명</th>
				<th scope="col">예금주</th>
				<th scope="col">사용목적</th>
				<th scope="col">등록일</th>
			</tr>
	</thead>
	<tbody id="selected">
	
	</tbody>
	</table>
</div>
</div>


<script type="text/javascript">

$(document).ready(function(){
    var tbl = $("#checkboxTestTbl");
    // 테이블 헤더에 있는 checkbox 클릭시
    $(":checkbox:first", tbl).click(function(){
        // 클릭한 체크박스가 체크상태인지 체크해제상태인지 판단
        if( $(this).is(":checked") ){
            $(":checkbox", tbl).attr("checked", "checked");
        }
        else{
            $(":checkbox", tbl).removeAttr("checked");
        }
        // 모든 체크박스에 change 이벤트 발생시키기               
        $(":checkbox", tbl).trigger("change");
    });
     
    // 헤더에 있는 체크박스외 다른 체크박스 클릭시
    $(":checkbox:not(:first)", tbl).click(function(){
        var allCnt = $(":checkbox:not(:first)", tbl).length;
        var checkedCnt = $(":checkbox:not(:first)", tbl).filter(":checked").length;
         
        // 전체 체크박스 갯수와 현재 체크된 체크박스 갯수를 비교해서 헤더에 있는 체크박스 체크할지 말지 판단
        if( allCnt==checkedCnt ){
            $(":checkbox:first", tbl).attr("checked", "checked");
        }
        else{
            $(":checkbox:first", tbl).removeAttr("checked");
        }
    }).change(function(){
        if( $(this).is(":checked") ){
            // 체크박스의 부모 > 부모 니까 tr 이 되고 tr 에 selected 라는 class 를 추가한다.
            var list = $(this).parent().parent();
           $("#selected").append("<tr>"+list.html()+"</tr>");
            console.log(list.html());
        }
        else{
           var removelist= $(this).parent().parent();
            $("#selected").empty("<tr>"+removelist.html()+"</tr>");
        }
    });
});


function printBt() {
// 	if($("input:checkbox[name=acctId]").is(":checked") == true) {
// 		document.getElementById("selected").innerHTML;
// 	}
	var initBody = document.body.innerHTML;
	window.onbeforeprint = function () {
		document.body.innerHTML = document.getElementById("printDiv").innerHTML;
		$("#pagingArea").hide();
		$("td:first-child").hide();
		$("th:first-child").hide();
	}
	window.onafterprint = function () {
		window.location.reload()
		
	}
	$("#pagingArea").show();
	window.print();
	}
	
function cheakboxCK(){
	if($("input:checkbox[name=acctId]:checked").length > 1 ){
		alert("수정할 목록 1개만 선택 해주세요")
	}else if($("input:checkbox[name=acctId]:checked").length==0 ){
		alert("수정할 목록을 선택 해주세요")
	}
	else{
		var acctNo = $("input:checkbox[name=acctId]:checked").val()
		location.href="${cPath}/office/account/accountUpdate.do?acctId="+acctNo;
	}
}


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
</script>



