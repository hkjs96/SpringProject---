<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 1. 28.      박지수      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<style>
	.board-list table thead td {
	  text-align: left;
	  font-size: 17px;
	  color: #222;
	  line-height: 1.5;
	  padding: 18px 0;
	  border-bottom: 1px solid #e9e9e9;
	  padding-left: 40px;
	}
	.board-list {
		width: 800px;
		margin-left: auto;
		margin-right: auto;
	}
</style>

<div id="container">

<!-- 	<h1> -->
<!-- 		여기는 비동기로 만들어볼까? -->
<!-- 		더블클릭시 폼으로 변환해서 엔터나, 다른곳 더블클릭시 저장되는 것? -->
<!-- 		그러면 난방코드나 이런부분은 라디오로?? -->
<!-- 	</h1> -->
    <div class="inner">
        <!-- 아파트 정보 상세 조회 -->
        <div class="board-list">
            <table>
                <colgroup>
                    <col style="width:80px">
                    <col style="width:100px">
                    <col style="width:80px">
                    <col style="width:100px">
                </colgroup>
                <thead>
	                <tr>
	                    <th>아파트 코드</th>
	                    <td>${apart.aptCode }</td>
	                    <th>아파트 명</th>
	                    <td>${apart.aptName }</td>
	                </tr>
	                <tr>
	                    <th>우편번호</th>
	                    <td colspan="1">${apart.aptZip }</td>
	                    <th>소장ID</th>
	                    <td colspan="1">${apart.memId }</td>
	                </tr>
	                <tr>
						<th scope="row">기본주소</th>
						<td>${apart.aptAdd1 }</td>
						<th scope="row">상세주소</th>
						<td>${apart.aptAdd2 }</td>
					</tr>
					<tr>
						<th scope="row">세대수</th>
						<td>${apart.aptCnt }</td>
						<th scope="row">총 주거면적</th>
						<td>${apart.aptArea }㎥</td>
					</tr>
					<tr>
						<th scope="row">활성화여부</th>
						<td>
							${apart.aptDelete eq 'Y' ? '<span style="color: red;"><strong>활성</strong></span>' : '<span style="color: gray;">비활성<span>' }
						</td>
						<th scope="row">난방정책</th>
						<td>${apart.aptHeat }</td>
					</tr>
					<tr>
						<th scope="row">관리사무소 전화번호</th>
						<td id="aptTel">${apart.aptTel }</td>
						<th scope="row">관리소장명</th>
						<td>${apart.aptHead }</td>
					</tr>
					<tr>
						<th scope="row">계약시작일</th>
						<td>${apart.aptStart }</td>
						<th scope="row">계약만료일</th>
						<td>${apart.aptEnd }</td>
					</tr>
					<tr>
						<th scope="row">아파트이미지</th>
						<td colspan="3">
							<c:if test="${not empty apart.aptImg }">
								<img style="width: 200px; height: 200px;" class="inimg" src="${cPath }/saveFiles/${apart.aptImg }">
							</c:if>
							<c:if test="${empty apart.aptImg }">
								이미지 없음
							</c:if>
						</td>
					</tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
	    <div class="col-auto text-center">
			<input type="button" value="단지설정" id="houseBtn" class="btn btn-success"/>
			<input type="button" value="수정" id="updateBtn" class="btn btn-primary"/>
			<input type="button" value="목록"  id="listBtn" class="btn btn-dark"/>
		</div>
    </div>
</div>
<script>
$("#updateBtn").on("click", function(){
	location.href="${cPath }/vendor/apartUpdateForm.do?aptCode=${apart.aptCode }";
});
$("#listBtn").on("click", function(){
	location.href="${cPath }/vendor/apartList.do?page=${pagingVO.currentPage }&searchType=${pagingVO.searchVO.searchType }&searchWord=${pagingVO.searchVO.searchWord }";
// 	location.href="${cPath }/vendor/apartList.do";
});
$("#houseBtn").on("click", function(){
	location.href="${cPath }/vendor/houseForm.do?aptCode=${apart.aptCode}";
});


let aptTel = $("#aptTel");
aptTel.text(formatTel(aptTel.text()));

/*		동적으로 만들어진 녀석은 바인딩이 되지않는다에 주목??
$(document).ready(function(){
  $("td").on("dblclick", function(){
	console.log($(this).attr("id"));
  	let text = $(this).text();
  	let name = $(this).attr("id");
    let input = $(this).replaceWith('<input class="tmp" type="text"/>');
    input.attr("name", name);
    console.log(input.attr("name"));
    input.val(text);
  });
    
  $("input").keydown(function(key) {

      if (key.keyCode == 13) {
          let tmp = $(".tmp").val();
          $(".tmp").replaceWith("<span id='aptHead'></span>");
          $("#aptHead").text(tmp);
      }
  });
});
*/
// https://www.w3schools.com/jquery/tryit.asp?filename=tryjquery_event_on_multiple
</script>