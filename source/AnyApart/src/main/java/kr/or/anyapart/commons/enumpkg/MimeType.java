package kr.or.anyapart.commons.enumpkg;

import javax.servlet.http.HttpServletRequest;

public  enum MimeType{
	HTML("text/html;charset=UTF-8"), PLAIN("text/plain;charset=UTF-8"), 
	XML("application/xml;charset=UTF-8"), JSON("application/json;charset=UTF-8"), 
	JAVASCRIPT("text/javascript;charset=UTF-8");
	private String mime;
	private MimeType(String mime) {
		this.mime = mime;
	}
	public String getMime() {
		return mime;
	}
	@Override
	public String toString() {
		return getMime();
	}
	
	public static MimeType parseAcceptToMimeType(HttpServletRequest req){
		String accept = req.getHeader("Accept");
		MimeType mime = MimeType.HTML;
		for(MimeType tmp : values()) {
			if(accept.toUpperCase().contains(tmp.name())) {
				mime = tmp;
				break;
			}
		}
		return mime;
	}
}