/**
 * @author 박 찬
 * @since 2021. 2. 15.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 15.         이경륜            최초작성
 * 2021. 3. 08.         박찬                관리사무소 차량 관리
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.car.service;

import java.util.List;

import javax.inject.Inject;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import kr.or.anyapart.car.dao.CarDAO;
import kr.or.anyapart.car.vo.CarIOVO;
import kr.or.anyapart.car.vo.CarVO;
import kr.or.anyapart.car.vo.EnrollcarVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;

@Service
public class CarServiceImpl implements CarService {

	@Inject
	private CarDAO carDAO;
	
	@Override
	public List<CarVO> retrieveCarListByMemId(ResidentVO residentVO) {
		return carDAO.selectCarListForMoveout(residentVO);
	}

	@Override
	public int sameCarNoSelete(CarVO carVO) {
		
		return carDAO.sameCarNoSelete(carVO);
	}
	
	@Transactional
	@Override
	public ServiceResult residentCarAdd(CarVO carVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = sameCarNoSelete(carVO);
		if(cnt != 0 ) {
			return result;
		}else {
			int createCnt = carDAO.residentCarAdd(carVO);
			if(createCnt >0) {
				result = ServiceResult.OK;
			}
			else {
				result = ServiceResult.INVALIDPASSWORD;
			}
		}
		return result;
	}

	@Override
	public List<CarVO> userInpossessionCarList(MemberVO authMember) {
	
		return carDAO.userInpossessionCarList(authMember);
	}

	@Override
	public List<CodeVO> carCodeList() {
		return carDAO.carCodeList();
	}

	@Override
	public List<EnrollcarVO> enrollList(MemberVO authMember) {
		
		return carDAO.enrollList(authMember);
	}

	@Override
	public List<EnrollcarVO> carAllList(EnrollcarVO enVO) {
		
		return carDAO.carAllList(enVO);
	}

	@Override
	public EnrollcarVO carSumNumber(MemberVO authmember) {
		// TODO Auto-generated method stub
		return carDAO.carSumNumber(authmember);
	}

	@Override
	public ServiceResult enrollreJect(EnrollcarVO enVO) {
		ServiceResult result=null;
		int cnt = carDAO.enrollreUpdate(enVO);
		if(cnt > 0) {
			cnt += carDAO.carUpdate(enVO);
			result = cnt>1? ServiceResult.OK : ServiceResult.FAILED;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<EnrollcarVO> residentCarListALL(EnrollcarVO enVO) {
		return carDAO.residentCarListALL(enVO);
	}

	@Override
	public EnrollcarVO carAllSumNumber(MemberVO authmember) {
		return carDAO.carALLSumNumber(authmember);
	}

	@Override
	public List<EnrollcarVO> dongList(EnrollcarVO enVO) {
		return carDAO.dougList(enVO);
	}

	@Override
	public ResidentVO residentInfo(ResidentVO residentVO) {
		String ho = residentVO.getHo();
		if(ho.length()<=3) {
			residentVO.setHo("0"+ho);
		}
		ResidentVO userInfo= carDAO.residentInfo(residentVO);
		MemberVO mem = new MemberVO();
		if(userInfo != null){
			mem.setMemId(userInfo.getMemId());
			userInfo.setCarList(carDAO.userInpossessionCarList(mem));
		}
		return userInfo;
	}

	@Override
	public ServiceResult officeCarAdd(CarVO carVO) {
		ServiceResult result = ServiceResult.FAILED;
		int cnt = sameCarNoSelete(carVO);
		if(cnt != 0 ) {
			return result;
		}else {
			int createCnt = carDAO.officeCarAdd(carVO);
			if(createCnt >0) {
				result = ServiceResult.OK;
			}
			else {
				result = ServiceResult.INVALIDPASSWORD;
			}
		}
		return result;
	}

	@Override
	public ServiceResult residentCarDelete(CarVO carVO) {
		ServiceResult result =ServiceResult.FAILED;
		int cnt =carDAO.residentCarDelete(carVO);
		    if(cnt>0) {
		    	cnt += carDAO.residentCarDelete2(carVO);
		    	if(cnt>1) {
		    		result = ServiceResult.OK;
		    	}else {
		    		result =ServiceResult.FAILED;
		    	}
		    }else {
		    	result= ServiceResult.FAILED;
		    }
		return result;
	}

	@Override
	public List<CarIOVO> carIOList(CarIOVO carVO) {

		List<CarIOVO> carIOList = carDAO.carIOList(carVO);
		return carIOList;
	}

	@Override
	public ServiceResult selectCarNum(CarVO carNumber) {
		ServiceResult result = ServiceResult.FAILED;
		CarVO carVO = carDAO.selectCarNum(carNumber);
		if(carVO==null || carVO.getMemId().equals("")) {
			//등록이 안된 차량일 경우
			result=ServiceResult.FAILED;
		}else {//등록 된차량일 경우

			//등록된 차량최근 방문 기록 조회하여 입차출차 현황조회
			CarIOVO whatIO = carDAO.whatIO(carVO);
			if(whatIO ==null || whatIO.getCarIochk().equals("O")) {
				//현재 상태가 출차일경우
				carVO.setCarIochk("I");
			}else if(whatIO.getCarIochk().equals("I")) {
				//현재 상태가 입차일떄
				carVO.setCarIochk("O");
			}
			int cnt = carDAO.carIOAdd(carVO);
			result=ServiceResult.OK;
		}
		return result;
	}

	@Override
	public int inCarCount(MemberVO authMember) {
		int inCarNumber = carDAO.inCarList(authMember);
		return inCarNumber;
	}

	@Override
	public String necarNumber() {
		return carDAO.newCarNumber();
	}
}
