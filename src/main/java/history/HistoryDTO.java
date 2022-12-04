package history;

public class HistoryDTO {
	private int optionNum;
	private int componentNum;
	private String content;
	
	public HistoryDTO() {
		
	}
	
	public HistoryDTO(int optionNum, int componentNum, String content) {
		super();
		this.optionNum = optionNum;
		this.componentNum = componentNum;
		this.content = content;
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
