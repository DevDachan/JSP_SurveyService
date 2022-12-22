package survey;

public class SurveyDTO {
	
	private int surveyId;
	private String surveyName;
	private String adminId;
	private String surveyContent;
	private int resultOption;
	private int limitState;
	private int editState;
	
	public SurveyDTO() {
	}

	
	public SurveyDTO(int surveyId, String surveyName, String adminId, String surveyContent, int resultOption,
			int limitState, int editState) {
		super();
		this.surveyId = surveyId;
		this.surveyName = surveyName;
		this.adminId = adminId;
		this.surveyContent = surveyContent;
		this.resultOption = resultOption;
		this.limitState = limitState;
		this.editState = editState;
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

	public int getResultOption() {
		return resultOption;
	}

	public void setResultOption(int resultOption) {
		this.resultOption = resultOption;
	}

	public int getLimitState() {
		return limitState;
	}

	public void setLimitState(int limitState) {
		this.limitState = limitState;
	}

	public int getEditState() {
		return editState;
	}

	public void setEditState(int editState) {
		this.editState = editState;
	}
	
}
