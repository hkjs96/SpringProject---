package kr.or.anyapart.commons.enumpkg;

public enum ServiceResult {
	OK, 
	FAILED, 
	NOTEXIST, 
	INVALIDPASSWORD, 
	PKDUPLICATED, 
	DISABLE, 
	INVALIDID,   /* 박정민 : 게시글 삭제시 작성자와 로그인한 id 다를때 오류 */
	ALREADYEXIST /*21.02.08 이경륜: 이미 입주한 호실일때 오류*/
}
