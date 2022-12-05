<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"  %>

<%@ page import='java.io.PrintWriter' %>
<%@ page import='java.time.LocalDateTime' %>
<%@ page import='java.time.format.DateTimeFormatter' %>
<%@ page import='survey.SurveyDAO' %>
<%@ page import='history.HistoryDAO' %>
<%@ page import='survey.OptionDetailDTO' %>

<%@ page import='java.net.URLEncoder' %>


<head>
	<meta http-equiv="Content-Tyep" content="text/html" charset="UTF-8">
	<!-- meta data add  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"> 
	<title>Survey Service</title>
	<!-- Bootstrap insert -->
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<!-- custom CSS insert -->
	<link rel="stylesheet" href="../css/custom.css?ver=1">
</head>

<body>

<% 
	request.setCharacterEncoding("UTF-8");
	int sid = Integer.parseInt(request.getParameter("sid"));
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	SurveyDAO surveyDAO = new SurveyDAO(application);
	HistoryDAO historyDAO = new HistoryDAO(application);
	

	
	OptionDetailDTO[] list = surveyDAO.getOption(sid); // [i][0] = option_num  [i][1] = option type

	int history_index = historyDAO.getHistoryNum(sid);
	
	int result = 0;	
	
	LocalDateTime  now = LocalDateTime .now();
	String date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	
	for(int i = 0; i<list.length; i++){

		if(list[i].getType().equals("checkbox") && request.getParameterValues("checkbox"+list[i].getOptionNum()+"[]") != null){
			for(int k = 0; k < request.getParameterValues("checkbox"+list[i].getOptionNum()+"[]").length; k++){
				int component_num = Integer.parseInt(request.getParameterValues("checkbox"+list[i].getOptionNum()+"[]")[k]);
				result = historyDAO.addHistory(sid,userID,history_index,list[i].getOptionNum(),component_num,"checkbox",date);	
				if(result == 0){
					%>
					<jsp:include page='../alert.jsp'> 
							<jsp:param name="title" value="<%=URLEncoder.encode(\"ERROR\", \"UTF-8\") %>" />
							<jsp:param name="content" value="<%=URLEncoder.encode(\"DB 오류가 발생했습니다.\", \"UTF-8\") %>" />
							<jsp:param name="url" value="history.back();"/>
					</jsp:include>	
					<% 	
					}
			}
			
		}
		else if(list[i].getType().equals("radio") && request.getParameter("radio"+list[i].getOptionNum()) != null){
			
			int component_num = Integer.parseInt(request.getParameter("radio"+list[i].getOptionNum()));
			result = historyDAO.addHistory(sid,userID,history_index,list[i].getOptionNum(),component_num,"radio",date);	
			if(result == 0){
				%>
				<jsp:include page='../alert.jsp'> 
						<jsp:param name="title" value="<%=URLEncoder.encode(\"ERROR\", \"UTF-8\") %>" />
						<jsp:param name="content" value="<%=URLEncoder.encode(\"DB 오류가 발생했습니다.\", \"UTF-8\") %>" />
						<jsp:param name="url" value="history.back();"/>
				</jsp:include>	
				<% 	
			}
		}
		else if (list[i].getType().equals("text") && request.getParameter("text"+list[i].getOptionNum()) != null){
			System.out.print("hello");
			String content = request.getParameter("text"+list[i].getOptionNum());
			result = historyDAO.addHistory(sid,userID,history_index,list[i].getOptionNum(),1,content,date);	
			if(result == 0){
				%>
				<jsp:include page='../alert.jsp'> 
						<jsp:param name="title" value="<%=URLEncoder.encode(\"ERROR\", \"UTF-8\") %>" />
						<jsp:param name="content" value="<%=URLEncoder.encode(\"DB 오류가 발생했습니다.\", \"UTF-8\") %>" />
						<jsp:param name="url" value="history.back();"/>
				</jsp:include>	
				<% 	
			}	
		}
		
	}

%>
<script>
		location.href = "./userSurveyResult.jsp?sid=<%=sid%>";
</script>

	<!-- JQuery Java Script Add -->
	<script src="../js/jquery.min.js" ></script>
	<!-- Popper Java Script Add -->
	<script src="../js/popper.min.js" ></script>
	<!-- Bootstrap Java Script Add -->
	<script src="../js/bootstrap.min.js" ></script>
</body>