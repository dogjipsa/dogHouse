package member.model.vo;

import java.sql.Date;

public class Member {

	public Member() {}
	
	private int freeBoardNo;
	private String freeBoardTitle;
	private String freeBoardContent;
	private Date freeBoardDate;
	private String freeBoardFile;
	private int freeBoardViews;
	private int freeBoardRecommend;
	private String userId;
	private String freeBoardDeleteYN;
	public int getFreeBoardNo() {
		return freeBoardNo;
	}
	

	public Member(int freeBoardNo, String freeBoardTitle, String freeBoardContent, Date freeBoardDate,
			String freeBoardFile, int freeBoardViews, int freeBoardRecommend, String userId, String freeBoardDeleteYN) {
		super();
		this.freeBoardNo = freeBoardNo;
		this.freeBoardTitle = freeBoardTitle;
		this.freeBoardContent = freeBoardContent;
		this.freeBoardDate = freeBoardDate;
		this.freeBoardFile = freeBoardFile;
		this.freeBoardViews = freeBoardViews;
		this.freeBoardRecommend = freeBoardRecommend;
		this.userId = userId;
		this.freeBoardDeleteYN = freeBoardDeleteYN;
	}

	public void setFreeBoardNo(int freeBoardNo) {
		this.freeBoardNo = freeBoardNo;
	}
	public String getFreeBoardTitle() {
		return freeBoardTitle;
	}
	public void setFreeBoardTitle(String freeBoardTitle) {
		this.freeBoardTitle = freeBoardTitle;
	}
	public String getFreeBoardContent() {
		return freeBoardContent;
	}
	public void setFreeBoardContent(String freeBoardContent) {
		this.freeBoardContent = freeBoardContent;
	}
	public Date getFreeBoardDate() {
		return freeBoardDate;
	}
	public void setFreeBoardDate(Date freeBoardDate) {
		this.freeBoardDate = freeBoardDate;
	}
	public String getFreeBoardFile() {
		return freeBoardFile;
	}
	public void setFreeBoardFile(String freeBoardFile) {
		this.freeBoardFile = freeBoardFile;
	}
	public int getFreeBoardViews() {
		return freeBoardViews;
	}
	public void setFreeBoardViews(int freeBoardViews) {
		this.freeBoardViews = freeBoardViews;
	}
	public int getFreeBoardRecommend() {
		return freeBoardRecommend;
	}
	public void setFreeBoardRecommend(int freeBoardRecommend) {
		this.freeBoardRecommend = freeBoardRecommend;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFreeBoardDeleteYN() {
		return freeBoardDeleteYN;
	}
	public void setFreeBoardDeleteYN(String freeBoardDeleteYN) {
		this.freeBoardDeleteYN = freeBoardDeleteYN;
	}


	@Override
	public String toString() {
		return "Member [freeBoardNo=" + freeBoardNo + ", freeBoardTitle=" + freeBoardTitle + ", freeBoardContent="
				+ freeBoardContent + ", freeBoardDate=" + freeBoardDate + ", freeBoardFile=" + freeBoardFile
				+ ", freeBoardViews=" + freeBoardViews + ", freeBoardRecommend=" + freeBoardRecommend + ", userId="
				+ userId + ", freeBoardDeleteYN=" + freeBoardDeleteYN + "]";
	}

	

}

