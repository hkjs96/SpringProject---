package kr.or.anyapart.commons.enumpkg;

public enum ServerKind {
	NAVER(new ServerSpec("smtp.naver.com", "smtp", 587), new ServerSpec("pop.naver.com", "pop3s", 995),
			new ServerSpec("imap.naver.com", "imaps", 993)),
	GMAIL(new ServerSpec("smtp.gmail.com", "smtp", 587), new ServerSpec("pop.gmail.com", "pop3s", 995),
			new ServerSpec("imap.gmail.com", "imaps", 993));
	ServerKind(ServerSpec smtp, ServerSpec pop, ServerSpec imap) {
		this.smtp = smtp;
		this.pop = pop;
		this.imap = imap;
	}

	private ServerSpec smtp;
	private ServerSpec pop;
	private ServerSpec imap;

	public ServerSpec getSmtp() {
		return smtp;
	}

	public ServerSpec getPop() {
		return pop;
	}

	public ServerSpec getImap() {
		return imap;
	}

	public static class ServerSpec {
		private String host;
		private Integer port;
		private String name;

		public ServerSpec(String host, String name, Integer port) {
			this.host = host;
			this.name = name;
			this.port = port;
		}

		public String getHost() {
			return host;
		}

		public String getName() {
			return name;
		}

		public Integer getPort() {
			return port;
		}
	}
}