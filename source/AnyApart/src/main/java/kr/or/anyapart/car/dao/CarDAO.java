/**
 * @author 이경륜
 * @since 2021. 2. 15.
 * @version 1.0
 * @see 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 15.         이경륜            최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.car.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.anyapart.car.vo.CarIOVO;
import kr.or.anyapart.car.vo.CarVO;
import kr.or.anyapart.car.vo.EnrollcarVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.maintenancecost.vo.CostVO;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;

@Repository
public interface CarDAO {
	/**
	 * 입주민 차량 조회
	 * @param mem id 들어있는 residentVO
	 * @return 등록된 차량 리스트
	 * @author 이경륜
	 */
	public List<CarVO> selectCarListForMoveout(ResidentVO residentVO);

	
	/**
	 * 입주민 차량 등록전 체크
	 * @param carVO
	 * @return
	 */
	public int sameCarNoSelete(CarVO carVO);
	
	/**
	 * 차량 등록 
	 * @param carVO
	 * @return
	 */
	public int residentCarAdd(CarVO carVO);

	/**
	 * 소유중인 자동차 리스트 조회
	 * @param authMember
	 * @return
	 */
	public List<CarVO> userInpossessionCarList(MemberVO authMember);

	/**
	 * 자동차 크기 코드 샐랙트
	 * @return
	 */
	public List<CodeVO> carCodeList();

	/**
	 * 자동차 신청 내역
	 * @param authMember
	 * @return
	 */
	public List<EnrollcarVO> enrollList(MemberVO authMember);

	
	/** 
	 * [관리사무소 ] 모든 차량 조회 
	 * @param authMember
	 * @return
	 */
	public List<EnrollcarVO> carAllList(EnrollcarVO enVO);


	public EnrollcarVO carSumNumber(MemberVO authmember);


	public int enrollreUpdate(EnrollcarVO enVO);


	public int carUpdate(EnrollcarVO enVO);


	public List<EnrollcarVO> residentCarListALL(EnrollcarVO enVO);


	public EnrollcarVO carALLSumNumber(MemberVO authmember);


	public List<EnrollcarVO> dougList(EnrollcarVO enVO);


	public ResidentVO residentInfo(ResidentVO residentVO);


	public int officeCarAdd(CarVO carVO);


	public int residentCarDelete(CarVO carVO);


	public int residentCarDelete2(CarVO carVO);


	public List<CarIOVO> carIOList(CarIOVO carVO);


	public CarVO selectCarNum(CarVO carNumber);


	public int carIOAdd(CarVO carVO);


	public CarIOVO whatIO(CarVO carVO);


	public int inCarList(MemberVO authMember);


	public String newCarNumber();


}
