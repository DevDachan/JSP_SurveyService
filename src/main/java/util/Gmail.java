package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{
	@Override
	// 해당 내용은 관리자 권한으로 사용자에게 보낼 메일을 위해 관리자 아이디와 비밀번호를 입력
	// 보안에 문제가 되기 때문에 protected method type으로 보호해준다.
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("dachan9524@gmail.com","mjdppawewxspdnag");	
	}
	
}
