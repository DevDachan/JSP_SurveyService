<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='user.UserDAO' %>
<%@ page import='survey.ComponentDTO' %>
<%@ page import='survey.OptionDetailDTO' %>
<%@ page import='survey.SurveyDTO' %>
<%@ page import='history.HistoryDAO' %>


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
</head>
<body>
<% 
	String userID = null;
	SurveyDAO surveyDAO = new SurveyDAO(application);
	UserDAO userDAO = new UserDAO(application);
	HistoryDAO historyDAO = new HistoryDAO(application);
	
	
	if(request.getParameter("sid") == null){
		%>
		<jsp:include page='../alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"ERROR\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"존재하지 않는 설문입니다.\", \"UTF-8\") %>" />
				<jsp:param name="url" value="location.href = '../index.jsp';"/>
		</jsp:include>	
		<% 	
	}else{
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}else{
			userID = "Guest";
		}
		
		int sid = Integer.parseInt(request.getParameter("sid"));
		
		int limitState = surveyDAO.getLimitState(sid);
		if(limitState == 0){
			if(userID == "Guest"){
				%>
				<jsp:include page='../alert.jsp'> 
						<jsp:param name="title" value="<%=URLEncoder.encode(\"접근 불가\", \"UTF-8\") %>" />
						<jsp:param name="content" value="<%=URLEncoder.encode(\"로그인 후 이용해주시기 바라겠습니다.\", \"UTF-8\") %>" />
						<jsp:param name="url" value="location.href = '../login/ViewLogin.jsp';"/>
				</jsp:include>	
				<% 	
			}else{
				int check_dup = historyDAO.getPrvhistoryIndex(sid,userID);
				if(check_dup != 0){
					response.sendRedirect("http://localhost:8080/Survey_project/user/ViewUserSurveyResult.jsp?sid=" + sid + "&&hid=" + check_dup);
				}
			}
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
	if(userID == null || userID.equals("Guest")){
		
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
	
	<section class="container mt-3" style="max-width: 700px;">

	<%
		SurveyDTO surveyDetail = surveyDAO.getSurvey(sid);
		String temp_survey_title= surveyDetail.getSurveyName().replace("\n","<br/>");
		String temp_survey_content= surveyDetail.getSurveyContent().replace("\n","<br/>");
		
	%>
	
	<div class="survey">
		<div class = "form-row">
			<div class="survey-title form-group col-sm-12">
				<label class='option-title-text' id='surveyTitle'><%=temp_survey_title%></label>
			</div>
			<div class="survey-content form-group col-sm-12" style="height:auto;">
				<label class='option-title-text form-control' style="padding:10px; font-size:15px;height:auto;" 
				id='surveyTitle'><%=temp_survey_content%></label>
			</div>
		</div>
	</div>

	<form action="./ActionUserSurveySubmit.jsp" method="post" id="survey-submit">
	<input type="hidden" name="sid" value="<%=sid %>">
	
	<%
	int count = 0;
	int temp_id;
	String buf ="";
	String result = "";

	ComponentDTO[] component = surveyDAO.getComponent(sid);
	OptionDetailDTO[] option = surveyDAO.getOption(sid);

	for(int option_num = 0; option_num< option.length; option_num++){
		
		String temp_content = option[option_num].getOptionContent().replace("\n","<br/>");
		String temp_title = option[option_num].getOptionTitle().replace("\n","<br/>");
		String start = "<div class='option mt-5 '>\n"+
						"<div class='option-title'>\n" + 
						"<p class='option-title-text'>"+ temp_title+
						"</p>\n" + 
						"</div>\n"+
						"<div class='option-content'>\n"+
						"<div class='option-content-item'>\n"+
								temp_content+
						"</div>\n"+
						"</div>\n";
		buf = "";
		temp_id = component[count].getOptionNum();
		String alert_text = "<label class='ml-3 mt-3' style='display:none; color:red; font-size:25px;' id='lb_alert"+component[count].getOptionNum()+"'>* 값을 입력해주세요.</label>";
		
		while(count < component.length && component[count].getOptionNum() == temp_id){
			if(component[count].getOptionType().equals("radio")){
				buf += "<div class='option-rows'>"; 
				buf += "<div class='option-item'><input type='radio' name='radio"+component[count].getOptionNum()+"' value='"+component[count].getComponentNum()+"' placeholder='helo'></div>";
				// 라디오 버튼 나눌 때는 이름으로 해서 같은 이름일 경우에는 다중 선택이 안된다.
				buf += "<div class='option-item'> <label type='text' id='radio' name='radio' >"+component[count].getContent()+"</label></div>";
				buf +="</div>";
			}else if(component[count].getOptionType().equals("checkbox")){
				buf += "<div class='option-rows'>"; 
				buf += "<div class='option-item'><input type='checkbox' name='checkbox"+component[count].getOptionNum()+"[]' value='"+component[count].getComponentNum()+"' placeholder='helo'></div>";
				buf += "<div class='option-item'> <label id='checkbox' name='checkbox' >"+component[count].getContent() +"</label></div>";
				buf +="</div>";
			}else if(component[count].getOptionType().equals("text")){
				buf += "<div class='option-rows-text'>"; 
				buf += "<textarea name='text" + component[count].getOptionNum()+ "' class='form-control' maxlength='2048' style='height:100px;'></textarea>";
				buf +="</div>";
			}
			count++;			
		}
		buf +="<div class='option-rows-text'> <label class='warning' style='display:none;'>* 필수로 하나는 선택해주세요</label> </div>";
		buf += "</div>";
		
		result = result + start + buf + alert_text;
	}	
	%>
	<%=	result %>
	
	
	<button type="button" id="submit_btn" class="btn btn-primary mt-5" style="width:100%;" onClick="checkUncheckedOption()"> 제출하기 </button>
	</form>
	
	<script>
	function checkUncheckedOption(){
		var sucess = 0;
		<%
		for(int i =0; i< option.length; i++){
			if(option[i].getType().equals("checkbox")){%>
				document.getElementById("lb_alert<%=option[i].getOptionNum()%>").style.display = 'none';
				var list = document.getElementsByName("<%=option[i].getType()%><%=option[i].getOptionNum()%>[]");
				var checkbox_sucess = 0;
				for(var k = 0; k< list.length; k++){
					if(list[k].checked == true)	{
						checkbox_sucess += 1;
					}
				}
				if(checkbox_sucess == 0){
					document.getElementById("lb_alert<%=option[i].getOptionNum()%>").style.display = 'block';
					sucess += 1;
				}
			<%}else if(option[i].getType().equals("radio")){%>
				document.getElementById("lb_alert<%=option[i].getOptionNum()%>").style.display = 'none';
				var list = document.getElementsByName("<%=option[i].getType()%><%=option[i].getOptionNum()%>");
				var radio_sucess = 0;
				for(var k = 0; k< list.length; k++){
					if(list[k].checked == true)	{
						radio_sucess += 1;
					}
				}
				if(radio_sucess == 0){
					document.getElementById("lb_alert<%=option[i].getOptionNum()%>").style.display = 'block';
					sucess += 1;
				}
			<%}else{%>
				document.getElementById("lb_alert<%=option[i].getOptionNum()%>").style.display = 'none';
				var check = document.getElementsByName("<%=option[i].getType()%><%=option[i].getOptionNum()%>")[0].value;
				if(check == null || check ==""){
					document.getElementById("lb_alert<%=option[i].getOptionNum()%>").style.display = 'block';
					sucess += 1;
				}
			<%}
			}%>
		if(sucess == 0){
			document.getElementById("survey-submit").submit();
		}else{
			document.getElementById("submit_btn").innerText = "제출하기 (미입력 값이 존재합니다)";
			document.getElementById("submit_btn").style.background = "red";
			
		}
	}
	</script>
	
	
	</section>
	
	<br/>

<%} %>

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

<%surveyDAO.endclose();%>