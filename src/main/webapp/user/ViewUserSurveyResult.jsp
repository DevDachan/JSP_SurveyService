<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.ComponentDTO' %>
<%@ page import='survey.OptionDetailDTO' %>

<%@ page import='survey.SurveyDAO' %>
<%@ page import='result.ResultDTO' %>
<%@ page import='result.ResultDAO' %>
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
	<style type="text/css">
		a, a:hover{
			color: #000000;
			text-decoration: none;
		}
	</style>
	
	<script>
	function sendEmail(){
		document.getElementById("alert_message").innerText = "";	
		userEmail = document.getElementById("ip_email").value;
		content = document.getElementById("content").innerHTML;
		if(userEmail == null || userEmail == ""){
			document.getElementById("alert_message").innerText = "* 이메일을 입력해주세요";	
		}else{
			document.getElementById("sendMailBtn").innerText = "재전송";
			document.getElementById("alert_message").innerText = "전송 완료";	
			$.ajax({
	    	 	type:'post',
	      	 	async:true, 
	       		url:'http://localhost:8080/Survey_project/user/ActionMailSend.jsp',
	        	dataType:'text',
	        	data:{
	        		userEmail:userEmail,
	        		content:content
	        		},
	        	success: function(res) {
	        		result = res.split('{')[1].split("}")[0];  		
	        		if(result.includes("Success")){
	  	
	        		}else{
	        			document.getElementById("sendMailBtn").innerText = "전송 실패 (올바른 이메일을 입력해주세요.)";	
	        		}
	        	},
	       		error:function (data, textStatus) {
	            	console.log('error');
	      	  	}
	  	  	})
		}
	
	}
	
	</script>
	
</head>
<body>
<% 
	ResultDAO resultDAO = new ResultDAO(application);
	SurveyDAO surveyDAO = new SurveyDAO(application);
	int sid = 0;
	int hid = 0;
	int prvsv = 0;
	String userID = null;
	String date = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}else{
		userID = "Guest";
	}
	
	if(request.getParameter("sid") != null){
		sid = Integer.parseInt(request.getParameter("sid"));
	}
	if(request.getParameter("hid") != null){
		hid = Integer.parseInt(request.getParameter("hid"));
	}
	if(request.getParameter("prvsv") != null){
		prvsv = 1;
	}else{
		if(request.getParameter("submitTime") != null){
			date = request.getParameter("submitTime");
		}else if(hid != 0){

			
			date = resultDAO.getDateTime(sid,userID,hid);
		}	
	}
	
	if(prvsv==0 && sid == 0 || prvsv==0 && date == null){
%>
		<jsp:include page='../alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"안내\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"설문조사 정보가 존재하지 않습니다.\", \"UTF-8\") %>" />
				<jsp:param name="url" value="history.back();" />
		</jsp:include>	
<% 					
		
	}
%>


	<nav class="navbar navbar-expand-lg navbar-light" style="background: #6DEDFE;">
		<a class="navbar-brand" href="../index.jsp" style="color:white; text-weight:bold;">설문 서비스 </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="../index.jsp" style="color:white;">메인 화면</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdowm-toggle" id="dropdown" data-toggle="dropdown" style="color:white;">
						회원 관리	
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null){
		
%>
						<a class="dropdown-item" href="../login/ViewLogin.jsp">로그인</a>
						<a class="dropdown-item" href="../login/ViewRegister.jsp">회원가입</a>
<% 
	}
	else{
		
%>
						<a class="dropdown-item" href="../login/ActionLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>	
			</ul>
		</div>
	</nav>
	
	<section class="container mt-3" style="max-width: 500px;">
	<%
		String content = resultDAO.userResultContent(sid, userID,date);
		
		OptionDetailDTO[] option = surveyDAO.getOption(sid);
		for(int i = 0; i< option.length; i++){
			if(option[i].getType().equals("checkbox")){
				String temp = "["+option[i].getType() + option[i].getOptionNum()+"]";
				String[] userSelectComponent = resultDAO.getSelectComponentCheckbox(sid,userID,date,option[i].getOptionNum());
				String userSelect = "";
				for(int k = 0; k< userSelectComponent.length; k++){
					userSelect += userSelectComponent[k];
					if(k != userSelectComponent.length-1){
						userSelect += ",";
					}
				}
				
				content = content.replace(temp,userSelect);	
			}else{
				String temp = "["+option[i].getType() + option[i].getOptionNum()+"]";
				String userSelect = resultDAO.getSelectComponent(sid,userID,date,option[i].getOptionNum());
				
				content = content.replace(temp,userSelect);	
			}
		}
		content = content.replace("\n","<br/>");
		
	
		String title = "";
		if(content.equals("") ){
			title = "제출 완료";
			content = "제출이 완료 되었습니다!";
		}
		if(prvsv == 1){
			content = "이미 제출이 완료된 설문입니다";
		}
	%>
	<h3><%= title %></h3>
	<div id="content">
	<%= content %>
	</div>
	
	<% 
		if(userID == "Guest"){
	%>
	<div class="mt-5">
		<input type="email" id="ip_email" placeholder="email" style="white-space : nowrap ">
		<button type="submit" class="btn btn-primary" id="sendMailBtn" onClick="sendEmail();" > 메일로 응답 받기 </button>
	</div>
	<label id="alert_message" style="color:red; margin-left:5px;"></label>
	<%}else{%>
	
	<button type="submit" class="btn btn-primary mt-5" onClick="location.href='../index.jsp';" style="width:100%;"> 메일로 응답 받기 </button>
	
	<%} %>
	<button type="submit" class="btn btn-primary mt-2" onClick="location.href='../index.jsp';" style="width:100%;"> 메인 </button>
	

	
	</section>
	
	<br/>

	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF; ">
		Copyright &copy; 2018 서다찬 All Rights Reserved
	</footer>	
	<!-- JQuery Java Script Add -->
	<script src="../js/jquery.min.js" ></script>
	<!-- Popper Java Script Add -->
	<script src="../js/popper.min.js" ></script>
	<!-- Bootstrap Java Script Add -->
	<script src="../js/bootstrap.min.js" ></script>
	
	
</body>
</html>