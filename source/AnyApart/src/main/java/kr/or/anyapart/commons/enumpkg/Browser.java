package kr.or.anyapart.commons.enumpkg;

public enum Browser{
	EDG("엣지"), CHROME("크롬"), TRIDENT("익스플로러"), OTHER("기타");
	
	private String browserName;
	Browser(String browserName){
		this.browserName = browserName;
	}
	public String getBrowser(){
		return browserName;
	}
	
	public static Browser getBrowserConstant(String agent) {
		Browser[] browsers = values();
		Browser finded = OTHER;
		for(Browser temp : browsers){
			if(agent.toUpperCase().contains(temp.name())){
				finded = temp;
				break;
			}
		}
		return finded;
	} 
	public static String getBrowserName(String agent){
		return getBrowserConstant(agent).getBrowser();
	}
}





