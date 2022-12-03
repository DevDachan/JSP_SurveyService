<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="survey.OptionDTO" %>
<%@ page import="survey.SurveyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import='java.net.URLEncoder' %>


<%
	//사용자로부터 입력받는 것은 모두 UTF-8을 사용하겠다.
	request.setCharacterEncoding("UTF-8");
	int surveyID = 0;
	String optionType = null;

	

	// 만약 사용자에게 data가 올바르게 들어왔을 경우(request) 해당 data를 local instance에 넣기
	if(request.getParameter("surveyID")!= null ){
		surveyID = Integer.parseInt(request.getParameter("surveyID"));			
	}
	if(request.getParameter("optionType")!= null ){
		optionType= request.getParameter("optionType");
	}
	
	
	// 하나라도 옳지 않은 내용이 존재하거나 null값이 존재 할 경우에는 오류 alert와 함께 이전 페이지로
	if(surveyID == 0 || optionType == null){
%>
		<jsp:include page='alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"Error\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"입력이 안 된 사항이 있습니다\", \"UTF-8\") %>" />
				<jsp:param name="url" value="location.href = 'index.jsp';" />
		</jsp:include>	
<% 		
	}
	
	SurveyDAO surveyDAO = new SurveyDAO(application);
	int result = surveyDAO.addOption(surveyID, optionType);
%>

<%
	if(result == 1){
		%>
{
	"result" : "success"
}

<% 
	}else{
%>

{
	"result" : "fail"
}

<% 
	}
%>
