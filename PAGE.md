# :bulb: 페이지 설명

</br>
</br>

**\[Parameter\]**
- 해당 페이지에서 request로 받는 parameter의 list를 말합니다.

**\[Ajax Option\]**
- Ajax를 사용하면서 만약 결과 값을 사용해야 한다면 현재 페이지와 동기식으로 작동이 되어야 하기 때문에 async옵션을 false로 해야하고 결과 값이 중요 하지 않을 경우에는 기본적으로 default로 되어 있는 true로 설정해줘야 합니다. 
- 만약 async가 false로 되어 있을 경우 해당 작업이 모두 완료될 때까지 페이지가 기다리므로 메일 전송하는 상황같은 경우 페이지가 멈춘것처럼 보일 수 있습니다.

</br>   
# View And Action Page

## [1 Login](#1-login)   
[1-1 ActionCodeCheck.jsp](#1-1-actioncodecheckjsp-ajax)   
[1-2 ActionCodeSend.jsp](#1-2-actioncodesendjsp-ajax)   
[1-3 ActionEmailCheck.jsp](#1-3-actionemailcheckjsp-ajax)   
[1-4 ActionIDCheck.jsp](#1-4-actionidcheckjsp)   
[1-5 ActionLogin.jsp](#1-5-actionloginjsp)   
[1-6 ActionLogout.jsp](#1-6-actionlogoutjsp)   
[1-7 ActionRegister.jsp](#1-7-actionregisterjsp)   
[1-8 ViewLogin.jsp](#1-8-viewloginjsp)   
[1-9 ViewRegister.jsp](#1-9-viewregisterjsp)   


## [2 Admin](#1-login)   
[2-1 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-2 ActionAddSurveyComponent.jsp (Ajax)](#2-2-actionaddsurveycomponentjsp-ajax)   
[2-3 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-4 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-5 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-6 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-7 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-8 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-9 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-10 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-11 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-12 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-13 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-14 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-15 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-16 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   
[2-17 ActionAddSurvey.jsp](#2-1-actionaddsurveyjsp-ajax)   

## [3 User](#3-user)   

## [DAO and DTO](#dao-and-dto)   

</br>
</br>



---------------------------------------------------------------------------------------

## 1. Login
* 전체적인 로그인과 회원가입 페이지들을 담고 있는 폴더입니다.
### 1-1 ActionCodeCheck.jsp (Ajax)
>  - ActionCodeCheck.jsp 페이지는 사용자에게 보낸 Email 인증 번호와 사용자가 입력한 번호가 일치하는지를 확인해주는 페이지입니다. Ajax를 통해 사용이 되며 만약 현재 DB에 email_cdoe table에서 사용자의 코드 정보가 일치한다면 sucess를, 그렇지 않다면 Fail을 response로 반환해줍니다.
>  - **Parameter**: 사용자 email, code 번호
>  - **Async**: false
>  - **사용되는 페이지**: ViewRegister.jsp


### 1-2 ActionCodeSend.jsp (Ajax)
>  - ActionCodeSend.jsp 페이지는 회원가입 페이지에서 사용자에게 인증 번호 메일을 보내는 페이지입니다. 인증번호는 8자리의 random한 정수값을 생성해서 DB에 저장 후 사용자에게 전송이 됩니다.
>  - **Parameter**: 사용자 email    
>  - **Async**: true
>  - **사용되는 페이지**: ViewRegister.jsp


### 1-3 ActionEmailCheck.jsp (Ajax)
>  - ActionEmailCheck.jsp 페이지는 회원가입시 사용자의 email 중복을 확인하는 페이지로 현재 서비스에 해당 email이 등록되어있는지 DB에서 확인해주는 페이지입니다. 사용자 email이 등록된 적이 없다면 Sucess를, 그렇지 않다면 False를 response로 반환해줍니다.    
>  - **Parameter**: 사용자 email
>  - **Async**: false
>  - **사용되는 페이지**: ViewRegister.jsp


### 1-4 ActionIDCheck.jsp (Ajax)
>  - ActionIDCheck.jsp 페이지 또한 사용자의 ID의 중복을 확인하는 페이지로 회원 가입시 사용자가 ID를 입력했을 때 input tag의 onChange의 script에서 사용이 됩니다. 입력값으로는 사용자의 ID를 받고 해당 ID가 이미 DB에 존재할 경우에는 False를 response로 반환해줍니다.   
>  - **Parameter**: 사용자 ID
>  - **Async**: false
>  - **사용되는 페이지**: ViewRegister.jsp


### 1-5 ActionLogin.jsp
> -  ActionLogin.jsp 페이지는 로그인 페이지에서 사용자에게 입력받은 ID와 Password를 DB에 있는 값과 확인하여 session에 저장해주는 페이지입니다. 만약 사용자의 ID가 올바르지 않거나 비밀번호가 맞지 않다면 Alert를 띄우고 로그인 페이지로 이동하며 일치할 경우에는 session에 저장후 index.jsp페이지로 이동합니다. 
> - **Parameter**: 사용자 ID, Password
> - **사용되는 페이지**: ViewLogin.jsp

### 1-6 ActionLogout.jsp
> -  AcionLogout.jsp 페이지는 로그아웃 페이지로써 session에 저장된 로그인 정보를 지우고 로그인 페이지로 이동하게 해줍니다.   
> - **사용되는 페이지**: 모든 페이지

### 1-7 ActionRegister.jsp
> - ActionRegister.jsp 페이지는 회원가입시 모든 입력사항이 입력 됐을 경우 이동하는 페이지로써 입력받은 값을 2차적으로 중복이 있는지 확인 하고 DB에 넣는 작업을 합니다. DB에 insert이후 session정보를 저장하고 index.jsp페이지로 이동합니다.
> - **Parameter**: 사용자 ID, Email, Password
> - **사용되는 페이지**: ViewRegister.jsp

### 1-8 ViewLogin.jsp
> - 처음 로그인 화면을 구성하는 페이지로 사용자에게 ID와 Password를 입력받아 ActionLogin.jsp 페이지로 넘겨주는 작업을 해줍니다. 


### 1-9 ViewRegister.jsp
>  - 회원가입을 하는 페이지로 사용자에게 새로운 ID와 Password를 입력받으며 email인증을 받기 위해 modal을 사용합니다. modal 내부에서는 사용자에게 email을 입력 받고 ActionCodeSend.jsp 페이지를 사용해 해당 메일에 인증코드를 보냅니다. 이후 ActionCodeCheck.jsp페이지를 사용해서 해당 코드값을 확인해 인증을 완료합니다. 사용자에게 ID, Password, Mail인증까지 모두 입력 받았으면 ActionRegister.jsp페이지로 해당 값을 넘겨줍니다.

</br>

## 2. Admin
### 2-1 ActionAddSurvey.jsp (Ajax)
> - ActionAddSurvey.jsp는 index.jsp 페이지에서 새로운 설문을 추가하는 페이지로써 설문을 만드는 method를 실행하고 만들어진 설문지 정보를 통해 ViewAdminSurvey.jsp로 이동시켜줍니다.
> - **Parameter**: 사용자 ID(userID)
> - **Async**: false

### 2-2 ActionAddSurveyComponent.jsp (Ajax)
> - ActionAddSurveyComopnent.jsp는 ViewAdminSurvey.jsp 페이지에서 각각의 질문(Option)의 선택지(Component)를 추가하는 페이지입니다 
> - **Parameter**: 설문지 ID(surveyID), 질문 번호(OptionNum)
> - **Async**: false

### 2-3 ActionAddSurveyOption.jsp (Ajax)
> - ActionAddSurveyComopnent.jsp는 ViewAdminSurvey.jsp 페이지에서 설문(survey)의 질문(Option)을 추가하는 페이지입니다. 
> - **Parameter**: 설문지 ID(surveyID), 질문 형식(Option Type)
> - **Async**: false


### 2-4 ActionChangeEditState.jsp (Ajax)
> - ActionChangeEditState.jsp는 설문지의 수정 가능 여부를 판단하는 Edit state값을 변경할 때 사용되는 페이지로써  ViewAdminSurvey.jsp 페이지에서 토글 버튼의 onClick event에서 사용이 됩니다.
> - **Parameter**: 설문지 ID(surveyID)
> - **Async**: false

### 2-5 ActionChangeLimitState.jsp (Ajax)
> - ActionChangeLimitState.jsp는 설문지의 중복 가능 여부를 판단하는 Limit state값을 변경할 때 사용되는 페이지로써  ViewAdminSurvey.jsp 페이지에서 토글 버튼의 onClick event에서 사용이 됩니다.
> - **Parameter**: 설문지 ID(surveyID)
> - **Async**: false

### 2-6 ActionChangeResultOption.jsp (Ajax)
> - ActionChangeResultOption.jsp는 결과 페이지를 분기시키는 옵션을 변경하는 페이지로써 만약 이전에 해당 질문(Option)에 대한 결과 페이지 구성이 있으면 해당 값을 불러오고 없다면 새로운 구성을 만들어서 DB에 Insert합니다.
> - **Parameter**: 사용자 ID(userID)
> - **Async**: false

### 2-6 ActionDeleteSurvey.jsp (Ajax)
> - ActionDeleteSurvey.jsp는 설문지를 삭제하는 페이지로써 해당 설문지 ID와 관련된 모든 정보를 삭제하는 페이지입니다. 다른 사용자가 삭제하는 경우가 있을 수 있어 survey의 admin이 아닐 경우에는 삭제되지 않도록 userID값을 입력 받아 admin을 check하는 과정을 거칩니다.
> - **Parameter**: 사용자 ID(userID), 설문지 ID(surveyID)
> - **Async**: false

### 2-7 ActionDeleteSurveyComponent.jsp (Ajax)
> - ActionDeleteSurveyComponent.jsp는 설문지(survey)에서 특정 질문(Option)의 선택지(Component)를 삭제하는 페이지 입니다. 
> - **Parameter**: 설문지 ID(surveyID), 질문 번호(OptionNum), 선택지 번호(ComponentNum)
> - **Async**: false

### 2-8 ActionDeleteSurveyOption.jsp (Ajax)
> - ActionDeleteSurveyOption.jsp는 설문지(survey)에서 특정 질문(Option)을 삭제하는 페이지 입니다. 
> - **Parameter**: 설문지 ID(surveyID), 질문 번호(OptionNum)
> - **Async**: false

### 2-9 ActionEditComponent.jsp (Ajax)
> - ActionDeleteSurveyComponent.jsp는 설문지(survey)에서 특정 질문(Option)의 선택지(Component)내용을 수정하는 페이지로 선택지의 추가 삭제가 아닌 선택지 내용을 수정하는 페이지 입니다.
> - **Parameter**: 설문지 ID(surveyID), 질문 번호(OptionNum), 선택지 번호(ComponentNum), 내용(content)
> - **Async**: false

### 2-10 ActionEditOption.jsp (Ajax)
> - ActionEditOption.jsp는 설문지(Survey)에서 특정 질문(Option)의 제목(title)과 본문(content)를 수정하는 페이지입니다. 이때 type은 option의 type이 아닌 제목(title), 본문(content)를 나눠주는 역할을 합니다.
> - **Parameter**: 설문지 ID(surveyID), 질문 번호(OptionNum), 선택지 번호(ComponentNum), 내용(content), 유형(type: title, content)
> - **Async**: false

### 2-11 ActionEditResult.jsp (Ajax)
> - ActionEditResult.jsp는 결과 페이지 구성에 대해 수정을 할 때 사용되는 페이지입니다. 이때 각각의 선택지에 따라 분기되는 결과 페이지 내용을 수정하는 것입니다.
> - **Parameter**: 설문지 ID(surveyID), 질문 번호(OptionNum), 선택지 번호(ComponentNum), 내용(content)
> - **Async**: false

### 2-12 ActionEditSurvey.jsp (Ajax)
> - ActionEditSurvey.jsp는 설문지에 대한 제목과 설명 내용을 수정할 때 사용되는 페이지입니다. 이때 사용되는 type또한 제목(title),본문(content)를 구분하는데 사용되는 값입니다.
> - **Parameter**: 설문지 ID(surveyID), 내용(content), 유형(type: title, content)
> - **Async**: false

### 2-13 ScriptAjax.jsp
> - 해당 jsp파일은 ViewAdminSurvey.jsp 페이지에서 각각의 Action페이지를 사용하기 위한 ajax script문을 따로 구분해놓은 페이지입니다. ViewAdminSurvey에서 해당 페이지를 Action tag를 사용해 불러와 사용합니다.

### 2-14 ViewAdminStatistic.jsp
> - ViewAdminStatistic.jsp는 사용자의 응답에 대한 통계 결과와 사용자마다 응답결과를 확인 할 수 있는 페이지입니다. 해당 페이지에서는 history에서 해당 설문에 해당하는 내역들을 모두 불러와서 Diagram으로 나타내줍니다. 화면 상단에 위치한 navigator를 통해서 통계치를 확인 할지 각각의 사용자 응답 결과를 확인할 지를 선택할 수 있습니다. 만약 사용자 응답 결과를 선택할 경우 ViewUserResponse.jsp페이지로 이동합니다.


### 2-15 ViewAdminSurvey.jsp
> - ViewAdminSurvey.jsp는 설문지를 생성하고 수정하는 작업인 CRUD가 모두 이루어지는 페이지입니다. 페이지 생성에서 가장 중요한 페이지이며 해당 페이지에서 설문의 내용, 질문 내용, 결과페이지 내용등을 모두 수정, 삭제, 생성이 가능합니다. 기본적인 기능들은 모두 onChange event를 사용해 ajax를 호출함으로써 별도의 submit없이 DB의 값이 수정 가능합니다. 한마디로 관리자 입장에서의 설문지라고 생각하시면 됩니다.


### 2-16 ViewAdminSurveyResult.jsp
> - ViewAdminSurveyResult.jsp는 결과 페이지에 대한 구성을 할 수 있는 페이지로써 default를 선택할 시에는 모든 설문지가 같은 결과 페이지를 가지게 되고 설문의 Radio 질문을 통해서 각각의 선택지에 따라 다른 결과페이지를 사용자에게 보여지게 디자인도 가능합니다.


### 2-17 ViewUserResponse.jsp
> - ViewUserResponse.jsp의 경우에는 관리자가 각각의 사용자의 제출 내용을 확인 하는 페이지로써 설문의 내용을 직접적으로 수정하는 것은 불가능하고 단순히 확인만 가능합니다.

</br>

## 3 User
### 3-1 ActionDeleteHistory.jsp (Ajax)
> - ActionDeleteHistory.jsp는 사용자가 자신의 설문 내역을 삭제할 때 사용하는 페이지로써 선택한 설문 내역을 DB에서 삭제해줍니다.
> - **Parameter**: 설문지 ID(surveyID), 사용자 ID(userID), 과거 설문 ID(historyID)
> - **Async**: false

### 3-2 ActionMailSend.jsp (Ajax)
> - ActionMainSend.jsp는 사용자에게 설문 결과를 Mail로 보내주는 페이지입니다. 
> - **Parameter**: 사용자 Email(userEmail), 내용(content)
> - **Async**: true

### 3-3 ActionUserEditSubmit.jsp
> - ActionUserEditSubmit.jsp는 사용자가 자신의 설문 내역을 수정하고 제출했을 경우 해당 내용을 DB에 Update시켜주는 페이지입니다.
> - **Parameter**: 설문지 ID(surveyID), 과거 설문 ID(historyID), 사용자 ID(userID)

### 3-4 ActionUserSurveySubmit.jsp
> - ActionUserSurveySubmit.jsp는 사용자가 설문을 제출했을 때 해당 내용을 DB에 저장해주는 페이지입니다.
> - **Parameter**: 사용자 ID(userID), 각각의 설문 내역들(request.getParameterValues("checkbox")...)

### 3-5 ViewUserSurvey.jsp
> - ViewUserSurvey.jsp는 사용자가 설문에 들어왔을 때 보여지는 페이지로써 설문의 모든 질문들이 표시되고 선택이 가능합니다. 한마디로 사용자 입장에서의 설문지라고 생각하시면 됩니다.

### 3-6 ViewUserSurveyEdit.jsp
> - ViewUserSurveyEdit.jsp는 사용자가 이미 제출한 설문을 수정할 때 표시되는 페이지로써 해당 페이지에서는 이전에 설문에 참여한 내역을 불러와 체크를 하거나 내용을 출력해 나타냅니다.
> - Edit페이지와 처음 제출 페이지를 분리 시킨 이유는 페이지에서 사용자 설문 내역을 불러오는 작업을 할 때 편리를 위해서이고 이후 설문을 제출하면서 만약 처음 설문을 할 때는 Insert작업을 해야 하지만 Edit의 경우 Update를 해야 하기 때문입니다. 


### 3-7 ViewUserSurveyResult.jsp
> - ViewUserSurveyResult.jsp는 사용자가 자신이 제출한 설문의 결과를 확인 할 수 있게 해주는 페이지로써 처음 설문을 제출 했을 때와 history에서 결과를 확인 했을 때 모두를 다루는 페이지입니다.

</br>
</br>


# DAO and DTO
## 1. history
- history의 경우 사용자가 이전에 설문에 참여한 내역에 대한 DB 접근을 해야 할 때 필요한 쿼리를 담고 있는 DAO와 각각의 용도에 맞게 필드값을 가지고 있는 DTO를 담고 있는 package입니다.   
### 1-1 HistoryDAO.java
### 1-2 HistoryCountDTO.java
```
private int componentNum;
private int count;
private String componentContent;
```
### 1-3 HistoryDTO.java
```
private int optionNum;
private int componentNum;
private String content;
```
### 1-4 HistoryListDTO.java
```
private int surveyID;	
private String surveyName;
private String surveyDate;
private String userID;
private int historyID;
private int editState;
```
</br>

## 2. result
- result 경우 설문 결과 페이지를 구성하는 정보에 대한 DB 접근을 할 때 사용하는 쿼리문과 DTO를 담고 있는 package입니다. 이때 말하는 결과 페이지란 사용자가 설문을 제출한 뒤 보이는 페이지를 말합니다.   
### 2-1 ResultDAO.java
### 2-2 ResultDTO.java
```
private int surveyID;
private int optionNum;
private int componentNum;
private String componentContent;
private String resultContent;
```

</br>

## 3. survey
- survey 경우 설문지를 생성하고 사용자에게 설문을 보여주기 위해서 설문에 대한 정보에 접근할 때 사용이 되는 쿼리문과 Option, Comonent DTO를 가지고 있는 package입니다. 해당 survey에서 대부분의 작업들이 수행됩니다.
### 3-1 SurveyDAO.java

### 3-2 AdminDTO.java   
```
private String surveyID;
private String surveyName;
private String surveyContent;
```
### 3-3 ComponentDTO.java
```
private int surveyID;
private String optionType;
private int optionNum;
private int componentNum;
private String content;
private String surveyName;
```
### 3-4 OptionDetailDTO.java
```
private int surveyID;
private int optionNum;
private String optionTitle;
private String optionContent;
private String type;
```
### 3-5 SurveyDTO.java
```
private int surveyId;
private String surveyName;
private String adminId;
private String surveyContent;
private int resultOption;
private int limitState;
private int editState;
```

</br>

## 4. user
- user의 경우 사용자가 로그인, 회원 가입을 할 때 사용하는 쿼리문과 DTO를 담고 있는 package입니다.
### 4-1 UserDAO.java
### 4-1 UserDTO.java
```
private String userID;
private String userPassword;
```

