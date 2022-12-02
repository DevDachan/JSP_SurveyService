<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='survey.OptionDTO' %>
<%@ page import='survey.SurveyDTO' %>

<%SurveyDAO surveyDAO = new SurveyDAO(application); %>

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
	<link rel="stylesheet" href="./css/custom.css">
	<style type="text/css">
		a, a:hover{
			color: #000000;
			text-decoration: none;
		}
	</style>
	<script>
		function addComponent(surveyID, optionNum){
			
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/addSurveyComponent.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNum
            		},
            	success: function(res) {
            		window.location.reload();	
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function deleteComponent(surveyID, optionNum, componentNum){

			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/deleteSurveyComponent.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNum,
            		componentNum:componentNum
            		},
            	success: function(res) {
            		window.location.reload();	
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function addOption(){
			
			surveyID = document.getElementById("surveyID").value;
			optionType = document.getElementById("optionType").value;
			
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/addSurveyOption.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionType:optionType
            		},
            	success: function(res) {
            		window.location.reload();	
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function deleteOption(surveyID, optionNum){			
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/deleteSurveyOption.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNum
            		},
            	success: function(res) {
            		window.location.reload();	
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function editOption(surveyID, optionNum, type){
			
			if(type == 1){
				content = document.getElementById("optionTitle"+optionNum).value;	
				optionType = "title";
			}else{
				content = document.getElementById("optionContent"+optionNum).value;
				optionType = "content";
			}

			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/editOption.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNum,
            		content:content,
            		type:optionType
            		},
            	success: function(res) {
            		window.location.reload();	
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function editComponent(surveyID, optionNum, componentNum,type){
			if(type == 1){
				optionType="radio";
			}else if(type == 2){
				optionType="checkbox";
			}
			content = document.getElementById(optionType+optionNum+componentNum).value;	
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/editComponent.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNum,
            		componentNum:componentNum,
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
		function editSurvey(surveyID, type){
			if(type == 1){
				optionType="surveyTitle";
			}else if(type == 2){
				optionType="surveyContent";
			}
			content = document.getElementById(optionType).value;	
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/editSurvey.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID,
            		type:optionType,
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
	</script>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	int sid = 0;
	if(request.getParameter("sid") != null){
		sid = Integer.parseInt(request.getParameter("sid"));	
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("history.back();");
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
	
	<section class="container mt-3" style="max-width: 500px;">

<%
	SurveyDTO survey = surveyDAO.getSurvey(sid);	
%>
<div class="survey">
	<div class = "form-row">
		<div class="survey-title form-group col-sm-12">
			<textarea maxlength='50' class='option-title-text' 
				id='surveyTitle' 
				onChange='editSurvey(<%=sid%>,1)'><%=survey.getSurveyName()%>
				</textarea>
		</div>
		<div class="survey-content form-group col-sm-12">
			<textarea maxlength='2048' class='option-title-text' 
				id='surveyContent' 
				onChange='editSurvey(<%=sid%>,2)'><%= survey.getSurveyContent()%>
			</textarea>
		</div>
	</div>
</div>


<%
	int count = 0;
	int temp_id;
	String buf ="";
	String result = "";
	OptionDTO[] option = surveyDAO.getComponent(sid);
	String[][] option_detail = surveyDAO.getOption(sid);

	for(int option_num = 0; option_num< option_detail.length; option_num++){
		String start = "<div class='option mb-5'>\n"+
							"<div class='option-title'>\n" + 
								"<textarea maxlength='50' class='option-title-text' id='optionTitle"+option[count].getOptionNum()+"' onChange='editOption("+sid+","+option[count].getOptionNum()+",1)'>"+ option_detail[option_num][0]+"</textarea>\n" + 
							"</div>\n"+
						"<div class='option-content'>\n"+
							"<div class='option-content-item'>\n"+
								"<textarea maxlength='2048' class='option-content-text' id='optionContent"+option[count].getOptionNum()+"' onChange='editOption("+sid+","+option[count].getOptionNum()+",2)' >"+option_detail[option_num][1]+"</textarea>\n" + 
							"</div>\n"+
						"</div>\n";
	
		buf = "";
		temp_id = option[count].getOptionNum();
	
		while(count < option.length && option[count].getOptionNum() == temp_id){
			if(option[count].getOptionType().equals("radio")){
				buf += "<div class='option-rows'>"; 
				buf += "<div class='option-item'><label><input type='radio' name='radio"+option[count].getComponentNum()+"' value='radio' placeholder='helo'></label></div>";
				// 라디오 버튼 나눌 때는 이름으로 해서 같은 이름일 경우에는 다중 선택이 안된다.
				buf += "<div class='option-item'> <input class='edit-text' type='text' id='radio"+option[count].getOptionNum()+
						option[count].getComponentNum()+"' name='radio"+option[count].getOptionNum()+option[count].getComponentNum()+
						"' value='"+option[count].getContent() +
						"' onChange='editComponent("+sid+","+option[count].getOptionNum()+","+option[count].getComponentNum()+",1)'></label></div>";
				buf += "<div class='option-item'> <button class='btn btn-option-delete' type='button' onClick='deleteComponent("+option[count].getSurveyID() +
						","+option[count].getOptionNum()+","+option[count].getComponentNum() +")' >-</button> </div>";
				buf +="</div>";
			}else if(option[count].getOptionType().equals("checkbox")){
				buf += "<div class='option-rows'>"; 
				buf += "<div class='option-item'><label><input type='checkbox' name='checkbox"+option[count].getComponentNum()+"' value='checkbox' placeholder='helo'></label></div>";
				buf += "<div class='option-item'> <input class='edit-text' type='text' id='checkbox"+option[count].getOptionNum()+
						option[count].getComponentNum()+"' name='checkbox"+option[count].getOptionNum()+option[count].getComponentNum()+
						"' value='"+option[count].getContent() +
						"' onChange='editComponent("+sid+","+option[count].getOptionNum()+","+option[count].getComponentNum()+",2)'></label></div>";
				buf += "<div class='option-item'> <button class='btn btn-option-delete' type='button' onClick='deleteComponent("+option[count].getSurveyID() +
						","+option[count].getOptionNum()+","+option[count].getComponentNum() +")' >-</button> </div>";
				buf +="</div>";
			}else if(option[count].getOptionType().equals("text")){
				buf += "<div class='option-rows-text'>"; 
				buf += "<textarea name='text'" + option[count].getComponentNum()+ " class='form-control' maxlength='2048' style='height:100px;'></textarea>";
				buf +="</div>";
				buf += "<div class='option-rows'>"+
						"<div class='option-item'></div>"+	
						"<div class='option-item'></div>"+	
						" <button class='option-item mt-3 btn btn-add' type='button' id='delete_btn"+(option[count].getOptionNum())+
						"' onClick='deleteOption("+option[count].getSurveyID() +","+option[count].getOptionNum() +")' >Delete</button>"+
						"</div>";
			}
			count++;			
		}
		if(option[count-1].getOptionType().equals("text") == false) {
			buf += "<div class='option-rows'>"+
						"<div class='option-item'>"+
							" <button class='btn btn-primary' type='button' id='add_btn"+(option[count-1].getOptionNum())+
							"' onClick='addComponent("+option[count-1].getSurveyID() +","+option[count-1].getOptionNum() +")' >+ Add option</button>"+
						"</div>"+
						"<div class='option-item'></div>"+	
						"<div class='option-item'>"+
							" <button class='btn btn-add' type='button' id='delete_btn"+(option[count-1].getOptionNum())+
							"' onClick='deleteOption("+option[count-1].getSurveyID() +","+option[count-1].getOptionNum() +")' >Delete</button>"+
						"</div>"+
					" </div>";
		}
		
		buf += "</div>";
		result = result + start + buf;
	}
%>

<%= result %>



	<form action="addSurveyOption.jsp" style="text-align:center;">
		<div class="form-row">
			<div class="form-group col-sm-6" style="text-align:right;">
				<select name="optionType" id="optionType">
				    <option value="radio">Radio</option>
				    <option value="checkbox">Checkbox</option>
				    <option value="text" selected="selected">Text</option>
				</select>
				<input type="hidden" id="surveyID" name="surveyID" value=<%=sid %>>
			</div>
			<div class="form-group col-sm-6" style="text-align:left;">
				<button type="button" class="btn btn-add" style="width:40%;margin:auto;" onClick='addOption()' > + </button>
			</div>
		</div>
	</form>
	
	<div class="form-row">
		<div class="form-group col-sm-12 form-survey-delete">
			<a href="deleteSurvey.jsp?surveyID=<%=sid %>" class="btn btn-add">DELETE</a>
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

<% surveyDAO.endclose();%>
