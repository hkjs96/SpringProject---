/**
 * @author 박지수
 * @since 2021. 2. 25.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 25.      박지수       최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commonsweb.dao;

import org.springframework.stereotype.Repository;

@Repository
public interface MyPageDAO {
	/*
	SELECT
	    a.mem_id,
	    a.mem_nick,
	    a.mem_pass,
	    a.mem_role,
	    a.mem_delete,
	    
	    b.house_code,
	    b.res_name,
	    b.res_hp,
	    b.res_tel,
	    b.res_mail,
	    b.res_birth,
	    b.res_job,
	    b.res_movein,
	    b.res_moveout,
	    
	    c.apt_code,
	    c.emp_name,
	    c.emp_mail,
	    c.emp_hp,
	    c.emp_zip,
	    c.emp_add1,
	    c.emp_add2,
	    c.emp_acct,
	    c.position_code,
	    c.emp_img,
	    c.emp_birth,
	    c.emp_tel,
	    c.emp_start,
	    c.emp_end,
	    c.emp_off,
	    c.emp_bank
	FROM
	    member a left outer join resident b on (a.mem_id = b.mem_id)
	             left outer join employee c on (a.mem_id = c.mem_id)
	where a.mem_id = 'A0001E007';
              
	 */
}
