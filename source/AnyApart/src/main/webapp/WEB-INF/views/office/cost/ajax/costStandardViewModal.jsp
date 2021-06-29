<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 23.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
	.range {
		font-size: 0.8em;
	}
	
	.lawP{
		color: blue;
	}
	#payLawTitleDiv {
		margin: 0 auto;
	}
	#payLawTitleSpan{
		font-size: 20px;
	}
	
</style>
<div class="card p-5">
	<div id="payLawTitleDiv">
		<span id="payLawTitleSpan" class="badge badge-info mb-4"><i class="fas fas fa-money-check"></i>&nbsp;부과 기준표</span>
	</div>
	
	<p class="lawP">* 공용관리비</p>
	<table class="table table-sm table-bordered text-center align-self-center">
		<thead class="thead-dark">
			<tr>
				<th style="width:25%">구분</th>
				<th>전체금액</th>
				<th>산정방식</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>일반관리비</td>
				<td>관리사무소 인건비</td>
				<td rowspan="4" class="align-middle">(전체금액 / 총 주거전용면적) * 세대면적</td>
			</tr>
			<tr>
				<td>청소비</td>
				<td>청소업체 인건비</td>
			</tr>
			<tr>
				<td>경비업체</td>
				<td>경비업체 인건비</td>
			</tr>
			<tr>
				<td>소독업체</td>
				<td>소독업체 인건비</td>
			</tr>
			<tr>
				<td>승강비유지비</td>
				<td>-</td>
				<td><fmt:parseNumber value="${frMap['F_ELEV'] }" integerOnly="true"/> 원 * 세대면적</td>
			</tr>
		</tbody>
	</table>
	<p class="lawP">* 개별관리비 (<i class="fas fa-question-circle"></i> 표시를 클릭하시면 산정방식을 확인할 수 있습니다.)</p>
	<table class="table table-sm table-bordered text-center align-self-center">
		<thead class="thead-dark">
			<tr>
				<th style="width:25%">구분</th>
				<th>기준표</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>난방&nbsp;</td>
				<td>
					<table class="table table-sm">
						<tr class="thead-light">
							<th colspan="2">
								개별난방&nbsp;<i class="fas fa-question-circle popoverclz" data-toggle="popover" data-popover-content="#ht_loc"></i>
							</th>
						</tr>
						<tr class="thead-light">
							<th>구분</th>
							<th>요금</th>
						</tr>
						<tr>
							<td>기본료</td>
							<td>m2당 <fmt:formatNumber value="${frMap['F_HTLOC_ST'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>사용료</td>
							<td>검침량 * <fmt:formatNumber value="${frMap['F_HTLOC_USE'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>급탕</td>
				<td>1t당 4300원</td>
			</tr>
			<tr>
				<td rowspan="2">전기</td>
				<td>
					<table class="table table-sm">
						<tr class="thead-light">
							<th colspan="3">
								기본료&nbsp;<i class="fas fa-question-circle popoverclz" data-toggle="popover" data-popover-content="#elec_st"></i>
							</th>
						</tr>
						<tr class="thead-light">
							<th>구간</th>
							<th>기준</th>
							<th>요금</th>
						</tr>
						<tr>
							<td>1구간</td>
							<td>~200kWh</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_ELEC_ST1'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>2구간</td>
							<td>201~400kWh</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_ELEC_ST2'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>3구간</td>
							<td>400kWh~</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_ELEC_ST3'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table class="table table-sm">
						<tr class="thead-light">
							<th colspan="3">
								사용료&nbsp;<i class="fas fa-question-circle popoverclz" data-toggle="popover" data-popover-content="#elec_use"></i>
							</th>
						</tr>
						<tr class="thead-light">
							<th>구간</th>
							<th>기준</th>
							<th>요금</th>
						</tr>
						<tr>
							<td>1구간</td>
							<td>~200kWh</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_ELEC_USE1'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>2구간</td>
							<td>201~400kWh</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_ELEC_USE2'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>3구간</td>
							<td>400kWh~</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_ELEC_USE3'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>수도&nbsp;<i class="fas fa-question-circle popoverclz" data-toggle="popover" data-popover-content="#water"></i></td>
				<td>
					<table class="table table-sm">
						<tr class="thead-light">
							<th>구간</th>
							<th>기준</th>
							<th>요금</th>
						</tr>
						<tr>
							<td>1구간</td>
							<td>1t~20t</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_WATER1'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>2구간</td>
							<td>21t~40t</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_WATER2'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>3구간</td>
							<td>41t~</td>
							<td class="text-right"><fmt:formatNumber value="${frMap['F_WATER3'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>주차</td>
				<td>
					<table class="table table-sm">
						<tr class="thead-light">
							<th>등록대수</th>
							<th>요금</th>
						</tr>
						<tr>
							<td>3대</td>
							<td><fmt:formatNumber value="${frMap['F_CAR3'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>4대</td>
							<td><fmt:formatNumber value="${frMap['F_CAR4'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
						<tr>
							<td>5대</td>
							<td><fmt:formatNumber value="${frMap['F_CAR5'] }" type="number" maxFractionDigits="3"/> 원</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>수선유지비</td>
				<td colspan="2"><fmt:parseNumber value="${frMap['F_AS'] }" integerOnly="true"/> 원 * 세대면적</td>
			</tr>
			<tr>
				<td>장기수선충당금</td>
				<td colspan="2"><fmt:parseNumber value="${frMap['F_LAS'] }" integerOnly="true"/> 원 * 세대면적</td>
			</tr>
			<tr>
				<td>입주자대표회의운영비</td>
				<td colspan="2"><fmt:parseNumber value="${frMap['F_COUNCIL'] }" integerOnly="true"/> 원 * 세대면적</td>
			</tr>
		</tbody>
	</table>
