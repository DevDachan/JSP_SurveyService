<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%
	//사용자로부터 입력받는 것은 모두 UTF-8을 사용하겠다.
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	
	// 만약 사용자에게 data가 올바르게 들어왔을 경우(request) 해당 data를 local instance에 넣기
	if(request.getParameter("userID")!= null ){
		userID = request.getParameter("userID");			
	}
	if(request.getParameter("userPWD")!= null ){
		userPassword = request.getParameter("userPWD");			
	}
	if(request.getParameter("userEmail")!= null ){
		userEmail = request.getParameter("userEmail");			
	}
	// 하나라도 옳지 않은 내용이 존재하거나 null값이 존재 할 경우에는 오류 alert와 함께 이전 페이지로
	if(userID == null || userPassword == null || userEmail == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	UserDAO userDAO = new UserDAO(application);
	int result = userDAO.registerUser(userID, userPassword,userEmail);
	
	if(result == 1){
		session.setAttribute("userID",userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
	}else if (result == 2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}else if (result == 3){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 Email입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
%>
