package question.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Question implements Serializable {
	private static final long serialVersionUID = -4625653056618896760L;
	
	private int inquireNo;
	private String inquireTitle;
	private String inquireContent;
	private Date inquireDate;
	private String replyYn;
	private String userId;
	
	public Question () {}

	public Question(int inquireNo, String inquireTitle, String inquireContent, Date inquireDate,
			String replyYn, String userId) {
		super();
		this.inquireNo = inquireNo;
		this.inquireTitle = inquireTitle;
		this.inquireContent = inquireContent;
		this.inquireDate = inquireDate;
		this.replyYn = replyYn;
		this.userId = userId;
	}

	public int getInquireNo() {
		return inquireNo;
	}

	public void setInquireNo(int inquireNo) {
		this.inquireNo = inquireNo;
	}

	public String getInquireTitle() {
		return inquireTitle;
	}

	public void setInquireTitle(String inquireTitle) {
		this.inquireTitle = inquireTitle;
	}

	public String getInquireContent() {
		return inquireContent;
	}

	public void setInquireContent(String inquireContent) {
		this.inquireContent = inquireContent;
	}

	public Date getInquireDate() {
		return inquireDate;
	}

	public void setInquireDate(Date inquireDate) {
		this.inquireDate = inquireDate;
	}

	public String getReplyYn() {
		return replyYn;
	}

	public void setReplyYn(String replyYn) {
		this.replyYn = replyYn;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Override
	public String toString () {
		return
				this.inquireNo + ", " + this.inquireTitle + ", " + this.inquireContent + ", " + this.inquireDate + ", "
			  + this.replyYn + ", " + this.userId;
	}

}
