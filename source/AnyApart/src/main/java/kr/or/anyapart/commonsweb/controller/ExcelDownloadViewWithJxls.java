package kr.or.anyapart.commonsweb.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.view.AbstractView;

public abstract class ExcelDownloadViewWithJxls extends AbstractView{

	@Override
	protected boolean generatesDownloadContent() {
		return true;
	}
	
	public abstract Resource getJxlsTemplate() throws IOException;
	
	public abstract String getDownloadFileName();
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
		
		try(
			InputStream tmplIs = getJxlsTemplate().getInputStream();
			ByteArrayOutputStream baos = createTemporaryOutputStream();
		){
			Context context = new Context(model);
			JxlsHelper.getInstance()
			
						.setProcessFormulas(true)
						.setEvaluateFormulas(true)
						.processTemplate(tmplIs, baos, context);
			String disposition =  String.format("attatchment;filename=\"%s\"", 
					URLEncoder.encode(getDownloadFileName(), "UTF-8").replace("+", " "));
			response.setHeader("Content-Disposition", disposition);
			writeToResponse(response, baos);
		}
	}

}
