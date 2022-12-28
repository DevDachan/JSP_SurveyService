package user;

import javax.servlet.ServletContext;

import util.DatabaseUtil;

public class UserDAO extends DatabaseUtil {
	 
	public UserDAO(ServletContext application) {
		super(application);
	}

	public int getUserData(String uid, String pass) {
		String query = "SELECT * FROM user WHERE id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(2).equals(pass)){
					return 1;	// Succeed login
				}
				else {
					return 0;	// Password error
				}
			}
			return -1;	// ID error
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2 ;   //  DE error
	}
	
	public int setUserCode(String email, String code) {
		String query_select = "SELECT * FROM emailCode WHERE email=?";
		int dup_check = 0;
		try {
			psmt = con.prepareStatement(query_select);
			psmt.setString(1, email);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dup_check = 1;
			}else {
				dup_check = 0;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		if(dup_check == 1) {
			String query = "UPDATE emailCode SET code =? WHERE email=?";
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, code);
				psmt.setString(2, email);
				
				int result = psmt.executeUpdate();
				return result;	// ID error
			}catch(Exception e){
				e.printStackTrace();
			}
		}else {
			String query = "INSERT INTO emailCode VALUES(?,?)";
			
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, email);
				psmt.setString(2, code);
				
				int result = psmt.executeUpdate();
				return result;	// ID error
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return 0; 
	}
	
	public int checkUserCode(String email, String code) {
		String query = "SELECT code FROM emailCode WHERE email=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, email);
			rs = psmt.executeQuery();
			if(rs.next()){
				if(rs.getString(1).equals(code)) {
					return 1;
				}else {
					return 0;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
	}
	public int registerUser(String userID, String userPWD, String userEmail) {
		
		try {
			String idcheck = "SELECT id FROM user WHERE id=?";
			psmt = con.prepareStatement(idcheck);
			psmt.setString(1, userID);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
					return 2;
			}
			
			if(userEmail.equals("Not") == false) {
				String emailcheck = "SELECT id FROM user WHERE user_email=?";
				psmt = con.prepareStatement(emailcheck);
				psmt.setString(1, userEmail);
				
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					return 3;
				}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		String query = "INSERT INTO user VALUES(?,?,?)";
			
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, userID);
			psmt.setString(2, userPWD);
			psmt.setString(3, userEmail);
				
			int result = psmt.executeUpdate();
			if(result != 0) {
				return 1;
			}	
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
	
	
	public AdminDTO[] getAdminList(String userID) {
		AdminDTO[] adminDTO = null;
		int admin_len = 0;
		try {
			String query = "SELECT COUNT(*) FROM survey WHERE admin_id=? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, userID);
			rs = psmt.executeQuery();
			if(rs.next()) {
				admin_len = rs.getInt(1);
			}
			              
			adminDTO = new AdminDTO[admin_len];
			query = "SELECT * FROM survey WHERE admin_id=? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, userID);
				
			rs = psmt.executeQuery();
			int i = 0;
			while(rs.next() && i < admin_len) {
				adminDTO[i++] = new AdminDTO(rs.getString(1),rs.getString(2),rs.getString(3));
		
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return adminDTO;
		
	}
	public String getUserEmail(String userID) {
	String query = "SELECT user_email FROM user WHERE id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, userID);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "" ;   //  DE error
	}
	
	public int checkUserEmail(String email) {
		String query = "SELECT COUNT(*) FROM user WHERE user_email=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, email);
			rs = psmt.executeQuery();
			if(rs.next()){
				return rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 1;
	}
	public int checkUserID(String userID) {
		String query = "SELECT COUNT(*) FROM user WHERE id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, userID);
			rs = psmt.executeQuery();
			if(rs.next()){
				return rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 1;
	}
}
	



 