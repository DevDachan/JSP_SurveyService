package result;

public class ResultDTO {
	private int surveyID;
	private int optionNum;
	private int componentNum;
	private String componentContent;
	private String resultContent;
	public ResultDTO() {
		
	}
	
	
	
	
	public ResultDTO(int surveyID, int optionNum, int componentNum, String componentContent, String resultContent) {
		super();
		this.surveyID = surveyID;
		this.optionNum = optionNum;
		this.componentNum = componentNum;
		this.componentContent = componentContent;
		this.resultContent = resultContent;
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
	public String getComponentContent() {
		return componentContent;
	}
	public void setComponentContent(String componentContent) {
		this.componentContent = componentContent;
	}
	public String getResultContent() {
		return resultContent;
	}
	public void setResultContent(String resultContent) {
		this.resultContent = resultContent;
	}
	
	
	


	
}
