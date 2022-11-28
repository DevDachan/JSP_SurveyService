package survey;

public class SurveyDTO {
	private String surveyID;
	private String surveyType;
	private int optionNum;
	private int componentNum;
	private String content;
	private String surveyName;
	
	
	public SurveyDTO(String surveyID, String surveyType, int optionNum, int componentNum, String content,
			String surveyName) {
		super();
		this.surveyID = surveyID;
		this.surveyType = surveyType;
		this.optionNum = optionNum;
		this.componentNum = componentNum;
		this.content = content;
		this.surveyName = surveyName;
	}
	public SurveyDTO() {
		
	}
	public String getSurveyID() {
		return surveyID;
	}
	public void setSurveyID(String surveyID) {
		this.surveyID = surveyID;
	}
	public String getSurveyType() {
		return surveyType;
	}
	public void setSurveyType(String surveyType) {
		this.surveyType = surveyType;
	}
	public int getOptionNum() {
		return optionNum;
	}
	public void setOptionNum(int optionNum) {
		this.optionNum = optionNum;
	}
	public int getComponentNum() {
		return componentNum;
	}
	public void setComponentNum(int componentNum) {
		this.componentNum = componentNum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSurveyName() {
		return surveyName;
	}
	public void setSurveyName(String surveyName) {
		this.surveyName = surveyName;
	}
	

	
}
