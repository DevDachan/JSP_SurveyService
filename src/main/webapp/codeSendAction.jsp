<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>

String userEmail = request.getParameter("userEmail");  
String userID = request.getParameter("userID");  

<%
	//사용자로부터 입력받는 것은 모두 UTF-8을 사용하겠다.
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userEmail = null;

	// 만약 사용자에게 data가 올바르게 들어왔을 경우(request) 해당 data를 local instance에 넣기
	if(request.getParameter("userID")!= null ){
		userID = request.getParameter("userID");			
	}
	if(request.getParameter("userEmail")!= null ){
		userEmail = request.getParameter("userEmail");			
	}
	// 하나라도 옳지 않은 내용이 존재하거나 null값이 존재 할 경우에는 오류 alert와 함께 이전 페이지로
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('ID를 입력해주세요');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	else if(userEmail == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이메일을 입력해 주세요');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	UserDAO userDAO = new UserDAO(application);
	int result = userDAO.setUserCode(userID, userEmail);
	
	
%>
