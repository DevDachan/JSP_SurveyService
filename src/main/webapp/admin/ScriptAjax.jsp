
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
		function addComponent(surveyID, optionNum){
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionAddSurveyComponent.jsp',
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
		function deleteComponent(surveyID, optionNum, componentNum){

			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionDeleteSurveyComponent.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNum,
            		componentNum:componentNum
            		},
            	success: function(res) {
            		window.location.reload();	
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function addOption(){
			
			surveyID = document.getElementById("surveyID").value;
			optionType = document.getElementById("optionType").value;
			
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionAddSurveyOption.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionType:optionType
            		},
            	success: function(res) {
            		window.location.reload();	
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function deleteOption(surveyID, optionNum){			
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionDeleteSurveyOption.jsp',
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
		function editOption(surveyID, optionNum, type){
			
			if(type == 1){
				content = document.getElementById("optionTitle"+optionNum).value;	
				optionType = "title";
			}else{
				content = document.getElementById("optionContent"+optionNum).value;
				optionType = "content";
			}

			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionEditOption.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNum,
            		content:content,
            		type:optionType
            		},
            	success: function(res) {
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function editComponent(surveyID, optionNum, componentNum,type){
			if(type == 1){
				optionType="radio";
			}else if(type == 2){
				optionType="checkbox";
			}
			content = document.getElementById(optionType+optionNum+componentNum).value;	
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionEditComponent.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID, 
            		optionNum:optionNum,
            		componentNum:componentNum,
            		content:content
            		},
            	success: function(res) {
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function editSurvey(surveyID, type){
			if(type == 1){
				optionType="surveyTitle";
			}else if(type == 2){
				optionType="surveyContent";
			}
			content = document.getElementById(optionType).value;	
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionEditSurvey.jsp',
            	dataType:'text',
            	data:{
            		surveyID:surveyID,
            		type:optionType,
            		content:content
            		},
            	success: function(res) {
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function change_limit_state(sid){
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionChangeLimitState.jsp',
            	dataType:'text',
            	data:{
            		surveyID:sid
            		},
            	success: function(res) {
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
		function change_edit_state(sid){
			$.ajax({
        	 	type:'post',
          	 	async:false, //false가 기본값임 - 비동기
           		url:'http://localhost:8080/Survey_project/admin/ActionChangeEditState.jsp',
            	dataType:'text',
            	data:{
            		surveyID:sid
            		},
            	success: function(res) {
            	},
            error:function (data, textStatus) {
                console.log('error');
            }
      	  })  	
		}
</script>

