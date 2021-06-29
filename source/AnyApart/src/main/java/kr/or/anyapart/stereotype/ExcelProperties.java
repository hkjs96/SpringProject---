package kr.or.anyapart.stereotype;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.lang.reflect.Field;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 
 * Domain 이 가진 속성들 중 엑셀에서 셀 하나를 구성하는데 사용될 것들을 선택.
 *
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ExcelProperties {
	String[] value() default {};
	
	@Getter
	@AllArgsConstructor(access=AccessLevel.PRIVATE)
	public static class ExcelMetaData{
		private String[] properties;
		private String[] headerNames;
		
		
		private static String[] validTest(Class<?> type, String[] properties) throws NoSuchFieldException {
			String[] headerNames = new String[properties.length];
			int colNum = 0;
			for(String propName : properties) {
				Field fld = type.getDeclaredField(propName);
				ExcelPropetyHeader header = fld.getDeclaredAnnotation(ExcelPropetyHeader.class);
				headerNames[colNum++] = header!=null ? header.value() : propName;
			}
			return headerNames;
		}
		
		public static ExcelMetaData parsingMataData(Class<?> type) throws NoSuchFieldException {
			ExcelProperties annotation = type.getDeclaredAnnotation(ExcelProperties.class);
			Field[] flds = type.getDeclaredFields();
			boolean allFlag = annotation==null || annotation.value().length==0;
			String[] properties = allFlag ?  new String[flds.length] : annotation.value();
			String[] headerNames = null;
			if(!allFlag) {
				headerNames = validTest(type, properties);
			}else {
				headerNames = new String[properties.length];
			}
			
			for(int i=0; i<flds.length; i++) {
				if(allFlag) {
					properties[i] = flds[i].getName();
					ExcelPropetyHeader header = flds[i].getDeclaredAnnotation(ExcelPropetyHeader.class);
					headerNames[i] = header!=null ? header.value() : properties[i];
				}	
			}
			
			return new ExcelMetaData(properties, headerNames);
		}
		
	}
}
