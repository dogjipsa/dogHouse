package notice.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import freeboard.model.vo.FreeBoard;

import static common.JDBCTemplate.*;

import notice.model.vo.Notice;

public class NoticeDao {
	public NoticeDao() {}
	
	public int insertNotice(Connection conn, Notice notice) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "insert into notice values((select max(notice_no) + 1 from notice), ?, ?, sysdate, ?, 0, ?, 'N', ?)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeContent());
			pstmt.setString(3, notice.getNoticeOriginFile());	
			pstmt.setString(4, notice.getManagerId());
			pstmt.setString(5, notice.getNoticeReFile());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public Notice selectOne(Connection conn, int noticeNo) {
		Notice notice = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice where notice_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				notice = new Notice();
				
				notice.setNoticeNo(noticeNo);
				notice.setNoticeTitle(rset.getString("notice_title"));
				notice.setNoticeDate(rset.getDate("notice_date"));
				notice.setManagerId(rset.getString("manager_id"));
				notice.setNoticeContent(rset.getString("notice_content"));
				notice.setNoticeOriginFile(rset.getString("notice_originfile"));
				notice.setNoticeReFile(rset.getString("notice_refile"));
			}
			System.out.println(notice.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return notice;
	}

	public int deleteNotice(Connection conn, int noticeNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "delete from notice where notice_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			result = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public int addReadCount(Connection conn, int noticeNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update notice set notice_views = notice_views + 1 where notice_no =?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateNotice(Connection conn, Notice notice) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update notice set notice_title = ?, notice_content =?, notice_originfile = ?, notice_Refile = ? where notice_no = ?"; 
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeContent());
			pstmt.setString(3, notice.getNoticeOriginFile());	
			pstmt.setString(4, notice.getNoticeReFile());
			pstmt.setInt(5, notice.getNoticeNo());
			
			System.out.println(notice);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn);
			close(pstmt);
		}
		
		return result;
	}
	
	public ArrayList<Notice> selectSearch(Connection conn, HashMap<String, Object> listOpt) {
		
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String opt = (String)listOpt.get("opt");//검색 옵션 
		String search = (String)listOpt.get("search");//검색내용
		String query = null;
		int startRow = (Integer)listOpt.get("startRow");
		
		try {
			if(opt == null) {
				query = "SELECT * " + 
						"FROM (SELECT ROWNUM RNUM, NOTICE_NO, " + 
						"NOTICE_TITLE, NOTICE_CONTENT, " + 
						"NOTICE_DATE, " + 
						"NOTICE_ORIGINFILE, NOTICE_VIEWS, " + 
						"MANAGER_ID, " + 
						"NOTICE_DELETE, NOTICE_REFILE " + 
						"FROM (SELECT * FROM NOTICE WHERE NOTICE_DELETE IN('n', 'N', null) " +
						"ORDER BY NOTICE_NO DESC)) " +  
						"WHERE RNUM >= ? AND RNUM <= ?";
				
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, startRow+9);
				
			}else if(opt.equals("0")) {//제목 검색
				query = "SELECT * " + 
						"FROM (SELECT ROWNUM RNUM, NOTICE_NO, " + 
						"NOTICE_TITLE, NOTICE_CONTENT, " + 
						"NOTICE_DATE, " + 
						"NOTICE_ORIGINFILE, NOTICE_VIEWS, " + 
						"MANAGER_ID, " + 
						"NOTICE_DELETE, NOTICE_REFILE " + 
						"FROM (SELECT * FROM NOTICE WHERE NOTICE_TITLE LIKE ? AND NOTICE_DELETE IN('n', 'N', null) " +
						"ORDER BY NOTICE_NO DESC)) " +  
						"WHERE RNUM >= ? AND RNUM <= ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
				
			}else if(opt.equals("1")){// 제목 + 내용 검색
				query = "SELECT * " + 
						"FROM (SELECT ROWNUM RNUM, NOTICE_NO, " + 
						"NOTICE_TITLE, NOTICE_CONTENT, " + 
						"NOTICE_DATE, " + 
						"NOTICE_ORIGINFILE, NOTICE_VIEWS, " + 
						"MANAGER_ID, " + 
						"NOTICE_DELETE, NOTICE_REFILE " + 
						"FROM (SELECT * FROM NOTICE WHERE NOTICE_TITLE LIKE ? OR NOTICE_CONTENT LIKE ? AND NOTICE_DELETE IN('n', 'N', null) " +
						"ORDER BY NOTICE_NO DESC)) " +  
						"WHERE RNUM >= ? AND RNUM <= ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setString(2, "%" + search + "%");
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, startRow+9);
				
			}
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Notice notice = new Notice();
				//번호제목이름조회수날짜첨부파일
				notice.setNoticeNo(rset.getInt("notice_no"));
				notice.setNoticeTitle(rset.getString("notice_title"));
				notice.setNoticeContent(rset.getString("notice_content"));
				notice.setManagerId(rset.getString("manager_id"));
				notice.setNoticeViews(rset.getInt("notice_views"));
				notice.setNoticeDate(rset.getDate("notice_date"));
				notice.setNoticeOriginFile(rset.getString("notice_originfile"));
				notice.setNoticeReFile(rset.getString("notice_refile"));
				
				list.add(notice);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	
	public int getListCount(Connection conn, HashMap<String, Object> listOpt) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String opt = (String)listOpt.get("opt");
		String inputdata = (String)listOpt.get("inputdata");
		int listCount = 1;
		
		if(opt == null) {
		
		String query = "select count(*) from notice";
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		}else if(opt.equals("0")) {
			
			String query = "select count(*) from notice where notice_title like ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					listCount = rset.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			
		}else if(opt.equals("1")) {
			
			String query = "select count(*) from notice where notice_content like ? or notice_title like ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setString(2, "%" + inputdata + "%");
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					listCount = rset.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}		
		
	}
	return listCount;
}
}
