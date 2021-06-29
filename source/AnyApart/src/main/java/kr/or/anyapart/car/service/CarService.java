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

package kr.or.anyapart.car.service;

import java.util.List;

import kr.or.anyapart.car.vo.CarIOVO;
import kr.or.anyapart.car.vo.CarVO;
import kr.or.anyapart.car.vo.EnrollcarVO;
import kr.or.anyapart.commons.enumpkg.ServiceResult;
import kr.or.anyapart.resident.vo.ResidentVO;
import kr.or.anyapart.vo.CodeVO;
import kr.or.anyapart.vo.MemberVO;

public interface CarService {
	/**
	 * 입주민 차량 조회
	 * @param mem id 들어있는 residentVO
	 * @return 등록된 차량 리스트
	 * @author 이경륜
	 */
	public List<CarVO> retrieveCarListByMemId(ResidentVO residentVO);

	public int sameCarNoSelete(CarVO carVO);

	public ServiceResult residentCarAdd(CarVO carVO);

	public List<CarVO> userInpossessionCarList(MemberVO authMember);

	public List<CodeVO> carCodeList();

	public List<EnrollcarVO> enrollList(MemberVO authMember);

	public List<EnrollcarVO> carAllList(EnrollcarVO enVO);

	public EnrollcarVO carSumNumber(MemberVO authMember);

	public ServiceResult enrollreJect(EnrollcarVO enVO);

	public List<EnrollcarVO> residentCarListALL(EnrollcarVO enVO);

	public EnrollcarVO carAllSumNumber(MemberVO authMember);

	public List<EnrollcarVO> dongList(EnrollcarVO enVO);

	public ResidentVO residentInfo(ResidentVO residentVO);

	public ServiceResult officeCarAdd(CarVO carVO);

	public ServiceResult residentCarDelete(CarVO carVO);

	public List<CarIOVO> carIOList(CarIOVO carVO);

	public ServiceResult selectCarNum(CarVO carNumber);

	public int inCarCount(MemberVO authMember);

	public String necarNumber();

}
