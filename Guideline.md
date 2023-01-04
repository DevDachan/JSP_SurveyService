# :clipboard: 사용 방법

##  1️⃣ 로그인 페이지

<img src="https://user-images.githubusercontent.com/111109411/210489668-27778d5a-b9b7-4957-844f-39ef7d02da03.png" width=50%>

* **로그인 페이지에서는 기본적으로 ID와 비밀번호를 입력 받습니다.**  

### ⚫ ID 오류  && 비밀번호 오류 
<div align="left">
  <img src="https://user-images.githubusercontent.com/111109411/210497816-a4ca204e-2ad4-4886-a6e3-c104a6aa89c3.png" width=20%>   
  <img src="https://user-images.githubusercontent.com/111109411/210497878-9be90127-4668-4ee7-98a8-cb4c9eb16df0.png" width=20%> 
  <img src="https://user-images.githubusercontent.com/111109411/210497578-fc70ca7c-4e50-433d-901d-b81a3c23cc95.png" width=20%>    
  <img src="https://user-images.githubusercontent.com/111109411/210497600-a7160898-c6c6-4976-a665-0583f2957036.png" width=20%> 
</div>

* **ID 또는 비밀번호가 틀릴 경우 오류 메세지와 함께 로그인이 되지 않습니다.**
* **만약 ID와 비밀번호가 일치할 경우에는 세션 정보를 저장 후 메인 화면으로 이동하게 됩니다.**







</br>   

##  2️⃣ 회원 가입 페이지
 
<img src="https://user-images.githubusercontent.com/111109411/210489765-90a7b517-bf9a-474a-9c11-b5f7b9fa8d2d.png" width=50%>   

* **회원가입시에는 기본적으로 사용하게 될 ID와 비밀번호 그리고 메일 인증 과정을 거치게 됩니다.**


### ⚫ ID 중복
<div>
  <img src="https://user-images.githubusercontent.com/111109411/210489814-a1d4c4f0-2e73-4f50-9200-f7e3aede5745.png" width=40%>  
  <img src="https://user-images.githubusercontent.com/111109411/210489834-d5384e6e-b8d5-48ca-aa7c-053bc6c0b389.png" width=40%>     
</div>

* **만약 ID가 이미 존재할 경우 중복 메세지를 띄우고 회원가입이 되지 않게 막습니다.**
* **메일도 동일하게 이미 존재하는 메일 주소일 경우에는 인증 절차가 불가능하도록 막습니다.**

### 🟡 이메일 인증하기 
<img src="https://user-images.githubusercontent.com/111109411/210489785-750e7b28-c3af-4c66-80bb-d81c87c0514e.png" width=50%> 

* **이메일 인증 과정을 modal을 통해서 현재 페이지 위에 창을 띄워 작업을 하게 됩니다.**
* **이메일 인증 과정에서는 사용자에게 mail 형식의 입력을 받고 해당 메일로 랜덤한 8자리 숫자를 전송해 인증을 받도록 합니다.**

<div>
  <img src="https://user-images.githubusercontent.com/111109411/210489868-2185e32e-b8ed-4be3-86e6-6432b891ff44.png" width=30%> 
  <img src="https://user-images.githubusercontent.com/111109411/210489878-80670a3f-893a-4737-97a8-00678dd2f77d.png" width=30%> 
  <img src="https://user-images.githubusercontent.com/111109411/210489914-09a55e75-f47d-4ea4-a838-8a12d3a02b58.png" width=30%> 
</div>

* **코드가 전송 완료되면 하단부분에 인증 코드를 입력하는 입력 부분이 나타나게 되고 해당 부분에 올바른 코드를 입력해야 인증이 완료 됩니다.**

### 🔵 이메일 인증 완료 
<img src="https://user-images.githubusercontent.com/111109411/210489980-ea7addbc-1aba-4321-a55b-7e24c372f428.png" width=50%> 

* **이메일 인증이 완료 됐을 경우 회원가입 페이지에서 인증 받은 메일 주소가 자동으로 입력되게 됩니다.**







</br>   

## 3️⃣ 메인 페이지 
<img src="https://user-images.githubusercontent.com/111109411/210493816-933df2ae-50ce-4552-8625-1cbaa36ffc30.png" width=50%>   

* **메일 화면에서는 자신이 관리자로 들어가있는 설문 목록과 이전에 설문에 참여한 내역을 확인이 가능합니다.**   


### ⚫ 카톡 공유 페이지 
<img src="https://user-images.githubusercontent.com/111109411/210494717-c18d54ba-0037-4e93-8766-7f309d75716b.png" width=50%> 

* **카카오톡으로 설문조사 링크를 공유할 시에는 자신의 카카오톡 계정으로 로그인 후 공유가 가능합니다.**








</br>   

## 4️⃣ \[관리자\] 수정 페이지 
<img src="https://user-images.githubusercontent.com/111109411/210493904-0903ea3d-c1a9-41b9-8713-0956ea359bba.png" width=50%> 

* **관리자가 설문조사 내용들을 수정하는 페이지로써 주 설문 서비스의 주 기능을 담당하는 페이지 입니다.**
* **해당 페이지에서 입력하는 내용들을 바로바로 DB에 저장이 되며 별다른 버튼을 눌러 저장할 필요가 없습니다.**

#### 중복 가능
> * **중복 가능 토글 버튼은 사용자가 설문에 참여하면서 중복된 설문을 제출할수 있게 할지를 결정해주는 버튼입니다.**

