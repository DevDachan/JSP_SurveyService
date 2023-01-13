<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='survey.ComponentDTO' %>
<%@ page import='survey.OptionDetailDTO' %>
<%@ page import='survey.SurveyDTO' %>
<%@ page import='java.net.URLEncoder' %>

<%SurveyDAO surveyDAO = new SurveyDAO(application); %>

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
	<link rel="stylesheet" href="../css/custom.css">
	<style type="text/css">
		a, a:hover{
			color: #000000;
			text-decoration: none;
		}
	</style>
	<jsp:include page="./ScriptAjax.jsp">
		<jsp:param name="default" value="" />
	</jsp:include>
	<script>
		function resize(obj) {
		  obj.style.height = "auto";
		  obj.style.height = (obj.scrollHeight)+"px";
		  obj.style.width = "100%";
		  
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
	<section class="container mt-3" style="max-width: 700px;">				  


<%
	SurveyDTO survey = surveyDAO.getSurvey(sid);
%>
<div class="survey">
	<div class = "form-row">
		<div class="survey-title form-group col-sm-12">
			<textarea maxlength='50' class='form-control option-title-text' 
				onkeydown='resize(this)' onkeyup='resize(this)' id='surveyTitle' onChange='editSurvey(<%=sid%>,1)'
				placeholder='설문 제목을 적어주세요' 
				><%=survey.getSurveyName()%></textarea>
			<script>
				resize(surveyTitle);
			</script>	
		</div>
		<div class="survey-content form-group col-sm-12">
			<textarea maxlength='2048' class='form-control option-title-text' 
				onkeydown='resize(this)' onkeyup='resize(this)' id='surveyContent' style='font-size: 15px;'
				onChange='editSurvey(<%=sid%>,2)' placeholder='설문 설명을 적어주세요' ><%= survey.getSurveyContent()%></textarea>
			<script>
				resize(surveyContent);
			</script>	
		</div>
	</div>
</div>

<%
	String check_limit_state = "<input type='checkbox' id='switch_limit' onChange='change_limit_state("+sid+")' />";
	if(survey.getLimitState() == 1){
		check_limit_state = "<input type='checkbox' checked='checked' id='switch_limit' onChange='change_limit_state("+sid+")' />";
	}
	
	String check_edit_state = "<input type='checkbox' id='switch_edit' onChange='change_edit_state("+sid+")' />";
	if(survey.getEditState() == 1){
		check_edit_state = "<input type='checkbox' checked='checked' id='switch_edit' onChange='change_edit_state("+sid+")' />";
	}
%>


	<div class="row">
		<div class="col-sm-7">
		 </div>
		<div class="form-group col-sm-3">
			<p style="text-align:right;">중복 참여 가능</p>
		</div>
		<div class="form-group col-sm-2 wrapper" style="text-align:left;">
			<%= check_limit_state%> 
			  <label for="switch_limit" class="switch_label">
			       <span class="onf_btn"></span>
			  </label>
		 </div>
		 
		 
		<div class="col-sm-7">
		 </div>
		<div class="form-group col-sm-3">
			<p style="text-align:right;">수정 가능</p>
		</div>
		<div class="form-group col-sm-2 wrapper" style="text-align:left;">
			<%= check_edit_state%> 
			  <label for="switch_edit" class="switch_label">
			       <span class="onf_btn"></span>
			  </label>
		 </div>
	</div>
	

<%
	int count = 0;
	int temp_id;
	String buf ="";
	String result = "";
	ComponentDTO[] option = surveyDAO.getComponent(sid);
	OptionDetailDTO[] option_detail = surveyDAO.getOption(sid);
						  
	
	for(int option_num = 0; option_num< option_detail.length; option_num++){
		String start = "";
		if(option[count].getOptionType().equals("radio") || option[count].getOptionType().equals("checkbox")){
			String check_history_state = "<input type='checkbox' class='switch_toggle '  id='switch_history_"+option_detail[option_num].getOptionNum()+"' onChange=\"change_history_state("+sid+","+option[count].getOptionNum()+")\" />";
			if(option_detail[option_num].getHistoryCheck() == 1){
				check_history_state = "<input type='checkbox' checked class='switch_toggle ' id='switch_history_"+option_detail[option_num].getOptionNum()+"' onChange=\"change_history_state("+sid+","+option[count].getOptionNum()+")\" />";
			}	
			
			start = "<div class='option mb-5'>\n"+
								"<p style='text-align:right;'>중복 선택 불가</p>"+
								"<div class='form-group' style='text-align:left;margin-left:15px;'>"+
										check_history_state+
								  "<label for='switch_history_"+option_detail[option_num].getOptionNum()+"' class='switch_label'>"+
								       "<span class='onf_btn'></span>"+
								  "</label>"+
							 	"</div>"+
								"<div class='option-title'>\n" + 
									"<textarea maxlength='50' onkeydown='resize(this)' onkeyup='resize(this)' class='option-title-text form-control' id='optionTitle"+option[count].getOptionNum()+"' onChange='editOption("+sid+","+option[count].getOptionNum()+",1)'  placeholder='질문 제목을 적어주세요' >"+ option_detail[option_num].getOptionTitle()+"</textarea>\n" + 
								"</div>\n"+
								"<div class='option-content'>\n"+
									"<div class='option-content-item'>\n"+
										"<textarea maxlength='2048' wrap='hard' cols='20' onkeydown='resize(this)' onkeyup='resize(this)' class='option-content-text form-control' id='optionContent"+option[count].getOptionNum()+"' onChange='editOption("+sid+","+option[count].getOptionNum()+",2)' placeholder='질문 내용을 적어주세요' >"+option_detail[option_num].getOptionContent()+"</textarea>\n" + 
										"<script>"+
											"resize(optionContent"+option[count].getOptionNum()+");"+
										"</script>"+			
									"</div>\n"+
								"</div>\n";
		}
		else{
			start = "<div class='option mb-5'>\n"+
								"<div class='option-title'>\n" + 
									"<textarea maxlength='50' onkeydown='resize(this)' onkeyup='resize(this)' class='option-title-text form-control' id='optionTitle"+option[count].getOptionNum()+"' onChange='editOption("+sid+","+option[count].getOptionNum()+",1)'  placeholder='질문 제목을 적어주세요' >"+ option_detail[option_num].getOptionTitle()+"</textarea>\n" + 
								"</div>\n"+
								"<div class='option-content'>\n"+
									"<div class='option-content-item'>\n"+
										"<textarea maxlength='2048' wrap='hard' cols='20' onkeydown='resize(this)' onkeyup='resize(this)' class='option-content-text form-control' id='optionContent"+option[count].getOptionNum()+"' onChange='editOption("+sid+","+option[count].getOptionNum()+",2)' placeholder='질문 내용을 적어주세요' >"+option_detail[option_num].getOptionContent()+"</textarea>\n" + 
										"<script>"+
											"resize(optionContent"+option[count].getOptionNum()+");"+
										"</script>"+			
									"</div>\n"+
								"</div>\n";
		}
		
	
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
				buf += "<textarea name='text'" + option[count].getComponentNum()+ " class='form-control' maxlength='2048' onkeydown='resize(this)' onkeyup='resize(this)' style='height:100px;' disabled placeholder='이곳은 사용자가 작성하는 공간입니다'></textarea>";
				buf +="</div>";
				buf += "<div class='option-rows'>"+
						"<div class='option-item'></div>"+	
						"<div class='option-item'></div>"+	
						" <button class='option-item mt-3 btn btn-delete'  type='button' id='delete_btn"+(option[count].getOptionNum())+
						"' onClick='deleteOption("+option[count].getSurveyID() +","+option[count].getOptionNum() +")' >질문 삭제</button>"+
						"</div>";
			}
			count++;			
		}
		if(option[count-1].getOptionType().equals("text") == false) {
			buf += "<div class='option-rows'>"+
						"<div class='option-item'>"+
							" <button class='btn btn-primary' type='button' id='add_btn"+(option[count-1].getOptionNum())+
							"' onClick='addComponent("+option[count-1].getSurveyID() +","+option[count-1].getOptionNum() +")' >+ 옵션 추가</button>"+
						"</div>"+
						"<div class='option-item'></div>"+	
						"<div class='option-item'>"+
							" <button class='btn btn-delete' type='button' id='delete_btn"+(option[count-1].getOptionNum())+
							"' onClick='deleteOption("+option[count-1].getSurveyID() +","+option[count-1].getOptionNum() +")' >질문 삭제</button>"+
						"</div>"+
					" </div>";
		}
		
		buf += "</div>";
		result = result + start + buf;
	}
%>

<%= result %>



	<form action="./ActionAddSurveyOption.jsp" style="text-align:center;">
		<div class="form-row">
			<div class="form-group col-sm-6" style="text-align:right;">
				<select name="optionType" class="select-option" id="optionType">
				    <option value="radio">라디오</option>
				    <option value="checkbox">체크박스</option>
				    <option value="text" selected="selected">단답형</option>
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
			<a href="../user/ViewUserSurvey.jsp?sid=<%=sid %>" class="btn btn-primary" style="width:100%;">설문 페이지</a>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group col-sm-12 form-survey-delete">
			<a href="../admin/ViewAdminSurveyResult.jsp?sid=<%=sid %>" class="btn btn-primary" style="width:100%;">결과 페이지 구성하기</a>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group col-sm-12 mt-4 form-survey-delete">
			<a href="./ActionDeleteSurvey.jsp?surveyID=<%=sid %>" class="btn btn-delete" style="width:100%;">설문조사 삭제하기</a>
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
