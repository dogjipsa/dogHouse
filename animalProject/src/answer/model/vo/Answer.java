package answer.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Answer implements Serializable {
	private static final long serialVersionUID = -11112222333L;
	
	private int answerNo;
	private String answerContent;
	private Date answerDate;
	
	public Answer() {}	
	
	public Answer(int answerNo, String answerContent, Date answerDate) {
		super();
		this.answerNo = answerNo;
		this.answerContent = answerContent;
		this.answerDate = answerDate;
	}	

	public int getAnswerNo() {
		return answerNo;
	}

	public void setAnswerNo(int answerNo) {
		this.answerNo = answerNo;
	}

	public String getAnswerContent() {
		return answerContent;
	}

	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}

	public Date getAnswerDate() {
		return answerDate;
	}

	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return this.answerNo + ", " + this.answerContent + ", " 
				+ this.answerDate;
	}
}

	