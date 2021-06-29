package kr.or.anyapart.commons.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

import kr.or.anyapart.commonsweb.dao.FareRateDAO;
import kr.or.anyapart.vo.FareRateVO;

@Component
public class WebApplicationContextInitializeListener {
	private static final Logger LOGGER = LoggerFactory.getLogger(WebApplicationContextInitializeListener.class);
	
	@Inject
	private FareRateDAO farerateDAO;
	
	@EventListener(classes=ContextRefreshedEvent.class)
	public void initialize(ContextRefreshedEvent event) {
		WebApplicationContext container =  (WebApplicationContext) event.getApplicationContext();
		ServletContext application = container.getServletContext();
		application.setAttribute("cPath", application.getContextPath());
		LOGGER.info("{} 컨텍스트  초기화, Root 컨테이너 초기화.", application.getContextPath());
		
		Map<String, Float> frMap = getFarerateMap();
		if(frMap!=null) {
			application.setAttribute("frMap", frMap);
			LOGGER.info("FARERATE 요금산정표 로드됨");
		}
	}
	
	/**
	 * 요금비율 산정표 로드
	 * @return key: 항목명 value: 해당하는 요금/비율 float
	 * @author 이경륜
	 * @since 21.02.23
	 */
	public Map<String, Float> getFarerateMap() {
		Map<String, Float> farerateMap = new HashMap<String, Float>();

		List<FareRateVO> farerateList  = farerateDAO.selectFareRateList();
		if(farerateList.size()>0) {
			
			for(FareRateVO fr : farerateList) {
				farerateMap.put(fr.getFrId(), fr.getFr());
			}
		}
		return farerateMap;
	}
}




















