package survey;

public class OptionDetailDTO {
	private int surveyID;
	private int optionNum;
	private String optionTitle;
	private String optionContent;
	private String type;
	
	public OptionDetailDTO() {
	}
	
	
	
	

	public OptionDetailDTO(int surveyID, int optionNum, String optionTitle, String optionContent, String type) {
		super();
		this.surveyID = surveyID;
		this.optionNum = optionNum;
		this.optionTitle = optionTitle;
		this.optionContent = optionContent;
		this.type = type;
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

	public String getOptionTitle() {
		return optionTitle;
	}

	public void setOptionTitle(String optionTitle) {
		this.optionTitle = optionTitle;
	}

	public String getOptionContent() {
		return optionContent;
	}

	public void setOptionContent(String optionContent) {
		this.optionContent = optionContent;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
	
	
	
}
