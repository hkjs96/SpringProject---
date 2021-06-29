/**
 * @author 이경륜
 * @since 2021. 3. 3.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 3. 3.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commons.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
/**
 * 자바오브젝트 -> json으로 변환하여 스크립트에서 쓸 수 있음
 * @author 이경륜
 */
public class JsonUtils {
	public static String toJson(Object value) throws JsonProcessingException{
		 ObjectMapper mapper = new ObjectMapper();
		 String json = mapper.writeValueAsString(value);
		 return json;
	}
}
