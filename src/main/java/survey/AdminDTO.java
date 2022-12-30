package survey;

public class AdminDTO {
	private String surveyID;
	private String surveyName;
	private String surveyContent;
	public AdminDTO() {
		
	}
	
	
	public AdminDTO(String surveyID, String surveyName, String surveyContent) {
		super();
		this.surveyID = surveyID;
		this.surveyName = surveyName;
		this.surveyContent = surveyContent;
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
	public String getSurveyContent() {
		return surveyContent;
	}
	public void setSurveyContent(String surveyContent) {
		this.surveyContent = surveyContent;
	}
	
	
	

	
}
