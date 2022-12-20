package survey;

public class ResultDTO {
	private int surveyID;
	private int optionNum;
	private int componentNum;
	private String content;
	
	public ResultDTO() {
		
	}
	
	public ResultDTO(int surveyID, int optionNum, int componentNum, String content) {
		super();
		this.surveyID = surveyID;
		this.optionNum = optionNum;
		this.componentNum = componentNum;
		this.content = content;
	}
	public int getSurveyID() {
		return surveyID;
	}
	public void setSurveyID(int surveyID) {
		this.surveyID = surveyID;
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
	


	
}
