/**
 * @author 이미정
 * @since 2021. 2. 1.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 1.      이미정       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.commons.advice;

import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class CommonExceptionAdvice {
   
   private static final Logger LOGGER = LoggerFactory.getLogger(CommonExceptionAdvice.class);
   
   @AfterThrowing(pointcut="execution(* kr.or.anyapart..service.*.*(..))",throwing="e")
   public void afterThrow(Throwable e) throws Throwable {
      LOGGER.error("===================",e);
      throw e;
   }
}