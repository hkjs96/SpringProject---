/**
 * @author 
 * @since 2021. 1. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                                수정자                            수정내용
 * --------     --------   -----------------------
 * 2021. 1. 26.      작성자명                        최초작성
 * 2021. 2. 10.		  박   찬 			 
 * Copyright (c) 2021. 1. 26. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.servicecompany.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.jxls.reader.ReaderBuilder;
import org.jxls.reader.XLSReader;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.xml.sax.SAXException;

import kr.or.anyapart.account.service.IAccountService;
import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.board.vo.NotyMessageVO;
import kr.or.anyapart.commons.enumpkg.Browser;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.commons.validate.groups.InsertGroup;
import kr.or.anyapart.commons.validate.groups.UpdateGroup;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.commonsweb.controller.ExcelDownloadViewWithJxls;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.servicecompany.service.AttachContrat;
import kr.or.anyapart.servicecompany.service.ServiceCompanyService;
import kr.or.anyapart.servicecompany.vo.ServiceAttachVO;
import kr.or.anyapart.servicecompany.vo.ServiceVO;
import kr.or.anyapart.vo.AttachVO;
import kr.or.anyapart.vo.BankCodeVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.CustomPaginationInfo;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;
import kr.or.anyapart.vo.SearchVO;


@Controller
@RequestMapping("/office/servicecompany")
public class ServiceCompanyController  extends BaseController {
	@Inject
	private ServiceCompanyService service;
	private ServletContext application;
	@Inject
	private WebApplicationContext container;
	
	@Inject
	private IAccountService accountService;
	
	@Inject
	private AttachContrat attService;
	
	@PostConstruct
	public void init() {
		application = container.getServletContext();
	}
	
	@ModelAttribute("serviceVOConteact")
	public ServiceVO serviceVOConteact() {
		return new ServiceVO();
	}
	
	/**
	 * 등록된 용역 업체 리스트 조회
	 * [ 페이지 넘버를 클릭시 해당 페이지 이동 하여 리스트를 조회한다.]
	 * [ 등록된 리스트의 총 갯수를 조회하여 TotalRecord에 들어간다.]
	 * @param currentPage
	 * @param searchVO
	 * @param model
	 * @return serviceList.jsp페이지 이동
	 */
	@RequestMapping("serviceList.do")
	public String contractlist(@RequestParam(value="page",required=false, defaultValue="1" )int currentPage
			,@ModelAttribute("searchVO") SearchVO searchVO, Model model,@AuthenticationPrincipal(expression="realMember") MemberVO authMember ) {
		
		setAptCode(authMember, searchVO);
		PagingVO<ServiceVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		
		int totalRecord = service.retrieveContractCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		
		List<ServiceVO> contractList = service.contractList(pagingVO);
		
		pagingVO.setDataList(contractList);
		
		
		model.addAttribute("pagingVO",pagingVO);
		model.addAttribute("paginationInfo", new CustomPaginationInfo<ServiceVO>(pagingVO));
		
		return "contract/serviceList";
	}
	
	/**
	 * 엑셀 다운로드 컨트롤러 페이지
	 * /WEB-INF/jxlstmpl/contractTemplate.xlsx 템플릿을 사용하여 메모장 jxl 명령어를 사용하여 컬럼 값을 불러 대입한뒤 저장한다.
	 * @param currentPage
	 * @param searchVO
	 * @param model
	 * @author 박찬
	 * @return
	 */
	@RequestMapping(value="downloadExcel.do")
	public ExcelDownloadViewWithJxls excelJXLS(@RequestParam(value="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("searchVO")  SearchVO searchVO , Model model ,@AuthenticationPrincipal(expression="realMember") MemberVO authMember) {
		
		contractlist(currentPage, searchVO, model, authMember);
		
		CustomPaginationInfo<ServiceVO> pagination = (CustomPaginationInfo<ServiceVO>) model.asMap().get("paginationInfo");
		PagingVO<ServiceVO> pagingVO = pagination.getPagingVO();
		model.addAttribute("pagingVO", pagingVO);
		
		return new ExcelDownloadViewWithJxls() {
			@Override
			public String getDownloadFileName() {
				return "용역업체 엑셀 파일.xlsx";
			}
			
			@Override
			public Resource getJxlsTemplate() throws IOException {
				return container.getResource("/WEB-INF/jxlstmpl/contractTemplate.xlsx");
			}
		};
	}
	
	/**
	 * 용역업체 상세 조회 [ svcId를 받아와서 해당 서비스를 조회한다. 이때 해당 되는 아이디의 파일 리스트도 같이 조회한다.] [ 용역업체
	 * 아이디 , 아파트 코드, 용역업종코드, 업체명, 업체 우편번호, 업체주소 1,2 ,업체 연락처, 업체 대리인 등 ]
	 * 
	 * @param param
	 * @param model
	 * @param redirectAttributes
	 * @return serviceView.jsp 페이지 이동
	 */
	@RequestMapping(value="serviceView.do")
	public String contractView(@ModelAttribute ServiceVO param
			,Model model,RedirectAttributes redirectAttributes
			) {
		ServiceVO serviceView = service.selectServiceView(param);
		List<ServiceAttachVO> fileList =service.selectServiceFile(param);
		
		model.addAttribute("fileList",fileList);
		model.addAttribute("serviceView", serviceView);
		
		return "office/contract/ajaxView/serviceView";
	}
	
	/**
	 * 용역업체 등록 
	 * [ 해당 로그인된 회원의 아파트 코드를 조회하여 아파트 간단 조회를 하여 해당 폼 작성시 출력 한다.]
	 * [ 은행코드 리스트를 조회하여 샐렉트 박스에 뿌려준다. (용엽업종 코드도 같은 원리)]
	 * @param model
	 * @param authMember
	 * @return serviceForm.jsp 페이지 이동
	 */
	@RequestMapping("/serviceForm.do")
	public String contratInsertForm(Model model, @AuthenticationPrincipal(expression="realMember") MemberVO authMember) {
		String aptCode = authMember.getMemId().substring(0, 5);
		ServiceVO serviceVo = new ServiceVO();
		serviceVo.setAptCode(aptCode);
		ApartVO apart = service.selectApart(serviceVo);
		List<BankCodeVO> bankCodeList = accountService.bankCodeList();
		List<CodeVO>svcCodeList = service.serviceCodeList();
		model.addAttribute("apart",apart);
		model.addAttribute("svcCodeList",svcCodeList);
		model.addAttribute("bankCodeList",bankCodeList);
		return "contract/serviceForm";
	}
	
	/**
	 * 클라언트 단에서 작성한 폼을 받아와 등록 
	 * [용역 업체 정보를 받아 등록한다. 이때 파일 첨부 여부를 조회하여 파일이 존재할 시 파일 업로드가 이루어진다.]
	 * @param serviceVO
	 * @param errors
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value="/serviceForm.do",method=RequestMethod.POST)
	public String insertContrat(@Validated(InsertGroup.class) ServiceVO serviceVO
			,BindingResult errors
			,Model model) throws SQLException {
		String goPage = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createContract(serviceVO);
			switch (result) {
				case OK:
					goPage ="redirect:/office/servicecompany/serviceList.do";
					break;
				default:	
					model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
					goPage = "redirect:/office/servicecompany/serviceForm.do";
				break;
			}
		}else {
			model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
			goPage = "redirect:/office/servicecompany/serviceForm.do";
		}
		return goPage;
	}
	
	/**
	 * 파일 다운로드
	 * [ 해당 용역업체의 아이디와 파일의 번호를 조회하여 클릭한 파일을 다운로드 한다.]
	 * [ context에 저장된 svdownloadView 의 빈의 주소를 통하여 이동한다.]
	 * [ 다운로드 컨트롤로에서 해당 파일을 다운로드 하여 현제 브라우저의 파일 다운로드 페이지를 통하여 진행한다.]
	 * @param param
	 * @param agent
	 * @param model
	 * @return svdownloadView
	 */
	@RequestMapping("/servicedownload.do")
	public String download(
			@ModelAttribute ServiceAttachVO param
			, @RequestHeader(value="User-Agent", required=false) String agent
			, Model model
		){
			Browser browser = Browser.getBrowserConstant(agent);
			ServiceAttachVO attatchs = attService.download(param);
			model.addAttribute("attatchs", attatchs);
			return "svdownloadView";
		}
	
	/**
	 * 용역업체 파일 수정 
	 * [해당 아이디를 받아와 등록 폼 (수정폼)으로 이동하여 해당 데이터들을 value에 담아서 뿌려준다.]
	 * @param serviceVO
	 * @param model
	 * @param authMember
	 * @return serviceForm.jsp 이동
	 */
	@RequestMapping("/serviceModify.do")
	public String modifyContractForm(ServiceVO serviceVO, Model model,@AuthenticationPrincipal(expression="realMember") MemberVO authMember) {
		
		ServiceVO serviceView = service.selectServiceView(serviceVO);
		String aptCode = authMember.getMemId().substring(0, 5);
		serviceVO.setAptCode(aptCode);
		ApartVO apart = service.selectApart(serviceVO);
		List<BankCodeVO> bankCodeList = accountService.bankCodeList();
		List<CodeVO>svcCodeList = service.serviceCodeList();
		List<ServiceAttachVO> fileList = service.selectServiceFile(serviceVO);
		serviceView.setAttachList(fileList);
		model.addAttribute("apart",apart);
		model.addAttribute("svcCodeList",svcCodeList);
		model.addAttribute("bankCodeList",bankCodeList);
		model.addAttribute("serviceView",serviceView);
		return "contract/serviceForm";
	}
	
	
	/**
	 * 수정 완료 처리 
	 * [ 클라이언트에서 수정 버튼을 클릭하여 용역업체 정보를 수정할 시 이루어진다.]
	 * [ |result|(ok):성공적으로 이루어질 시 리스트 페이지 이동
	 * 			 (false): 실패시 수정폼으로 다시 이동.
	 * @param serviceVO
	 * @param errors
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/serviceModify.do", method=RequestMethod.POST)
	public String modifyContract(@Validated(UpdateGroup.class)
	ServiceVO serviceVO,BindingResult errors, Model model) {
	String goPage = null;
	if(!errors.hasErrors()) {
		ServiceResult result = service.modifyContract(serviceVO);
		switch (result) {
			case OK:
				goPage ="redirect:/office/servicecompany/serviceList.do";
			break;
		default:	
				model.addAttribute("message", INSERT_SERVER_ERROR_MSG);
				goPage = "redirect:/office/servicecompany/serviceModify.do";
			break;
			}
	}else {
		model.addAttribute("message", INSERT_CLIENT_ERROR_MSG);
		goPage = "redirect:/office/servicecompany/serviceModify.do";
	}
	return goPage;
	}
	
	/** 
	 * 계약 만료 
	 * [ 해당 삭제 여부를 판단하여 처리한다.]
	 * @param serviceVO
	 * @return
	 */
	@RequestMapping("/delete.do")
	public String modifyContract(ServiceVO serviceVO) {
		String goPage="";
		String delCode = serviceVO.getSvcDel();
		System.out.println(delCode);
		int cnt =0;
		if(delCode.equals("Y")) {
			serviceVO.setSvcDel("N");
			 cnt = service.serviceDelete(serviceVO);
		}else {
			serviceVO.setSvcDel("Y");
			 cnt = service.serviceDelete(serviceVO);
		}
		if (cnt > 0) {
			goPage ="redirect:/office/servicecompany/serviceList.do";
		}else {
			goPage="";
		}
		
		return goPage;
	}
	
	@RequestMapping("/downloadTmpl.do")
	public String downloadTmpl(
			@ModelAttribute ServiceAttachVO param
			, @RequestHeader(value="User-Agent", required=false) String agent
			, Model model
		){
			Browser browser = Browser.getBrowserConstant(agent);
			AttachVO attach = new AttachVO();
			attach.setAttFilename("용역업체 양식파일.xlsm");
			attach.setAttSavename("contractSample.xlsm");
			model.addAttribute("attach", attach);
			return "excelTmplDownloadView";
		}
	
	
	@RequestMapping(value="/uploadExcel.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
	public String uploadJXLS(
			@AuthenticationPrincipal(expression="realMember") MemberVO authMember
			,@RequestPart("excelFile") MultipartFile excelFile
			,Model model) {
			
			NotyMessageVO message = INSERT_SERVER_ERROR_MSG;
			ServiceResult result = ServiceResult.FAILED;
			
			List<ServiceVO> contractList = new ArrayList<>();
			Resource tmpl = container.getResource("classpath:kr/or/anyapart/jxlstmpl/contractList.xml");
			
			try (
					InputStream is = new BufferedInputStream(tmpl.getInputStream())
			) {
				
					XLSReader reader = ReaderBuilder.buildFromXML(is);
					
					Map<String, Object> beans = new HashMap<>();
					beans.put("contractList", contractList);
					
					try {
						InputStream excelStream = excelFile.getInputStream();
						reader.read(excelStream, beans);
						
						System.out.println(contractList);
						contractList.forEach(serviceVO -> serviceVO.setAptCode(getAptCode(authMember)));
						result = service.createMuitlpleContract(contractList);
						
					} catch (InvalidFormatException | SQLException e) {
						LOGGER.error(this.getClass().getName() + " " + e.getMessage());
					}
				
			} catch (SAXException | IOException e) {
				LOGGER.error(this.getClass().getName() + " " + e.getMessage());
			}
			
			switch (result) {
			case OK:
				message = null;
				break;
			case ALREADYEXIST:
				message = getCustomNoty("이미 등록된 용역 업체를 포함한 파일입니다.");
				break;
			case FAILED:
				message = getCustomNoty("엑셀 업로드 양식에 맞지 않습니다.");
				break;
			}
		if(message != null) model.addAttribute("message", message);
		
		return "jsonView";
		
	}
}
