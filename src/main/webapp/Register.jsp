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
	<script>
	/*
	function sendCode(String Email){
		UserDAO userDAO = new UserDAO(application);
		int result = userDAO.sendUserCode(Email);
		if(result == -1){
			Fail (please input correct email)
		}
	}*/
	
	
	</script>
	
</head>
<body>
<%	String userID = null; %>
<%-- 
<% 
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 정보가 존재합니다.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
		script.close();
	}


%>--%>

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
		<form method="post" action="./LoginAction.jsp">
		<div class="form-row">
			<div class="col-sm-12">
				<div class="form-row" >
					<div class="form-group col-sm-2">
						ID
					</div>
					<div class="form-group col-sm-10">
						<input type="text" name="userID" class="form-control" required placeholder="ID">
					</div>
				</div>
				<div class="form-row" >
					<div class="form-group col-sm-2 ">
						<p class="mr-3" >PWD</p>
					</div>
					<div class="form-group col-sm-10">
						<input type="password" name="userPWD" class="form-control" required placeholder="Password">
					</div>
				</div>
				<div class="form-row" >	
					<div class="form-group col-sm-6">
						<input type="text" name="userEmail" class="form-control" required placeholder="Email">
					</div>	
					<div class="form-group col-sm-6">
						<button type="button" class="btn" style="background:#FF8484; width:100%; height:100%; color:white;">Code Send</button>
					</div>
				</div>
				<div class="form-row" >	
					<div class="form-group col-sm-12">
						<input type="text" name="authCode" class="form-control" required placeholder="Code">
					</div>				
				</div>	
			</div>	
			<div class="col-sm-12">
				<button type="submit" class="btn" style="background:#FF8484; width:100%; height:90%; color:white;">Register</button>
			</div>
		</div>
		</form>
	<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#reportModal">이메일 인증하기</a>
	</section>
	

	<%-- tabindex: 키보드 포커싱 제외, Tab을 눌렀을때 이동하지 않도록 --%>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id ="modal">이메일 인증 하기</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>	
					</div>
					<div class="modal-body">
						<form action="./emailCheckAction.jsp" method="post">
							<div class="form-row">
								<div class="form-group col-sm-4">
									<label>Email</label>
								</div>
								<div class="form-group col-sm-8">
									<input type="email" name="userEmail" id="email" class="form-control" 
									pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"placeholder="example@gmail.com" maxlength="30">	
								</div>
								<div class="form-group col-sm-12 mb-5">
									<button type="button" class="btn btn-primary" style="width:100%;">Send Code</button>
								</div>
								<div class="form-group col-sm-4">
									<label>Code</label>
								</div>
								<div class="form-group col-sm-8">
									<input type="text" name="reportTitle" class="form-control" maxlength="30" required>	
								</div>
								
								<div class="modal-footer col-sm-12">
									<div class="form-group col-sm-6">
										<button type="submit" class="btn btn-danger" style="width:100%;">Submit</button>
									</div>
									<div class="form-group col-sm-6">
										<button type="button" class="btn btn-secondary" style="width:100%;" data-dismiss="modal">취소</button>
									</div>
									
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div> 

	
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