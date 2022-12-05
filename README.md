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
<image src="https://user-images.githubusercontent.com/111109411/205490048-73cfb9ba-4d13-46de-a3ea-4ba01156d584.png" />
* 구글 로그인은 아직 구현되지 않았습니다.

## 회원 가입 페이지
<image src="https://user-images.githubusercontent.com/111109411/205490091-ce3f3cb8-1c3c-4a91-a88e-df73c103f1ca.png" />

* 회원가입을 하면서 기본적으로 이메일 인증을 사용해 회원가입을 하게 됩니다. 만약 회원가입시 이메일 인증을 하지 않고 회원가입을 할 경우에 DB에 Not이 저장이 된다.
(이메일 인증을 하는 이유는 사용자 인증과 추후 설문 결과를 이메일로 받기 위함이다.)

<image src="https://user-images.githubusercontent.com/111109411/205490195-2eb9301b-5efd-4ea4-add4-aaca007905ae.png" />

* 이메일 인증하기를 누르면 보이는 것과 같이 Modal을 통해 인증하기 화면이 생성된다.

<image src="https://user-images.githubusercontent.com/111109411/205490321-e3648291-aaad-43dd-927b-2b5adb232123.png" width="50%" />
<image src="https://user-images.githubusercontent.com/111109411/205490327-4c976da8-abcd-4617-8e81-6de3fc7f40f2.png" width="50%" height="200px"/>


## 메인 화면
<image src=""/>


## 회원 가입 페이지
<image src=""/>


## 회원 가입 페이지
<image src=""/>

## 회원 가입 페이지
<image src=""/>

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
