/**
 * @author 박지수
 * @since 2021. 2. 5.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 5.      박지수       최초작성
 * 2021. 2. 9.      박지수       PasswordEncoder @inject 방식으로 변경
 * Copyright (c) 2021 by DDIT All right reserved
 * </pre>
 */

package kr.or.anyapart.auth.service;

import java.util.Properties;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.anyapart.auth.dao.IAuthDAO;
import kr.or.anyapart.commons.enumpkg.ServerKind;
import kr.or.anyapart.commons.enumpkg.ServerKind.ServerSpec;
import kr.or.anyapart.vo.MemberVO;

@Service
public class AuthServiceImpl implements AuthService {

	@Inject
	private PasswordEncoder pwEncoder;
	
	@Inject
	private IAuthDAO dao;

	/*
	 * [회원 ID 조회]
	 */
	@Override
	public MemberVO retrieveId(MemberVO member) {
		return dao.retrieveMember(member);
	}

	/*
	 * [존재하는 회원인지 조회]
	 */
	@Override
	public String retrieveMember(MemberVO member) {
		Object obj = dao.retrieveMember(member);
		String certNum = null;
		if (obj != null) {
			certNum = mailSend(member);
		}
		return certNum;
	}

	public String mailSend(MemberVO member) {
		ServerSpec mailServer = ServerKind.GMAIL.getSmtp();
		String username = "hkjs9620";
		String password = "gqhqpumkxhgfdfke";
		String to = member.getMemEmail();
		String from = "AnyApart";

		// 1) MailSender 기본 설정
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost(mailServer.getHost());
		mailSender.setPort(mailServer.getPort());
		mailSender.setUsername(username);
		mailSender.setPassword(password);
		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", true);
		mailSender.setJavaMailProperties(props);

		String certNum = RandomStringUtils.randomNumeric(6);
		// 2) SimpleMailMessage를 이용한 메시지 설정
		SimpleMailMessage mail = new SimpleMailMessage();
		mail.setTo(to);
		mail.setFrom(from);
		mail.setSubject("AnyApart ID/PW 찾기 인증번호");
		mail.setText("인증번호 : " + certNum);

		// 3) 전송
		mailSender.send(mail);
		System.out.println("전송 완료");
		return certNum;
	}

	/*
	 * [메일로 비밀번호 변경 페이지 전송]
	 */
	@Override
	public String passSite(MemberVO member, String site) {
		ServerSpec mailServer = ServerKind.GMAIL.getSmtp();
		String username = "hkjs9620";
		String password = "gqhqpumkxhgfdfke";
		String to = member.getMemEmail();
		String from = "AnyApart";

		// 1) MailSender 기본 설정
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost(mailServer.getHost());
		mailSender.setPort(mailServer.getPort());
		mailSender.setUsername(username);
		mailSender.setPassword(password);
		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", true);
		mailSender.setJavaMailProperties(props);
		
		// 2) javax.mail.internet.MimeMessage 객체를 직접 생성하기 위해
		// MimeMessagePreparator를 콜백 인터페이스로 사용한다.
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
			mimeMessage.setFrom(from);
			mimeMessage.setRecipients(RecipientType.TO, to);
			mimeMessage.setSubject("AnyApart PW link");
			StringBuffer html = new StringBuffer();
			
			html.append("<a href='"+site+"' onClick=\"window.open(this.href, '', 'width=400, height=400'); return false;\">패스워드 변경</h4>");
			mimeMessage.setContent(
			html.toString(), "text/html;charset=UTF-8");
			}
		};
		// 3) 전송시 콜백 객체를 send 메소드에 인자로 넘긴다.
		mailSender.send(preparator);
		System.out.println("전송 완료");

		return "OK";
	}

	/* 
	 * [회원 비밀번호 변경]
	 */
	@Override
	public void modifyPass(MemberVO member) {
		
		// 비밀번호 암호화 로직이 들어가야한다.
		pwEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		member.setMemPass(pwEncoder.encode(member.getMemPass()));
		
		int rowcnt =  dao.updatePass(member);
		if(rowcnt == 0) {
			throw new RuntimeException("변경되지 않음");
		}
	}
}
