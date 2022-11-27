<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='user.UserDAO' %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Tyep" content="text/html" charset="UTF-8">
	<!-- meta data add  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"> 
	
	<title>강의 평가 웹 사이트</title>
	<!-- Bootstrap insert -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
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
	
	<section class="container mt-3" style="max-width: 500px;">
	<a href="./adminSurvey.jsp"> Admin page </a>
	
	<form action="./userSurveyResult.jsp" method="post">
<% 	
	int type = 1;
	for(int survey_num = 0; survey_num<3;survey_num++){
		
	%>
	<div class="survey mb-5">
		<div class="survey-title">
			<p class="survey-title-text">지원 동기</p>
		</div>
		<div class="survey-content">
			<div class="survey-content-item">
			저희 동아리에 지원하게 된 계기가 어떻게 되시나요?
			</div>
		</div>
			
				<%
				int leng = 3; 
				String temp = "";
				for(int i=0; i < leng; i++){
					if(type == 1){
						temp += "<div class='survey-rows'>"; 
						
						temp += "<div class='survey-item'><label><input type='radio' name='radio"+survey_num+"' value='radio' placeholder='helo'></label></div>";
						// 라디오 버튼 나눌 때는 이름으로 해서 같은 이름일 경우에는 다중 선택이 안된다.
						temp += "<div class='survey-item'> <label>"+" Radio" +"</label></div>";
						
						temp +="</div>";
						
					}else if(type==2){
						temp += "<div class='survey-rows'>"; 
						temp += "<div class='survey-item'><label><input type='checkbox' name='checkbox"+survey_num+"' value='checkbox' placeholder='helo'></label></div>";
						temp += "<div class='survey-item'> <label>"+" checkbox" +"</label></div>";
						temp +="</div>";
					}else if(type==3){
						temp += "<div class='survey-rows-text'>"; 
						temp += "<textarea name='text' class='form-control' maxlength='2048' style='height:100pxpx;'></textarea>";
						temp +="</div>";
						break;
					}
					
				}
				%>
				<%= temp %>
	</div>

<%
		type++;
	}
%>
	
	<button type="submit" class="btn btn-primary" style="width:100%;" > submit </button>
	</form>
	
	</section>
	
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