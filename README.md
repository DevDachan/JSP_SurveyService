# Survey-service-JSP


## Purpose
Google Forms과 Microsoft Forms을 JSP를 사용해서 구현. 기존에 있는 Form에서 결과 페이지를 구성하거나 Google email뿐만 아니라 다른 email들을 사용할 수 있게 하고 사용자가 설문 결과에 대해서 단순히 설문지 결과 뿐만 아니라 미리 설정을 해놓음으로써 설문지 결과 or 특정 질문 선택지에 따른 결과 창을 디자인 할 수 있도록 하는 것이 목적이다.
<br/>



## Previous solution
-------------------- 
* #### Google Forms
<image src="https://user-images.githubusercontent.com/111109411/204485195-2d1ea060-ac3f-4144-9e85-4524f7effa4f.png"  width="250" height="200"/>
https://docs.google.com/forms/

* #### Microsoft Forms
<image src="https://user-images.githubusercontent.com/111109411/204485423-9c6b7f00-9ff6-4edc-81c4-1aaa3d88d1eb.png"  width="250" height="200"/>
https://forms.office.com/ 

### 로그인 페이지
<image src="https://user-images.githubusercontent.com/111109411/205638820-42d094c7-62fd-4e3e-8d22-f7331695c4c6.png" />
* 구글 로그인은 아직 구현되지 않았습니다.


## 회원 가입 페이지
<image src="https://user-images.githubusercontent.com/111109411/205638907-1d4c07c5-bd78-46e8-848a-8aeb2de141ba.png" />


* 회원가입을 하면서 기본적으로 이메일 인증을 사용해 회원가입을 하게 됩니다. 만약 회원가입시 이메일 인증을 하지 않고 회원가입을 할 경우에 DB에 Not이 저장이 된다.
(이메일 인증을 하는 이유는 사용자 인증과 추후 설문 결과를 이메일로 받기 위함이다.)

<image src="https://user-images.githubusercontent.com/111109411/205638959-f006bb65-0a8a-407d-a8a0-e70a4bfe00ac.png" />

* 이메일 인증하기를 누르면 보이는 것과 같이 Modal을 통해 인증하기 화면이 생성된다.

<image src="https://user-images.githubusercontent.com/111109411/205639092-b23df0f4-80cf-4e82-8b7f-706487d16047.png" />
<image src="https://user-images.githubusercontent.com/111109411/205639167-27e2361c-3192-4eb0-9980-83fc19eda464.png" />

## 메인 화면
<image src="https://user-images.githubusercontent.com/111109411/205639340-9f483109-a0d8-4df6-a05d-d7ffc8144ef7.png"/>
* 메인 화면에서는 현재 내가 관리자로 있는 설문지와 이전에 설문에 참여했던 내역들을 확인 할 수 있다.


## 설문 수정
<image src="https://user-images.githubusercontent.com/111109411/205639541-86e89b3b-e0fd-4993-b911-e9b466ca735c.png"/>

* 설문은 총 3가지로 구성된다. suervey: 전체 설문지, option: 각각의 질문에 해당하는 blcok, component: 답변. 
* 제일 상단에 위치한 내용에는 설문지의 제목과 설문 설명이 들어가고 질문은 Radio, Checkbox, Text로 구성된다. 

<br/>

<image src="https://user-images.githubusercontent.com/111109411/205639901-0d9bbb12-7b1f-443a-94d8-8f30e575cda8.png"/>

* selection과 + 버튼을 통해 새로운 질문지를 추가할 수 있으며 미리보기를 통해 유저가 보는 페이지를 확인 할 수 있다. 제일 하단에 위치한 설문 조사 삭제하기를 누르면 전체 설문지가 삭제된다.

		function addComponent(surveyID, optionNum){
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
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
    
* 해당 수정 페이지에서 전체적인 수정 과정은 ajax를 사용해 비동기식으로 처리하기 때문에 별다른 submit이 필요없고 수정하는 동시에 DB에 값이 저장되고 수정된다.

## 유저 설문 페이지
<image src="https://user-images.githubusercontent.com/111109411/205640416-22ebfd28-ccd2-45a8-9734-535bcc5e70f7.png"/>

		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}else{
			userID = "Guest";
		}
    
* 유저가 들어온 설문지 페이지에서는 수정할 수 있는 버튼들이 보이지 않으며 만약 현재 로그인이 된 사용자라면 사용자의 아이디를 저장하고 그렇지 않다면 "Guest"값으로 DB에 저장이 된다.


## Alert
<image src="https://user-images.githubusercontent.com/111109411/205641222-67d3cec7-a7ca-44b9-a9a4-faf2b77b9aac.png"/>

```
  if(result == 0){
				%>
				<jsp:include page='../alert.jsp'> 
						<jsp:param name="title" value="<%=URLEncoder.encode(\"ERROR\", \"UTF-8\") %>" />
						<jsp:param name="content" value="<%=URLEncoder.encode(\"DB 오류가 발생했습니다.\", \"UTF-8\") %>" />
						<jsp:param name="url" value="history.back();"/>
				</jsp:include\>	
				<% 	
			}
```

* 해당 서비스에서는 자바에서 제공되는 alert()를 별도의 modal을 사용해 구현했으며 jsp파일로 원하는 알림 부분에서 title,content,url을 넣어 사용하면 된다. 해당 파일을 사용할 때는 jsp의 action tag인 include를 통해 jsp파일을 추가해준다.

<br/> 

## Draft design 
---------------
<image src="https://user-images.githubusercontent.com/111109411/204488705-8e777975-4e9a-453a-bbcc-b46818afcd94.jpg" />
https://www.figma.com/file/aQCJkBCNo8teAWXhETiZa1/Survey?node-id=0%3A1&t=L2SnxxHQvxm2hP5d-1 


<br/>

## Language
-----------
#### JSP, JQuery, HTML, JS, CSS, MySQL


<br/>
<br/>

### JSP Study
-------------
https://circular-otter-276.notion.site/JSP-2022-11-7a8fdc51009b402ab2bf778612774916
