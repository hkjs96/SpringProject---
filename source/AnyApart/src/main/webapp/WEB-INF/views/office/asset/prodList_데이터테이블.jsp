<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<br>
	<h4><strong>물품관리</strong></h4>
	<br>
	<div class="container">
	<div class="col-md-12 " style="border-style:outset;border-radius: 8px;">
	    <form id="searchForm" class="form-inline">
	    	<input type="hidden" name="page" />
			<input type="hidden" name="searchType" value="${pagingVO.searchVO.searchType }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchVO.searchWord }"/>
		  <div class="row g-0">
			    <div class="col-md-3" style="margin-top:20px;">
			      <img src="${pageContext.request.contextPath}/images/searchIcon.png" alt="searchIcon"
			        style="width:30px;height:30px;margin-left:10px;margin-top:10px;">&nbsp;&nbsp;<strong>검색 조건</strong>
			    </div>
			    <div id="inputUI" class="col-md-9">
				    <div class="card-body ">
				        	&nbsp;&nbsp;분류선택&nbsp;&nbsp;
				        	<select name="prodCode" class="custom-select col-md-6">
				        		<option value>전체</option>
				        	</select> 
					    <input type="text" name="searchWord" class="form-control col-md-6"> 
						<button class="btn btn-dark" style='margin:5pt;'>검색</button>
					</div>
			    </div>
		  </div>
	    </form>
	</div>
	</div>
	<br>
	
	
<div align="right" class="mb-2 mr-5">
	<input type="button" class="btn btn-dark" role="alert" value="인쇄">
</div>	
 <div class="card text-center col-auto">
	  <div class="card-body row">
		  <div class="col-sm-12">
			<table id="prodTable" class="table">
<!-- 			<table class="table"> -->
				<thead class="thead-dark">
			    <tr>
			      <th scope="col">물품등록번호</th>
			      <th scope="col">물품분류</th>
			      <th scope="col">물품명</th>
			      <th scope="col">가격</th>
			      <th scope="col">제조사</th>
			      <th scope="col">수량</th>
			    </tr>
				</thead>
				<tbody id="listBody">
			    
				</tbody>
			</table>
			<ul class="pagination justify-content-center">
			    <li class="page-item" ><a class="page-link alert alert-secondary" href="#">Previous</a></li>
			    <li class="page-item"><a class="page-link alert alert-secondary" href="#">1</a></li>
			    <li class="page-item"><a class="page-link alert alert-secondary" href="#">2</a></li>
			    <li class="page-item"><a class="page-link alert alert-secondary" href="#">3</a></li>
			    <li class="page-item"><a class="page-link alert alert-secondary" href="#">Next</a></li>
			</ul>
		</div>	
	</div>
</div>
<div id="insertDiv">
	<div class="container">
		<div class="row">
			<div class="col-md-11">
				<strong>물품등록</strong>
			</div>
			<div class="col-md-1">
				<input type="button" class="btn btn-dark" role="alert" value="저장"
					style="width: 100px;">
			</div>
		</div>
	</div>
	<div class="card text-center col-auto">
		<div class="card-body row">
			<div class="col-sm-12">
				<table class="table table-bordered">
					<thead class="thead-dark">
						<tr>
							<th>물품등록번호</th>
							<th>물품분류코드</th>
							<th>물품명</th>
							<th>가격</th>
							<th>제조사</th>
							<th>수량</th>
						</tr>
					</thead>
					<tbody class="tbody-dark">
						<tr>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
							<td><input type="text"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- <table id="prodTable" class="table"> -->
<!-- 	<thead class="thead-dark"> -->
<!-- 		<tr> -->
<!-- 			<th>물품등록번호</th> -->
<!-- 			<th>물품분류코드</th> -->
<!-- 			<th>물품명</th> -->
<!-- 			<th>가격</th> -->
<!-- 			<th>제조사</th> -->
<!-- 			<th>수량</th> -->
<!-- 		</tr> -->
<!-- 	</thead> -->
<!-- </table> -->
<script>

//---------------------------------------------------

let optTag = $("[name='prodCode']");
$.ajax({
	url : "${cPath }/prod/getOption.do ",
	method : "get",
	dataType : "json",
	success : function(resp) {
		let opts = [];
		// 옵션을 동적으로 구성
		$(resp.option).each(function(idx, opt){
			opts.push(
				// type을 그대로 유지하기 위해서 prop 를 사용
				$("<option>").text(opt.codeName)
							 .attr("value", opt.codeId)
// 							 .prop("selected", "${pagingVO.searchDetail.boType}"==opt.codeId)
							 // EL은 javaBean 규약을 기반으로 움직인다.
			);
		});
		optTag.append(opts);
	},
	error : function(xhr) {
		console.log(xhr);
	}
});

let prodCode = null;

/*searchBuilder*/
$.fn.dataTable.ext.search.push(
	function( settings, data, dataIndex ){
		prodCode = $(':input[name=prodCode]').val();
		if(prodCode != null){
			return true;
		}
		return false;
	}
);


$(document).ready(function() {
	/*searchPanes*/
	
	let table = $('#prodTable').DataTable({
		language : {
			
		},
// 		dom: 'Qlfrtip',
// 		dom: 'Plfrtip',
		searchPane: true,
		
		scrollY:        "400px",
        scrollCollapse : true,
        paging :         false
// 		processing: true,
// 		serverSide: true,
// 		ajax : '${cPath }/office/asset/prod/prodList.do'
		, ajax : {
			url : '${cPath }/office/prodList.do'
			, json : "json"
			, dataSrc: "data"
		}
		, columns : [
			{ data : 'prodId'}
			, { data : 'prodCode'}
			, { data : 'prodName'}
			, { data : 'prodPrice'}
			, { data : 'prodCompany'}
			, { data : 'prodQty'}
// 			{ "data": "물품등록번호"}
// 			, { "data" : "물품분류코드"}
// 			, { "data" : "물품명"}
// 			, { "data" : "가격"}
// 			, { "data" : "제조사"}
// 			, { "data" : "수량"}
		]
// 		, columnDefs: [{
// 	        searchPanes: {
// 	            show: true
// 	        },
// // 	        targets: [0, 1, 2, 3, 4, 5]
// 	        targets: '_all'
// 	    }]
	});
	
	$(":input[name=prodCode]").keyup(function(){
		table.draw();
	});
	
// 	new $.fn.dataTable.SearchBuilder(table, {});
//     table.searchBuilder.container().prependTo(table.table().container());
	
	new $.fn.dataTable.SearchPanes(table, {});
	table.searchPanes.container().prependTo(table.table().container());
	table.searchPanes.resizePanes();
});

</script>