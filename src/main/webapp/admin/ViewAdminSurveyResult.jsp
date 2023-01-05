<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='survey.SurveyDTO' %>
<%@ page import='result.ResultDTO' %>
<%@ page import='result.ResultDAO' %>
<%@ page import='survey.OptionDetailDTO' %>
<%@ page import='survey.ComponentDTO' %>

<%@ page import='java.net.URLEncoder' %>

<%
  SurveyDAO surveyDAO = new SurveyDAO(application);
  ResultDAO resultDAO = new ResultDAO(application);
%>

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
	<link rel="stylesheet" href="../css/custom.css?after">
	<style type="text/css">
		a, a:hover{
			color: #000000;
			text-decoration: none;
		}
	</style>
	<script>
		function resize(obj) {
		  obj.style.height = "auto";
		  obj.style.height = (obj.scrollHeight)+"px";
		  obj.style.width = "100%";
		  
		}
	
		function editContent(componentNumber){
			
			document.getElementById("ta_content"+componentNumber).style.height = 'auto';
			document.getElementById("ta_content"+componentNumber).style.height = (12+ document.getElementById("ta_content"+componentNumber).scrollHeight) + "px";
			
			surveyID = document.getElementById("surveyID").value;
			optionNumber = document.getElementById("optionNumber").value;
		
			content = document.getElementById("ta_content"+componentNumber).value;	
			document.getElementById("output_label0").value  = content;
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionEditResult.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNumber:optionNumber,
            		componentNumber:componentNumber,
            		content:content
            		},
            	success: function(res) {
            		window.location.reload();
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		
		function changeOption(){
			surveyID = document.getElementById("surveyID").value;
			optionNumber = document.getElementById("selectOption").value;
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionChangeResultOption.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNumber
            		},
            	success: function(res) {
            		window.location.reload();	
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
	</script>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userID") == null){
%>
		<jsp:include page='../alert.jsp'> 
			<jsp:param name="title" value="<%=URLEncoder.encode(\"로그인\", \"UTF-8\") %>" />
			<jsp:param name="content" value="<%=URLEncoder.encode(\"세션 정보가 존재하지 않습니다\", \"UTF-8\") %>" />
			<jsp:param name="url" value="location.href = '../login/ViewLogin.jsp';" />
		</jsp:include>
<% 				
	}
	else if(request.getParameter("sid") == null){
%>
		<jsp:include page='../alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"안내\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"설문조사 정보가 존재하지 않습니다.\", \"UTF-8\") %>" />
				<jsp:param name="url" value="history.back();" />
		</jsp:include>	
<% 					
		
	}else{
		String userID = (String) session.getAttribute("userID");
		int sid = Integer.parseInt(request.getParameter("sid"));	
	
%>

	<nav class="navbar navbar-expand-lg navbar-light nav-background" >
		<a class="navbar-brand" href="../index.jsp" style="color:white; text-weight:bold;">설문 서비스 </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="../index.jsp" style="color:white;">메인 화면</a>
				</li>
				<li class="nav-item active">
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
	
	<section class="container mt-3" style="max-width: 1000px;">

<%
	SurveyDTO survey = surveyDAO.getSurvey(sid);
	ResultDTO[] result = resultDAO.getResult(sid);
	OptionDetailDTO[] option = surveyDAO.getOption(sid);
	%>
	<input type="hidden" id="surveyID" name="surveyID" value=<%=sid %>>	
	<input type="hidden" id="optionNumber" name="optionNumber" value="<%=result[0].getOptionNum() %>" />

	<div class="survey mb-5">
		<div class = "form-row">
			<div class="survey-title form-group col-sm-12">
				<label class='form-control option-title-text btl-black' 
					id='surveyTitle'><%=survey.getSurveyName()%> 결과 페이지</label>
			</div>
		</div>
	</div>
	
	
	
		
		
		
	<div class="row mb-5 btl-black">	
		<table id="view_tag" class="col-sm-6" style=" margin-top:20px; margin-bottom:30px;">
			<tr>
			 	<th class="viewtag-item" style="color:#48cfeb; font-size:1.5rem;">태그</th>
				<th class="viewtag-item" style="color:#48cfeb; font-size:1.5rem;">질문 내용</th>
			</tr>
	<%
		for(int i = 0 ; i< option.length; i++){
			String temp ="";
		%>	<tr>
			<th class="viewtag-item"> [<%=option[i].getType()%><%= option[i].getOptionNum()%>]</th>
			<th class="viewtag-item"><%= option[i].getOptionTitle()%></th>
			</tr>
		<%
		}
	%>
		</table>
		<div class="col-sm-6" style="padding:30px;">
		<label> > 태그는 아래 결과 페이지에서 입력하는 값이며 각각의 질문 내용에 대한 사용자의 답변이 결과 페이지에서 들어가게 됩니다.</label>
		<label> > 체크박스의 경우 다중 선택이 가능한데 해당 값은 ,로 분리되어 출력이 됩니다. ex)[checkbox1] = 교무팀, 지원팀</label>
		
		</div>	 
	</div>	
	
	
	
	
	<div class="form-row mb-3">
		<div class="form-group col-sm-2"><h4>결과 분기 질문</h4></div>
		
		<div class="form-row form-group col-sm-10">
			<select name="selectOption" class="select-option" id="selectOption">
				<option value="0">기본 페이지</option>
			<%
				for(int i =0; i<option.length; i++){
					if(option[i].getType().equals("radio") ){
						if(option[i].getOptionNum() == result[0].getOptionNum()){
						%>
							<option value="<%=option[i].getOptionNum()%>" selected><%=option[i].getOptionNum()%></option>
						<%	
						}else{
						%>
						<option value="<%=option[i].getOptionNum()%>"><%=option[i].getOptionNum()%></option>
						<%}
					}
				}
			%>
			</select>
		<button type="button" class="btn btn-add" style="width:40%;margin-left:10px;" onClick='changeOption()' > 선택하기 </button>			</div>
	</div>
	
	
	
	
	<div class="row" id="entire_table">
<% 
	for(int i = 0; i<result.length; i++){
		if(result[0].getOptionNum() == 0 ){
			String temp = "";
			temp = result[i].getResultContent();
			temp = temp.replace("\n","<br/>");
			
		%>
			<div class="row col-sm-12" id="component_table">
				<div class="row col-sm-6" id="input_table">		
					<div class="col-sm-4">
						<label id="lb_optionNum">Default</label>
					</div>
					<div class="col-sm-8">
					</div>
					<div class="col-sm-12">
						<textarea maxlength='2048' wrap="hard" cols="20" onkeydown="resize(this)" onkeyup="resize(this)" class="result-content" id="ta_content0" placeholder="결과 페이지를 작성해주세요" onChange="editContent(<%= 0%>)"><%=result[i].getResultContent()%></textarea>
					</div>
					<script>
						resize(ta_content0);
					</script>
				</div>
				<div class="row col-sm-6" id="output_table">		
					<div class="row-sm-2 col-sm-12" id="output_label0">
						<%=temp%>
					</div>
					
				</div>
			</div>
		<%
		}else{
			String temp = "";
			temp = result[i].getResultContent().replace("\n","<br/>");
		%>
		<div class="row col-sm-12">
			<div class="col-sm-6 mb-5" id="input_table">		
				<div class="col-sm-12">
					<label id="lb_optionNum"><%=result[i].getComponentNum()%></label>
					<label id="lb_optionNum"><%=result[i].getComponentContent()%></label>
				</div>
				
				<div class="col-sm-12">
					<textarea maxlength='2048' wrap="hard" cols="20" onClick="resize(this)" onkeydown="resize(this)" onkeyup="resize(this)" class="result-content" id="ta_content<%=result[i].getComponentNum() %>" placeholder="결과 페이지를 작성해주세요" onChange="editContent(<%=result[i].getComponentNum() %>)"><%=result[i].getResultContent()%></textarea>
					<script>
								resize(ta_content<%=result[i].getComponentNum() %>);
					</script>
				</div>
			</div>	
			<div class="row col-sm-6" id="output_table">		
					<div class="row-sm-2 col-sm-12" id="output_label0">
						<%=temp%>
					</div>
					
			</div>
		</div>
		<%}
	}
%>
	</div>	

	




	<div class="form-row">
		<div class="form-group col-sm-12 form-survey-delete">
			<a href="../user/ViewUserSurvey.jsp?sid=<%=sid%>" class="btn btn-primary" style="width:100%;">설문 페이지</a>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group col-sm-12 form-survey-delete">
			<a href="../admin/ViewAdminSurvey.jsp?sid=<%=sid %>" class="btn btn-primary" style="width:100%;">뒤로가기</a>
		</div>
	</div>

	
	</section>
	
	<br/>
<% }// if(sid != null) %>


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

<% surveyDAO.endclose();%>
