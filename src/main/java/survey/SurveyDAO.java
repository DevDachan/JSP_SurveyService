package survey;

import javax.servlet.ServletContext;

import util.DatabaseUtil;

public class SurveyDAO extends DatabaseUtil {
	
	public SurveyDAO(ServletContext application) {
		super(application);
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
			return 1;
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
			rs.next();
			maxIndex = rs.getInt(1)+1;
			if(maxIndex == 1) {
				return 0;
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
			rs.next();
			surveyType = rs.getString(1);
			componentNum = rs.getInt(2)+1;
			if(surveyType==null) {
				return 0;
			}
			if(componentNum==0) {
				return 0;
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
	
	public String getAdminSurvey(String sid) {
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
			rs.next();
			survey_len = rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}
		String count_option = "SELECT COUNT(*) FROM option_detail WHERE survey_id=?;";
		try {
			psmt = con.prepareStatement(count_option);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			rs.next();
			option_len = rs.getInt(1);
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
			String start = "<div class='survey mb-5'>\n"+
							"<div class='survey-title'>\n" + 
							"<p class='survey-title-text'>"+ option_title[option_num]+
							"</p>\n" + 
							"</div>\n"+
							"<div class='survey-content'>\n"+
							"<div class='survey-content-item'>\n"+
							option_content[option_num]+
							"</div>\n"+
							"</div>\n";
			buf = "";
			temp_id = survey[count].getOptionNum();

			while(count < survey.length && survey[count].getOptionNum() == temp_id){
				if(survey[count].getSurveyType().equals("radio")){
					buf += "<div class='survey-rows'>"; 
					buf += "<div class='survey-item'><label><input type='radio' name='radio"+survey[count].getComponentNum()+"' value='radio' placeholder='helo'></label></div>";
					// 라디오 버튼 나눌 때는 이름으로 해서 같은 이름일 경우에는 다중 선택이 안된다.
					buf += "<div class='survey-item'> <input class='edit-text' type='text' id='radio' name='radio' value='"+survey[count].getContent() +"'></label></div>";
					buf += "<div class='survey-item'> <button class='btn' type='button' onClick='deleteComponent("+survey[count].getSurveyID() +
							","+survey[count].getOptionNum()+","+survey[count].getComponentNum() +")' >-</button> </div>";
					buf +="</div>";
				}else if(survey[count].getSurveyType().equals("checkbox")){
					buf += "<div class='survey-rows'>"; 
					buf += "<div class='survey-item'><label><input type='checkbox' name='checkbox"+survey[count].getComponentNum()+"' value='checkbox' placeholder='helo'></label></div>";
					buf += "<div class='survey-item'> <input class='edit-text' type='text' id='checkbox' name='checkbox' value='"+survey[count].getContent() +"'></label></div>";
					buf += "<div class='survey-item'> <button class='btn' type='button' onClick='deleteComponent("+survey[count].getSurveyID() +
							","+survey[count].getOptionNum()+","+survey[count].getComponentNum() +")' >-</button> </div>";
					buf +="</div>";
				}else if(survey[count].getSurveyType().equals("text")){
					buf += "<div class='survey-rows-text'>"; 
					buf += "<textarea name='text'" + survey[count].getComponentNum()+ " class='form-control' maxlength='2048' style='height:100pxpx;'></textarea>";
					buf +="</div>";
				}
				count++;			
			}
			if(survey[count-1].getSurveyType().equals("text") == false) {
				buf += "<div class='survey-item-add'> <button class='btn btn-add' type='button' name='add_btn"+(survey[count-1].getOptionNum())+
						"' onClick='addComponent("+survey[count-1].getSurveyID() +","+survey[count-1].getOptionNum() +")' >+ Add option</button> </div>";
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
			rs.next();
			survey_len = rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}
		String count_option = "SELECT COUNT(*) FROM option_detail WHERE survey_id=?;";
		try {
			psmt = con.prepareStatement(count_option);
			psmt.setString(1, sid);
			rs = psmt.executeQuery();
			rs.next();
			option_len = rs.getInt(1);
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
			String start = "<div class='survey mb-5'>\n"+
							"<div class='survey-title'>\n" + 
							"<p class='survey-title-text'>"+ option_title[option_num]+
							"</p>\n" + 
							"</div>\n"+
							"<div class='survey-content'>\n"+
							"<div class='survey-content-item'>\n"+
							option_content[option_num]+
							"</div>\n"+
							"</div>\n";
			buf = "";
			temp_id = survey[count].getOptionNum();

			while(count < survey.length && survey[count].getOptionNum() == temp_id){
				if(survey[count].getSurveyType().equals("radio")){
					buf += "<div class='survey-rows'>"; 
					buf += "<div class='survey-item'><label><input type='radio' name='radio"+survey[count].getComponentNum()+"' value='radio' placeholder='helo'></label></div>";
					// 라디오 버튼 나눌 때는 이름으로 해서 같은 이름일 경우에는 다중 선택이 안된다.
					buf += "<div class='survey-item'> <label type='text' id='radio' name='radio' >"+survey[count].getContent()+"</label></div>";
					buf +="</div>";
				}else if(survey[count].getSurveyType().equals("checkbox")){
					buf += "<div class='survey-rows'>"; 
					buf += "<div class='survey-item'><label><input type='checkbox' name='checkbox"+survey[count].getComponentNum()+"' value='checkbox' placeholder='helo'></label></div>";
					buf += "<div class='survey-item'> <label id='checkbox' name='checkbox' >"+survey[count].getContent() +"</label></div>";
					buf +="</div>";
				}else if(survey[count].getSurveyType().equals("text")){
					buf += "<div class='survey-rows-text'>"; 
					buf += "<textarea name='text'" + survey[count].getComponentNum()+ " class='form-control' maxlength='2048' style='height:100pxpx;'></textarea>";
					buf +="</div>";
				}
				count++;			
			}
			
			buf += "</div>";
			result = result + start + buf;
		}
		
		return result;
	}
	
	
}
