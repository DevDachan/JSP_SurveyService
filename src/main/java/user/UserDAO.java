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
			rs.next();
			if(rs.getString(1) != null) {
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
			rs.next();
			if(rs.getString(1).equals(code)) {
				return 1;
			}else {
				return 0;
			}	
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
	}
	public int registerUser(String userID, String userPWD, String userEmail) {
		String query_select = "SELECT * FROM user WHERE id=?";
		int dup_check = 0;
		try {
			psmt = con.prepareStatement(query_select);
			psmt.setString(1, userID);
			
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getString(1) != null) {
				dup_check = 1;
			}else {
				dup_check = 0;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(dup_check == 0) {
			String query = "INSERT INTO user VALUES(?,?,?)";
			
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, userID);
				psmt.setString(2, userPWD);
				psmt.setString(3, userEmail);
				
				int result = psmt.executeUpdate();
				
				return result;
			}catch(Exception e){
				e.printStackTrace();
			}
		}else {
			return 2;
		}
		
		
		return 0;
	}
	
}
