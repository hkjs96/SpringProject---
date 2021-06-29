/**
 * @author 이경륜
 * @since 2021. 1. 26.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 1. 26.      작성자명       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.account.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.ibatis.annotations.Insert;
import org.hibernate.validator.constraints.NotBlank;

import kr.or.anyapart.commons.validate.groups.DeleteGroup;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of ="acctId")
public class AccountVO  implements Serializable {
	@NotNull (groups = {UpdateGroup.class,InsertGroup.class})
	private String acctId; // 계좌등록번호
	@NotBlank(groups = {UpdateGroup.class,InsertGroup.class})
	@Size(max = 60)
	private String bankCode; // 은행코드
	@NotNull(groups = {UpdateGroup.class})
	@Size(max = 17)
	private String acctNo; // 계좌번호
	@NotBlank(groups = {UpdateGroup.class,InsertGroup.class})
	@Size(max = 60)
	private String acctCode; // 계좌분류코드
	@NotBlank (groups = {UpdateGroup.class,InsertGroup.class})
	@Size(max=20)
	private String acctUser; //예금주
	@Size(max=7)
	private String acctDate; //등록일
	@NotNull(groups = {UpdateGroup.class,InsertGroup.class})
	@Size(max=50) 
	private String acctComent; //사용목적
	
	private Integer acctrum;
	private String bankRecode;
	private String acctRecode;
	private String apartType;
	
	
	
	
}
