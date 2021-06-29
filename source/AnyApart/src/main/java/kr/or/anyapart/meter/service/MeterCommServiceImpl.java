/**
 * @author 박정민
 * @since 2021. 2. 17.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Infomation)]]
 * 수정일                  수정자            수정내용
 * --------     --------   -----------------------
 * 2021. 2. 17.       박정민         최초작성
 * Copyright (c) 2021. 2. 17. by DDIT All right reserved
 * </pre>
 */
package kr.or.anyapart.meter.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.anyapart.apart.vo.ApartVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.meter.dao.IMeterCommDAO;
import kr.or.anyapart.meter.vo.MeterCommVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class MeterCommServiceImpl implements IMeterCommService{

	@Inject
	private IMeterCommDAO dao;
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#retreiveCommMeterCount(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public int retreiveCommMeterCount(PagingVO<MeterCommVO> pagingVO) {
		return dao.selectCommMeterCount(pagingVO);
	}
	
	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#retreiveCommMeterList(kr.or.anyapart.vo.PagingVO)
	 */
	@Override
	public List<MeterCommVO> retreiveCommMeterList(PagingVO<MeterCommVO> pagingVO) {
		return dao.selectCommMeterList(pagingVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#insertCommMeter(kr.or.anyapart.meter.vo.CommMeterVO)
	 */
	@Override
	public int insertCommMeter(MeterCommVO cmVO) {
		MeterCommVO commVO = dao.selectExcelCommMeter(cmVO);
		int cnt = 0;
		if(commVO!=null) {
			cnt = -1;
		}else {
			cnt = dao.insertCommMeter(cmVO);
		}
		return cnt;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#retreiveCommMeter(kr.or.anyapart.meter.vo.CommMeterVO)
	 */
	@Override
	public MeterCommVO retreiveCommMeter(MeterCommVO coMeterVO) {
		return dao.selectCommMeter(coMeterVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#updateCommMeter(kr.or.anyapart.meter.vo.CommMeterVO)
	 */
	@Override
	public int updateCommMeter(MeterCommVO cmVO) {
		return dao.updateCommMeter(cmVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#selectApart(kr.or.anyapart.vo.MemberVO)
	 */
	@Override
	public ApartVO selectApart(MemberVO authMemberVO) {
		return dao.selectApart(authMemberVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#createMuitlpleCommMeter(java.util.List)
	 */
	@Override
	public ServiceResult createMuitlpleCommMeter(List<MeterCommVO> commMeterList, MemberVO authMember) {
		ServiceResult result = ServiceResult.FAILED;
		if(commMeterList.size()!=0) {
			int cnt = 0;
			int chk = checkAlreadyComm(commMeterList, authMember);
			if(chk>0) {
				result = ServiceResult.ALREADYEXIST;
			}else {
				for(MeterCommVO cmVO : commMeterList) {
					cmVO.setAptCode(authMember.getAptCode());
					cnt += dao.insertCommMeter(cmVO);
				}
				if(cnt>=commMeterList.size()) {
					result = ServiceResult.OK;
				}
			}
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	/**
	 * @param commMeterList
	 * @return
	 */
	private int checkAlreadyComm(List<MeterCommVO> commMeterList, MemberVO authMember) {
		int chk = 0;
		for(MeterCommVO cmVO : commMeterList) {
			cmVO.setAptCode(authMember.getAptCode());
			MeterCommVO commMeterVO = dao.selectExcelCommMeter(cmVO);
			if(commMeterVO != null) {
				chk++;
				break;
			}
		}
		return chk;
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#deleteCommMeter(kr.or.anyapart.meter.vo.CommMeterVO)
	 */
	@Override
	public int deleteCommMeter(MeterCommVO cmVO) {
		return dao.deleteCommMeter(cmVO);
	}

	/* (non-Javadoc)
	 * @see kr.or.anyapart.meter.service.IMeterCommService#retreiveCommMeterTotalCnt()
	 */
	@Override
	public int retreiveCommMeterTotalCnt(PagingVO<MeterCommVO> pagingVO) {
		return dao.selectCommMeterTotalCnt(pagingVO);
	}

}
