package history;

import javax.servlet.ServletContext;

import util.DatabaseUtil;

public class HistoryDAO extends DatabaseUtil{
	public HistoryDAO(ServletContext application) {
		super(application);
	}

	public int getPrvhistory(int sid, String uid) {
		String query = "SELECT * FROM survey_history WHERE survey_id=? AND user_id=?";
		int result = 0;
		try{
			psmt = con.prepareStatement(query);
			psmt.setInt(1, sid);
			psmt.setString(2, uid);	
			rs = psmt.executeQuery();
			if(rs.next()) {
				result =  1;
			}
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public int getHistoryNum(int sid) {
		String query = "SELECT MAX(history_index) FROM survey_history WHERE survey_id=?";
		
		try{
			psmt = con.prepareStatement(query);
			psmt.setInt(1, sid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int addHistory(int sid,String userID,int history_index,int option_num,int component_num,String content,String date){
		String query = "INSERT INTO survey_history VALUES(?,?,?,?,?,?,?)";
		try{
			psmt = con.prepareStatement(query);
			psmt.setInt(1, sid);
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
	
	public int deletePrvHistory(String uid, int sid, int hid) {
		
		try {
			String query = "SELECT DISTINCT user_id FROM survey_history WHERE survey_id = ? AND history_index = ?";
			psmt = con.prepareStatement(query);
			psmt.setInt(1, sid);
			psmt.setInt(2, hid);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(uid)) {
					query = "DELETE FROM survey_history WHERE survey_id = ? AND history_index = ?";
					psmt = con.prepareStatement(query);
					psmt.setInt(1, sid);
					psmt.setInt(2, hid);
					int result = psmt.executeUpdate();
					return result;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	public HistoryDTO[] getHistory(String uid, int sid,int hid) {
		HistoryDTO[] historyDTO = null;
		int history_len = 0;
		try {
			String query = "SELECT COUNT(*) FROM survey_history WHERE user_id=? AND survey_id=? AND history_index =? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setInt(2, sid);
			psmt.setInt(3, hid);
	
			rs = psmt.executeQuery();
			if(rs.next()) {
				history_len = rs.getInt(1);
			}
	
			historyDTO = new HistoryDTO[history_len];
			query = "SELECT option_num,component_num,content FROM survey_history WHERE user_id=? AND survey_id=? AND history_index =? ORDER BY option_num,component_num ASC";
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setInt(2, sid);
			psmt.setInt(3, hid);
					
			
			rs = psmt.executeQuery();
			int i = 0;
			while(rs.next() && i<history_len) {
				historyDTO[i++] = new HistoryDTO(rs.getInt(1),rs.getInt(2),rs.getString(3));
				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}

		return historyDTO;
	}
	
	public HistoryListDTO[] getHistoryList(String userID) {
		HistoryListDTO[] historyDTO = null;
		int history_len = 0;
		try {
			String query = "SELECT COUNT(distinct survey_id, history_index) FROM survey_history WHERE user_id=? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, userID);
			rs = psmt.executeQuery();
			if(rs.next()) {
				history_len = rs.getInt(1);
			}
			              
			historyDTO = new HistoryListDTO[history_len];
			query = "SELECT DISTINCT history_index, survey_id, name , date, edit_state FROM survey_history JOIN survey ON(survey_id = id) WHERE user_id =? ORDER BY date,option_num,component_num ";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, userID);
				
			rs = psmt.executeQuery();
			int i = 0;
			while(rs.next() && i<history_len) {
				historyDTO[i++] = new HistoryListDTO(rs.getString(2),rs.getString(3),rs.getString(4),rs.getInt(1),rs.getInt(5));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return historyDTO;
	}
	
	public int deleteHistory(String userID, int sid, int hid) {
		try {
			String query = "SELECT DISTINCT user_id FROM survey_history WHERE survey_id =? AND history_index =?";
			psmt = con.prepareStatement(query);
			psmt.setInt(1, sid);
			psmt.setInt(2, hid);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userID)) {
					query = "DELETE FROM survey_history WHERE survey_id =? AND history_index =?";
					psmt = con.prepareStatement(query);
					psmt.setInt(1, sid);
					psmt.setInt(2, hid);
					int result = psmt.executeUpdate();
					if(result > 0) {
						return 1;
					}
				}else {
					return 0;
				}
			} 
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public HistoryCountDTO[] getHistoryCount(int sid, int optionNum) {
		HistoryCountDTO[] history = null;	// history[][0] == componentNum     history[][1] == countHistory
		int component_len = 0;
		int i = 0;
		try {
			String countQuery = "SELECT COUNT(component_num) FROM survey_option WHERE survey_id =? AND option_num =?";
			psmt = con.prepareStatement(countQuery);
			psmt.setInt(1, sid);
			psmt.setInt(2, optionNum);
			
			rs = psmt.executeQuery(); 
			if(rs.next()) {
				component_len = rs.getInt(1);
			}
			if(component_len != 0) {
				String selectQuery = "SELECT component_num,content FROM survey_option WHERE survey_id =? AND option_num =?";
				psmt = con.prepareStatement(selectQuery);
				psmt.setInt(1, sid);
				psmt.setInt(2, optionNum);
				
				rs = psmt.executeQuery(); 
				history = new HistoryCountDTO[component_len];
				while(rs.next() && i <component_len) {
					history[i++] = new HistoryCountDTO(rs.getInt(1),0,rs.getString(2));

				}			
				String optionQuery = "SELECT component_num,COUNT(*) FROM survey_history WHERE survey_id = ? AND option_num = ? GROUP BY component_num;";
				psmt = con.prepareStatement(optionQuery);
				psmt.setInt(1, sid);
				psmt.setInt(2, optionNum);
				
				rs = psmt.executeQuery(); 
				i = 0;
				while(rs.next()) {
					for(int k = 0; k< history.length; k++) {
						if(rs.getInt(1) == history[k].getComponentNum()) {
							history[k].setCount(rs.getInt(2));
							break;
						}
					}
				}
			}
			
						
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return history;
	}
	public String[] getHistoryText(int sid, int optionNum) {
		String[] history = null;
		int text_len = 0;
		int i = 0;
		
		try {
			String countQuery = "SELECT COUNT(*) FROM survey_history WHERE survey_id =? AND option_num =?";
			psmt = con.prepareStatement(countQuery);
			psmt.setInt(1, sid);
			psmt.setInt(2, optionNum);
			
			rs = psmt.executeQuery(); 
			if(rs.next()) {
				text_len = rs.getInt(1);
			}
			if(text_len !=0) {
				String componentQuery = "SELECT content FROM survey_history WHERE survey_id =? AND option_num =?";
				psmt = con.prepareStatement(componentQuery);
				psmt.setInt(1, sid);
				psmt.setInt(2, optionNum);
				
				rs = psmt.executeQuery(); 
				history = new String[text_len];
				while(rs.next() && i < text_len) {
					history[i++] = rs.getString(1);		
				}
				
			}			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return history;
	}
	
}
