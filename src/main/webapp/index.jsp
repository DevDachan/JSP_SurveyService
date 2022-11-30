<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='user.UserDAO' %>


<% UserDAO userDAO = new UserDAO(application); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Tyep" content="text/html" charset="UTF-8">
	<!-- meta data add  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"> 
	
	<title>강의 평가 웹 사이트</title>
	<!-- Bootstrap insert -->
	<link rel="stylesheet" href="./css/bootstrap.min.css" type="text/css">
	<!-- custom CSS insert -->
	<link rel="stylesheet" href="./css/custom.css?ver=1">
	<style type="text/css">
		a, a:hover{
			color: #000000;
			text-decoration: none;
		}
	</style>
</head>
<body>
<% 
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('세션 정보가 존재하지 않습니다.');");
		script.println("location.href = 'Login.jsp';");
		script.println("</script>");
		script.close();
	}
%>

		<nav class="navbar navbar-expand-lg navbar-light" style="background: #6DEDFE; border-radius: 0px 0px 20px 20px;">
		<a class="navbar-brand" href="index.jsp" style="color:white; text-weight:bold;">Survey Service </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp" style="color:white;">Main</a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="userSurvey.jsp" style="color:white;">User Survey</a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="adminSurvey.jsp" style="color:white;">Admin Survey</a>
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
	<h3 class="mb-5">Main Page</h3>	
	
	<%=
		userDAO.getSurveyList(userID)
	%>
	<div class="list mb-5">
		<div class="list-title">
			<h4 style="margin:auto;">User list</h4>
		</div>
		<div class="list-content">
			<div class="list-option">
				<div class="list-option-itme">
					날짜
				</div>
				<div class="list-option-itme">
					이름
				</div>
				<div class="list-option-itme">
					Edit
				</div>
				<div class="list-option-itme">
					Result
				</div>
			</div>
			<div class="list-rows" >
				<div class="list-item">
				2022.11.24
				</div>
				<div class="list-item">
				한풍 지원서
				</div>
				<div class="list-item">
				edit
				</div>
				<div class="list-item">
				result
				</div>
			</div>
			<div class="list-rows" >
				<div class="list-item">
				2022.11.24
				</div>
				<div class="list-item">
				한풍 지원서
				</div>
				<div class="list-item">
				edit
				</div>
				<div class="list-item">
				result
				</div>
			</div>
		</div>
	</div>
	

	
	
	</section>
	
	<br/>

	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF; ">
		Copyright &copy; 2018 서다찬 All Rights Reserved
	</footer>	
	<!-- JQuery Java Script Add -->
	<script src="./js/jquery.min.js" ></script>
	<!-- Popper Java Script Add -->
	<script src="./js/popper.min.js" ></script>
	<!-- Bootstrap Java Script Add -->
	<script src="./js/bootstrap.min.js" ></script>
	
	
</body>
</html>