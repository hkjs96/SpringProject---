/**
 * @author 박정민
 * @since 2021. 2. 25.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 25.       박정민            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.meter.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.commonsweb.controller.BaseController;
import kr.or.anyapart.meter.dao.IMeterCommDAO;
import kr.or.anyapart.meter.dao.IMeterIndvDAO;
import kr.or.anyapart.meter.service.IMeterCommService;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.meter.vo.MeterIndvVO;
import kr.or.anyapart.vo.MemberVO;

@Controller
public class MeterAllController extends BaseController{
	
	@Inject
	private IMeterCommDAO daoC;
	
	@Inject
	private IMeterIndvDAO daoI;
	
	@Inject
	private IMeterCommService service;
	
	@RequestMapping("/office/meter/meterAllList.do")
	public String meterAllList(Model model, MeterCommVO cmVO, MeterIndvVO miVO,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO) {
		MeterCommVO thisMonthVO = new MeterCommVO();
		MeterCommVO preMonthVO = new MeterCommVO();
		Calendar calendar = Calendar.getInstance();
		
		calendar.add(Calendar.MONTH, -1);
		SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyyMM");
		String commYear = dateFormat1.format(calendar.getTime()).substring(0,4);
		String commMonth = dateFormat1.format(calendar.getTime()).substring(4,6);
//		이번달 검침량 조회
		thisMonthVO.setCommYear(Integer.parseInt(commYear));
		thisMonthVO.setCommMonth(Integer.parseInt(commMonth));
		thisMonthVO.setAptCode(authMemberVO.getAptCode());
		
//		지난달 검침량 조회
		calendar.add(Calendar.MONTH, -1);
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyyMM");
		String commPreYear = dateFormat2.format(calendar.getTime()).substring(0,4);
		String commPreMonth = dateFormat2.format(calendar.getTime()).substring(4,6);
		preMonthVO.setCommYear(Integer.parseInt(commPreYear));
		preMonthVO.setCommMonth(Integer.parseInt(commPreMonth));
		preMonthVO.setAptCode(authMemberVO.getAptCode());
		
		MeterCommVO thisMonthMCVO = null;
		MeterCommVO preMonthMCVO = null;
		ApartVO apart = null;
		try {
			thisMonthMCVO = daoC.selectExcelCommMeter(thisMonthVO);
			preMonthMCVO = daoC.selectExcelCommMeter(preMonthVO);
			apart = service.selectApart(authMemberVO);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		
		model.addAttribute("thisMonthMCVO", thisMonthMCVO);
		model.addAttribute("preMonthMCVO", preMonthMCVO);
		model.addAttribute("apart", apart);
		return "meter/meterAllList";
	}
	
	/**
	 * 이번년도 공동검침량 조회 ajax
	 * @param model
	 * @param miVO
	 * @return
	 */
	@RequestMapping(value="/office/meter/meterCommByEnergyAjax.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<MeterCommVO> meterCommByEnergyAjax(Model model, @Param("year")String year,
			@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO) {
		MeterCommVO thisMonthVO = new MeterCommVO();
		if("0000".equals(year)) {
			Calendar calendar = Calendar.getInstance();
			
			calendar.add(Calendar.MONTH, -1);
			SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyyMM");
			String commYear = dateFormat1.format(calendar.getTime()).substring(0,4);
			thisMonthVO.setCommYear(Integer.parseInt(commYear));
		}else {
			thisMonthVO.setCommYear(Integer.parseInt(year));
		}
		
		thisMonthVO.setAptCode(authMemberVO.getAptCode());
		List<MeterCommVO> thisYearList  = new ArrayList<>();
		try {
			thisYearList = daoC.selectMeterCommThisYear(thisMonthVO);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		return thisYearList;
	}
	
	/**
	 * 세대검침 동에따른 에너지 검침량 조회 ajax
	 * @param model
	 * @param miVO
	 * @return
	 */
	@RequestMapping(value="/office/meter/meterIndvByEnergyAjax.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<MeterIndvVO> meterIndvByEnergyAjax(Model model, MeterIndvVO miVO, 
			@AuthenticationPrincipal(expression="realMember")MemberVO authMemberVO) {
		if(miVO.getIndvYear()==0) {
			Calendar calendar = Calendar.getInstance();
			
			calendar.add(Calendar.MONTH, -1);
			SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyyMM");
			String year = dateFormat1.format(calendar.getTime()).substring(0,4);
			miVO.setIndvYear(Integer.parseInt(year));
		}
		miVO.setAptCode(authMemberVO.getAptCode());
		List<MeterIndvVO> dongListByEnergy = new ArrayList<>();
		try {
			dongListByEnergy = daoI.selectMeterIndvEnergyList(miVO);
		}catch (Exception e) {
			LOGGER.info(""+e);
		}
		return dongListByEnergy;
	}
	
	
	
	
	
	
	
}
