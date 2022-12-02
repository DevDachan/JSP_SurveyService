<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='java.time.LocalDateTime' %>
<%@ page import='java.time.format.DateTimeFormatter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='survey.OptionDTO' %>


<% 
	request.setCharacterEncoding("UTF-8");
	int sid = Integer.parseInt(request.getParameter("survey_id"));
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	SurveyDAO surveyDAO = new SurveyDAO(application);
	String[][] list = surveyDAO.getOptionResult(sid); // [i][0] = option_num  [i][1] = option type

	int history_index = surveyDAO.getHistoryNum(sid);
	
	int result = 0;	
	
	LocalDateTime  now = LocalDateTime .now();
	String date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	
	for(int i = 0; i<list.length; i++){
		System.out.print("option = "+list[i][1]+"\n");
		System.out.print(request.getParameter("text"+list[1][0]));
		if(list[i][1].equals("checkbox") && request.getParameterValues("checkbox"+list[i][0]+"[]") != null){
			for(int k = 0; k < request.getParameterValues("checkbox"+list[i][0]+"[]").length; k++){
				int component_num = Integer.parseInt(request.getParameterValues("checkbox"+list[i][0]+"[]")[k]);
				result = surveyDAO.addHistory(sid,userID,history_index,Integer.parseInt(list[i][0]),component_num,"checkbox",date);	
				if(result == 0){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('DB Error');");
					script.println("history.back();");
					script.println("</script>");
					script.close();
					}
			}
			
		}
		else if(list[i][1].equals("radio") && request.getParameter("radio"+list[i][0]) != null){
			
			int component_num = Integer.parseInt(request.getParameter("radio"+list[i][0]));
			result = surveyDAO.addHistory(sid,userID,history_index,Integer.parseInt(list[i][0]),component_num,"radio",date);	
			if(result == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB Error');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			}
		}
		else if (list[i][1].equals("text") && request.getParameter("text"+list[i][0]) != null){
			System.out.print("hello");
			String content = request.getParameter("text"+list[i][0]);
			result = surveyDAO.addHistory(sid,userID,history_index,Integer.parseInt(list[i][0]),1,content,date);	
			if(result == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('DB Error');");
				script.println("history.back();");
				script.println("</script>");
				script.close();
			}	
		}
		
	}

%>
<script>
		location.href = "userSurveyResult.jsp?sid=<%=sid%>";
</script>
