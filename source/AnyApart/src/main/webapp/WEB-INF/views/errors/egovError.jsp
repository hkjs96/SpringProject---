<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2021. 2. 11.  이경륜      최초작성
* Copyright (c) 2021 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h4>EgovBizException 에러</h4>
${pageContext.errorData.throwable }
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td width="100%" height="100%" align="center" valign="middle" style="padding-top: 150px;"><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="<spring:message code='image.errorBg' />">
                        <span style="font-family: Tahoma; font-weight: bold; color: #000000; line-height: 150%; width: 440px; height: 70px;">
                        	${pageContext.errorData.requestURI }
                        	${pageContext.errorData.statusCode }
                        	${pageContext.errorData.throwable }
                        </span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>