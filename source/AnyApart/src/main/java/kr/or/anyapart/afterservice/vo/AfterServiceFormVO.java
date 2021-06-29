package kr.or.anyapart.afterservice.vo;


public class AfterServiceFormVO {
	private AfterServiceVO afterServiceVO;
	private AfterServiceVO searchRmdlVO;
	
	/**
	 * 
	 */
	public AfterServiceFormVO() {
		this.afterServiceVO = new AfterServiceVO();
		this.searchRmdlVO = new AfterServiceVO();
	}
	/**
	 * @return the afterServiceVO
	 */
	public AfterServiceVO getAfterServiceVO() {
		return afterServiceVO;
	}
	/**
	 * @param afterServiceVO the afterServiceVO to set
	 */
	public void setAfterServiceVO(AfterServiceVO afterServiceVO) {
		this.afterServiceVO = afterServiceVO;
	}
	/**
	 * @return the searchRmdlVO
	 */
	public AfterServiceVO getSearchRmdlVO() {
		return searchRmdlVO;
	}
	/**
	 * @param searchRmdlVO the searchRmdlVO to set
	 */
	public void setSearchRmdlVO(AfterServiceVO searchRmdlVO) {
		this.searchRmdlVO = searchRmdlVO;
	}
	
	
}
