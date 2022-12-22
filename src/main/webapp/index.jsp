<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='user.UserDAO' %>
<%@ page import='user.AdminDTO' %>
<%@ page import='history.HistoryListDTO' %>
<%@ page import='history.HistoryDAO' %>

<%@ page import='java.net.URLEncoder' %>

<% 
   UserDAO userDAO = new UserDAO(application); 
   HistoryDAO historyDAO = new HistoryDAO(application);
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
            	  var copyText = "http://localhost:8080/Survey_project/user/userSurvey.jsp?sid="+sid;
            	  
            	  const t = document.createElement("textarea");
            	  document.body.appendChild(t);
            	  t.value = copyText;
            	  t.select();
            	  document.execCommand('copy');
            	  document.body.removeChild(t);
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
				<jsp:param name="url" value="location.href = './login/Login.jsp';" />
		</jsp:include>
	<%
	
	}else{
	String userID = (String) session.getAttribute("userID");
%>


		<nav class="navbar navbar-expand-lg navbar-light" style="background: #6DEDFE; border-radius: 0px 0px 20px 20px;">
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
						<a class="dropdown-item" href="./login/Login.jsp">로그인</a>
						<a class="dropdown-item" href="./login/Register.jsp">회원가입</a>
<% 
	}
	else{
		
%>
						<a class="dropdown-item" href="./login/LogoutAction.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>	
			</ul>
		</div>
	</nav>
	
	
	
	
	<section class="container mt-3" style="max-width: 900px;">
<%-- 
	<div class = "row">
		<div class="col-xl-3 col-md-6 mb-3">
			<div class="card bg-primary">
				<div class="card-body">
					<h3>hello </h3>
				</div>
				<div class="card-footer">
					<a class="stretched-link" href="http://www.naver.com">hi</a>
				</div>
			</div>
		</div>
		
		<%
		AdminDTO[] adminDTO = userDAO.getAdminList(userID);
		String adminList ="<div class='row'>";
		
		for(int step = 0; step<adminDTO.length; step++) {
			adminList +="<div class='col-xl-3 col-md-6 mb-3'>\n"+ 
						"<div class='card bg-primary'>\n"+
							"<div class='card-body' style='color:white'>"+
								"<h3>"+ adminDTO[step].getSurveyName() + "</h3>\n"+
							"</div>\n"+
							"<div>\n"+
								adminDTO[step].getSurveyID()+
							"</div>\n"+
							"<div class='card-footer'>\n"+
								"<a href='./admin/ViewAdminSurvey.jsp?sid="+adminDTO[step].getSurveyID()+"' style='width:100%'>수정하기</a>\n"+
							"</div>\n"+
				   		"</div>\n" + 
						"</div>";
		}
		adminList += "</div>";
		%>
		<%= adminList %>
	</div>
	
	--%>
	
	
	<div class="list mb-5">
		<div class="list-title">
			<h4 class="ml-4" style="margin:auto;">설문 리스트</h4>
				<a href="./admin/ActionAddSurvey.jsp" class="btn btn-add" >설문지 만들기</a>
		</div>
		<div class="list-content">
			<div class="list-option">
				<div class="list-option-item">
					설문링크
			 	</div>
				<div class="list-option-item">
					이름 
				</div> 
				<div class="list-option-item">
					수정 
				</div>
			 	<div class="list-option-item">
			 		통계 
				</div>
				<div class="list-option-item">
			 		공유 
				</div> 
			</div>
		<%
		AdminDTO[] adminDTO = userDAO.getAdminList(userID);
		String adminList ="";
		
	

		for(int step = 0; step<adminDTO.length; step++) {
			adminList +="<div class=\"list-rows\" >\n"+ 
						"<div class=\"list-item\">\n"+
							 "<p class='box" + adminDTO[step].getSurveyID()+"'>\n"+
						        "<button style='border:0px; background:white;' onclick='copy_to_clipboard("+adminDTO[step].getSurveyID()+")'>\n"+
						        	"<img src='https://blog.kakaocdn.net/dn/N1wUc/btqIl7XZtKM/b44qX9Six1vczz2ISWj4LK/img.png' alt='복사하기'>\n"+
						        "</button>\n"+
						    "</p>\n"+  	
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							adminDTO[step].getSurveyName()+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='./admin/ViewAdminSurvey.jsp?sid="+adminDTO[step].getSurveyID()+"'class='btn btn-primary'>수정하기</a>\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='./admin/ViewAdminStatistic.jsp?sid="+adminDTO[step].getSurveyID()+"'class='btn btn-primary'>통계</a>\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+		
								"<a href='http://localhost:8080/Survey_project' id='kakao_href'></a>"+		
						         "<img src='https://ifh.cc/g/BbQVhq.png' onClick=\"kakaoShare("+"\'"+adminDTO[step].getSurveyName()+"\',"+adminDTO[step].getSurveyID() + " );\" width='50' alt='Share' class='btnImg'>"+
						"</div>\n"+
						"</div>";
		}
		%>
		
		<%= adminList %>
		</div>
	</div>
	
	
	<div class="list mb-5">
		<div class="list-title">
			<h4 class="ml-4" style="margin:auto;">과거 설문 내역</h4>
		</div>
		<div class="list-content">
			<div class="list-option">
				<div class="list-option-item">
					날짜
			 	</div>
				<div class="list-option-item">
					이름 
				</div> 
				<div class="list-option-item">
					수정
				</div>
			 	<div class="list-option-item">
					결과
				</div>
			 	<div class="list-option-item">
			 		삭제 
				</div> 
			</div>
		<%
		HistoryListDTO[] historyListDTO = historyDAO.getHistoryList(userID);
		String historyList ="";
		
		for(int step = 0; step<historyListDTO.length; step++) {
			if(historyListDTO[step].getEditState() == 0){
				historyList +="<div class=\"list-rows\" >\n"+ 
						"<div class=\"list-item\">\n"+
								historyListDTO[step].getSurveyDate()+ "\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
								historyListDTO[step].getSurveyName()+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<label class='btn btn-editNot'>수정하기</a>\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='./user/userSurveyResult.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" 'class='btn btn-primary'>결과보기</a>\n"+
						"</div>\n"+			
						"<div class=\"list-item\">\n"+
							"<label class='btn btn-deleteNot'>삭제</a>\n"+
						"</div>\n"+
				   "</div>";	
			}else{
				historyList +="<div class=\"list-rows\" >\n"+ 
						"<div class=\"list-item\">\n"+
								historyListDTO[step].getSurveyDate()+ "\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
								historyListDTO[step].getSurveyName()+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='./user/userSurveyEdit.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" ' class='btn btn-primary'>수정하기</a>\n"+
						"</div>\n"+
						"<div class=\"list-item\">\n"+
							"<a href='./user/userSurveyResult.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+" 'class='btn btn-primary'>결과보기</a>\n"+
						"</div>\n"+			
						"<div class=\"list-item\">\n"+
							"<a href='./user/deleteHistory.jsp?sid="+historyListDTO[step].getSurveyID()+"&&hid="+historyListDTO[step].getHistoryID()+"' class='btn btn-delete' >삭제</a>\n"+
						"</div>\n"+
				   "</div>";				
			}
			
		}
		%>
		<%= historyList %>
		</div>
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