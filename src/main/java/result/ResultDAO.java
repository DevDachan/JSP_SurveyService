package result;

import java.util.ArrayList;

import javax.servlet.ServletContext;

import util.DatabaseUtil;


public class ResultDAO extends DatabaseUtil {
	
	public ResultDAO(ServletContext application) {
		super(application);
	}
	
	public int setResult(int surveyID, int optionNum,int componentNum ,String content) {
		try {
			String countQuery = "SELECT COUNT(*) FROM survey_result WHERE survey_id=? AND option_num = ? AND component_num = ?";
			psmt = con.prepareStatement(countQuery);
			psmt.setInt(1, surveyID);
			psmt.setInt(2, optionNum);
			psmt.setInt(3, componentNum);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getInt(1) != 0) {
					String query ="UPDATE survey_result SET content = ? WHERE survey_id=? AND option_num = ? AND component_num = ?";
					psmt = con.prepareStatement(query);
					psmt.setString(1, content);
					psmt.setInt(2, surveyID);
					psmt.setInt(3, optionNum);
					psmt.setInt(4, componentNum);
					int result = psmt.executeUpdate();
					return result;
				}
				else{
					String query ="INSERT INTO survey_result VALUES(?,?,?,?,?)";
					psmt = con.prepareStatement(query);
					psmt.setInt(1, surveyID);
					psmt.setInt(2, optionNum);
					psmt.setInt(3, componentNum);
					psmt.setString(4, content);
					int result = psmt.executeUpdate();
					return result;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return 0;
	}
	public ResultDTO[] getResult(int surveyID) {
		ResultDTO[] resultDTO = null;
		int count = 0;
		int optionNum = 0;
		try {
			
			String optionQuery = "SELECT result_option FROM survey WHERE id=?";
			psmt = con.prepareStatement(optionQuery);
			psmt.setInt(1, surveyID);
			rs = psmt.executeQuery();
			if(rs.next()) {
				optionNum = rs.getInt(1);
				
				if(optionNum !=0) {
					String countQuery = "SELECT COUNT(*) FROM survey_result WHERE survey_id=? AND option_num=?";
					psmt = con.prepareStatement(countQuery);
					psmt.setInt(1, surveyID);
					psmt.setInt(2, optionNum);
	
					rs = psmt.executeQuery();
					
					if(rs.next()) {
						count = rs.getInt(1);
						String query ="SELECT survey_id,option_num,component_num, content, result_content FROM (SELECT survey_id,option_num,component_num, content AS result_content FROM survey_result WHERE survey_id=? AND option_num=?) AS a LEFT JOIN survey_option USING(survey_id, option_num, component_num);";
						psmt = con.prepareStatement(query);
						psmt.setInt(1, surveyID);
						psmt.setInt(2, optionNum);
						rs = psmt.executeQuery();
						resultDTO = new ResultDTO[count];
	
						int step = 0;
						while(rs.next() && step<count) {
							resultDTO[step++] = new ResultDTO(rs.getInt(1),rs.getInt(2),rs.getInt(3),rs.getString(4),rs.getString(5));
						}
						return resultDTO;
					}
				}else {
					String query ="SELECT survey_id,option_num,component_num, content, result_content FROM (SELECT survey_id,option_num,component_num, content AS result_content FROM survey_result WHERE survey_id=? AND option_num=?) AS a LEFT JOIN survey_option USING(survey_id, option_num, component_num);";
					psmt = con.prepareStatement(query);
					psmt.setInt(1, surveyID);
					psmt.setInt(2, optionNum);
					rs = psmt.executeQuery();
					resultDTO = new ResultDTO[1];

					int step = 0;
					if(rs.next()) {
						resultDTO[step] = new ResultDTO(rs.getInt(1),rs.getInt(2),rs.getInt(3),rs.getString(4),rs.getString(5));
					}
					return resultDTO;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return resultDTO;
	}
	public int editContent(int surveyID, int optionNum, int componentNum, String content) {
		String query = "UPDATE survey_result SET content=? WHERE survey_id = ? AND option_num = ? AND component_num =? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, content);
			psmt.setInt(2, surveyID);
			psmt.setInt(3, optionNum);
			psmt.setInt(4, componentNum);
			psmt.executeUpdate();

			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public int changeResultOption(int surveyID, int optionNum) {
		String countQuery = "SELECT component_num FROM survey_option WHERE survey_id=? AND option_num=?";
		
		String checkQuery = "SELECT COUNT(*) FROM survey_result WHERE survey_id =? AND option_num=?";
		ArrayList<Integer> componentList = new ArrayList<>();
		try {
			psmt = con.prepareStatement(countQuery);
			psmt.setInt(1, surveyID);
			psmt.setInt(2, optionNum);
			rs = psmt.executeQuery();
			while(rs.next()) {
				componentList.add(rs.getInt(1));
			}
			
			psmt = con.prepareStatement(checkQuery);
			psmt.setInt(1, surveyID);
			psmt.setInt(2, optionNum);
			rs = psmt.executeQuery();
			
			if(rs.next()) {		
				if(rs.getInt(1) == 0) {
					for(int i = 0; i< componentList.size(); i++) {
						String insertQuery = "INSERT INTO survey_result VALUES(?,?,?,?)";
						psmt = con.prepareStatement(insertQuery);
						psmt.setInt(1, surveyID);
						psmt.setInt(2, optionNum);
						psmt.setInt(3, componentList.get(i));
						psmt.setString(4, "");
						
						psmt.executeUpdate();
					}
				}
			}
			
			String updateQuery = "UPDATE survey SET result_option=? WHERE id =?";
			psmt = con.prepareStatement(updateQuery);
			psmt.setInt(1, optionNum);
			psmt.setInt(2, surveyID);
			return psmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public String getDateTime(int surveyID,String userID, int historyID) {
		String query = "SELECT date FROM survey_history WHERE survey_id=? AND user_id=? AND history_index =?";
		
		try {
			
			psmt = con.prepareStatement(query);
			psmt.setInt(1,surveyID);
			psmt.setString(2,userID);
			psmt.setInt(3,historyID);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
		
	}
	public String userResultContent(int surveyID,String userID, String date) {
		int resultOption = 0;
		int selectComponent = 0;
		String resultOptionQuery = "SELECT result_option FROM survey WHERE id=?";
		String historyQuery = "SELECT option_num, component_num FROM survey_history WHERE survey_id= ? AND user_id=? AND date =?";
		String contentQuery = "SELECT content FROM survey_result WHERE survey_id= ? AND option_num =? AND component_num =?";
		
		try {
			
			psmt = con.prepareStatement(resultOptionQuery);
			psmt.setInt(1, surveyID);
			rs = psmt.executeQuery();			
			if(rs.next()) {
				resultOption = rs.getInt(1);
			}

			psmt = con.prepareStatement(historyQuery);
			psmt.setInt(1, surveyID);
			psmt.setString(2, userID);
			psmt.setString(3, date);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getInt(1) == resultOption) {
					selectComponent = rs.getInt(2);
					break;
				}
			}
			
			psmt = con.prepareStatement(contentQuery);
			psmt.setInt(1, surveyID);
			psmt.setInt(2, resultOption);
			psmt.setInt(3, selectComponent);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	public String getSelectComponent(int surveyID,String userID,String date,int optionNum) {
		
		String historyQuery = "SELECT content FROM survey_history WHERE survey_id= ? AND user_id=? AND date =? AND option_num=?";
		try {
			psmt = con.prepareStatement(historyQuery);
			psmt.setInt(1, surveyID);
			psmt.setString(2, userID);
			psmt.setString(3, date);
			psmt.setInt(4, optionNum);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
			
		}catch(Exception e ) {
			e.printStackTrace();
		}
		return "";
	}
	public String[] getSelectComponentCheckbox(int surveyID,String userID,String date,int optionNum) {
		String[] content = null;
		String historyQuery = "SELECT content FROM survey_history WHERE survey_id= ? AND user_id=? AND date =? AND option_num=?";
		String countQuery = "SELECT COUNT(*) FROM survey_history WHERE survey_id= ? AND user_id=? AND date =? AND option_num=?";
		
		try {
			int count = 0;
			psmt = con.prepareStatement(countQuery);
			psmt.setInt(1, surveyID);
			psmt.setString(2, userID);
			psmt.setString(3, date);
			psmt.setInt(4, optionNum);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			psmt = con.prepareStatement(historyQuery);
			psmt.setInt(1, surveyID);
			psmt.setString(2, userID);
			psmt.setString(3, date);
			psmt.setInt(4, optionNum);
			rs = psmt.executeQuery();
			content = new String[count];
			int i = 0;
			
			while(rs.next()) {
				content[i++] = rs.getString(1);
			}
			return content;
		}catch(Exception e ) {
			e.printStackTrace();
		}
		return content;
	}

}




