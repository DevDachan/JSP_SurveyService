package history;

public class HistoryListDTO {
	private int surveyID;
	private String surveyName;
	private String surveyDate;
	private String userID;
	private int historyID;
	private int editState;
	
	public HistoryListDTO() {
		
	}

	public HistoryListDTO(int surveyID, String surveyName, String surveyDate, String userID, int historyID,
			int editState) {
		super();
		this.surveyID = surveyID;
		this.surveyName = surveyName;
		this.surveyDate = surveyDate;
		this.userID = userID;
		this.historyID = historyID;
		this.editState = editState;
	}

	public int getSurveyID() {
		return surveyID;
	}

	public void setSurveyID(int surveyID) {
		this.surveyID = surveyID;
	}

	public String getSurveyName() {
		return surveyName;
	}

	public void setSurveyName(String surveyName) {
		this.surveyName = surveyName;
	}

	public String getSurveyDate() {
		return surveyDate;
	}

	public void setSurveyDate(String surveyDate) {
		this.surveyDate = surveyDate;
	}

	
	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public int getHistoryID() {
		return historyID;
	}

	public void setHistoryID(int historyID) {
		this.historyID = historyID;
	}

	public int getEditState() {
		return editState;
	}

	public void setEditState(int editState) {
		this.editState = editState;
	}



	
		
	
	

	
}
