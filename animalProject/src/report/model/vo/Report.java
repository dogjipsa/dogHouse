package report.model.vo;

public class Report {
	
	private int reportNo;
	private String reportContent;
	private String reportCategory;
	private int boardNo;
	private String userId;
	
	public Report() {}

	public Report(int reportNo, String reportContent, String reportCategory, int boardNo, String userId) {
		super();
		this.reportNo = reportNo;
		this.reportContent = reportContent;
		this.reportCategory = reportCategory;
		this.boardNo = boardNo;
		this.userId = userId;
	}


	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public String getReportCategory() {
		return reportCategory;
	}

	public void setReportCategory(String reportCategory) {
		this.reportCategory = reportCategory;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", reportContent=" + reportContent + ", reportCategory="
				+ reportCategory + ", boardNo=" + boardNo + ", userId=" + userId + "]";
	}

	
}
