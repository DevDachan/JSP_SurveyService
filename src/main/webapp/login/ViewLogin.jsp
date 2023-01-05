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
	<script>
	function checkLogin(){
		document.getElementById("alert_userID").style.display = "none";
		document.getElementById("alert_userPwd").style.display = "none";
		document.getElementById("ip_userID").style.border = "1px solid #ced4da";
		document.getElementById("ip_userPwd").style.border = "1px solid #ced4da";
		
		if(document.getElementById("ip_userID").value == null  || document.getElementById("ip_userID").value == ""){
			document.getElementById("ip_userID").style.border = "4px solid red";
			document.getElementById("alert_userID").innerText = "ID를 입력해주세요";	
   			document.getElementById("alert_userID").style.display = "block";
   			return;
		}else{
			userID = document.getElementById("ip_userID").value;
		}
		if(document.getElementById("ip_userPwd").value == null || document.getElementById("ip_userPwd").value == ""){
			document.getElementById("ip_userPwd").style.border = "4px solid red";
			document.getElementById("alert_userPwd").innerText = "비밀번호를 입력해주세요";	
   			document.getElementById("alert_userPwd").style.display = "block";
   			return;
		}else{		
			pwd = document.getElementById("ip_userPwd").value;
		}
		
		$.ajax({
         	type:'post',
         	async:false, 
        	url:'http://localhost:8080/Survey_project/login/ActionLogin.jsp',
           	dataType:'text',
           	data:{
           		userID:userID, 
           		userPWD:pwd
           		},
           	success: function(res) {
           		result = res.split('{')[1].split("}")[0];
           		if(result.includes("0")){
           			location.href = "../index.jsp";
           		}else if(result.includes("1")){
           			document.getElementById("ip_userID").style.border = "4px solid red";
           			document.getElementById("alert_userID").innerText = "올바른 ID를 입력해주세요";	
           			document.getElementById("alert_userID").style.display = "block";
           		}else if(result.includes("2")){
           			document.getElementById("ip_userPwd").style.border = "4px solid red";
           			document.getElementById("alert_userPwd").innerText = "올바른 비밀번호를 입력해주세요";	
           			document.getElementById("alert_userPwd").style.display = "block";
           		}
           	},
           error:function (data, textStatus) {
               console.log('error');
           }
      	})  	
	}
	</script>


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

	<nav class="navbar navbar-expand-lg navbar-light nav-background" >
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

	<section class="container mt-3" style="max-width: 1000px;">
		<div class="row">
			<div class="col-sm-6">
				<img src="../public/login_background.jpg" style="width:100%;height:100% ;border-radius: 20px" />
			</div>
			<div class="col-sm-6" style="padding-top:100px;">
				<h3 class="login-title"> 설문 서비스</h3>
				<form method="post" id="login_form" action="./ActionLogin.jsp">
					<div class="form-row">
						<div class="col-sm-6">
							<div class="form-row" >
								<div class="form-group col-sm-12">
									<input type="text" id="ip_userID" name="userID" class="form-control" required placeholder="ID">
								</div>
								<div class="col-sm-12">
									<label id="alert_userID" style="color:red;display:none;">* 올바른 ID를 입력해주세요</label>
								</div>
								<div class="form-group col-sm-12">
									<input type="password" id="ip_userPwd" name="userPWD" class="form-control" required autocomplete="off"  placeholder="Password">
								</div>
								<div class="col-sm-12">
									<label id="alert_userPwd" style="color:red; display:none;">* 올바른 비밀번호를 입력해주세요</label>
								</div>
							</div>
						</div>
						<div class="col-sm-6 row-sm-2 mb-3">
							<button type="button" class="btn" style="background:#FF8484; width:100%; height:100%; color:white;" onClick="checkLogin()" >로그인</button>
						</div>
						<div class="col-sm-12">
							<a href="http://localhost:8080/Survey_project/login/ViewRegister.jsp" class="btn" style="background:#FF8484; width:100%; height:100%; background:#62B6C9; color:white;">회원가입</a>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		
		
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