package board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Board implements Serializable {

	private static final long serialVersionUID = 20190307L;
	
	private int boardNum;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private String boardOriginalFilename;
	private String boardRenameFilename;
	private int boardRef;			//참조하는 원글번호, 원글일 때는 자기댓글번호
	private int boardReplyRef;	//참조하는 댓글번호, 원글일때는 
	private int boardReplyLev;	//원글 0, 원글의 댓글 1, 댓글의
	private int boardReplySeq;	//댓글의 순번
	private int boardReadcount;
	private Date boardDate;
	
	public Board() {}

	public Board(int boardNum, String boardWriter, String boardTitle, String boardContent, String boardOriginalFilename,
			String boardRenameFilename, int boardRef, int boardReplyRef, int boardReplyLev, int boardReplySeq,
			int boardReadcount, Date boardDate) {
		super();
		this.boardNum = boardNum;
		this.boardWriter = boardWriter;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardOriginalFilename = boardOriginalFilename;
		this.boardRenameFilename = boardRenameFilename;
		this.boardRef = boardRef;
		this.boardReplyRef = boardReplyRef;
		this.boardReplyLev = boardReplyLev;
		this.boardReplySeq = boardReplySeq;
		this.boardReadcount = boardReadcount;
		this.boardDate = boardDate;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public String getBoardWriter() {
		return boardWriter;
	}

	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getBoardOriginalFilename() {
		return boardOriginalFilename;
	}

	public void setBoardOriginalFilename(String boardOriginalFilename) {
		this.boardOriginalFilename = boardOriginalFilename;
	}

	public String getBoardRenameFilename() {
		return boardRenameFilename;
	}

	public void setBoardRenameFilename(String boardRenameFilename) {
		this.boardRenameFilename = boardRenameFilename;
	}

	public int getBoardRef() {
		return boardRef;
	}

	public void setBoardRef(int boardRef) {
		this.boardRef = boardRef;
	}

	public int getBoardReplyRef() {
		return boardReplyRef;
	}

	public void setBoardReplyRef(int boardReplyRef) {
		this.boardReplyRef = boardReplyRef;
	}

	public int getBoardReplyLev() {
		return boardReplyLev;
	}

	public void setBoardReplyLev(int boardReplyLev) {
		this.boardReplyLev = boardReplyLev;
	}

	public int getBoardReplySeq() {
		return boardReplySeq;
	}

	public void setBoardReplySeq(int boardReplySeq) {
		this.boardReplySeq = boardReplySeq;
	}

	public int getBoardReadcount() {
		return boardReadcount;
	}

	public void setBoardReadcount(int boardReadcount) {
		this.boardReadcount = boardReadcount;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Board [boardNum=" + boardNum + ", boardWriter=" + boardWriter + ", boardTitle=" + boardTitle
				+ ", boardContent=" + boardContent + ", boardOriginalFilename=" + boardOriginalFilename
				+ ", boardRenameFilename=" + boardRenameFilename + ", boardRef=" + boardRef + ", boardReplyRef="
				+ boardReplyRef + ", boardReplyLev=" + boardReplyLev + ", boardReplySeq=" + boardReplySeq
				+ ", boardReadcount=" + boardReadcount + ", boardDate=" + boardDate + "]";
	}
	
	
	
	

}
