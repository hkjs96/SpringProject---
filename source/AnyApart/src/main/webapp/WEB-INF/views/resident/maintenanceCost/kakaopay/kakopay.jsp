<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script> 

<form action="${cPath}/resident/maintenanceCost/pay.do" id="user">
	<input type="hidden" name="memId" value="${thisCost.memId}">
	<input type="hidden" name="costDuedate" value="${thisCost.costDuedate }">
</form>


 <script>
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('imp23418340'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용 << 실거래가 아니면 태스트 코드를 사용 
        var msg;
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '[${apart.aptName}]${user.dong}동 ${user.ho} 호 ${thisCost.costYear}년도 ${thisCost.costMonth}월분 관리비',
            amount : ${thisCost.costTotal},
            buyer_email : 'yco1234@naver.com',
            buyer_name : '${user.resName}',
            buyer_tel : '${user.resHp}',
            buyer_addr : '${apart.aptAdd1} / ${apart.aptAdd2}',
            buyer_postcode : '${apart.aptZip}',
            //m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
               $.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    // 핸드폰에서 직접 결제 완료하였을때 
                    // 광고 등록 하기!!
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        
                        alert(msg);
                    } else {
                       // 아직 결제 안되었을때
					// 결제 금액 재대로 입력 안했을 때 
					// 광고 등록 취소 하기
                    }
                });
                //성공시 이동할 페이지
//                 location.href="${cPath}/resident/maintenanceCost/pay.do";
					alert("정상적으로 관리비 정산이  완료되었습니다.");
					$("#user").submit();
               	
            } else {
                msg = '결제에 실패하였습니다.';
                msg += rsp.error_msg;
                //실패시 이동할 페이지
                location.href="${cPath}/resident/maintenanceCost/feePayment.do";
                //실패 메시지 띄우기
                alert(msg);
            }
        });
        
    });
    </script> 

