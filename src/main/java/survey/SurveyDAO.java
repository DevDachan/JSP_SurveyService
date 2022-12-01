package survey;

import javax.servlet.ServletContext;

import util.DatabaseUtil;

public class SurveyDAO extends DatabaseUtil {
	
	public SurveyDAO(ServletContext application) {
		super(application);
	}
	
	public int addSurvey(String userID) {
		try {
			String query = "INSERT INTO survey_option VALUES('randomID','radio',1,1,'Radio')";
			psmt = con.prepareStatement(query);
			psmt.executeUpdate();
			
			query = "INSERT INTO survey_option VALUES('randomID','checkbox',2,1,'Checkbox')";
			psmt = con.prepareStatement(query);
			psmt.executeUpdate();
			
			query = "INSERT INTO survey_option VALUES('randomID','text',3,1,'Text')";
			psmt = con.prepareStatement(query);
			psmt.executeUpdate();
			
			query = "INSERT INTO option_detail VALUES('randomID',1,'Title','content','radio')";
			psmt = con.prepareStatement(query);
			psmt.executeUpdate();
			
			query = "INSERT INTO option_detail VALUES('randomID',2,'Title','content','checkbox')";
			psmt = con.prepareStatement(query);
			psmt.executeUpdate();
			
			query = "INSERT INTO option_detail VALUES('randomID',3,'Title','content','text')";
			psmt = con.prepareStatement(query);
			psmt.executeUpdate();
			
			
			
			query = "INSERT INTO survey VALUES('randomID','test',?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1,userID);
			int result = psmt.executeUpdate();
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int editComponent(String surveyID, int optionNum,int componentNum ,String content) {
		String query = "UPDATE survey_option SET content=? WHERE survey_id = ? AND option_num = ? AND component_num=?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, content);
			psmt.setString(2, surveyID);
			psmt.setInt(3, optionNum);
			psmt.setInt(4, componentNum);
				
			int result = psmt.executeUpdate();
			if(result == 0) {
				return 0;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		return 0;
	}
	
	public int editOption(String surveyID, int optionNum ,String content, String type) {
		
		if(type.equals("title")) {
			String query = "UPDATE option_detail SET option_title=? WHERE survey_id = ? AND option_num = ?;";
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, content);
				psmt.setString(2, surveyID);
				psmt.setInt(3, optionNum);
					
				int result = psmt.executeUpdate();
				if(result == 0) {
					return 0;
				}
				return 1;
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else {
			String query = "UPDATE option_detail SET option_content=? WHERE survey_id = ? AND option_num = ?;";
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, content);
				psmt.setString(2, surveyID);
				psmt.setInt(3, optionNum);
					
				int result = psmt.executeUpdate();
				if(result == 0) {
					return 0;
				}
				return 1;
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		
		return 0;
	}
	
	
	public int deleteComponent(String surveyID , int optionNum, int componentNum) {
		
		String query = "DELETE FROM survey_option WHERE survey_id = ? AND option_num = ? AND component_num = ?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, surveyID);
			psmt.setInt(2, optionNum);
			psmt.setInt(3, componentNum);
			
			int result = psmt.executeUpdate();
			if(result == 0) {
				return 0;
			}
			
			query = "SELECT COUNT(*) FROM survey_option WHERE survey_id=? AND option_num = ?;";
			psmt = con.prepareStatement(query);
			psmt.setString(1, surveyID);
			psmt.setInt(2, optionNum);
			rs = psmt.executeQuery();
			if(rs.next()){
				if(rs.getInt(1) == 0) {
					query = "DELETE FROM option_detail WHERE survey_id=? AND option_num = ?;";
					psmt = con.prepareStatement(query);
					psmt.setString(1, surveyID);
					psmt.setInt(2, optionNum);
					psmt.executeUpdate();
				}
			}
			
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return 0;
		
	}
	public int deleteOption(String surveyID, int optionNum) {
		String query = "DELETE FROM option_detail WHERE survey_id=? AND option_num = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, surveyID);
			psmt.setInt(2, optionNum);
			
			int result = psmt.executeUpdate();
			if(result == 0) {
				return 0;
			}else {
				query = "DELETE FROM survey_option WHERE survey_id=? AND option_num = ?";
				psmt = con.prepareStatement(query);
				psmt.setString(1, surveyID);
				psmt.setInt(2, optionNum);
				result = psmt.executeUpdate();
				if(result == 0) {
					return 0;
				}else {
					return 1;
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int addOption(String surveyID, String optionType) {
		String getquery = "SELECT MAX(option_num) FROM option_detail where survey_id = ?";
		int maxIndex = 0;
		
		try {
			psmt = con.prepareStatement(getquery);
			psmt.setString(1, surveyID);


			rs = psmt.executeQuery();
			if(rs.next()) {
				maxIndex = rs.getInt(1)+1;
				if(maxIndex == 1) {
					return 0;
				}	
			}
			

		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		String query = "INSERT INTO option_detail VALUES(?,?,'test_title','test_content',?)";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, surveyID);
			psmt.setInt(2, maxIndex);
			psmt.setString(3, optionType);

			int result = psmt.executeUpdate();
			query = "INSERT INTO survey_option VALUES(?,?,?,?,'test');";
			psmt = con.prepareStatement(query);
			psmt.setString(1, surveyID);
			psmt.setString(2, optionType);
			psmt.setInt(3, maxIndex);
			psmt.setInt(4, 1); // Component number
			psmt.executeUpdate();
			return result;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return 0;
	}
	public int addComponent(String surveyID , int optionNum) {
		String getquery = "SELECT type, MAX(component_num) FROM survey_option where survey_id = ? AND option_num =?;";
		String surveyType="";
		int componentNum = 0;
		try {
			psmt = con.prepareStatement(getquery);
			psmt.setString(1, surveyID);
			psmt.setInt(2, optionNum);

			rs = psmt.executeQuery();
			if(rs.next()) {
				surveyType = rs.getString(1);
				componentNum = rs.getInt(2)+1;
				if(surveyType==null) {
					return 0;
				}
				if(componentNum==0) {
					return 0;
				}
			}

			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		String query = "INSERT INTO survey_option VALUES(?,?,?,?,'New option')";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, surveyID);
			psmt.setString(2, surveyType);
			psmt.setInt(3, optionNum);
			psmt.setInt(4, componentNum);
			
			int result = psmt.executeUpdate();
			return result;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public String[][] getOption(String sid) {
		String[][] option = null;
		int option_len = 0;
		String count_option = "SELECT COUNT(*) FROM option_detail WHERE survey_id=?;";
		try {
			psmt = con.prepareStatement(count_option);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				option_len = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		String select_option = "SELECT * FROM option_detail WHERE survey_id = ?;";
		option= new String[option_len][2];
		try {
			psmt = con.prepareStatement(select_option);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
		
			int i = 0;
			while(rs.next()){ // get survey content
				option[i][0] = rs.getString(3);
				option[i++][1] =  rs.getString(4);
				if(i == option_len) {
					break;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return option;
	}
	public SurveyDTO[] getComponent(String sid) {
		SurveyDTO[] survey = null;
		int survey_len = 0;
		String count_survey = "SELECT COUNT(*) FROM survey_option WHERE survey_id=?;";
		try {
			psmt = con.prepareStatement(count_survey);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				survey_len = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		String query = "SELECT * FROM survey_option JOIN survey ON (survey_id = id) WHERE survey_id = ?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();

			survey = new SurveyDTO[survey_len];
			int i = 0;
			while(rs.next()){ // get survey content
				survey[i] = new SurveyDTO(rs.getString(1),rs.getString(2),rs.getInt(3),rs.getInt(4),rs.getString(5),rs.getString(7));
				i++;
				if(i == survey_len) {
					break;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return survey;
	}
	
	public String[][] getOptionResult(String sid) {
		String[][] option = null;
		int option_len = 0;
		
		try {
			String query = "SELECT COUNT(*) FROM option_detail WHERE survey_id = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				option_len = rs.getInt(1);
			}

			
			query = "SELECT option_num, type FROM option_detail WHERE survey_id = ?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			option = new String[option_len][2];
			int i = 0;
			while(rs.next()) {
				option[i][0] = rs.getString(1);
				option[i++][1] = rs.getString(2);
				
				if(i == option_len) {
					break;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return option;
	}
	
	public int getHistoryNum(String sid) {
		String query = "SELECT MAX(history_index) FROM survey_history WHERE survey_id=?";
		
		try{
			psmt = con.prepareStatement(query);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int addHistory(String sid,String userID,int history_index,int option_num,int component_num,String content,String date){
		String query = "INSERT INTO survey_history VALUES(?,?,?,?,?,?,?)";
		try{
			psmt = con.prepareStatement(query);
			psmt.setString(1, sid);
			psmt.setString(2, userID);
			psmt.setInt(3, history_index);
			psmt.setInt(4, option_num);
			psmt.setInt(5, component_num);
			psmt.setString(6, content);
			psmt.setString(7, date);
			
			int result = psmt.executeUpdate();
			return result;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}






/*
 * public String getAdminSurvey(String sid) {
		SurveyDTO[] survey = null;
		
		String buf = "";		
		String result ="";
		int option_len = 0;
		int survey_len = 0;
		String[] option_content;
		String[] option_title ;
		
		//------------------- get survey data --------------------------------
		
		
		
		//-------------------- get Count length ------------------------------
		String count_survey = "SELECT COUNT(*) FROM survey_option WHERE survey_id=?;";
		try {
			psmt = con.prepareStatement(count_survey);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				survey_len = rs.getInt(1);				
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
		String count_option = "SELECT COUNT(*) FROM option_detail WHERE survey_id=?;";
		try {
			psmt = con.prepareStatement(count_option);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				option_len = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//------------------------- get component data ------------------------------
		String query = "SELECT * FROM survey_option JOIN survey ON (survey_id = id) WHERE survey_id = ?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();

			survey = new SurveyDTO[survey_len];
			int i = 0;
			while(rs.next()){ // get survey content
				survey[i] = new SurveyDTO(rs.getString(1),rs.getString(2),rs.getInt(3),rs.getInt(4),rs.getString(5),rs.getString(7));
				i++;
				if(i == survey_len) {
					break;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		//------------------------- get Option data ------------------------------
		String query2 = "SELECT * FROM option_detail WHERE survey_id = ? ORDER BY option_num ASC;";
		option_content = new String[option_len];
		option_title = new String[option_len];
		
		try {
			psmt = con.prepareStatement(query2);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
		
			int i = 0;
			while(rs.next()){ // get survey content
				option_title[i] = rs.getString(3);
				option_content[i++] =  rs.getString(4);
				if(i == option_len) {
					break;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		//-----------------------Set Survey Option Tag--------------------------------
		int count = 0;
		int temp_id;
		for(int option_num = 0; option_num< option_len; option_num++){
			String start = "<div class='option mb-5'>\n"+
								"<div class='option-title'>\n" + 
									"<textarea maxlength='30' class='option-title-text' id='optionTitle"+survey[count].getOptionNum()+"' onChange='editOption("+sid+","+survey[count].getOptionNum()+",1)'>"+ option_title[option_num]+"</textarea>\n" + 
								"</div>\n"+
							"<div class='option-content'>\n"+
								"<div class='option-content-item'>\n"+
									"<textarea maxlength='2048' class='option-content-text' id='optionContent"+survey[count].getOptionNum()+"' onChange='editOption("+sid+","+survey[count].getOptionNum()+",2)' >"+option_content[option_num]+"</textarea>\n" + 
								"</div>\n"+
							"</div>\n";
		
			buf = "";
			temp_id = survey[count].getOptionNum();

			while(count < survey.length && survey[count].getOptionNum() == temp_id){
				if(survey[count].getOptionType().equals("radio")){
					buf += "<div class='option-rows'>"; 
					buf += "<div class='option-item'><label><input type='radio' name='radio"+survey[count].getComponentNum()+"' value='radio' placeholder='helo'></label></div>";
					// 라디오 버튼 나눌 때는 이름으로 해서 같은 이름일 경우에는 다중 선택이 안된다.
					buf += "<div class='option-item'> <input class='edit-text' type='text' id='radio' name='radio' value='"+survey[count].getContent() +"'></label></div>";
					buf += "<div class='option-item'> <button class='btn btn-option-delete' type='button' onClick='deleteComponent("+survey[count].getSurveyID() +
							","+survey[count].getOptionNum()+","+survey[count].getComponentNum() +")' >-</button> </div>";
					buf +="</div>";
				}else if(survey[count].getOptionType().equals("checkbox")){
					buf += "<div class='option-rows'>"; 
					buf += "<div class='option-item'><label><input type='checkbox' name='checkbox"+survey[count].getComponentNum()+"' value='checkbox' placeholder='helo'></label></div>";
					buf += "<div class='option-item'> <input class='edit-text' type='text' id='checkbox"+survey[count].getOptionNum()+
							survey[count].getComponentNum()+"' name='checkbox"+survey[count].getOptionNum()+survey[count].getComponentNum()+
							"' value='"+survey[count].getContent() +
							"' onChange='editComponent("+sid+","+survey[count].getOptionNum()+","+survey[count].getComponentNum()+",2)'></label></div>";
					buf += "<div class='option-item'> <button class='btn btn-option-delete' type='button' onClick='deleteComponent("+survey[count].getSurveyID() +
							","+survey[count].getOptionNum()+","+survey[count].getComponentNum() +")' >-</button> </div>";
					buf +="</div>";
				}else if(survey[count].getOptionType().equals("text")){
					buf += "<div class='option-rows-text'>"; 
					buf += "<textarea name='text'" + survey[count].getComponentNum()+ " class='form-control' maxlength='2048' style='height:100px;'></textarea>";
					buf +="</div>";
					buf += "<div class='option-rows'>"+
							"<div class='option-item'></div>"+	
							"<div class='option-item'></div>"+	
							" <button class='option-item mt-3 btn btn-add' type='button' id='delete_btn"+(survey[count].getOptionNum())+
							"' onClick='deleteOption("+survey[count].getSurveyID() +","+survey[count].getOptionNum() +")' >Delete</button>"+
							"</div>";
				}
				count++;			
			}
			if(survey[count-1].getOptionType().equals("text") == false) {
				buf += "<div class='option-rows'>"+
							"<div class='option-item'>"+
								" <button class='btn btn-primary' type='button' id='add_btn"+(survey[count-1].getOptionNum())+
								"' onClick='addComponent("+survey[count-1].getSurveyID() +","+survey[count-1].getOptionNum() +")' >+ Add option</button>"+
							"</div>"+
							"<div class='option-item'></div>"+	
							"<div class='option-item'>"+
								" <button class='btn btn-add' type='button' id='delete_btn"+(survey[count-1].getOptionNum())+
								"' onClick='deleteOption("+survey[count-1].getSurveyID() +","+survey[count-1].getOptionNum() +")' >Delete</button>"+
							"</div>"+
						" </div>";
			}
			
			buf += "</div>";
			result = result + start + buf;
		}
		
		return result;
	}
	public String getUserSurvey(String sid) {
		SurveyDTO[] survey = null;
		
		String buf = "";		
		String result ="";
		int option_len = 0;
		int survey_len = 0;
		String[] option_content;
		String[] option_title ;
		
		//-------------------- get Count length ------------------------------
		String count_survey = "SELECT COUNT(*) FROM survey_option WHERE survey_id=?;";
		try {
			psmt = con.prepareStatement(count_survey);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				survey_len = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		String count_option = "SELECT COUNT(*) FROM option_detail WHERE survey_id=?;";
		try {
			psmt = con.prepareStatement(count_option);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				option_len = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//------------------------- get Survey data ------------------------------
		String query = "SELECT * FROM survey_option JOIN survey ON (survey_id = id) WHERE survey_id = ?;";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();

			survey = new SurveyDTO[survey_len];
			int i = 0;
			while(rs.next()){ // get survey content
				survey[i] = new SurveyDTO(rs.getString(1),rs.getString(2),rs.getInt(3),rs.getInt(4),rs.getString(5),rs.getString(7));
				i++;
				if(i == survey_len) {
					break;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		//------------------------- get Option data ------------------------------
		String query2 = "SELECT * FROM option_detail WHERE survey_id = ?;";
		option_content = new String[option_len];
		option_title = new String[option_len];
		
		try {
			psmt = con.prepareStatement(query2);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
		
			int i = 0;
			while(rs.next()){ // get survey content
				option_title[i] = rs.getString(3);
				option_content[i++] =  rs.getString(4);
				if(i == option_len) {
					break;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		//-----------------------Set Survey Option Tag--------------------------------
		int count = 0;
		int temp_id;
		for(int option_num = 0; option_num< option_len; option_num++){
			String start = "<div class='option mb-5'>\n"+
							"<div class='option-title'>\n" + 
							"<p class='option-title-text'>"+ option_title[option_num]+
							"</p>\n" + 
							"</div>\n"+
							"<div class='option-content'>\n"+
							"<div class='option-content-item'>\n"+
							option_content[option_num]+
							"</div>\n"+
							"</div>\n";
			buf = "";
			temp_id = survey[count].getOptionNum();

			while(count < survey.length && survey[count].getOptionNum() == temp_id){
				if(survey[count].getOptionType().equals("radio")){
					buf += "<div class='option-rows'>"; 
					buf += "<div class='option-item'><label><input type='radio' name='radio"+survey[count].getComponentNum()+"' value='radio' placeholder='helo'></label></div>";
					// 라디오 버튼 나눌 때는 이름으로 해서 같은 이름일 경우에는 다중 선택이 안된다.
					buf += "<div class='option-item'> <label type='text' id='radio' name='radio' >"+survey[count].getContent()+"</label></div>";
					buf +="</div>";
				}else if(survey[count].getOptionType().equals("checkbox")){
					buf += "<div class='option-rows'>"; 
					buf += "<div class='option-item'><label><input type='checkbox' name='checkbox"+survey[count].getComponentNum()+"' value='checkbox' placeholder='helo'></label></div>";
					buf += "<div class='option-item'> <label id='checkbox' name='checkbox' >"+survey[count].getContent() +"</label></div>";
					buf +="</div>";
				}else if(survey[count].getOptionType().equals("text")){
					buf += "<div class='option-rows-text'>"; 
					buf += "<textarea name='text'" + survey[count].getComponentNum()+ " class='form-control' maxlength='2048' style='height:100px;'></textarea>";
					buf +="</div>";
				}
				count++;			
			}
			
			buf += "</div>";
			result = result + start + buf;
		}
		
		return result;
	}
 * 
 * */
