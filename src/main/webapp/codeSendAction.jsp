<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="util.Gmail" %>
<%@ page import="util.SHA256" %>

<%@ page import="java.util.*" %>
<%@ page import='java.net.URLEncoder' %>

<%
	//사용자로부터 입력받는 것은 모두 UTF-8을 사용하겠다.
	request.setCharacterEncoding("UTF-8");
	String userEmail = null;
	String result = "Error";
	// 만약 사용자에게 data가 올바르게 들어왔을 경우(request) 해당 data를 local instance에 넣기
	if(request.getParameter("userEmail")!= null ){
		userEmail = request.getParameter("userEmail");			
		UserDAO userDAO = new UserDAO(application);
		
		String randomCode = "";
		double rand = Math.random();
	    randomCode = Double.toString(rand).substring(2, 10);
		int setResult = userDAO.setUserCode(userEmail,randomCode);
		
		if(setResult == 1){
			String host = "http://localhost:8080/Survey_project/";
			String from = "dachan9524@gmail.com";
			String to = userEmail;
			String subject = "회원가입을 위한 이메일 인증 메일입니다.";
			String content = "다음 코드를 입력하여 이메일 인증을 진행하세요.\n" +
			"Code = " + randomCode;
			Properties p = new Properties();
			p.put("mail.smtp.user",from);
			p.put("mail.smtp.host","smtp.googlemail.com");
			p.put("mail.smtp.port","465");
			p.put("mail.smtp.starttls.enable","true");
			p.put("mail.smtp.auth","true");
			p.put("mail.smtp.debug","true");
			p.put("mail.smtp.socketFactory.port","465");
			p.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			p.put("mail.smtp.socketFactory.fallback","false");
	
			// 강의 이후 추가해야하는 부분
			p.put("mail.smtp.ssl.protocols", "TLSv1.2");
			p.put("mail.smtp.ssl.enable", "true");
	
			try{
				Authenticator auth = new Gmail();
				Session ses = Session.getInstance(p, auth);
				ses.setDebug(true);
				MimeMessage msg = new MimeMessage(ses);
				msg.setSubject(subject);
				Address fromAddr = new InternetAddress(from);
				msg.setFrom(fromAddr);
				Address toAddr = new InternetAddress(to);
				msg.addRecipient(Message.RecipientType.TO, toAddr);
				msg.setContent(content, "text/html;charset=UTF8");
				Transport.send(msg);
			} catch(Exception e){
				e.printStackTrace();
		%>
				<jsp:include page='alert.jsp'> 
						<jsp:param name="title" value="<%=URLEncoder.encode(\"Error\", \"UTF-8\") %>" />
						<jsp:param name="content" value="<%=URLEncoder.encode(\"오류가 발생했습니다.\", \"UTF-8\") %>" />
						<jsp:param name="url" value="location.href = 'index.jsp';" />
				</jsp:include>	
		<% 		
			}
			
				result = "Success";
			}else{
				result = "Mail Error";
			}
			userDAO.endclose();
		}else{
			result = "DB Error";
		}
		
%>


{
<%= result %>
}
