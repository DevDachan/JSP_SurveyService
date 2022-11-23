package user;

public class UserDTO {
	private String userID;
	private String userPassword;
	
	
	public UserDTO(String userID, String userPassword) {
		super();
		this.userID = userID;
		this.userPassword = userPassword;
	}
	public UserDTO() {
		
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	
}
