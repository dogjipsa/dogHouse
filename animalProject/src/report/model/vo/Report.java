package report.model.vo;

import java.io.Serializable;

public class Report implements Serializable{
	private static final long serialVersionUID = -2141244057348904471L;
	private int reportNo;
	private String reportContent;
	private String reportCategory;
	private int boardNo;
	private String userId;
	
	public Report() {
		// TODO Auto-generated constructor stub
	}

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
		return reportNo + ", " + reportContent + ", " + reportCategory + ", " + boardNo + ", " + userId;
	}
	
	
}