#### 수정 가능
> * **수정 가능 토글 버튼은 사용자가 이전 설문을 수정할 수 있게 할지를 결정해주는 버튼입니다.**


### ⚫ 질문 종류 

<div>
  <img src="https://user-images.githubusercontent.com/111109411/210494138-1e8651cb-b5f2-4d80-a87b-92e9982f76ce.png" width=30%> 
  <img src="https://user-images.githubusercontent.com/111109411/210494169-4b23f694-4d70-4faf-8044-e3d6c7ae93f7.png" width=30%> 
  <img src="https://user-images.githubusercontent.com/111109411/210494186-0bba5f5a-3374-41ca-8205-66873edfbf07.png" width=30%> 
</div>

* **왼쪽부터 차례대로 라디오, 체크박스, 텍스트 형식의 질문을 생성한 모습입니다.**
* **옵션 추가를 누를 경우 선택지가 추가되며 왼쪽 -버튼을 누를 경우 해당 선택지가 삭제 됩니다.**
* **질문 삭제는 해당 질문을 삭제하는 버튼입니다.**
* **중복 선택 불가 토글 버튼의 경우에는 해당 선택지를 각각의 사용자마다 중복을 방지할지를 결정해주는 버튼입니다.**




</br>  

## 5️⃣ \[관리자\] 결과 구성 페이지

### ⚫ Default(기본 페이지) 
<img src="https://user-images.githubusercontent.com/111109411/210494235-a5d0f1be-a1c9-4505-ab51-8392e01363ae.png" width=50%> 

* **기본 페이지의 경우에는 사용자의 선택과는 상관없이 모든 설문 결과에 대한 페이지를 구성하는 스크립트를 말합니다.**
* **상단에 위치한 태그-질문 내용의 경우에는 사용자가 선택한 선택지를 결과 페이지에서 가져와 사용할 수 있게 제공하는 태그를 말합니다.**
* **해당 태그 이외에 다른 HTML 태그 또한 사용이 가능합니다.**


### 🟡 라디오 선택시 
<img src="https://user-images.githubusercontent.com/111109411/210494410-94cba102-5d64-4580-9bd0-2e98ff5dffc7.png" width=50%> 

* **만약 특정 라디오 옵션을 선택할 시에 라디오 옵션의 선택지에 따라서 결과 페이지 분기가 가능해집니다.**





</br>   

## 6️⃣ \[관리자\] 통계 페이지

### ⚫ 통계 보기 
<img src="https://user-images.githubusercontent.com/111109411/210494478-08955fb7-7d80-4ffa-8219-3fd2767be59b.png" width=50%> 

* **통계 보기의 경우 해당 설문에서 모든 설문 결과를 통계를 통해 다이어그램으로 종합해서 보여주는 페이지입니다.**


### 🟡 개인 응답 
<img src="https://user-images.githubusercontent.com/111109411/210494539-3e7e232e-6dbc-4504-bdc6-5a135a50d1d1.png" width=50%> 

* **개인 응답의 경우에는 각각의 사용자의 응답을 따로 확인 할 수 있는 페이지입니다.**




</br>   

## 7️⃣ \[사용자\] 설문 페이지
<div> 
  <img src="https://user-images.githubusercontent.com/111109411/210494797-4ec0117b-c59e-498d-aab6-9150fc6b3866.png" width=50%> 
  <img src="https://user-images.githubusercontent.com/111109411/210494833-8b9621c1-beb4-4318-ae16-fdaff3523c4a.png" width=50%> 
</div>

* **사용자 설문 페이지에서는 해당 설문 제목, 설문 설명 내용을 보여주고 각각의 질문지를 나타내줍니다.**
* **사용자가 설문에 참여할 경우에는 제일 하단에 위치한 제출하기 버튼을 눌러야 해당 설문 내용이 제출이 됩니다.**   


### ⚫ 중복 선택 불가시 
<img src="https://user-images.githubusercontent.com/111109411/210494881-af6685c6-daf0-4cea-b2a0-564e12a48e92.png" width=50%> 

* **만약 해당 질문에 대해서 중복 선택 불가를 관리자가 선택했을 경우에는 이전 사용자들이 선택한 옵션에 대해서 disabled되어 선택이 불가능합니다.**




</br>   

## 8️⃣ \[사용자\] 결과 페이지 
<img src="https://user-images.githubusercontent.com/111109411/210495049-d372a8af-5bc1-4035-92da-36b525723289.png" width=50%> 

* **설문이 제출되고 결과페이지는 관리자가 미리 설정한 결과 페이지 내용을 출력해줍니다.**
* **만약 관리자가 따로 설정을 하지 않았다면 기본적으로 제출이 완료되었습니다가 출력됩니다.**

### ⚫ 메일 보내기 
<img src="https://user-images.githubusercontent.com/111109411/210495076-456282a7-65b5-450e-8c26-d72bf11c8a85.png" width=50%> 

* **로그인이 된 상태로 메일 보내기를 클릭했을 경우 해당 결과 페이지 내용을 메일로 전송해줍니다.**

### 🟡 게스트 결과 페이지 
<img src="https://user-images.githubusercontent.com/111109411/210495196-68a9ba78-032e-4c30-9f41-ef8ac01cba29.png" width=50%> 

* **만약 로그인이 안된 상태라면 사용자에게 직접 이메일을 입력 받고 해당 메일로 결과를 전송해줍니다.**
