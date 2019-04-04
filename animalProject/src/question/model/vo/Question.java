package question.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Question implements Serializable {
	private static final long serialVersionUID = -4625653056618896760L;
	
	private int questionNo;
	private String questionTitle;
	private String questionContent;
	private Date questionDate;
	private String questionReplyYn;
	private String userId;
	private String questionOriginalFileName;
	private String questionRenameFileName;
	private int questionRef; 
	private int questionReplyRef;
	private int questionReplyLev; 
	private int questionReplySeq; 
	
	public Question () {}

	public Question(int questionNo, String questionTitle, String questionContent, Date questionDate,
			String questionReplyYn, String userId, String questionOriginalFileName, String questionRenameFileName,
			int questionRef, int questionReplyRef, int questionReplyLev, int questionReplySeq) {
		super();
		this.questionNo = questionNo;
		this.questionTitle = questionTitle;
		this.questionContent = questionContent;
		this.questionDate = questionDate;
		this.questionReplyYn = questionReplyYn;
		this.userId = userId;
		this.questionOriginalFileName = questionOriginalFileName;
		this.questionRenameFileName = questionRenameFileName;
		this.questionRef = questionRef;
		this.questionReplyRef = questionReplyRef;
		this.questionReplyLev = questionReplyLev;
		this.questionReplySeq = questionReplySeq;
	}

	public int getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}

	public String getQuestionTitle() {
		return questionTitle;
	}

	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public Date getQuestionDate() {
		return questionDate;
	}

	public void setQuestionDate(Date questionDate) {
		this.questionDate = questionDate;
	}

	public String getQuestionReplyYn() {
		return questionReplyYn;
	}

	public void setQuestionReplyYn(String questionReplyYn) {
		this.questionReplyYn = questionReplyYn;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getQuestionOriginalFileName() {
		return questionOriginalFileName;
	}
	
	public void setQuestionOriginalFileName(String questionOriginalFileName) {
		this.questionOriginalFileName = questionOriginalFileName;
	}
	
	public String getQuestionRenameFileName() {
		return questionRenameFileName;
	}
	
	public void setQuestionRenameFileName(String questionRenameFileName) {
		this.questionRenameFileName = questionRenameFileName;
	}
	
	public int getQuestionRef() {
		return questionRef;
	}

	public void setQuestionRef(int questionRef) {
		this.questionRef = questionRef;
	}

	public int getQuestionReplyRef() {
		return questionReplyRef;
	}

	public void setQuestionReplyRef(int questionReplyRef) {
		this.questionReplyRef = questionReplyRef;
	}

	public int getQuestionReplyLev() {
		return questionReplyLev;
	}

	public void setQuestionReplyLev(int questionReplyLev) {
		this.questionReplyLev = questionReplyLev;
	}

	public int getQuestionReplySeq() {
		return questionReplySeq;
	}

	public void setQuestionReplySeq(int questionReplySeq) {
		this.questionReplySeq = questionReplySeq;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return this.questionNo + ", " + this.questionTitle + ", " + this.questionContent + ", "
				+ this.questionDate + ", " + this.questionReplyYn + ", " + this.userId + ", "
				+ this.questionOriginalFileName + ", " + this.questionRenameFileName + this.questionRef + ", "
				+ this.questionReplyLev + ", " + this.questionReplyRef + ", " + this.questionReplySeq;
	}
}
