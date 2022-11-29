<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>



<%
	//사용자로부터 입력받는 것은 모두 UTF-8을 사용하겠다.
	request.setCharacterEncoding("UTF-8");
	String userEmail = null;
	String inputCode = null;
	
	String result = "Error";
	// 만약 사용자에게 data가 올바르게 들어왔을 경우(request) 해당 data를 local instance에 넣기
	if(request.getParameter("userEmail")!= null && request.getParameter("inputCode") !=null){
		userEmail = request.getParameter("userEmail");			
		inputCode = request.getParameter("inputCode");
		UserDAO userDAO = new UserDAO(application);

		int setResult = userDAO.checkUserCode(userEmail,inputCode);
		
		if(setResult == 1){
			result = "Success";
		}else{
			result = "Fail";
		}
	}
	
%>


{<%= result %>}
