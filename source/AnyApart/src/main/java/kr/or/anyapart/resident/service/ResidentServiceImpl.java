/**
 * @author 이경륜
 * @since 2021. 2. 4.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 4.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.resident.service;

import java.util.List;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.anyapart.apart.vo.HouseVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.dao.ResidentDAO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.MemberVO;
import kr.or.anyapart.vo.PagingVO;

@Service
public class ResidentServiceImpl implements ResidentService {

	@Inject
	private PasswordEncoder pwEncoder;
	
	@Inject
	private ResidentDAO residentDAO;
	
	@Override
	public int retrieveResidentCount(PagingVO<ResidentVO> pagingVO) {
		return residentDAO.selectResidentCount(pagingVO);
	}

	@Override
	public List<ResidentVO> retrieveResidentList(PagingVO<ResidentVO> pagingVO) {
		return residentDAO.selectResidentList(pagingVO);
	}

	@Override
	public List<HouseVO> retrieveDongList(HouseVO house) {
		return residentDAO.selectDongList(house);
	}

	@Override
	public List<HouseVO> retrieveHoList(HouseVO house) {
		return residentDAO.selectHoList(house);
	}

	@Transactional
	@Override
	public ServiceResult createResident(ResidentVO residentVO) {
		ServiceResult result = ServiceResult.FAILED;
		
		// 1. HOUSE 테이블 조회하여 MOVE_YN='N'인 경우에 진행
		String moveYn = residentDAO.selectHouseMoveYn(residentVO);
		if("N".equals(moveYn)) {
			// 2. MEMBER 테이블에 INSERT
			String encoded = pwEncoder.encode(residentVO.getResHp()); // 초기비밀번호 구성방법 생각해야함
			MemberVO member = MemberVO.builder()
									.aptCode(residentVO.getAptCode()) /* selectKey때문에 필요 */
									.memPass(encoded)
									.memName(residentVO.getResName())
									.memNick(residentVO.getResName())
									.memEmail(residentVO.getResMail())
									.memRole("ROLE_RES")
									.memDelete("N")
									.build();
			int memCnt = residentDAO.insertMember(member);
			if(memCnt > 0) {
				// 3. RESIDENT 테이블에 INSERT
				residentVO.setMemId(member.getMemId());
				int resCnt = residentDAO.insertResident(residentVO);
				
				if(resCnt > 0) {
					// 4. HOUSE 테이블 UPDATE 
					int houseCnt = residentDAO.updateHouseMoveYn(residentVO);
					// 5. 모두 완료되면 성공
					result = ServiceResult.OK;
				}
			}
		}else {
			result = ServiceResult.ALREADYEXIST;
		}
		return result;
	}

	@Override
	public ServiceResult modifyResident(ResidentVO residentVO) {
		ServiceResult result = null;
		int cnt = residentDAO.updateResident(residentVO);
		result = cnt>0? ServiceResult.OK : ServiceResult.FAILED;
		return result;
	}

	@Transactional
	@Override
	public ServiceResult createMuitlpleResident(List<ResidentVO> residentList) {
		ServiceResult result = ServiceResult.FAILED;
		int listCnt = residentList.size();
		if(listCnt == 0) { // 파일의 데이터를 읽어들이지 못했을때
			return result;
		}
		int insertCnt = 0;
		
		for(ResidentVO residentVO : residentList) {
			/*
			 * 임시 하우스코드
			 */
			StringBuffer houseCode = new StringBuffer();
			houseCode.append(residentVO.getAptCode())
					 .append("D")
					 .append(residentVO.getDong())
					 .append("H")
					 .append(residentVO.getHo().length() == 3 ? "0" + residentVO.getHo() : residentVO.getHo());
			
			residentVO.setHouseCode(houseCode.toString());
			ServiceResult singleResult = createResident(residentVO); 
			if(singleResult == ServiceResult.OK) {
				insertCnt++;
			}else if(singleResult == ServiceResult.ALREADYEXIST ){// 
				result = singleResult;
				return result;
			}
		}
		if(listCnt == insertCnt) result = ServiceResult.OK;
		
		return result;
	}

	@Override
	public int retrieveMoveoutResidentCount(PagingVO<ResidentVO> pagingVO) {
		return residentDAO.selectMoveoutResidentCount(pagingVO);
	}

	@Override
	public List<ResidentVO> retrieveMoveoutResidentList(PagingVO<ResidentVO> pagingVO) {
		return residentDAO.selectMoveoutResidentList(pagingVO);
	}

	@Override
	public ResidentVO retrieveMoveoutResident(ResidentVO residentVO) {
		return residentDAO.selectMoveoutResident(residentVO);
	}

	@Override
	public ResidentVO retrieveResidentByHouseCode(ResidentVO residentVO) {
		return residentDAO.selectResidentByHouseCode(residentVO);
	}

	@Override
	public void removeResident(ResidentVO residentVO) {
		residentDAO.deleteResident(residentVO);
	}

	@Override
	public void cancelResidentMoveout(ResidentVO residentVO) {
		residentDAO.cancelResidentMoveout(residentVO);
	}

	@Override
	public List<ResidentVO> retrieveMoveinCntMonthly(ResidentVO residentVO) {
		return residentDAO.selectMoveinCntMonthly(residentVO);
	}

	@Override
	public List<ResidentVO> retrieveMoveoutCntMonthly(ResidentVO residentVO) {
		return residentDAO.selectMoveoutCntMonthly(residentVO);
	}

	@Override
	public List<HouseVO> retrieveHouseInfoBySpace(CostVO cost) {
		return residentDAO.selectHouseInfoBySpace(cost);
	}

}
