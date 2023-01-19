<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='survey.AdminDTO' %>
<%@ page import='history.HistoryListDTO' %>
<%@ page import='history.HistoryDAO' %>

<%@ page import='java.net.URLEncoder' %>

<% 
	HistoryDAO historyDAO = new HistoryDAO(application);
	SurveyDAO surveyDAO = new SurveyDAO(application);
	int tabLimit = 5;
	int maxHistoryIndex = 0;
	int historyCount = 0;
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Tyep" content="text/html" charset="UTF-8">
	<!-- meta data add  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"> 
	
	<title>Survey Service</title>
	<!-- Bootstrap insert -->
	<link rel="stylesheet" href="./css/bootstrap.min.css" type="text/css">
	<!-- custom CSS insert -->
	<link rel="stylesheet" href="./css/custom.css?after">
	<style type="text/css">
		a, a:hover{
			color: #000000;
			text-decoration: none;
		}
	</style>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script type="text/javascript">
        function kakaoShare(surveyTitle,sid) {
			Kakao.cleanup();
			Kakao.init("ff87a0a2d649bcb736dbcbebed8135e9");      // 사용할 앱의 JavaScript 키
		 
			Kakao.Link.createDefaultButton({
               	objectType:"feed",
	    		container: document.querySelector("#kakao_href")
           		,content : {
           			title:surveyTitle
           			,description:"http://localhost:8080/Survey_project/admin/ViewAdminSurvey.jsp?sid=" + sid  // 콘텐츠 설명
           			,imageUrl:"https://ifh.cc/g/1Drn85.jpg" // 썸네일 같은거
           			,link : {
           				mobileWebUrl:"http://localhost:8080/Survey_project/admin/ViewAdminSurvey.jsp?sid=" + sid    // 모바일 카카오톡에서 사용하는 웹 링크 URL
           				,webUrl:"http://localhost:8080/Survey_project/admin/ViewAdminSurvey.jsp?sid=" + sid  // PC버전 카카오톡에서 사용하는 웹 링크 URL
           			}
           		}, 
           		buttons : [
                  		 { title:"설문 참여하기"    // 공유했을 때 뜨는 버튼 제목
                   		 , link : {
                       		mobileWebUrl:"http://localhost:8080/Survey_project/admin/ViewAdminSurvey.jsp?sid=" + sid // 모바일 카카오톡에서 사용하는 웹 링크 URL
                   			,webUrl:"http://localhost:8080/Survey_project/admin/ViewAdminSurvey.jsp?sid=" + sid   
                 			}	
                   		}
                		]
       		});
           	document.getElementById("kakao_href").click(); // 새로고침
          	 }
		function copy_to_clipboard(sid) { 
			  var bt = document.getElementById("copy_bt_"+sid);
			  bt.style.cssText = "filter: opacity(0) drop-shadow(0 0 0 white);";
          	  var copyText = "http://localhost:8080/Survey_project/user/ViewUserSurvey.jsp?sid="+sid;
          	  const copy_content = document.createElement("textarea");
           	  document.body.appendChild(copy_content);
           	  copy_content.value = copyText;
           	  copy_content.select();
           	  document.execCommand('copy');
           	  document.body.removeChild(copy_content);
        	  bt.style.cssText = "transition-property: filter;  transition-duration: 2s;  filter: opacity(1) drop-shadow(0 0 0 white);";
		}
		function changeHTable(newtbnum ,limit,maxindex,tbcount){
			var curtbnum = document.getElementById("currentTabindex").value;
			
			indexnewtbnum = (Number(newtbnum)-1)*Number(limit);
			indexcurtbnum = (Number(curtbnum)-1)*Number(limit);

			if(newtbnum != curtbnum){
				if(newtbnum > maxindex){ // next를 통한 table 변경
					if(indexnewtbnum != Number(indexcurtbnum)+Number(limit)){ //만약 현재 index가 최대값이라면 변경사항 X
						document.getElementById("currentTabindex").value = Number(curtbnum)+1; 
						for(var i = 1; i<= limit; i++){
							if(Number(indexcurtbnum)+Number(limit)+Number(i) <= tbcount){ //list의 개수가 limit보다 작을 경우를 위한 예외처리
								document.getElementById("datatable_"+(Number(indexcurtbnum)+Number(limit)+Number(i))).style.display = '';
							}
							if(Number(indexcurtbnum)+Number(i) <= tbcount){
								document.getElementById("datatable_"+(Number(indexcurtbnum)+Number(i))).style.display = 'none';
							}
						}
						if(Number(indexcurtbnum)+Number(limit)+Number(i) > tbcount){
							document.getElementById("datatable_info").innerText = "Showing "+(Number(curtbnum)*5+1)+" to "+(tbcount)+ " of "+tbcount+"entries";
						}else{
							document.getElementById("datatable_info").innerText = "Showing "+(Number(curtbnum)*5+1)+" to "+((Number(curtbnum))*5+limit)+ " of "+tbcount+"entries";	
						}
						
						document.getElementById("selecttb_"+curtbnum).style.background = "white";
						document.getElementById("selecttb_"+curtbnum).style.color = "#5F9EA0";
						document.getElementById("selecttb_"+(Number(curtbnum)+1)).style.background = "#87F5F5";
						document.getElementById("selecttb_"+(Number(curtbnum)+1)).style.color = "#fff";
					}	
				}else if(newtbnum == 0){ // prev를 통한 table 변경
					if(curtbnum != 1){   // 만약 첫번째 index에서 prev를 눌렀을 경우 변경사항 X 
						document.getElementById("currentTabindex").value = Number(curtbnum)-1;
						
						for(var i = 1; i<= limit; i++){
							if(Number(indexcurtbnum)-Number(limit)+Number(i) <= tbcount){
								document.getElementById("datatable_"+(Number(indexcurtbnum)-Number(limit)+Number(i))).style.display = '';
							}
							if(Number(indexcurtbnum)+Number(i) <= tbcount){
								document.getElementById("datatable_"+(Number(indexcurtbnum)+Number(i))).style.display = 'none';
							}
						}
						if(Number(indexcurtbnum)-Number(limit)+Number(i) > tbcount){
							document.getElementById("datatable_info").innerText = "Showing "+((Number(curtbnum)-2)*5+1)+" to "+(tbcount)+ " of "+tbcount+"entries";
						}else{
							document.getElementById("datatable_info").innerText = "Showing "+((Number(curtbnum)-2)*5+1)+" to "+((Number(curtbnum)-2)*5+limit)+ " of "+tbcount+"entries";	
						}
						
						document.getElementById("selecttb_"+curtbnum).style.background = "white";
						document.getElementById("selecttb_"+curtbnum).style.color = "#5F9EA0";
						document.getElementById("selecttb_"+(Number(curtbnum)-1)).style.background = "#87F5F5";
						document.getElementById("selecttb_"+(Number(curtbnum)-1)).style.color = "#fff";
					}	
				}else{ //일반적으로 숫자를 눌렀을 경우 table 변경
					document.getElementById("currentTabindex").value = newtbnum;
					for(var i = 1; i<= limit; i++){
						if(Number(indexnewtbnum)+Number(i) <= Number(tbcount)){
							document.getElementById("datatable_"+(Number(indexnewtbnum)+Number(i))).style.display = '';
						}				
						if(Number(indexcurtbnum)+Number(i) <= Number(tbcount)){
							document.getElementById("datatable_"+(Number(indexcurtbnum)+Number(i))).style.display = 'none';
						}
					}
					document.getElementById("selecttb_"+curtbnum).style.background = "white";
					document.getElementById("selecttb_"+curtbnum).style.color = "#5F9EA0";
					document.getElementById("selecttb_"+newtbnum).style.background = "#87F5F5";
					document.getElementById("selecttb_"+newtbnum).style.color = "#fff";
				}
			}
		}
	</script>
