package kr.or.anyapart.commonsweb.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
/**
 * ck에디터 이미지 업로드 컨트롤러  
 * 
 * 경로 추가할 시  ("#{appInfo.____이곳에 작성_____}") --> appInfo <<추가 해주기
 * @author 박찬
 * 
 * */
@Controller
public class ImageUploadController {
	private static final Logger LOGGER = LoggerFactory.getLogger(ImageUploadController.class);
	@Inject
	private WebApplicationContext container;
	
	@Value("#{appInfo.boardImages}")
	String saveFolderUrl;
	File saveFolder;
	@PostConstruct
	public void init() throws IOException {
		saveFolder = container.getResource(saveFolderUrl).getFile();
		if(!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		LOGGER.info("{}", saveFolder.getAbsolutePath());
	}
	
	/**
	 * 경로 지정 url 지정url/imageUpload.do <<
	 *  @author 박찬
	 * */
	
	@RequestMapping(value="**/imageUpload.do", method=RequestMethod.POST)
	public String upload(@RequestPart(value="upload", required=true) MultipartFile imageFile, Model model) throws IllegalStateException, IOException{
		String savename = UUID.randomUUID().toString();
		imageFile.transferTo(new File(saveFolder, savename));
		
		model.addAttribute("fileName", imageFile.getOriginalFilename());
		model.addAttribute("uploaded", 1);
		String saveUrl = container.getServletContext().getContextPath() + saveFolderUrl+"/"+savename;
		model.addAttribute("url", saveUrl);
		return "jsonView";
	}
	
	public String upload(MultipartHttpServletRequest req, Model model) throws IllegalStateException, IOException{
		MultipartFile imageFile = req.getFile("upload");
//		if(imageFile==null || StringUtils.isBlank(imageFile.getOriginalFilename())) {
//			resp.sendError(400);
//			return null;
//		}
		
		String savename = UUID.randomUUID().toString();
		imageFile.transferTo(new File(saveFolder, savename));
		
		model.addAttribute("fileName", imageFile.getOriginalFilename());
		model.addAttribute("uploaded", 1);
		String saveUrl = req.getContextPath() + saveFolderUrl+"/"+savename;
		model.addAttribute("url", saveUrl);
		return "jsonView";
	}
}



















