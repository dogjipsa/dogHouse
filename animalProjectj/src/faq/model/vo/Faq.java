package faq.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Faq implements Serializable {
	private static final long serialVersionUID = -7616138761377886352L;
	
	private int faqNo;
	private String faqTitle;
	private String faqContent;
	private Date faqDate;
	private int faqViews;
	private String managerId;
	
	public Faq () {}

	public Faq(int faqNo, String faqTitle, String faqContent, Date faqDate, int faqViews, String managerId) {
		super();
		this.faqNo = faqNo;
		this.faqTitle = faqTitle;
		this.faqContent = faqContent;
		this.faqDate = faqDate;
		this.faqViews = faqViews;
		this.managerId = managerId;
	}

	public int getFaqNo() {
		return faqNo;
	}

	public void setFaqNo(int faqNo) {
		this.faqNo = faqNo;
	}

	public String getFaqTitle() {
		return faqTitle;
	}

	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}

	public String getFaqContent() {
		return faqContent;
	}

	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}

	public Date getFaqDate() {
		return faqDate;
	}

	public void setFaqDate(Date faqDate) {
		this.faqDate = faqDate;
	}

	public int getFaqViews() {
		return faqViews;
	}

	public void setFaqViews(int faqViews) {
		this.faqViews = faqViews;
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Override
	public String toString() {
		return this.faqNo + ", " + this.faqTitle + ", " + this.faqContent + ", " + this.faqDate + ", "
			 + this.faqViews + ", " + this.managerId;
	}

}
