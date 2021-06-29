package kr.or.anyapart.vendorDashboard.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(exclude= {"qnaTotal", "qnareplyTotal", "aptCode", "notQnareply"})
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DashboardVO {
	private String qnaTotal;
	private String qnareplyTotal;
	private String aptCode;
	private String notQnareply;
	private String monday;
	private String year;
}
