/**
 * @author 박정민
 * @since 2021. 2. 23.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 23.       박정민         최초작성
 * Copyright (c) 2021. 2. 23. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.meter.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.meter.dao.IMeterIndvDAO;
import kr.or.anyapart.meter.vo.MeterIndvListVO;
import kr.or.anyapart.meter.vo.MeterIndvVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class MeterIndvServiceImpl implements IMeterIndvService{

	@Inject
	private IMeterIndvDAO dao;
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterIndvService#retreiveMeterIndvCount(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public int retreiveMeterIndvCount(PagingVO<MeterIndvVO> pagingVO) {
		return dao.selectMeterIndvCount(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterIndvService#retreiveMeterIndvList(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public List<MeterIndvVO> retreiveMeterIndvList(PagingVO<MeterIndvVO> pagingVO) {
		return dao.selectMeterIndvList(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterIndvService#createMuitlpleIndvMeter(java.util.List)
	 */
	@Override
	public ServiceResult createMuitlpleIndvMeter(List<MeterIndvVO> meterIndvList) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = 0;
		if(meterIndvList.size()!=0) {
			int chk = checkAlreayData(meterIndvList);
			if(chk>0) {
				result = ServiceResult.ALREADYEXIST;
			}else {
				for(MeterIndvVO miVO : meterIndvList) {
					cnt = dao.insertIndvMeter(miVO);
					if(cnt>0) {
						result = ServiceResult.OK;
					}
				}
			}
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	/**
	 * @param meterIndvList
	 * @return
	 */
	private int checkAlreayData(List<MeterIndvVO> meterIndvList) {
		int chk = 0;
		for(MeterIndvVO miVO : meterIndvList) {
			MeterIndvVO meterIndvVO = dao.selectExcelMeterIndv(miVO);
			if(meterIndvVO==null) {
				continue;
			}else {
				if(meterIndvVO.getIndvYear().equals(miVO.getIndvYear())
						&& meterIndvVO.getIndvMonth().equals(miVO.getIndvMonth())
						&& meterIndvVO.getMemId().equals(meterIndvVO.getMemId())) {
					chk++;
					break;
				}
			}
		}
		return chk;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterIndvService#deleteMeterIndv(kr.or.anyapart.meter.vo.MeterIndvVO)
	 */
	@Override
	public int deleteMeterIndv(MeterIndvVO miVO) {
		return dao.deleteMeterIndv(miVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterIndvService#updateMeterIndv(kr.or.anyapart.meter.vo.MeterIndvVO)
	 */
	@Override
	public ServiceResult updateMeterIndv(MeterIndvVO miVO) {
		ServiceResult result = ServiceResult.FAILED;
		ResidentVO residentVO = dao.selectResident(miVO);
		if(residentVO==null) {
			result = ServiceResult.INVALIDID;
		}else {
			int cnt = dao.updateMeterIndv(miVO);
			if(cnt>0) {
				result = ServiceResult.OK;
			}
		}
		return result;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterIndvService#retreiveMeterIndv(kr.or.anyapart.meter.vo.MeterIndvVO)
	 */
	@Override
	public MeterIndvVO retreiveMeterIndv(MeterIndvVO meterIndvVO) {
		return dao.selectMeterIndv(meterIndvVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterIndvService#insertMeterIndv(kr.or.anyapart.meter.vo.MeterIndvVO)
	 */
	@Override
	public int insertMeterIndv(MeterIndvListVO indvList) {
		List<MeterIndvVO> list = indvList.getIndvList();
		int cnt = 0;
		for(MeterIndvVO indv : list) {
			MeterIndvVO meterIndvVO = dao.selectExcelMeterIndv(indv);
			if(meterIndvVO!=null) { //이미 등록되어 있는 검침데이터
				cnt = -1;
				break;
			}
		}
		if(cnt!=-1) {
			cnt = dao.insertAllIndvMeter(indvList);
		}
		return cnt;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterIndvService#retreiveIndvMeterTotalCnt()
	 */
	@Override
	public int retreiveIndvMeterTotalCnt(PagingVO<MeterIndvVO> pagingVO) {
		return dao.selectIndvMeterTotalCnt(pagingVO);
	}

}
