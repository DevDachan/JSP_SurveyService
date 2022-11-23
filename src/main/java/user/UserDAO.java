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
	
	
	
	
	
}
