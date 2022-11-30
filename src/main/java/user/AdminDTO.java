package user;

public class AdminDTO {
	private String surveyID;
	private String surveyName;
	
	public AdminDTO() {
		
	}
	
	public AdminDTO(String surveyID, String surveyName) {
		super();
		this.surveyID = surveyID;
		this.surveyName = surveyName;
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
	
	
	

	
}
