/**
 * @author 작성자명
 * @since 2021. 2. 6.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2021. 2. 6.   이경륜       최초작성 (isEmpty, formatTel, onlyNumber)
 * 2021. 2. 9.   이경륜		getNoty, getErrorNotyDefault 추가
 * 2021. 2. 15.  이경륜		numberWithCommas 추가
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */ 

/**
 * 매개변수가 값이 있는지 확인하는 함수
 * @param param
 * @returns true: undefined/공백/null일때, false: 값이 있을 때
 * @author 이경륜
 */
function isEmpty(param) {
	if(param == undefined) return true;
	param += "";
	if(param.trim().length == 0 || param == null || param == "") return true;
}

/**
 * 휴대폰 번호 포맷하는 함수
 * @param memHp 01012341234 or 0181231234
 * @returns result 010-1234-1234 or 018-123-1234
 * @author 이경륜
 */
function formatTel(tel) {
	if(isEmpty(tel)) return tel; // 널체크
	tel = tel.replaceAll("-", ""); // 이미 포맷팅된게 들어왔으면 재포맷을 위해 리셋
	
	var regExp = /^(\d{10,11})$/; // 정규식
	
	if ( regExp.test(tel) ){ // 1) 10자리 혹은 11자리 숫자 입력 확인
		// 2) 맞다면 ***-****-**** 또는 ***-***-**** 로 변경
		return tel.replace(/(\d{3})(\d{3,4})(\d{4})/, "$1-$2-$3");
	} else {
		return tel; // 양식에 맞지 않는 값이 들어왔다면 화면에 그대로 출력하여 사용자에게 db정보가 잘못됨을 알림
	}
}

/**
 * input type="text"에서 number만 입력하게 체크하는 함수 
 * @param evt
 * @returns true: 숫자입력 false: 숫자제외
 * @author 이경륜
 */
// 사용법 <input type="text" onkeypress="return onlyNumber(event)" maxLength="4"/>
function onlyNumber(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)){
            return false;
        }
    return true;
}

/**
 * ajax 실행후 controller에서 실패noty를 message로 보냈을때 응답에서 noty 띄우는 함수
 * @param resp
 * @author 이경륜
 */
// 주의사항
// 1. Controller에서 반드시 message라는 이름으로 noty 보내야함
// 2. ajax success에서 쓸 수 있음
function getNoty(resp) {
	new Noty({
		 text: resp.message.text, 
		 layout: resp.message.layout,
		 type: resp.message.type,
		 timeout: resp.message.timeout,
		 progressBar: true
	}).show();
}

/**
 * 성공 노티 얻는 함수
 * @param message
 * @author 이경륜
 */
function getSuccessNotyDefault(message) {
	new Noty({
		text: message, 
		layout: 'topCenter',
		type: 'success',
		timeout: 3000,
		progressBar: true
	}).show();
}

/**
 * 에러 노티 얻는 함수
 * @param message
 * @author 이경륜
 */
function getErrorNotyDefault(message) {
	new Noty({
		 text: message, 
		 layout: 'topCenter',
		 type: 'error',
		 timeout: 3000,
		 progressBar: true
	}).show();
}

/**
 * 금액 3자리마다 콤마 찍는 함수
 * @param x
 * @returns 123,456
 * @author 이경륜
 */
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}



