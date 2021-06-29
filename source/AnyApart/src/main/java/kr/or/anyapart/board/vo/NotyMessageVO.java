package kr.or.anyapart.board.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@AllArgsConstructor
@ToString
public class NotyMessageVO {
	public enum NotyType { alert, success, warning, error, info }
	public enum NotyLayout { top, topLeft, topCenter, topRight, center, centerLeft, centerRight, bottom, bottomLeft, bottomCenter, bottomRight	}
	
	private String text;
	private NotyType type;
	private NotyLayout layout;
	private long timeout;

	public static NotyMessageVOBuilder builder(String text) {
		return new NotyMessageVOBuilder(text);
	}
	public static class NotyMessageVOBuilder{
		NotyMessageVOBuilder(String text) {
			this.text = text;
		}
		private String text;
		private NotyType type = NotyType.error;
		private NotyLayout layout = NotyLayout.topCenter;
		private long timeout = 3000;
		
		public NotyMessageVOBuilder text(String text) {
			this.text = text;
			return this;
		}
		public NotyMessageVOBuilder type(NotyType type) {
			this.type = type;
			return this;
		}
		public NotyMessageVOBuilder layout(NotyLayout layout) {
			this.layout = layout;
			return this;
		}
		public NotyMessageVOBuilder timeout(long timeout) {
			this.timeout = timeout;
			return this;
		}
		
		public NotyMessageVO build() {
			return new NotyMessageVO(text, type, layout, timeout);
		}
	}
}
