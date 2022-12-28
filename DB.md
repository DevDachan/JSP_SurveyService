# DB구성

## E-R Diagram
![survey_service](https://user-images.githubusercontent.com/111109411/209756717-5640d1d9-10ad-4580-acea-e1c7fb11ec64.jpg)



[1. Survey](#1-Survey)

[2. Opition_detail](#2-Opition_detail)

[3. Survey_option](#3-Survey_option)

[4. Survey_result](#4-Survey_result)

[5. user](#5-user)

[6. emailcode](#6-emailcode)



### 1. Survey
> Survey는 기본적인 설문의 큰 정보를 가지고 있는 Table입니다.
> * **id**            : 각각의 설문지를 구분할 수 있는 ID정보 입니다.   
> * **admin_id**      : 설문지의 소유자 ID정보 입니다.   
> * **name**          : 각 설문의 이름을 말합니다.   
> * **content**       : 각 설문의 소개글을 이야기합니다.   
> * **result_option** : 결과 페이지의 분기를 위해 사용되는 Option의 number를 말합니다.   
> * **limit_state**   : 설문지가 중복이 가능한지를 check하는 속성입니다. (1: 중복불가, 0:중복가능)    
> * **edit_state**    : 설문지가 중복이 가능한지를 check하는 속성입니다. (1: 중복불가, 0:중복가능)    

### 2. Option_detail
> Option_detail 각 설문의 질문(Option) 정보를 가지고 있는 Table입니다.    
> * **survey_id**        : 각각의 설문지를 구분할 수 있는 ID정보 입니다.   
> * **option_num**       : 질문(Option)을 구분하는 Index number를 말합니다. 
> * **option_title**     : 질문(Option)의 제목입니다. 
> * **option_content**   : 질문(Option)의 설명 내용입니다.   
> * **type**             : 질문(Option)의 Type을 말합니다. (radio, checkbox, text)

### 3. Survey_option
> Survey_option은 각 설문의 질문(Option)의 선택지(Component) 정보를 가지고 있는 Table입니다.    
> * **survey_id**         : 각각의 설문지를 구분할 수 있는 ID정보 입니다.   
> * **option_num**        : 질문(Option)을 구분하는 Index number를 말합니다.  
> * **component_num**     : 질문 선택지(Component)를 구분하는 Index number를 말합니다.    
> * **type**              : 질문(Option)의 Type을 말합니다. (radio, checkbox, text) 
> * **content**           : 질문 선택지(Component)의 값입니다. 


### 4. Survey_result
> Survey_result은 설문지의 결과 페이지 내용을 담고 있는 Table입니다.    
> * **survey_id**         : 각각의 설문지를 구분할 수 있는 ID정보 입니다.   
> * **option_num**        : 질문(Option)을 구분하는 Index number를 말합니다.  
> * **component_num**     : 질문 선택지(Component)를 구분하는 Index number를 말합니다.   
> * **content**           : 결과 페이지 HTML Script를 저장합니다.   


### 5. user
> user는 각 사용자들의 정보를 담고 있습니다..    
> * **id**             : 사용자 아이디입니다.   
> * **pwd**            : 사용자 아이디의 비밀번호입니다.   
> * **user_email**     : 사용자의 Email입니다.  


### 6. emailcode
> emailcode는 이메일 인증시 인증코드를 비교하기 위해 사용되는 Table입니다.    
> * **email**          : 사용자의 Email입니다.
> *  **code**          : 사용자 Email 인증을 위해 생성되는 random값으로 8자리 numver로 되어 있습니다.






