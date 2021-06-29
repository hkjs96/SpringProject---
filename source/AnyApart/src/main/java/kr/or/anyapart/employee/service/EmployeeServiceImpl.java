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
package kr.or.anyapart.employee.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.employee.dao.IEmployeeDAO;
import kr.or.anyapart.employee.dao.LicenseDAO;
import kr.or.anyapart.employee.vo.EmployeeVO;
import kr.or.anyapart.employee.vo.LicenseVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class EmployeeServiceImpl implements IEmployeeService{
	private static final Logger LOGGER = LoggerFactory.getLogger(EmployeeServiceImpl.class);
	
	@Inject
	private IEmployeeDAO employeeDAO;
	
	@Inject
	private LicenseDAO licDAO;
	
	@Value("#{appInfo['boardFiles']}")
	private File saveFolder;

	@PostConstruct
	public void init() {
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		LOGGER.info("{}", saveFolder.getAbsolutePath());
	}
	
	
	@Override
	public List<EmployeeVO> retrieveEmployeeList(PagingVO<EmployeeVO> pagingVO) {
		return employeeDAO.selectEmployeeInfoList(pagingVO);
	}
	
	@Override
	public List<EmployeeVO> retrievePayInfoList(PagingVO<EmployeeVO> pagingVO) {
		return employeeDAO.selectPayInfoList(pagingVO);
	}

	public int retrieveEmployeeCount(PagingVO<EmployeeVO> pagingVO) {
		return employeeDAO.selectEmployeeInfoCount(pagingVO);
	}


	@Override
	public int retrieveEmployeeChangeCount(PagingVO<EmployeeVO> pagingVO) {
		return employeeDAO.selectEmployeeChangeCount(pagingVO);
	}


	@Override
	public List<EmployeeVO> retrieveEmployeeChangeList(PagingVO<EmployeeVO> pagingVO) {
		return employeeDAO.selectEmployeeChangeList(pagingVO);
	}
	
	
	
	@Override
	public EmployeeVO retrieveEmployee(EmployeeVO employeeVO) {
		return employeeDAO.selectEmployeeInfo(employeeVO);
	}

	@Override
	public EmployeeVO getEmployeeMaxId(String aptCode) {
		return employeeDAO.getEmployeeMaxId(aptCode);
	}

	@Transactional
	@Override
	public ServiceResult createEmployee(MemberVO memberVO, EmployeeVO employeeVO) {
		ServiceResult result = ServiceResult.OK;
		memberVO.setMemNick(employeeVO.getEmpName());
		int rowcnt = employeeDAO.insertEmpWebInfo(memberVO);
		rowcnt += employeeDAO.insertEmpOfficeInfo(employeeVO);
		List<LicenseVO> employeeLicenseList = new ArrayList<>();
		int licNo = licDAO.selectMaxLicenseNo();
		if(employeeVO.getLicCodes()!=null) {
			for(int i = 0; i<employeeVO.getLicCodes().length;i++) {
				LicenseVO license;
				try {
					license = new LicenseVO(
								licNo
							  , employeeVO.getLicCodes()[i]
							  , employeeVO.getLicDates()[i]
							  , UUID.randomUUID().toString()
							  , employeeVO.getMemId()
					);
					employeeLicenseList.add(license);
					licNo++;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}	
			
			employeeVO.setLicenseList(employeeLicenseList);
			rowcnt += licDAO.insertLicenses(employeeVO);
		}
		try {
			if(rowcnt>0) {
				employeeVO.saveToEmpImg(saveFolder);
				employeeVO.saveToEmpLic(saveFolder);
				result = ServiceResult.OK;
			}
			return result;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Transactional
	@Override
	public ServiceResult removeEmployee(EmployeeVO employeeVO) {
		String savedEmpImg = employeeDAO.selectEmployeeInfo(employeeVO).getEmpImg();
		ServiceResult result = ServiceResult.FAILED;
		int rowcnt = employeeDAO.deleteEmployee(employeeVO);
		if(savedEmpImg!=null) {
			if(rowcnt>0) {
				deleteEmpImg(savedEmpImg);
				deleteAllLicense(employeeVO);
				result = ServiceResult.OK;
			}
		}
		return result;
	}
	
	@Override
	public ServiceResult removeEmployeeCancel(EmployeeVO employee) {
		ServiceResult result = ServiceResult.FAILED;
		int rowcnt = employeeDAO.removeEmployeeCancel(employee);
		
		if(rowcnt>0) {
			result = ServiceResult.OK;
		}
	
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult modifyEmployee(EmployeeVO employeeVO, MemberVO memberVO) {
		ServiceResult result = ServiceResult.FAILED;
			int rowcnt = employeeDAO.updateEmployeeEmpInfo(employeeVO);
			rowcnt += employeeDAO.updateEmployeeMemInfo(memberVO);
			
			String[] deleteLicCodes = employeeVO.getDeleteLicCodes();
			if(deleteLicCodes!=null && deleteLicCodes.length>0) {
				rowcnt += licDAO.deleteLicenses(employeeVO);
			}
			List<LicenseVO> employeeLicenseList = new ArrayList<>();
			int licNo = licDAO.selectMaxLicenseNo();
			if(employeeVO.getLicCodes()!=null) {
				for(int i = 0; i<employeeVO.getLicCodes().length;i++) {
					LicenseVO license;
					try {
						license = new LicenseVO(
									licNo
								  , employeeVO.getLicCodes()[i]
								  , employeeVO.getLicDates()[i]
								  , UUID.randomUUID().toString()
								  , employeeVO.getMemId()
						);
						employeeLicenseList.add(license);
						licNo++;
					} catch (IOException e) {
						e.printStackTrace();
					}
				}	
				
				employeeVO.setLicenseList(employeeLicenseList);
				rowcnt += licDAO.insertLicenses(employeeVO);
				try {
					employeeVO.saveToEmpLic(saveFolder);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(employeeVO.getEmpImg()!=null) {
				try {
					deleteEmpImg(employeeVO.getEmpImg());
					employeeVO.saveToEmpImg(saveFolder);
					rowcnt+=1;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(rowcnt>0) {
				result = ServiceResult.OK;
			}
		
		return result;
	}


	private void deleteEmpImg(String savedEmpImg) {
		
		if(StringUtils.isNotBlank(savedEmpImg)) {
			(new File(saveFolder, savedEmpImg)).delete();
		}
	}
	
	private void deleteAllLicense(EmployeeVO employeeVO) {
		List<LicenseVO> savedEmpLicenses = licDAO.selectEmpLicenseList(employeeVO);
		if(savedEmpLicenses!=null) {
			for(int i = 0; i<savedEmpLicenses.size(); i++) {
					(new File(saveFolder, savedEmpLicenses.get(i).getLicImg())).delete();
			}	
		}
		licDAO.deleteAllLicense(employeeVO);
	}
	
	@Override
	public LicenseVO retrieveLicenseImage(LicenseVO licEmp) {
		return licDAO.selectLicenseImage(licEmp);
	}

}

