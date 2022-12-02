package user;

public class HistoryDTO {
	private String surveyID;
	private String surveyName;
	private String surveyDate;
	public HistoryDTO() {
		
	}
	
	
	
	public HistoryDTO(String surveyID, String surveyName, String surveyDate) {
		super();
		this.surveyID = surveyID;
		this.surveyName = surveyName;
		this.surveyDate = surveyDate;
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
