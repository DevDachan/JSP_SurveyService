package survey;

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
			
				String countQuery = "SELECT COUNT(*) FROM survey_result WHERE survey_id=? AND option_num=?";
				
				psmt = con.prepareStatement(countQuery);
				psmt.setInt(1, surveyID);
				psmt.setInt(2, optionNum);

				rs = psmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
					String query ="SELECT * FROM survey_result WHERE survey_id=? AND option_num=?";
					psmt = con.prepareStatement(query);
					psmt.setInt(1, surveyID);
					psmt.setInt(2, optionNum);
					rs = psmt.executeQuery();
					resultDTO = new ResultDTO[count];

					int step = 0;
					while(rs.next() && step<count) {
						resultDTO[step++] = new ResultDTO(rs.getInt(1),rs.getInt(2),rs.getInt(3),rs.getString(4));
					}
					return resultDTO;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return resultDTO;
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
						psmt.setString(4, "empty");
						
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
}




