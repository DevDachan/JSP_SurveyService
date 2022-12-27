<img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=200&section=header&text=Survey-service-JSP&fontSize=70" width=100% />

<div align='center'>
	<img src="https://img.shields.io/badge/JavaScript-007396?style=flat&logo=JavaScript&logoColor=white"/>
	<img src="https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=MySQL&logoColor=white"/>
	<img src="https://img.shields.io/badge/Apache Tomcat-F8DC75?style=flat&logo=Apache Tomcat&logoColor=white"/>
	<img src="https://img.shields.io/badge/JQuery-0769AD?style=flat&logo=JQuery&logoColor=white"/>
	<img src="https://img.shields.io/badge/HTML-007396?style=flat&logo=HTML5&logoColor=white"/>
	<img src="https://img.shields.io/badge/CSS-F43059?style=flat&logo=CSS Wizardry&logoColor=white"/>
</div>
<br/>


- 기존에 존재하는 Google Forms과 Microsoft Forms에서 라디오 버튼의 선택지로 결과 페이지를 분기시키는 기능과 프로그래밍적 요소를 추가할 수 있는 기능을 추가한 서비스입니다.




<br/>
<br/>

## :yellow_heart:목차
[1. 미리보기](#green_heart미리보기)

[2. 개발 환경](#blue_heart개발-환경)

[3. 설치](#purple_heart설치)

[4. 페이지 흐름](#heartpulse페이지-흐름)

[5. 주요 기능](#heartbeat주요-기능)

[6. JSP Study](#notebookjsp-study)



<br/>
<br/>

## :green_heart:미리보기
<div>
	<img src="https://user-images.githubusercontent.com/111109411/209615941-ad2a34c1-33c1-48a4-b4fb-69f55c2854b3.png" style="height:300px; width:400px"/>
	<img src="https://user-images.githubusercontent.com/111109411/209616400-94392b5f-a7e4-4efa-a980-528e9b5ab417.png" style="height:300px; width:400px"/>
</div>

<br/>
<br/>

## :blue_heart:개발 환경 

[Eclipse v4.25.0](https://www.eclipse.org/downloads/) - JAVA 개발 환경

[tomcat v9.0](https://tomcat.apache.org/download-80.cgi)  - Web container

[mysql v8.0.28](https://dev.mysql.com/downloads/installer/) - DB

[Bootstrap v4.0.0](https://getbootstrap.com/) - Web framework


<br/>
<br/>

## :purple_heart:설치
- Clone the repo: ```git clone https://github.com/DevDachan/Survey-service-JSP.git```

<br/>
<br/>


## :heartpulse:페이지 흐름
 
> #### 1. View page
> * View page의 경우 사용자에게 보여주는 페이지를 구성하는 jsp파일을 이야기 합니다. 해당 페이지에서는 단순히 HTML코드를 가지고 페이지 구성을 나타내거나 DAO를 통해 가져온 값을 통해서 tag값을 구성하기도 합니다. 
>
> #### 2. Action page
> * Action apge의 경우에는 page를 이동하면서 필요한 특정 action들을 담고 있는 jap 파일입니다. 예를 들어 Login이나 Logout을 하거나 이메일 인증 코드등을 통해서 값을 비교할 때 중간 단계에서 DB값과 비교하는 페이지라고 생각하시면 됩니다.
> * 추가적으로 설문조사를 만들면서 질문 내용이나 옵션등을 추가하거나 삭제하는 기능에서도 action page가 사용이되며 해당 page는 ajax를 통해 비동기식으로 처리가 됩니다.
>
> #### 3. DAO and DTO 
> * DAO와 DTO는 Data Access Object ,Data Transfer Object를 말하며 DB에 있는 data에 접근시 사용되는 java class를 말합니다. 보통 DTO는 DB에 있는 table의 attribute와 동일하게 구성이되는 object를 말하고 DAO의 경우에는 DB에서 CRUD를 담당하는 Query문을 실행시켜주는 Method를 가지고 있는 class를 말합니다.

<br/>
<br/>


## :heartbeat:주요 기능

> #### 1. 결과 페이지 구성
> - 결과페이지에서는 먼저 이전 사용자가 설문에 응답한 내용를 토대로 내용을 출력해줘야 합니다. 때문에 각각의 결과 페이지에서 어떤 질문을 토대로 분기를 할지 결정을 합니다. 기본적으로 하나만 선택할 수 있는 라디오버튼이 선택 사항이 됩니다. 


> ##### Admin Result
> - Admin측에서는 textarea를 통해 결과 페이지에 대한 HTML을 작성하게 됩니다. 이때 '\n'을 포함해 저장이 되어야 하므로 wrap option을 hard로 지정해줘야 합니다. warp은 textarea의 text를 보내면서 줄바꿈을 포함시켜 보내주며 cols를 지정해줘야 사용이 가능합니다.
```
<textarea maxlength='2048' wrap="hard" cols="20" onkeydown="resize(this)" onkeyup="resize(this)" class="result-content" id="ta_content" onChange="editContent(0)"></textarea>
```


> ##### User Result
> - DB에 저장된 text를 불러오면서는 이전에 사용자에게 제공해줬던 tag값을 통해 DB에 저장된 설문 정보와 matching시켜 값을 대입시켜줍니다. 이때 값은 replace()를 사용해 넣어주며 출력하는 부분에서 HTML로 출력이 되기 때문에 줄바꿈 문자를 </br>로 바꿔주는 작업이 필요 합니다.
```
<%
	String content = resultDAO.userResultContent(sid, userID,date);
		
	OptionDetailDTO[] option = surveyDAO.getOption(sid);
	for(int i = 0; i< option.length; i++){
		if(option[i].getType().equals("checkbox")){
			String temp = "["+option[i].getType() + option[i].getOptionNum()+"]";
			String[] userSelectComponent = resultDAO.getSelectComponentCheckbox(sid,userID,date,option[i].getOptionNum());
			String userSelect = "";
			for(int k = 0; k< userSelectComponent.length; k++){
				userSelect += userSelectComponent[k];
				if(k != userSelectComponent.length-1){
					userSelect += ",";
				}
			}
				
			content = content.replace(temp,userSelect);	
		}else{
			String temp = "["+option[i].getType() + option[i].getOptionNum()+"]";
			String userSelect = resultDAO.getSelectComponent(sid,userID,date,option[i].getOptionNum());
				
			content = content.replace(temp,userSelect);	
		}
	}
	content = content.replace("\n","<br/>");
%>
<%=content%>
```

</br>


> #### 2. Alert.jsp
> - alert를 위한 기능을 사용하면서 자바에서 제공하는 기본적인 alert의 경우에는 각각의 브라우져 환경마다 다른 형태로 출력이 되기 때문에 해당 alert를 위해서 modal을 사용하여 경고 문구를 출력하도록 했습니다.
> 
> ※   alert의 경우 사용자의 USE CASE의 흐름을 방해하기 때문에 사용을 지양하고 정말 필요한 부분에서만 사용해야 합니다.
```
<%@ page import='java.net.URLDecoder' %>
<%
	request.setCharacterEncoding("UTF-8");
	String title =URLDecoder.decode(request.getParameter("title"), "UTF-8");
	String content = URLDecoder.decode(request.getParameter("content"), "UTF-8");
	String url = URLDecoder.decode(request.getParameter("url"), "UTF-8");
%>
<a id="sessionModal" data-toggle="modal" href="#Modal" style="display:none;"></a>	
	
<script>
	window.onload=function(){
		document.getElementById("sessionModal").click();	
	}
</script>

<div class="modal fade" id="Modal" tabindex="-1" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id ="modal">
					<%=title %>
				</h5>
				<button type="button" class="close" data-dismiss="modal" onClick="<%=url%>" aria-label="Close" >
				<span aria-hidden="true">&times;</span>
				</button>	
			</div>
			
			<div class="modal-body">
				<div class="form-row">
					<div class="form-group col-sm-12">
						<label><%=content %></label>
					</div>		
					<div class="modal-footer col-sm-12">
						<div class="form-group col-sm-12">
							<button type="button" id="close_modal" class="btn btn-secondary" style="width:100%;" data-dismiss="modal" onClick="<%=url%>">닫기</button>
						</div>  </div> </div> </div> </div>	</div> </div>
```

> alert.jap 사용하는 부분
> - 해당 alert.jsp를 사용할 때에는 사용하는 페이지에서 actiontag를 이용해 title, content, url parameter를 넘겨주며 선언을 해주면 됩니다.
> - 이때 사용되는 jsp:include action tag의 경우에는 페이지가 실행되면서 다른 jsp페이지를 포함시켜주는 역할을 합니다.
```
	if(session.getAttribute("userID") == null){
	%>
		<jsp:include page='alert.jsp'> 
				<jsp:param name="title" value="<%=URLEncoder.encode(\"로그인\", \"UTF-8\") %>" />
				<jsp:param name="content" value="<%=URLEncoder.encode(\"세션 정보가 존재하지 않습니다\", \"UTF-8\") %>" />
				<jsp:param name="url" value="location.href = './login/Login.jsp';" />
		</jsp:include>
	<%
	
	}
```
<image src="https://user-images.githubusercontent.com/111109411/208437090-e0b2f93a-e10d-424b-afe0-56145735d899.png" width=50%>


> #### 3. Ajax
> - ajax는 기본적으로 페이지 내부에서 비동기적인 흐름을 담게 해주는 기법 중 하나로써 해당 서비스에서는 설문지를 만들고 해당 설문지 내부에서 수정 및 삭제하는 작업시 바로바로 DB와 연동해서 update가 되도록 만들어주는 기능을 하고 있습니다.
> - 해당 ajax기법을 사용함으로써 사용자는 설문지를 수정하면서 특정 submit 버튼 없이 내용 수정이 가능합니다.
> - ajax는 특정 page에 request를 보내고 response를 받아와 결과에 대한 작업 수행이 가능합니다. 이때 Data를 request에 함께 실어서 보낼 수 있으며 앞서 말한 action페이지에서는 이렇게 ajax로 들어온 request에 대해서 DB값을 update하는 작업을 하게 됩니다.   
```
		function addComponent(surveyID, optionNum){
			$.ajax({
        	 	type:'post',
          	 	async:false,
           		url:'http://localhost:8080/Survey_project/admin/addSurveyComponent.jsp',
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
```  
  
  
## :man:Authors

* **Dachan Seo** - [DevDachan](https://github.com/DevDachan)


## Acknowledgments
* Hat tip to anyone whose code was used
* Inspiration
* etc





<br/>
<br/>

### README-template
-------------------
https://gist.github.com/PurpleBooth/109311bb0361f32d87a2#file-readme-template-md 


### :notebook:JSP Study
-------------
[Notion - JSP Study](https://circular-otter-276.notion.site/JSP-2022-11-7a8fdc51009b402ab2bf778612774916)
