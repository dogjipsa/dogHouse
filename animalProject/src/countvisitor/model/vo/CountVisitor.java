package countvisitor.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class CountVisitor implements Serializable{
	private static final long serialVersionUID = 1312563445893392400L;
	
	private int countVisitor;
	private Date visitDate;
	
	public CountVisitor() {}

	public CountVisitor(int countVisitor, Date visitDate) {
		super();
		this.countVisitor = countVisitor;
		this.visitDate = visitDate;
	}

	public int getCountVisitor() {
		return countVisitor;
	}

	public void setCountVisitor(int countVisitor) {
		this.countVisitor = countVisitor;
	}

	public Date getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(Date visitDate) {
		this.visitDate = visitDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String toString() {
		
		return this.countVisitor + ", " + this.visitDate;
	}
	
}
