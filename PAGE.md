# 페이지 설명





- Ajax를 사용하면서 만약 결과 값을 사용해야 한다면 현재 페이지와 동기식으로 작동이 되어야 하기 때문에 async옵션을 false로 해야하고 결과 값이 중요 하지 않을 경우에는 기본적으로 default로 되어 있는 true로 설정해줘야 합니다. 
- 만약 async가 false로 되어 있을 경우 해당 작업이 모두 완료될 때까지 페이지가 기다리므로 메일 전송하는 상황같은 경우 페이지가 멈춘것처럼 보일 수 있습니다.

# JSP Page
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

### 1-8 ActionRegister.jsp
> - ActionRegister.jsp 페이지는 회원가입시 모든 입력사항이 입력 됐을 경우 이동하는 페이지로써 입력받은 값을 2차적으로 중복이 있는지 확인 하고 DB에 넣는 작업을 합니다. DB에 insert이후 session정보를 저장하고 index.jsp페이지로 이동합니다.
> - **Parameter**: 사용자 ID, Email, Password
> - **사용되는 페이지**: ViewRegister.jsp

### 1-9 ViewLogin.jsp
> - 처음 로그인 화면을 구성하는 페이지로 사용자에게 ID와 Password를 입력받아 ActionLogin.jsp 페이지로 넘겨주는 작업을 해줍니다. 


### 1-10 ViewRegister.jsp
>  - 회원가입을 하는 페이지로 사용자에게 새로운 ID와 Password를 입력받으며 email인증을 받기 위해 modal을 사용합니다. modal 내부에서는 사용자에게 email을 입력 받고 ActionCodeSend.jsp 페이지를 사용해 해당 메일에 인증코드를 보냅니다. 이후 ActionCodeCheck.jsp페이지를 사용해서 해당 코드값을 확인해 인증을 완료합니다. 사용자에게 ID, Password, Mail인증까지 모두 입력 받았으면 ActionRegister.jsp페이지로 해당 값을 넘겨줍니다.

</br>

## 2. admin
### 2-1 ActionAddSurvey.jsp
### 2-2 ActionAddSurveyComponent.jsp
### 2-3 ActionChangeEditState.jsp
### 2-4 ActionChangeLimitState.jsp
### 2-5 ActionChangeResultOption.jsp
### 2-6 ActionDeleteSurvey.jsp
### 2-7 ActionDeleteSurveyComponent.jsp
### 2-8 ActionDeleteSurveyOption.jsp
### 2-9 ActionEditComponent.jsp
### 2-10 ActionEditOption.jsp
### 2-11 ActionEditResult.jsp
### 2-12 ActionEditSurvey.jsp
### 2-13 ScriptAjax.jsp
### 2-14 ViewAdminStatistic.jsp
### 2-15 ViewAdminSurvey.jsp
### 2-16 ViewAdminSurveyResult.jsp
### 2-17 ViewUserResponse.jsp

</br>

## 3. user
### 3-1 ActionDeleteHistory.jsp
### 3-1 ActionMailSend.jsp
### 3-1 ActionUserEditSubmit.jsp
### 3-1 ActionUserSurveySubmit.jsp
### 3-1 ViewUserSurvey.jsp
### 3-1 ViewUserSurveyEdit.jsp
### 3-1 ViewUserSurveyResult.jsp




# DAO and DTO
## 1. history
### 1-1 HistoryCountDTO.java
### 1-2 HistoryDAO.java
### 1-3 HistoryDTO.java
### 1-4 HistoryListDTO.java

</br>

## 2. result

## 3. survey

## 4. user
