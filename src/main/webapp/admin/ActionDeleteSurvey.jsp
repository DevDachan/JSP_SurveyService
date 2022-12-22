<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="survey.OptionDTO" %>
<%@ page import="survey.SurveyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import='java.net.URLEncoder' %>

<head>
	<meta http-equiv="Content-Tyep" content="text/html" charset="UTF-8">
	<!-- meta data add  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"> 
	<title>Survey Service</title>
	<!-- Bootstrap insert -->
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<!-- custom CSS insert -->
	<link rel="stylesheet" href="../css/custom.css?ver=1">
</head>

<body>

<%
	//사용자로부터 입력받는 것은 모두 UTF-8을 사용하겠다.
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	int surveyID = 0;
	
	// 만약 사용자에게 data가 올바르게 들어왔을 경우(request) 해당 data를 local instance에 넣기
	if(session.getAttribute("userID")!= null ){
		userID = (String) session.getAttribute("userID");			
	}
	if(request.getParameter("surveyID")!= null ){
		surveyID =  Integer.parseInt(request.getParameter("surveyID"));			
	}
	// 하나라도 옳지 않은 내용이 존재하거나 null값이 존재 할 경우에는 오류 alert와 함께 이전 페이지로
	if(userID == null || surveyID ==0){
		PrintWriter script = response.getWriter();
		%>
		<jsp:include page='../alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"안내\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"세션 정보가 존재하지 않습니다.\", \"UTF-8\") %>" />
				<jsp:param name="url" value="location.href = '../index.jsp';" />
		</jsp:include>	
<% 		
	}
	
	SurveyDAO surveyDAO = new SurveyDAO(application);
	int result = surveyDAO.deleteSurvey(userID, surveyID);
	if(result == 1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = '../index.jsp'");
		script.println("</script>");
		script.close();
	}else if(result == 2){
%>
		<jsp:include page='../alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"안내\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"유저 정보가 일치하지 않습니다.\", \"UTF-8\") %>" />
				<jsp:param name="url" value="history.back();" />
		</jsp:include>	
<% 		
	}else{
%>
		<jsp:include page='../alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"ERROR\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"DB 오류가 발생했습니다.\", \"UTF-8\") %>" />
				<jsp:param name="url" value="history.back();" />
		</jsp:include>	
<% 
	}
	
%>

	<!-- JQuery Java Script Add -->
	<script src="../js/jquery.min.js" ></script>
	<!-- Popper Java Script Add -->
	<script src="../js/popper.min.js" ></script>
	<!-- Bootstrap Java Script Add -->
	<script src="../js/bootstrap.min.js" ></script>
</body>