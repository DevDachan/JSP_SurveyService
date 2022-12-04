<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='user.UserDAO' %>
<%@ page import='user.AdminDTO' %>
<%@ page import='history.HistoryListDTO' %>
<%@ page import='history.HistoryDAO' %>

<%@ page import='java.net.URLEncoder' %>

<% 
   UserDAO userDAO = new UserDAO(application); 
   HistoryDAO historyDAO = new HistoryDAO(application);
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Tyep" content="text/html" charset="UTF-8">
	<!-- meta data add  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"> 
	
	<title>Survey Service</title>
	<!-- Bootstrap insert -->
	<link rel="stylesheet" href="./css/bootstrap.min.css" type="text/css">
	<!-- custom CSS insert -->
	<link rel="stylesheet" href="./css/custom.css?after">
	<style type="text/css">
		a, a:hover{
			color: #000000;
			text-decoration: none;
		}
	</style>
</head>
<body>


<% 

	if(session.getAttribute("userID") == null){
	%>
		<jsp:include page='alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"로그인\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"세션 정보가 존재하지 않습니다\", \"UTF-8\") %>" />
				<jsp:param name="url" value="location.href = 'Login.jsp';" />
		</jsp:include>
	<%
	
	}else{
	String userID = (String) session.getAttribute("userID");
%>


		<nav class="navbar navbar-expand-lg navbar-light" style="background: #6DEDFE; border-radius: 0px 0px 20px 20px;">
		<a class="navbar-brand" href="index.jsp" style="color:white; text-weight:bold;">Survey Service </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp" style="color:white;">메인 화면</a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="userSurvey.jsp" style="color:white;">User Survey</a>
				</li>
				<li class="nav-item dropdown">
				
					<a class="nav-link dropdowm-toggle" id="dropdown" data-toggle="dropdown" style="color:white;">
						회원 관리	
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null){
		
%>
						<a class="dropdown-item" href="Login.jsp">로그인</a>
						<a class="dropdown-item" href="Register.jsp">회원가입</a>
<% 
	}
	else{
		
%>
						<a class="dropdown-item" href="LogoutAction.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>	
			</ul>
		</div>
	</nav>
	
	<section class="container mt-3" style="max-width: 700px;">
	<div class="list mb-5">
		<div class="list-title">
			<h4 class="ml-4" style="margin:auto;">설문 리스트</h4>
				<a href="addSurvey.jsp" class="btn btn-add" >Add Survey</a>
		</div>
		<div class="list-content">
			<div class="list-option">
				<div class="list-option-item">
					ID
			 	</div>
				<div class="list-option-item">
					이름 
				</div> 
				<div class="list-option-item">
					수정 
				</div>
			 	<div class="list-option-item">
			 		결과 
				</div> 
			</div>
		<%
		AdminDTO[] adminDTO = userDAO.getAdminList(userID);
		String adminList ="";
		
		for(int step = 0; step<adminDTO.length; step++) {
			adminList +="<div class=\"list-rows\" >\n"+ 
						"<div class=\"list-item\">\n"+
							adminDTO[step].getSurveyID()+ "\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							adminDTO[step].getSurveyName()+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='adminSurvey.jsp?sid="+adminDTO[step].getSurveyID()+"'class='btn btn-primary'>edit</a>\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='adminResult.jsp?sid="+adminDTO[step].getSurveyID()+"'class='btn btn-primary'>result</a>\n"+
						"</div>\n"+
				   "</div>";
		}
		%>
		<%= adminList %>
		</div>
	</div>
	
	<div class="list mb-5">
		<div class="list-title">
			<h4 class="ml-4" style="margin:auto;">과거 설문 내역</h4>
		</div>
		<div class="list-content">
			<div class="list-option">
				<div class="list-option-item">
					날짜
			 	</div>
				<div class="list-option-item">
					이름 
				</div> 
				<div class="list-option-item">
					수정
				</div>
			 	<div class="list-option-item">
			 		삭제 
				</div> 
			</div>
		<%
		HistoryListDTO[] historyListDTO = historyDAO.getHistoryList(userID);
		String historyList ="";
		
		for(int step = 0; step<historyListDTO.length; step++) {
			historyList +="<div class=\"list-rows\" >\n"+ 
						"<div class=\"list-item\">\n"+
								historyListDTO[step].getSurveyDate()+ "\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
								historyListDTO[step].getSurveyName()+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='userSurveyEdit.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" ' class='btn btn-primary'>edit</a>\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='deleteHistory.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+"' class='btn btn-delete' >delete</a>\n"+
						"</div>\n"+
				   "</div>";
		}
		%>
		<%= historyList %>
		</div>
	</div>

	
	</section>
<%	}// if userID == null 
%>		
	<br/>

	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF; ">
		Copyright &copy; 2022 서다찬 All Rights Reserved
	</footer>	
	<!-- JQuery Java Script Add -->
	<script src="./js/jquery.min.js" ></script>
	<!-- Popper Java Script Add -->
	<script src="./js/popper.min.js" ></script>
	<!-- Bootstrap Java Script Add -->
	<script src="./js/bootstrap.min.js" ></script>
	
	
</body>
</html>