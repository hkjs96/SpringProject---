/**
 * @author 이경륜
 * @since 2021. 2. 9.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 9.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.commonsweb.view;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.anyapart.commons.enumpkg.Browser;
import kr.or.anyapart.vo.AttachVO;

public class ExcelTmplDownloadView extends AbstractView{

	@Value("#{appInfo.exceltmpl}")
	private File saveFolder;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		AttachVO attatch =  (AttachVO) model.get("attach");
		String browser = request.getHeader("User-Agent");
		String savename = attatch.getAttSavename();
		String filename = attatch.getAttFilename();
		if(Browser.TRIDENT.equals(browser)) {
			filename = URLEncoder.encode(filename, "UTF-8").replace("+", "%20");
		}else {
			byte[] bytes = filename.getBytes();
			filename = new String(bytes, "ISO-8859-1");
			System.out.println("===============>"+filename);
		}
		response.setHeader("Content-Disposition", "attatchment;filename=\""+filename+"\"");
		File saveFile = new File(saveFolder, savename);
		response.setContentType("application/octet-stream");
		try(
			OutputStream os = response.getOutputStream();	
		){
			FileUtils.copyFile(saveFile, os);
		}		
		
	}

	
}
