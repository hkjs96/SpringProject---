package kr.or.anyapart.vo;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class BankCodeVO  implements Serializable{
	
//	private String typecode= "ACCT_CODE";
	private String bankCode;//은행 코드
	private String bankName;// 분류 코드명


}
