/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.      이경륜        최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.board.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of="repNo")
@Builder
public class ReplyVO implements Serializable{
	@NotNull
	private Integer boNo; // 게시글 번호
	@NotBlank
	private String repWriter;  //사용자 코드 -> 입주민자유게시판에서 mem_nick으로 치환해서 데려옴
	@NotNull(groups= {DeleteGroup.class, UpdateGroup.class})
	private Integer repNo; // 리플번호
	@NotBlank
	private String repContent; // 리플내용
	private Integer repParent; // 부모리플
	private Integer repDepth; // 계층레벨
	private String repDate; // 등록 일자
	
	private String repWriterId; // 삭제시 memId와 작성자id 비교하기위함 
}
