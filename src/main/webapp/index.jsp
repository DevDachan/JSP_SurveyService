<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   %>
    
<%@ page import='java.io.PrintWriter'  %>
<%@ page import='user.UserDAO'  %>

    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Survey Project</title>
</head>
<body>

<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");	
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'Login.jsp';");
		script.println("</script>");
		script.close();
	}
%>


	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp" >강의평가 웹 사이트 </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
				
					<a class="nav-link dropdowm-toggle" id="dropdown" data-toggle="dropdown">
						회원 관리	
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					
<%
	if(userID == null){
		
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<% 
	}
	else{
		
%>
						<a class="dropdown-item" href="userLogoutAction.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>	
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" aria-lable="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공">전공</option>
				<option value="교양">교양</option>
				<option value="기타">기타</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고하기</a>
		</form>
		
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"> 컴퓨터개론 &nbsp; <small> 나동빈 </small> </div>
					<div class="col-4 text-right">
						종합<span style="color: red;">A </span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title"> 정말 좋은 강의에요 &nbsp; <small> (2017년 가을학기)</small></h5>
				<p class="card-text">강의가 많이 널널해서, 솔직히 많이 배운 건 없지만 학점도 잘 나오고 너무 좋은 것 같습니다</p>
				<div class="row">
					<div class="col-9 text-left">
						성적 <span style="color: red;" > A </span>
						널널 <span style="color: red;" > B </span>
						강의 <span style="color: red;" > C </span>
						<span style="color: green;">(추천:15) </span>				
					</div>
					<div class="col-3 text-right">
						<a onClick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
						<a onClick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
					</div>
				</div>
			</div>
		</div>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"> 컴퓨터개론 &nbsp; <small> 나동빈 </small> </div>
					<div class="col-4 text-right">
						종합<span style="color: red;">A </span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title"> 정말 좋은 강의에요 &nbsp; <small> (2017년 가을학기)</small></h5>
				<p class="card-text">강의가 많이 널널해서, 솔직히 많이 배운 건 없지만 학점도 잘 나오고 너무 좋은 것 같습니다</p>
				<div class="row">
					<div class="col-9 text-left">
						성적 <span style="color: red;" > A </span>
						널널 <span style="color: red;" > B </span>
						강의 <span style="color: red;" > C </span>
						<span style="color: green;">(추천:15) </span>				
					</div>
					<div class="col-3 text-right">
						<a onClick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
						<a onClick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
					</div>
				</div>
			</div>
		</div>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"> 컴퓨터개론 &nbsp; <small> 나동빈 </small> </div>
					<div class="col-4 text-right">
						종합<span style="color: red;">A </span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title"> 정말 좋은 강의에요 &nbsp; <small> (2017년 가을학기)</small></h5>
				<p class="card-text">강의가 많이 널널해서, 솔직히 많이 배운 건 없지만 학점도 잘 나오고 너무 좋은 것 같습니다</p>
				<div class="row">
					<div class="col-9 text-left">
						성적 <span style="color: red;" > A </span>
						널널 <span style="color: red;" > B </span>
						강의 <span style="color: red;" > C </span>
						<span style="color: green;">(추천:15) </span>				
					</div>
					<div class="col-3 text-right">
						<a onClick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
						<a onClick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
					</div>
				</div>
			</div>
		</div>
		
	</section>
	
	
		<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id ="modal">평가등록</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>	
					</div>
					<div class="modal-body">
						<form action="./evaluationRegisterAction.jsp" method="post">
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label>강의명</label>
									<input type="text" name="lectureName" class="form-control" maxlength=20>
								</div>
								<div class="form-group col-sm-6">
									<label>교수명</label>
									<input type="text" name="professorName" class="form-control" maxlength=20>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-4">
									<label>수강 연도</label>
									<select name="lectureYear" class="form-control">
										<option value="2011">2011</option>
										<option value="2012">2012</option>
										<option value="2013">2013</option>
										<option value="2014">2014</option>
										<option value="2015">2015</option>
										<option value="2016">2016</option>
										<option value="2017">2017</option>
										<option value="2018">2018</option>
										<option value="2019">2019</option>
										<option value="2020">2020</option>
										<option value="2021">2021</option>
										<option value="2022" selected>2022</option>
									</select>
								</div>
								<div class="form-group col-sm-4">
									<label> 수강학기</label>
									<select name="semesterDivide" class="form-control">
										<option value="1학기" selected>1학기</option>
										<option value="여름학기">여름학기</option>
										<option value="2학기">2학기</option>
										<option value="겨울학기">겨울학기</option>
									</select>
								</div>
								<div class="form-group col-sm-4">
									<label> 강의 구분</label>
									<select name="lectureDivide" class="form-control">
										<option value="전공" selected>전공</option>
										<option value="교양">교양</option>
										<option value="기타">기타</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label>제목</label>
								<input type="text" name="evaluationTitle" class="form-control" maxlength="30">	
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height:180px; "></textarea>	
							</div>
							<div class="form-row">
								<div class="form-group col-sm-3">
									<label>성적</label>
									<select name="creditScore" class="form-control">
										<option value="A" selected> A </option>
										<option value="B" selected> B </option>
										<option value="C" selected> C </option>
										<option value="D" selected> D </option>
										<option value="E" selected> E </option>
										<option value="F" selected> F </option>
									</select>
								</div>
								<div class="form-group col-sm-3">
									<label>종합</label>
									<select name="totalScore" class="form-control">
										<option value="A" selected> A </option>
										<option value="B" selected> B </option>
										<option value="C" selected> C </option>
										<option value="D" selected> D </option>
										<option value="E" selected> E </option>
										<option value="F" selected> F </option>
									</select>
								</div> 
								<div class="form-group col-sm-3">
									<label>널널</label>
									<select name="confortableScore" class="form-control">
										<option value="A" selected> A </option>
										<option value="B" selected> B </option>
										<option value="C" selected> C </option>
										<option value="D" selected> D </option>
										<option value="E" selected> E </option>
										<option value="F" selected> F </option>
									</select>
								</div> 
								<div class="form-group col-sm-3">
									<label>강의력</label>
									<select name="lectureScore" class="form-control">
										<option value="A" selected> A </option>
										<option value="B" selected> B </option>
										<option value="C" selected> C </option>
										<option value="D" selected> D </option>
										<option value="E" selected> E </option>
										<option value="F" selected> F </option>
									</select>
								</div>  
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-primary" >등록하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div> 
		
		<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id ="modal">신고하기</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>	
					</div>
					<div class="modal-body">
						<form action="./reportAction.jsp" method="post">
							<div class="form-group">
								<label>신고 제목</label>
								<input type="text" name="reportTitle" class="form-control" maxlength="30">	
							</div>
							<div class="form-group">
								<label>신고 내용</label>
								<textarea name="reportContent" class="form-control" maxlength="2048" style="height:180px; "></textarea>	
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-danger" >신고하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div> 

	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF;">
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