</head>
<body>


<% 

	if(session.getAttribute("userID") == null){
	%>
		<jsp:include page='alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"로그인\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"세션 정보가 존재하지 않습니다\", \"UTF-8\") %>" />
				<jsp:param name="url" value="location.href = './login/ViewLogin.jsp';" />
		</jsp:include>
	<%
	
	}else{
	String userID = (String) session.getAttribute("userID");
%>


		<nav class="navbar navbar-expand-lg navbar-light nav-background">
		<a class="navbar-brand" href="index.jsp" style="color:white; text-weight:bold;">설문 서비스 </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp" style="color:white;">메인 화면</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdowm-toggle" id="dropdown" data-toggle="dropdown" style="color:white;">
						회원 관리	
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null){
		
%>
						<a class="dropdown-item" href="./login/ViewLogin.jsp">로그인</a>
						<a class="dropdown-item" href="./login/ViewRegister.jsp">회원가입</a>
<% 
	}
	else{
		
%>
						<a class="dropdown-item" href="./login/ActionLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>	
			</ul>
		</div>
	</nav>
	
	
	
	
	<section class="container mt-3" style="max-width: 960px;">	
	
	<div class="list mb-5">
		<div class="list-title">
			<h4 class="ml-4" style="margin:auto;">설문 리스트</h4>
				<a href="./admin/ActionAddSurvey.jsp" class="btn btn-add" >설문지 만들기</a>
		</div>
		<div class="list-content">
			<div class="list-option">
				<div class="list-option-item">
					제목 
				</div> 
				<div class="list-option-item">
					수정 
				</div>
			 	<div class="list-option-item">
			 		통계 
				</div>
				<div class="list-option-item">
					링크
			 	</div>
				<div class="list-option-item">
			 		공유 
				</div> 
			</div>
		<%
		AdminDTO[] adminDTO = surveyDAO.getAdminList(userID);
		String adminList ="";
		
	

		for(int step = 0; step<adminDTO.length; step++) {
			adminList +="<div class=\"list-rows\" >\n"+ 
						"<div class=\"list-item\">\n"+
							adminDTO[step].getSurveyName()+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='./admin/ViewAdminSurvey.jsp?sid="+adminDTO[step].getSurveyID()+"'class='btn btn-primary btn-width-9'>수정하기</a>\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='./admin/ViewAdminStatistic.jsp?sid="+adminDTO[step].getSurveyID()+"'class='btn btn-primary btn-width-9'>통계</a>\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
						 "<p class='clip'>\n"+
					        "<button class='copy-bt' id='copy_bt_"+adminDTO[step].getSurveyID()+"' onclick='copy_to_clipboard("+adminDTO[step].getSurveyID()+")'>\n"+
					        	"<img src='https://i.ibb.co/9NfdRzk/copy-image.png' class='copy-img' id='copy_img_"+adminDTO[step].getSurveyID()+"' alt='복사하기'>\n"+
					        "</button>\n"+
					    "</p>\n"+  	
						"</div>\n"+			
						"<div class=\"list-item\">\n"+
							"<div style='background:#f9e000; border-radius: 0.25rem;'>"+
								"<a href='http://localhost:8080/Survey_project' id='kakao_href'></a>"+		
						         "<img src='https://i.ibb.co/gzWLmg0/kakao.png'style='border-radius:8px;width:20%' onClick=\"kakaoShare("+"\'"+adminDTO[step].getSurveyName()+"\',"+adminDTO[step].getSurveyID() + " );\" width='50' alt='Share' class='btnImg'>"+
							"</div>\n"+
						"</div>\n"+        		 
						"</div>";
		}
		%>
		
		<%= adminList %>
		</div>
	</div>

	
	<div class="card" style="border:0px;background:white;">
		<div class="card-header" style="border-radius:20px; border:0px;">
			<h4 class="ml-4" style="margin:auto; text-align:left;">과거 설문 내역</h4>
		</div>
		<div class="card-body">
			<table class="table " style="text-align:center;">
			<thead>
			<tr role="row">
				<th class="datatable-option-item">
					날짜
			 	</th>
				<th class="datatable-option-item">
					이름 
				</th> 
				<th class="datatable-option-item">
					수정
				</th>
			 	<th class="datatable-option-item">
					결과
				</th>
			 	<th class="datatable-option-item">
			 		삭제 
				</th> 
			</tr>
			</thead>
			<tbody>
		<%
		HistoryListDTO[] historyListDTO = historyDAO.getHistoryList(userID);
		String historyList ="";
		
		
		//---  history table values ------------------------
		historyCount = historyListDTO.length;
		maxHistoryIndex = historyListDTO.length / tabLimit ;		
		if(historyListDTO.length % tabLimit != 0){
			maxHistoryIndex ++; 
		}
		//--------------------------------------------------
		
		
		int historyLimitcheck = 0;
		for(int step = 0; step<historyListDTO.length; step++) {
			if(historyLimitcheck++ < tabLimit){
				
				if(historyListDTO[step].getEditState() == 0){
					historyList +="<tr id='datatable_"+(step+1)+"'>\n"+ 
							"<th class=\"datatable-item\" >\n"+
									historyListDTO[step].getSurveyDate()+ "\n"+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
									historyListDTO[step].getSurveyName()+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
								"<label class='btn btn-editNot'>수정하기</a>\n"+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
								"<a href='./user/ViewUserSurveyResult.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" 'class='btn btn-primary'>결과보기</a>\n"+
							"</th>\n"+			
							"<th class=\"datatable-item\">\n"+
								"<label class='btn btn-deleteNot'>삭제</a>\n"+
							"</th>\n"+
					   "</tr>";	
				}else{
					historyList +="<tr id='datatable_"+(step+1)+"'>\n"+ 
							"<th class=\"datatable-item\">\n"+
									historyListDTO[step].getSurveyDate()+ "\n"+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
									historyListDTO[step].getSurveyName()+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
								"<a href='./user/ViewUserSurveyEdit.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" ' class='btn btn-primary'>수정하기</a>\n"+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
								"<a href='./user/ViewUserSurveyResult.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" 'class='btn btn-primary'>결과보기</a>\n"+
							"</th>\n"+			
							"<th class=\"datatable-item\">\n"+
								"<a href='./user/ActionDeleteHistory.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+"' class='btn btn-delete' >삭제</a>\n"+
							"</th>\n"+
					   "</tr>";				
				}
			}else{
				if(historyListDTO[step].getEditState() == 0){
					historyList +="<tr id='datatable_"+(step+1)+"' style=\"display:none;\">\n"+ 
							"<th class=\"datatable-item\" >\n"+
									historyListDTO[step].getSurveyDate()+ "\n"+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
									historyListDTO[step].getSurveyName()+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
								"<label class='btn btn-editNot'>수정하기</a>\n"+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
								"<a href='./user/ViewUserSurveyResult.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" 'class='btn btn-primary'>결과보기</a>\n"+
							"</th>\n"+			
							"<th class=\"datatable-item\">\n"+
								"<label class='btn btn-deleteNot'>삭제</a>\n"+
							"</th>\n"+
					   "</tr>";	
				}else{
					historyList +="<tr id='datatable_"+(step+1)+"'  style=\"display:none;\">\n"+ 
							"<th class=\"datatable-item\">\n"+
									historyListDTO[step].getSurveyDate()+ "\n"+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
									historyListDTO[step].getSurveyName()+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
								"<a href='./user/ViewUserSurveyEdit.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" ' class='btn btn-primary'>수정하기</a>\n"+
							"</th>\n"+
							"<th class=\"datatable-item\">\n"+
								"<a href='./user/ViewUserSurveyResult.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" 'class='btn btn-primary'>결과보기</a>\n"+
							"</th>\n"+			
							"<th class=\"datatable-item\">\n"+
								"<a href='./user/ActionDeleteHistory.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+"' class='btn btn-delete' >삭제</a>\n"+
							"</th>\n"+
					   "</tr>";				
				}
				
			}
		}
		%>
		<%= historyList %>
		
			</table>
		
			<div class="row">
				<div class="col-sm-6">
					<div class="datatable_info" id="datatable_info">
						Showing 1 to <%=tabLimit %> of <%=historyCount %>entries
					</div>
				</div>
				<div class="col-sm-6">
					<div class="dataTables_paginate paging_simple_numbers" id="datatable_paginate">
						<input type="hidden" id="currentTabindex" value="1" />
						<ul class="pagination mr-2" style="justify-content: flex-end;">
						<li class="paginate_button page-item ">
							<button id="selecttb_0" onClick="changeHTable(0,<%=tabLimit%>,<%=maxHistoryIndex %>,<%=historyCount %>)"  aria-controls="dataTable" tabindex="0" class="page-link">이전 페이지</button>
						</li>
						<li class="paginate_button page-item ">
							<button id="selecttb_1" onClick="changeHTable(1,<%=tabLimit%>,<%=maxHistoryIndex %>,<%=historyCount %>)"  aria-controls="dataTable" tabindex="0" class="page-link" style="background:#87F5F5; color:white;">1</button>
						</li>
						<%
							for(int i = 2; i<=maxHistoryIndex; i++){
							%>
							<li class="paginate_button page-item ">
							<button id="selecttb_<%=i%>" onClick="changeHTable(<%=i%>,<%=tabLimit%>,<%=maxHistoryIndex %>,<%=historyCount %>)"  aria-controls="dataTable" tabindex="0" class="page-link"><%=i %></button>
							</li>
							<%}%>
	
						<li class="paginate_button page-item">
							<button id="selecttb_4" onClick="changeHTable(<%=maxHistoryIndex+1 %>,<%=tabLimit%>,<%=maxHistoryIndex %>,<%=historyCount %>)" aria-controls="dataTable"  tabindex="0" class="page-link">다음 페이지</button>
						</li>
						</ul>
					</div>
				</div>
			</div>
		</div><%--card-body --%>
	</div>

	
	</section>
<%	}// if userID == null 
%>		
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