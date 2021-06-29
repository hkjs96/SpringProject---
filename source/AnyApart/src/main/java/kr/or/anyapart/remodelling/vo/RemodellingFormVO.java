package kr.or.anyapart.remodelling.vo;


public class RemodellingFormVO {
	private RemodellingVO remodellingVO;
	private RemodellingVO searchRmdlVO;
	
	public RemodellingFormVO() {
		this.remodellingVO = new RemodellingVO();
		this.searchRmdlVO = new RemodellingVO();
	}

	public RemodellingVO getRemodellingVO() {
		return remodellingVO;
	}

	public void setRemodellingVO(RemodellingVO remodellingVO) {
		this.remodellingVO = remodellingVO;
	}

	public RemodellingVO getSearchRmdlVO() {
		return searchRmdlVO;
	}

	public void setSearchRmdlVO(RemodellingVO searchRmdlVO) {
		this.searchRmdlVO = searchRmdlVO;
	}
	
	
}