</div>


<div id="water" style="display:none;">
	<div class="popover-heading">수도 사용료<span style="float:right;cursor:pointer;" class="fa fa-times" data-toggle="popover"></span></div>
	<div class="popover-body">
		<table class="table table-sm">
			<tr class="thead-light text-center">
				<th>
					공용 사용료
				</th>
			</tr>
			<tr class="text-center">
				<th>
					 (공용검침량 기준 사용료 / 총 주거전용면적) * 세대면적
				</th>
			</tr>
			<tr class="thead-light text-center">
				<th>
					개별 사용료
				</th>
			</tr>
			<tr class="text-center">
				<td>
					개별검침량 기준 사용료
				</td>
			</tr>
		</table>
	</div>
</div>

<div id="ht_loc" style="display:none;">
	<div class="popover-heading">개별 난방<span style="float:right;cursor:pointer;" class="fa fa-times" data-toggle="popover"></span></div>
	<div class="popover-body">
		<table class="table table-sm">
			<tr class="thead-light text-center">
				<th>
					공용요금 산정방식
				</th>
			</tr>
			<tr class="text-center">
				<th>
					 { (검침량) / 총 주거전용면적} / 세대 * 기준요금
				</th>
			</tr>
			<tr class="thead-light text-center">
				<th>
					개별요금 산정방식
				</th>
			</tr>
			<tr class="text-center">
				<td>
					세대면적 * 기준요금 + 검침량 * 기준요금
				</td>
			</tr>
		</table>
	</div>
</div>

<div id="elec_use" style="display:none;">
	<div class="popover-heading">전기 사용료<span style="float:right;cursor:pointer;" class="fa fa-times" data-toggle="popover"></span></div>
	<div class="popover-body">
		<table class="table table-sm">
			<tr class="thead-light text-center">
				<th>
					공용 사용료
				</th>
			</tr>
			<tr class="text-center">
				<th>
					 { (평균사용량을 구간별로 분할)*해당구간요금*세대수 } / 총주거전용면적 * 세대면적
				</th>
			</tr>
			<tr class="thead-light text-center">
				<th>
					개별 사용료
				</th>
			</tr>
			<tr class="text-center">
				<td>
					(평균사용료 구간별 분할) * 해당구간요금
				</td>
			</tr>
		</table>
	</div>
</div>

<div id="elec_st" style="display:none;">
	<div class="popover-heading">전기 기본료<span style="float:right;cursor:pointer;" class="fa fa-times" data-toggle="popover"></span></div>
	<div class="popover-body">
		<table class="table table-sm">
			<tr class="thead-light text-center">
				<th>
					공용 기본료
				</th>
			</tr>
			<tr class="text-center">
				<th>
					(해당 구간 기본료 * 세대수 / 총 주거전용면적) * 세대면적
				</th>
			</tr>
			<tr class="thead-light text-center">
				<th>
					개별기본료
				</th>
			</tr>
			<tr class="text-center">
				<td>
					해당 구간 기본료
				</td>
			</tr>
		</table>
	</div>
</div>
<script>
$(function() {
	$("[data-toggle='popover']").popover({
		sanitize: false,
		html: true,
	    content: function() {
			var content = $(this).attr("data-popover-content");
			return $(content).children(".popover-body").html().trim();
		},
		title: function() {
	    	var title = $(this).attr("data-popover-content");
			return $(title).children(".popover-heading").html();
		}
	});
});

</script>