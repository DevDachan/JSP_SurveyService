package history;

public class HistoryCountDTO {
	private int componentNum;
	private int count;
	private String componentContent;
	
	public HistoryCountDTO() {
		
	}

	public HistoryCountDTO(int componentNum, int count, String componentContent) {
		super();
		this.componentNum = componentNum;
		this.count = count;
		this.componentContent = componentContent;
	}

	public int getComponentNum() {
		return componentNum;
	}

	public void setComponentNum(int componentNum) {
		this.componentNum = componentNum;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getComponentContent() {
		return componentContent;
	}

	public void setComponentContent(String componentContent) {
		this.componentContent = componentContent;
	}
	
	

	
}
