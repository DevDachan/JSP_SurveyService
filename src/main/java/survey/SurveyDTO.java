package survey;

public class SurveyDTO {
	
	private int surveyId;
	private String surveyName;
	private String adminId;
	private String surveyContent;
	
	public SurveyDTO() {
	}
	
	
	public SurveyDTO(int surveyId, String surveyName, String adminId, String surveyContent) {
		super();
		this.surveyId = surveyId;
		this.surveyName = surveyName;
		this.adminId = adminId;
		this.surveyContent = surveyContent;
	}
	public int getSurveyId() {
		return surveyId;
	}
	public void setSurveyId(int surveyId) {
		this.surveyId = surveyId;
	}
	public String getSurveyName() {
		return surveyName;
	}
	public void setSurveyName(String surveyName) {
		this.surveyName = surveyName;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getSurveyContent() {
		return surveyContent;
	}
	public void setSurveyContent(String surveyContent) {
		this.surveyContent = surveyContent;
	}
	
	
	
}
