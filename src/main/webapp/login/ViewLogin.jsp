<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='user.UserDAO' %>
<%@ page import='java.net.URLEncoder' %>

<!DOCTYPE html>
<html>
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
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	
%>
		<jsp:include page='../alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"안내\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"로그인 정보가 존재합니다.\", \"UTF-8\") %>" />
				<jsp:param name="url" value="location.href = '../index.jsp';" />
		</jsp:include>	
<% 		
	}

%>

	<nav class="navbar navbar-expand-lg navbar-light" style="background: #6DEDFE;">
		<a class="navbar-brand" href="./ViewLogin.jsp" style="color:white; text-weight:bold;">설문 서비스 </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="https://github.com/DevDachan/Survey-service-JSP" style="color:white;">Github</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdowm-toggle" id="dropdown" data-toggle="dropdown" style="color:white;">
						회원 관리	
					</a>
					
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null){
		
%>
						<a class="dropdown-item" href="ViewLogin.jsp">로그인</a>
						<a class="dropdown-item" href="ViewRegister.jsp">회원가입</a>
<% 
	}
	else{
		
%>
						<a class="dropdown-item" href="ActionLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>	
			</ul>
		</div>
	</nav>

	<section class="container mt-3" style="max-width: 500px;">
		<form method="post" action="./ActionLogin.jsp">
		<div class="form-row">
			<div class="col-sm-6">
				<div class="form-row" >
					<div class="form-group col-sm-12">
						<input type="text" name="userID" class="form-control" required placeholder="ID">
					</div>
					<div class="form-group col-sm-12">
						<input type="password" name="userPWD" class="form-control" required autocomplete="off"  placeholder="Password">
					</div>
				</div>
			</div>
			<div class="col-sm-6 row-sm-2 mb-3">
				<button type="submit" class="btn" style="background:#FF8484; width:100%; height:100%; color:white;">로그인</button>
			</div>
			<div class="col-sm-12 mb-3">
				<a href="http://localhost:8080/Survey_project/GoogleLoginAction.jsp" class="btn" style="background:#FF8484; width:100%; height:100%; background:#724A4A;color:white; ">Login with Google</a>
			</div>
			<div class="col-sm-12">
				<a href="http://localhost:8080/Survey_project/login/ViewRegister.jsp" class="btn" style="background:#FF8484; width:100%; height:100%; background:#62B6C9; color:white;">회원가입</a>
			</div>
		</div>
		</form>
	</section>

	<br/>

	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF; ">
		Copyright &copy; 2022 서다찬 All Rights Reserved
	</footer>	
	<!-- JQuery Java Script Add -->
	<script src="../js/jquery.min.js" ></script>
	<!-- Popper Java Script Add -->
	<script src="../js/popper.min.js" ></script>
	<!-- Bootstrap Java Script Add -->
	<script src="../js/bootstrap.min.js" ></script>
	
	
</body>
</html>