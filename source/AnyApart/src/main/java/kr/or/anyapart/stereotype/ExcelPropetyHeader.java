package kr.or.anyapart.stereotype;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 *  Domain 이 가진 속성들 중 엑셀에서 셀 하나의 헤더를 결정하는데 사용되며 생략시 property name 이 그대로 사용됨. 
 *
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ExcelPropetyHeader {
	String value();
}
