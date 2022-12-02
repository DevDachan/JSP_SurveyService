package user;

public class HistoryListDTO {
	private String surveyID;
	private String surveyName;
	private String surveyDate;
	private int historyID;
	
	public HistoryListDTO() {
		
	}
	
	
	
	public HistoryListDTO(String surveyID, String surveyName, String surveyDate, int historyID) {
		super();
		this.surveyID = surveyID;
		this.surveyName = surveyName;
		this.surveyDate = surveyDate;
		this.historyID = historyID;
	}



	public int getHistoryID() {
		return historyID;
	}
	public void setHistoryID(int historyID) {
		this.historyID = historyID;
	}
	public String getSurveyID() {
		return surveyID;
	}
	public void setSurveyID(String surveyID) {
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
	
	
	
	
	
	

	
}
