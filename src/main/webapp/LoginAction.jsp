<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>

String userId = request.getParameter("userID"); 
String userPwd = request.getParameter("userPWD");  


<%
	//사용자로부터 입력받는 것은 모두 UTF-8을 사용하겠다.
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;

	// 만약 사용자에게 data가 올바르게 들어왔을 경우(request) 해당 data를 local instance에 넣기
	if(request.getParameter("userID")!= null ){
		userID = request.getParameter("userID");			
	}
	if(request.getParameter("userPWD")!= null ){
		userPassword = request.getParameter("userPWD");			
	}
	// 하나라도 옳지 않은 내용이 존재하거나 null값이 존재 할 경우에는 오류 alert와 함께 이전 페이지로
	if(userID == null || userPassword == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	UserDAO userDAO = new UserDAO(application);
	int result = userDAO.getUserData(userID, userPassword);
	
	if(result == 1){
		session.setAttribute("userID",userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
	}else if (result == -1){
		// 회원가입이 완료되면 해당 내용을 session에 저장 시키고 email인증이 되도록 하기
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}else if (result == 0){
		// 회원가입이 완료되면 해당 내용을 session에 저장 시키고 email인증이 되도록 하기
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('올바른 비밀번호를 입력해주세요.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}else{
		// 회원가입이 완료되면 해당 내용을 session에 저장 시키고 email인증이 되도록 하기
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
%>

	