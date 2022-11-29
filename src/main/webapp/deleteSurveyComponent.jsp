<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="survey.SurveyDTO" %>
<%@ page import="survey.SurveyDAO" %>
<%@ page import="java.io.PrintWriter" %>




<%
	//사용자로부터 입력받는 것은 모두 UTF-8을 사용하겠다.
	request.setCharacterEncoding("UTF-8");
	String surveyID = null;
	int optionNum = 0;
	int componentNum = 0;
	

	// 만약 사용자에게 data가 올바르게 들어왔을 경우(request) 해당 data를 local instance에 넣기
	if(request.getParameter("surveyID")!= null ){
		surveyID = request.getParameter("surveyID");			
	}
	if(request.getParameter("optionNum")!= null ){
		optionNum= Integer.parseInt(request.getParameter("optionNum"));	
	}
	if(request.getParameter("componentNum")!= null ){
		componentNum= Integer.parseInt(request.getParameter("componentNum"));	
	}
	
	// 하나라도 옳지 않은 내용이 존재하거나 null값이 존재 할 경우에는 오류 alert와 함께 이전 페이지로
	if(surveyID == null || optionNum == 0 || componentNum ==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("location.href = 'index.jsp;");
		script.println("</script>");
		script.close();
	}
	
	SurveyDAO surveyDAO = new SurveyDAO(application);
	int result = surveyDAO.deleteComponent(surveyID, optionNum,componentNum);
	
	if(result == 1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('삭제 성공!');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
%>

{
	"name" : "hello"
}
