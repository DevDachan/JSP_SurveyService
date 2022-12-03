<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='survey.OptionDTO' %>
<%@ page import='user.HistoryDTO' %>
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
	SurveyDAO surveyDAO = new SurveyDAO(application);
	UserDAO userDAO = new UserDAO(application);
	
	int sid = 0;
	if(request.getParameter("sid") != null){
		sid = Integer.parseInt(request.getParameter("sid"));	
	}else{
		%>
		<jsp:include page='alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"ERROR\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"존재하지 않는 설문입니다.\", \"UTF-8\") %>" />
				<jsp:param name="url" value="location.href = 'index.jsp';"/>
		</jsp:include>	
		<% 	
	}
	int hid = 0;
	if(request.getParameter("hid") != null){
		hid = Integer.parseInt(request.getParameter("hid"));	
	}
	
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
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
	
	<section class="container mt-3" style="max-width: 500px;">
	<% 
		HistoryDTO[] history = surveyDAO.getHistory(userID, sid,hid); 
	%>
	
	<form action="./userHistorySubmit.jsp" method="post" id="survey-submit">
	<input type="hidden" name="sid" value="<%=sid %>">
	
	<%
	
	int count = 0;
	int temp_id;
	String buf ="";
	String result = "";
	OptionDTO[] component = surveyDAO.getComponent(sid);
	String[][] option = surveyDAO.getOption(sid);
	
	int hstep = 0;
	
	for(int option_num = 0; option_num< option.length; option_num++){
		String start = "<div class='option mb-5'>\n"+
						"<div class='option-title'>\n" + 
						"<p class='option-title-text'>"+ option[option_num][0]+
						"</p>\n" + 
						"</div>\n"+
						"<div class='option-content'>\n"+
						"<div class='option-content-item'>\n"+
							option[option_num][1]+
						"</div>\n"+
						"</div>\n";
		buf = "";
		temp_id = component[count].getOptionNum();
		while(count < component.length && component[count].getOptionNum() == temp_id){
			if(component[count].getOptionType().equals("radio")){
				buf += "<div class='option-rows'>"; 
				if(hstep<history.length && history[hstep].getOptionNum() == component[count].getOptionNum() && history[hstep].getComponentNum() == component[count].getComponentNum()){
					buf += "<div class='option-item'><input type='radio' name='radio"+component[count].getOptionNum()+"' value='"+component[count].getComponentNum()+"' placeholder='helo' checked></div>";	
					hstep++;
				}else{
					buf += "<div class='option-item'><input type='radio' name='radio"+component[count].getOptionNum()+"' value='"+component[count].getComponentNum()+"' placeholder='helo'></div>";
				}
				buf += "<div class='option-item'> <label type='text' id='radio' name='radio' >"+component[count].getContent()+"</label></div>";
				buf +="</div>";
			}else if(component[count].getOptionType().equals("checkbox")){
				buf += "<div class='option-rows'>"; 
				if(hstep<history.length && history[hstep].getOptionNum() == component[count].getOptionNum() && history[hstep].getComponentNum() == component[count].getComponentNum()){
					buf += "<div class='option-item'><input type='checkbox' name='checkbox"+component[count].getOptionNum()+"[]' value='"+component[count].getComponentNum()+"' placeholder='helo' checked></div>";
					hstep++;
				}else{
					buf += "<div class='option-item'><input type='checkbox' name='checkbox"+component[count].getOptionNum()+"[]' value='"+component[count].getComponentNum()+"' placeholder='helo'></div>";					
				}
				buf += "<div class='option-item'> <label id='checkbox' name='checkbox' >"+component[count].getContent() +"</label></div>";
				buf +="</div>";
			}else if(component[count].getOptionType().equals("text")){
				buf += "<div class='option-rows-text'>"; 
				if(hstep<history.length && history[hstep].getOptionNum() == component[count].getOptionNum() && history[hstep].getComponentNum() == component[count].getComponentNum()){
					buf += "<textarea name='text" + component[count].getOptionNum()+ "' class='form-control' maxlength='2048' style='height:100px;'>"+history[hstep].getContent()+"</textarea>";
					hstep++;
				}else{
					buf += "<textarea name='text" + component[count].getOptionNum()+ "' class='form-control' maxlength='2048' style='height:100px;'></textarea>";
				}
				buf +="</div>";
			}
			count++;
		}
		buf +="<div class='option-rows-text'> <label class='warning' style='display:none;'>* 필수로 하나는 선택해주세요</label> </div>";
		buf += "</div>";
		result = result + start + buf;
	}	
	%>
	<%=	result %>
	
	
	<button type="submit" class="btn btn-primary" style="width:100%;"> submit </button>
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

<%surveyDAO.endclose();%>
<%userDAO.endclose();%>
