package manager.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import faq.model.vo.Faq;
import freeboard.model.vo.FreeBoard;
import manager.model.vo.Manager;
import member.model.vo.Member;
import notice.model.vo.Notice;
import question.model.vo.Question;
import tipboard.model.vo.TipBoard;

public class ManagerDao {

	public ManagerDao() {
	}

	public Manager loginManager(Connection conn, String managerId, String managerPwd) {
		// 관리자 로그인 시 조회용
		Manager loginManager = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		String query = "select * from manager where manager_id = ? and manager_password = ?";

		try {
			pstat = conn.prepareStatement(query);
			pstat.setString(1, managerId);
			pstat.setString(2, managerPwd);
			rSet = pstat.executeQuery();

			if (rSet.next()) {
				loginManager = new Manager();
				loginManager.setManagerId(managerId);
				loginManager.setManagerName(rSet.getString("manager_name"));
				loginManager.setManagerPassword(managerPwd);
				System.out.println(loginManager + "<- loginManager Dao");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		return loginManager;
	}
	public boolean checkLogoutManager(Connection conn, String managerId) {
		boolean result = false;
		Manager loginManager = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		String query = "select * from manager where manager_id = ?";

		try {
			pstat = conn.prepareStatement(query);
			pstat.setString(1, managerId);
			rSet = pstat.executeQuery();

			if (rSet.next()) {
				loginManager = new Manager();
				loginManager.setManagerId(managerId);
				System.out.println(loginManager + "<- loginManager Dao");
			}
			if(loginManager != null) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		return result;
	}

	public ArrayList<FreeBoard> selectFreeBoardList(Connection conn, int currentPage, int pageList, String option, String word) {
		// 자유 게시판 목록 조회용
		ArrayList<FreeBoard> freeboardList = new ArrayList<>();
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		
		int startRow = (currentPage -1) * pageList + 1;
		int endRow = startRow + pageList - 1;

		StringBuffer query = new StringBuffer();
		try {
			if(option == null) {
				query.append( "select b.rnum, b.freeboard_no, b.user_id, b.freeboard_title, b.freeboard_content, b.freeboard_date, b.freeboard_delete ")
					 .append("from ( select rownum as rnum, a.freeboard_no, a.user_id, a.freeboard_title, a.freeboard_content, a.freeboard_date, a.freeboard_delete ")
					 .append("from ( select freeboard_no, user_id, freeboard_title, freeboard_content, freeboard_date, freeboard_delete ")
					 .append("from freeboard order by freeboard_date desc) a ").append("where rownum <= ?) b ")
					 .append("where b.rnum >= ?");
				
				pstat = conn.prepareStatement(query.toString());
				pstat.setInt(1, endRow);
				pstat.setInt(2, startRow);

				rSet = pstat.executeQuery();
				// 한 페이지당 10개까지만 출력되게

				while (rSet.next()) {
					FreeBoard freeBoard = new FreeBoard();
					freeBoard.setFreeboardTitle(rSet.getString("freeboard_title"));
					freeBoard.setUserId(rSet.getString("user_id"));
					freeBoard.setFreeboardNo(rSet.getInt("freeboard_no"));
					freeBoard.setFreeboardDelete(rSet.getString("freeboard_delete"));
					freeBoard.setFreeboardContent(rSet.getString("freeboard_content"));
					freeBoard.setFreeboardDate(rSet.getDate("freeboard_date"));

					freeboardList.add(freeBoard);
				}
			} else if(option.equals("delyorn")) {//1 if
				query.append(
						"select b.rnum, b.freeboard_no, b.user_id, b.freeboard_title, b.freeboard_content, b.freeboard_date, b.freeboard_delete ")
						.append("from ( select rownum as rnum, a.freeboard_no, a.user_id, a.freeboard_title, a.freeboard_content, a.freeboard_date, a.freeboard_delete ")
						.append("from ( select freeboard_no, user_id, freeboard_title, freeboard_content, freeboard_date, freeboard_delete ")
						.append("from freeboard where freeboard_delete like ? order by freeboard_date desc) a ").append("where rownum <= ?) b ")
						.append("where b.rnum >= ?");
				
				pstat = conn.prepareStatement(query.toString());
				pstat.setString(1, "%"+word+"%");
				pstat.setInt(2, endRow);
				pstat.setInt(3, startRow);

				rSet = pstat.executeQuery();
				// 한 페이지당 10개까지만 출력되게

				while (rSet.next()) {
					FreeBoard freeBoard = new FreeBoard();
					freeBoard.setFreeboardTitle(rSet.getString("freeboard_title"));
					freeBoard.setUserId(rSet.getString("user_id"));
					freeBoard.setFreeboardNo(rSet.getInt("freeboard_no"));
					freeBoard.setFreeboardDelete(rSet.getString("freeboard_delete"));
					freeBoard.setFreeboardContent(rSet.getString("freeboard_content"));
					freeBoard.setFreeboardDate(rSet.getDate("freeboard_date"));
					freeboardList.add(freeBoard);
				}
			} else if(option.equals("writer")) { //2 if
				query.append(
						"select b.rnum, b.freeboard_no, b.user_id, b.freeboard_title, b.freeboard_content, b.freeboard_date, b.freeboard_delete ")
						.append("from ( select rownum as rnum, a.freeboard_no, a.user_id, a.freeboard_title, a.freeboard_content, a.freeboard_date, a.freeboard_delete ")
						.append("from ( select freeboard_no, user_id, freeboard_title, freeboard_content, freeboard_date, freeboard_delete ")
						.append("from freeboard where user_id like ? order by freeboard_date desc) a ").append("where rownum <= ?) b ")
						.append("where b.rnum >= ?");
				
				pstat = conn.prepareStatement(query.toString());
				pstat.setString(1, "%"+word+"%");
				pstat.setInt(2, endRow);
				pstat.setInt(3, startRow);

				rSet = pstat.executeQuery();
				// 한 페이지당 10개까지만 출력되게

				while (rSet.next()) {
					FreeBoard freeBoard = new FreeBoard();
					freeBoard.setFreeboardTitle(rSet.getString("freeboard_title"));
					freeBoard.setUserId(rSet.getString("user_id"));
					freeBoard.setFreeboardNo(rSet.getInt("freeboard_no"));
					freeBoard.setFreeboardDelete(rSet.getString("freeboard_delete"));
					freeBoard.setFreeboardContent(rSet.getString("freeboard_content"));
					freeBoard.setFreeboardDate(rSet.getDate("freeboard_date"));
					
					freeboardList.add(freeBoard);
				}
			} else if(option.equals("createDel")) {
				System.out.println("디비 날짜 date " + word);
				query.append(
						"select b.rnum, b.freeboard_no, b.user_id, b.freeboard_title, b.freeboard_content, b.freeboard_date, b.freeboard_delete ")
						.append("from ( select rownum as rnum, a.freeboard_no, a.user_id, a.freeboard_title, a.freeboard_content, a.freeboard_date, a.freeboard_delete ")
						.append("from ( select freeboard_no, user_id, freeboard_title, freeboard_content, freeboard_date, freeboard_delete ")
						.append("from freeboard where freeboard_date like ? order by freeboard_date desc) a ").append("where rownum <= ?) b ")
						.append("where b.rnum >= ?");
				java.sql.Date date = java.sql.Date.valueOf(word);
				pstat = conn.prepareStatement(query.toString());
				pstat.setDate(1, date);
				pstat.setInt(2, endRow);
				pstat.setInt(3, startRow);

				rSet = pstat.executeQuery();
				// 한 페이지당 10개까지만 출력되게

				while (rSet.next()) {
					FreeBoard freeBoard = new FreeBoard();
					freeBoard.setFreeboardTitle(rSet.getString("freeboard_title"));
					freeBoard.setUserId(rSet.getString("user_id"));
					freeBoard.setFreeboardNo(rSet.getInt("freeboard_no"));
					freeBoard.setFreeboardDelete(rSet.getString("freeboard_delete"));
					freeBoard.setFreeboardContent(rSet.getString("freeboard_content"));
					freeBoard.setFreeboardDate(rSet.getDate("freeboard_date"));
					
					freeboardList.add(freeBoard);
				}
			}
			System.out.println("디피 flist : " + freeboardList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}

		return freeboardList;
	}

	public int boardListCount(Connection conn, String option, String word) {
		int result = 0;
		Statement stat = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		String query = ("select count(*) from freeboard");
		try {
			if(option == null) {
				stat = conn.createStatement();
				rSet = stat.executeQuery(query);
			} else if(option.equals("writer")) {
				query = ("select count(*) from freeboard where user_id like ?"); 
				pstat = conn.prepareStatement(query);
				pstat.setString(1, "%" + word + "%");
				rSet = pstat.executeQuery();
			} else if(option.equals("createDel")) {
				query = ("select count(*) from freeboard where freeboard_date like ?"); 
				pstat = conn.prepareStatement(query);
				pstat.setString(1, "%" + word + "%");
				rSet = pstat.executeQuery();
			} else {
				stat = conn.createStatement();
				rSet = stat.executeQuery(query);
			}

			if (rSet.next()) {
				result = rSet.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(stat);
		}

		return result;
	}
	public int tipboardListCount(Connection conn, String option, String word) {
		int result = 0;
		Statement stat = null;
		PreparedStatement pstat = null;
		ResultSet rSet = null;
		String query = ("select count(*) from tipboard");
		try {
			if(option == null) {
				stat = conn.createStatement();
				rSet = stat.executeQuery(query);
			} else if(option.equals("writer")) {
				query = ("select count(*) from tipboard where user_id like ?"); 
				pstat = conn.prepareStatement(query);
				pstat.setString(1, "%" + word + "%");
				rSet = pstat.executeQuery();
			} else if(option.equals("createDel")) {
				query = ("select count(*) from tipboard where tipboard_date like ?"); 
				pstat = conn.prepareStatement(query);
				pstat.setString(1, "%" + word + "%");
				rSet = pstat.executeQuery();
			} else {
				stat = conn.createStatement();
				rSet = stat.executeQuery(query);
			}

			if (rSet.next()) {
				result = rSet.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(stat);
		}

		return result;
	}

	public ArrayList<TipBoard> selectTipBoardList(Connection conn, int currentPage, int pageList, String option, String word) {
		// 관리자 페이지 팁게시판 목록 조회용
		ArrayList<TipBoard> tipboardList = new ArrayList<>();
		PreparedStatement pstat = null;
		ResultSet rSet = null;

		int startRow = (currentPage - 1) * pageList + 1;
		int endRow = startRow + pageList - 1;

		StringBuffer query = new StringBuffer();
		try {
			if (option == null) {
				query.append("select b.rnum, b.tipboard_no, b.user_id, b.tipboard_title, b.tipboard_content, b.tipboard_date, b.tipboard_delete ")
					 .append("from ( select rownum as rnum, a.tipboard_no, a.user_id, a.tipboard_title, a.tipboard_content, a.tipboard_date, a.tipboard_delete ")
					 .append("from ( select tipboard_no, user_id, tipboard_title, tipboard_content, tipboard_date, tipboard_delete ")
					 .append("from tipboard order by tipboard_date desc) a ").append("where rownum <= ?) b ")
					 .append("where b.rnum >= ?");

				pstat = conn.prepareStatement(query.toString());
				pstat.setInt(1, endRow);
				pstat.setInt(2, startRow);

				rSet = pstat.executeQuery();
				// 한 페이지당 10개까지만 출력되게

				while (rSet.next()) {
					TipBoard tipBoard = new TipBoard();
					tipBoard.setTipBoardTitle(rSet.getString("tipboard_title"));
					tipBoard.setUserId(rSet.getString("user_id"));
					tipBoard.setTipBoardNo(rSet.getInt("tipboard_no"));
					tipBoard.setTipBoardDelete(rSet.getString("tipboard_delete"));
					tipBoard.setTipBoardContent(rSet.getString("tipboard_content"));
					tipBoard.setTipBoardDate(rSet.getDate("tipboard_date"));

					tipboardList.add(tipBoard);
				}
			} else if (option.equals("delyorn")) {// 1 if
				query.append(
						"select b.rnum, b.tipboard_no, b.user_id, b.tipboard_title, b.tipboard_content, b.tipboard_date, b.tipboard_delete ")
						.append("from ( select rownum as rnum, a.tipboard_no, a.user_id, a.tipboard_title, a.tipboard_content, a.tipboard_date, a.tipboard_delete ")
						.append("from ( select tipboard_no, user_id, tipboard_title, tipboard_content, tipboard_date, tipboard_delete ")
						.append("from tipboard where tipboard_delete like ? order by tipboard_date desc) a ").append("where rownum <= ?) b ")
						.append("where b.rnum >= ?");

				pstat = conn.prepareStatement(query.toString());
				pstat.setString(1, "%" + word + "%");
				pstat.setInt(2, endRow);
				pstat.setInt(3, startRow);

				rSet = pstat.executeQuery();
				// 한 페이지당 10개까지만 출력되게

				while (rSet.next()) {
					TipBoard tipBoard = new TipBoard();
					tipBoard.setTipBoardTitle(rSet.getString("tipboard_title"));
					tipBoard.setUserId(rSet.getString("user_id"));
					tipBoard.setTipBoardNo(rSet.getInt("tipboard_no"));
					tipBoard.setTipBoardDelete(rSet.getString("tipboard_delete"));
					tipBoard.setTipBoardContent(rSet.getString("tipboard_content"));
					tipBoard.setTipBoardDate(rSet.getDate("tipboard_date"));

					tipboardList.add(tipBoard);
				}
			} else if (option.equals("writer")) { // 2 if
				query.append(
						"select b.rnum, b.tipboard_no, b.user_id, b.tipboard_title, b.tipboard_content, b.tipboard_date, b.tipboard_delete ")
						.append("from ( select rownum as rnum, a.tipboard_no, a.user_id, a.tipboard_title, a.tipboard_content, a.tipboard_date, a.tipboard_delete ")
						.append("from ( select tipboard_no, user_id, tipboard_title, tipboard_content, tipboard_date, tipboard_delete ")
						.append("from tipboard where user_id like ? order by tipboard_date desc) a ").append("where rownum <= ?) b ")
						.append("where b.rnum >= ?");

				pstat = conn.prepareStatement(query.toString());
				pstat.setString(1, "%" + word + "%");
				pstat.setInt(2, endRow);
				pstat.setInt(3, startRow);

				rSet = pstat.executeQuery();
				// 한 페이지당 10개까지만 출력되게

				while (rSet.next()) {
					TipBoard tipBoard = new TipBoard();
					tipBoard.setTipBoardTitle(rSet.getString("tipboard_title"));
					tipBoard.setUserId(rSet.getString("user_id"));
					tipBoard.setTipBoardNo(rSet.getInt("tipboard_no"));
					tipBoard.setTipBoardDelete(rSet.getString("tipboard_delete"));
					tipBoard.setTipBoardContent(rSet.getString("tipboard_content"));
					tipBoard.setTipBoardDate(rSet.getDate("tipboard_date"));

					tipboardList.add(tipBoard);
				}
			} else if (option.equals("createDel")) {
				System.out.println("디비 날짜 date " + word);
				query.append(
						"select b.rnum, b.tipboard_no, b.user_id, b.tipboard_title, b.tipboard_content, b.tipboard_date, b.tipboard_delete ")
						.append("from ( select rownum as rnum, a.tipboard_no, a.user_id, a.tipboard_title, a.tipboard_content, a.tipboard_date, a.tipboard_delete ")
						.append("from ( select tipboard_no, user_id, tipboard_title, tipboard_content, tipboard_date, tipboard_delete ")
						.append("from tipboard where tipboard_date like ? order by tipboard_date desc) a ")
						.append("where rownum <= ?) b ").append("where b.rnum >= ?");
				java.sql.Date date = java.sql.Date.valueOf(word);
				pstat = conn.prepareStatement(query.toString());
				pstat.setDate(1, date);
				pstat.setInt(2, endRow);
				pstat.setInt(3, startRow);

				rSet = pstat.executeQuery();
				// 한 페이지당 10개까지만 출력되게

				while (rSet.next()) {
					TipBoard tipBoard = new TipBoard();
					tipBoard.setTipBoardTitle(rSet.getString("tipboard_title"));
					tipBoard.setUserId(rSet.getString("user_id"));
					tipBoard.setTipBoardNo(rSet.getInt("tipboard_no"));
					tipBoard.setTipBoardDelete(rSet.getString("tipboard_delete"));
					tipBoard.setTipBoardContent(rSet.getString("tipboard_content"));
					tipBoard.setTipBoardDate(rSet.getDate("tipboard_date"));

					tipboardList.add(tipBoard);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}

		return tipboardList;
	}
	public int managerDeleteFreeBoard(Connection conn, String delNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update freeboard set freeboard_delete = 'y' where freeboard_no in ?";
		
		try {
			pstmt = conn.prepareStatement(query);				
			pstmt.setInt(1, Integer.parseInt(delNo));
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	public int managerDeleteTipBoard(Connection conn, String delNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update tipboard set tipboard_delete = 'y' where tipboard_no in ?";
		
		try {
			pstmt = conn.prepareStatement(query);				
			pstmt.setInt(1, Integer.parseInt(delNo));
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int memberListCount(Connection conn, HashMap<String, Object> listOpt) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String opt = (String)listOpt.get("opt");
		String inputdata = (String)listOpt.get("inputdata");
		int listCount = 1;
		
		if(opt == null) {
		
		String query = "select count(*) from member where petsitter = '0'";
		
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
			
			String query = "select count(*) from member where user_id like ? and petsitter = '0'";
			
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
			
			String query = "select count(*) from member where user_name like ? and petsitter = '0'";
			
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
	}
		return listCount;
		
	}

	public ArrayList<Member> selectMemberList(Connection conn, HashMap<String, Object> listOpt) {
		ArrayList<Member> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String opt = (String)listOpt.get("opt");
		String inputdata = (String)listOpt.get("inputdata");
		int startRow = (Integer)listOpt.get("startRow");
		
		
		if(opt == null){
			
			String query = "SELECT * " + 
						   "FROM (SELECT ROWNUM RNUM, USER_ID, EMAIL, USER_NAME, ADDRESS, " + 
						   "PHONE, JOB, PETSITTER, PRICE, USER_DATE, PASSWORD, USER_DELETE, " + 
						   "USER_ORIGINFILE, USER_REFILE, NAVER_CODE, TITLE_IMG, REPORT_ADD " + 
						   "FROM (SELECT * FROM MEMBER WHERE petsitter = '0' " + 
						   "ORDER BY USER_ID DESC)) " + 
						   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, startRow+9);
				
				rset = pstmt.executeQuery();
							
				while(rset.next()) {
					
					Member member = new Member();
					
					member.setUserId(rset.getString("USER_ID"));
					member.setEmail(rset.getString("EMAIL"));
					member.setUserName(rset.getString("USER_NAME"));
					member.setAddress(rset.getString("ADDRESS"));
					member.setPhone(rset.getString("PHONE"));
					member.setJob(rset.getString("JOB"));
					member.setPetSitter(rset.getString("PETSITTER"));
					member.setPrice(rset.getInt("PRICE"));
					member.setUserDate(rset.getDate("USER_DATE"));
					member.setUserPwd(rset.getString("PASSWORD"));
					member.setUserDelete(rset.getString("USER_DELETE"));
					member.setUseroriginfile(rset.getString("USER_ORIGINFILE"));
					member.setUserrefile(rset.getString("USER_REFILE"));
					member.setNaverCode(rset.getString("NAVER_CODE"));
					member.setTitleImg(rset.getString("TITLE_IMG"));
					member.setReportAdd(rset.getInt("REPORT_ADD"));
					
					list.add(member);
					
					}
		
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}	
			
			
		}else if(opt.equals("0")) {
			
			String query = "SELECT * " + 
					   "FROM (SELECT ROWNUM RNUM, USER_ID, EMAIL, USER_NAME, ADDRESS, " + 
					   "PHONE, JOB, PETSITTER, PRICE, USER_DATE, PASSWORD, USER_DELETE, " + 
					   "USER_ORIGINFILE, USER_REFILE, NAVER_CODE, TITLE_IMG, REPORT_ADD " + 
					   "FROM (SELECT * FROM MEMBER WHERE USER_ID LIKE ? and petsitter = '0' " + 
					   "ORDER BY USER_ID DESC)) " + 
					   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
								
				rset = pstmt.executeQuery();
				
					while(rset.next()) {
						Member member = new Member();
						
						member.setUserId(rset.getString("USER_ID"));
						member.setEmail(rset.getString("EMAIL"));
						member.setUserName(rset.getString("USER_NAME"));
						member.setAddress(rset.getString("ADDRESS"));
						member.setPhone(rset.getString("PHONE"));
						member.setJob(rset.getString("JOB"));
						member.setPetSitter(rset.getString("PETSITTER"));
						member.setPrice(rset.getInt("PRICE"));
						member.setUserDate(rset.getDate("USER_DATE"));
						member.setUserPwd(rset.getString("PASSWORD"));
						member.setUserDelete(rset.getString("USER_DELETE"));
						member.setUseroriginfile(rset.getString("USER_ORIGINFILE"));
						member.setUserrefile(rset.getString("USER_REFILE"));
						member.setNaverCode(rset.getString("NAVER_CODE"));
						member.setTitleImg(rset.getString("TITLE_IMG"));
						member.setReportAdd(rset.getInt("REPORT_ADD"));
						
						list.add(member);
						}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			
			
		}else if(opt.equals("1")) {
			
			String query = "SELECT * " + 
					   "FROM (SELECT ROWNUM RNUM, USER_ID, EMAIL, USER_NAME, ADDRESS, " + 
					   "PHONE, JOB, PETSITTER, PRICE, USER_DATE, PASSWORD, USER_DELETE, " + 
					   "USER_ORIGINFILE, USER_REFILE, NAVER_CODE, TITLE_IMG, REPORT_ADD  " + 
					   "FROM (SELECT * FROM MEMBER WHERE USER_NAME LIKE ? and petsitter = '0' " + 
					   "ORDER BY USER_ID DESC)) " + 
					   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
				
				
				rset = pstmt.executeQuery();
				
					while(rset.next()) {
						Member member = new Member();
						
						member.setUserId(rset.getString("USER_ID"));
						member.setEmail(rset.getString("EMAIL"));
						member.setUserName(rset.getString("USER_NAME"));
						member.setAddress(rset.getString("ADDRESS"));
						member.setPhone(rset.getString("PHONE"));
						member.setJob(rset.getString("JOB"));
						member.setPetSitter(rset.getString("PETSITTER"));
						member.setPrice(rset.getInt("PRICE"));
						member.setUserDate(rset.getDate("USER_DATE"));
						member.setUserPwd(rset.getString("PASSWORD"));
						member.setUserDelete(rset.getString("USER_DELETE"));
						member.setUseroriginfile(rset.getString("USER_ORIGINFILE"));
						member.setUserrefile(rset.getString("USER_REFILE"));
						member.setNaverCode(rset.getString("NAVER_CODE"));
						member.setTitleImg(rset.getString("TITLE_IMG"));
						member.setReportAdd(rset.getInt("REPORT_ADD"));
						
						list.add(member);
					}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
		}
		return list;
	}

	public ArrayList<Member> selectPetsitterList(Connection conn, HashMap<String, Object> listOpt) {
		ArrayList<Member> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String opt = (String)listOpt.get("opt");
		String inputdata = (String)listOpt.get("inputdata");
		int startRow = (Integer)listOpt.get("startRow");
		
		
		if(opt == null){
			
			String query = "SELECT * " + 
						   "FROM (SELECT ROWNUM RNUM, USER_ID, EMAIL, USER_NAME, ADDRESS, " + 
						   "PHONE, JOB, PETSITTER, PRICE, USER_DATE, PASSWORD, USER_DELETE, " + 
						   "USER_ORIGINFILE, USER_REFILE, NAVER_CODE ,TITLE_IMG, REPORT_ADD " + 
						   "FROM (SELECT * FROM MEMBER WHERE petsitter = '1' or petsitter = '2' " + 
						   "ORDER BY USER_ID DESC)) " + 
						   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, startRow+9);
				
				rset = pstmt.executeQuery();
							
				while(rset.next()) {
					
					Member member = new Member();
					
					member.setUserId(rset.getString("USER_ID"));
					member.setEmail(rset.getString("EMAIL"));
					member.setUserName(rset.getString("USER_NAME"));
					member.setAddress(rset.getString("ADDRESS"));
					member.setPhone(rset.getString("PHONE"));
					member.setJob(rset.getString("JOB"));
					member.setPetSitter(rset.getString("PETSITTER"));
					member.setPrice(rset.getInt("PRICE"));
					member.setUserDate(rset.getDate("USER_DATE"));
					member.setUserPwd(rset.getString("PASSWORD"));
					member.setUserDelete(rset.getString("USER_DELETE"));
					member.setUseroriginfile(rset.getString("USER_ORIGINFILE"));
					member.setUserrefile(rset.getString("USER_REFILE"));
					member.setNaverCode(rset.getString("NAVER_CODE"));
					member.setTitleImg(rset.getString("TITLE_IMG"));
					member.setReportAdd(rset.getInt("REPORT_ADD"));
					
					list.add(member);
					
					}
		
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}	
			
			
		}else if(opt.equals("0")) {
			
			String query = "SELECT * " + 
					   "FROM (SELECT ROWNUM RNUM, USER_ID, EMAIL, USER_NAME, ADDRESS, " + 
					   "PHONE, JOB, PETSITTER, PRICE, USER_DATE, PASSWORD, USER_DELETE, " + 
					   "USER_ORIGINFILE, USER_REFILE, NAVER_CODE, TITLE_IMG, REPORT_ADD  " + 
					   "FROM (SELECT * FROM MEMBER WHERE USER_ID = ? and petsitter = '1' or petsitter = '2' " + 
					   "ORDER BY USER_ID DESC)) " + 
					   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
								
				rset = pstmt.executeQuery();
				
					while(rset.next()) {
						Member member = new Member();
						
						member.setUserId(rset.getString("USER_ID"));
						member.setEmail(rset.getString("EMAIL"));
						member.setUserName(rset.getString("USER_NAME"));
						member.setAddress(rset.getString("ADDRESS"));
						member.setPhone(rset.getString("PHONE"));
						member.setJob(rset.getString("JOB"));
						member.setPetSitter(rset.getString("PETSITTER"));
						member.setPrice(rset.getInt("PRICE"));
						member.setUserDate(rset.getDate("USER_DATE"));
						member.setUserPwd(rset.getString("PASSWORD"));
						member.setUserDelete(rset.getString("USER_DELETE"));
						member.setUseroriginfile(rset.getString("USER_ORIGINFILE"));
						member.setUserrefile(rset.getString("USER_REFILE"));
						member.setNaverCode(rset.getString("NAVER_CODE"));
						member.setTitleImg(rset.getString("TITLE_IMG"));
						member.setReportAdd(rset.getInt("REPORT_ADD"));
						
						list.add(member);
						}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			
			
		}else if(opt.equals("1")) {
			
			String query = "SELECT * " + 
					   "FROM (SELECT ROWNUM RNUM, USER_ID, EMAIL, USER_NAME, ADDRESS, " + 
					   "PHONE, JOB, PETSITTER, PRICE, USER_DATE, PASSWORD, USER_DELETE, " + 
					   "USER_ORIGINFILE, USER_REFILE, NAVER_CODE, TITLE_IMG, REPORT_ADD  " + 
					   "FROM (SELECT * FROM MEMBER WHERE USER_ID = ? and petsitter = '1' or petsitter = '2' " + 
					   "ORDER BY USER_ID DESC)) " + 
					   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
				
				
				rset = pstmt.executeQuery();
				
					while(rset.next()) {
						Member member = new Member();
						
						member.setUserId(rset.getString("USER_ID"));
						member.setEmail(rset.getString("EMAIL"));
						member.setUserName(rset.getString("USER_NAME"));
						member.setAddress(rset.getString("ADDRESS"));
						member.setPhone(rset.getString("PHONE"));
						member.setJob(rset.getString("JOB"));
						member.setPetSitter(rset.getString("PETSITTER"));
						member.setPrice(rset.getInt("PRICE"));
						member.setUserDate(rset.getDate("USER_DATE"));
						member.setUserPwd(rset.getString("PASSWORD"));
						member.setUserDelete(rset.getString("USER_DELETE"));
						member.setUseroriginfile(rset.getString("USER_ORIGINFILE"));
						member.setUserrefile(rset.getString("USER_REFILE"));
						member.setNaverCode(rset.getString("NAVER_CODE"));
						member.setTitleImg(rset.getString("TITLE_IMG"));
						member.setReportAdd(rset.getInt("REPORT_ADD"));
						
						list.add(member);
					}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
		}
		return list;
		
		
	}

	public int petsitterListCount(Connection conn, HashMap<String, Object> listOpt) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String opt = (String)listOpt.get("opt");
		String inputdata = (String)listOpt.get("inputdata");
		int listCount = 1;
		
		if(opt == null) {
		
		String query = "select count(*) from member where petsitter = '1' or petsitter = '2'";
		
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
			
			String query = "select count(*) from member where user_id like ? and petsitter = '1' or petsitter = '2'";
			
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
			
			String query = "select count(*) from member where user_name like ? and petsitter = '1' or petsitter '2'";
			
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
	}
		return listCount;
	}

	public int updatePetsitter(Connection conn, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		System.out.println("dao userId : " + userId);
		String query = "update member set petsitter = 2 where user_id = ? and petsitter = 1"; 
		
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
			System.out.println("dao result : " + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
			
		return result;
	}
	

	public ArrayList<FreeBoard> selectReadCountTop5(Connection conn) {
		ArrayList<FreeBoard> flist = new ArrayList<> ();
		Statement pstat = null;
		ResultSet rSet = null;
		
		StringBuffer query = new StringBuffer();
		query.append("select rownum, freeboard_no, freeboard_title, freeboard_views ")
			 .append("from freeboard where rownum >= 1 and rownum <= 5 and freeboard_delete = 'n'")
			 .append("order by freeboard_date desc");
		
		try {
			pstat = conn.createStatement();
			rSet = pstat.executeQuery(query.toString());
			
			while(rSet.next()) {
				FreeBoard board = new FreeBoard();
				
				board.setFreeboardNo(rSet.getInt("freeboard_no"));
				board.setFreeboardTitle(rSet.getString("freeboard_title"));
				board.setFreeboardViews(rSet.getInt("freeboard_views"));
				
				flist.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);
		}
		return flist;
	}

	public ArrayList<Question> selectQuestionList(Connection conn, int limit, int currentPage) {
		ArrayList<Question> list = new ArrayList<Question>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		int startRow = 1;//(currentPage - 1) * limit + 1;
		int endRow = startRow + limit;
		System.out.println("디에오"+startRow + "=" + endRow);
		String query = "SELECT * FROM (SELECT ROWNUM RNUM, QUESTION_NO, QUESTION_TITLE, "
				+ "QUESTION_CONTENT, QUESTION_DATE, REPLY_YN, " 
				+ "USER_ID, QUESTION_ORIGINAL_FILENAME, " 
				+ "QUESTION_RENAME_FILENAME, QUESTION_REF, "
				+ "QUESTION_REPLY_REF, QUESTION_REPLY_LEV, " 
				+ "QUESTION_REPLY_SEQ "
				+ "FROM (SELECT * FROM QUESTION ORDER BY QUESTION_REF DESC, QUESTION_REPLY_REF ASC, "
				+ "QUESTION_REPLY_LEV ASC, QUESTION_REPLY_SEQ ASC)) WHERE RNUM >= ? AND RNUM <= ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();

			while (rset.next()) {
				Question question = new Question();

				question.setQuestionNo(rset.getInt("question_no"));
				question.setQuestionTitle(rset.getString("question_title"));
				question.setQuestionContent(rset.getString("question_content"));
				question.setQuestionDate(rset.getDate("question_date"));
				question.setQuestionReplyYn(rset.getString("reply_yn"));
				question.setUserId(rset.getString("user_id"));				
				question.setQuestionOriginalFileName(rset.getString("question_original_filename"));
				question.setQuestionRenameFileName(rset.getString("question_rename_filename"));
				question.setQuestionRef(rset.getInt("question_ref"));
				question.setQuestionReplyRef(rset.getInt("question_reply_ref"));
				question.setQuestionReplyLev(rset.getInt("question_reply_lev"));
				question.setQuestionReplySeq(rset.getInt("question_reply_seq"));

				list.add(question);
				System.out.println(question);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}

		return list;
	}

	public int questionListCount(Connection conn) {
		PreparedStatement pstmt =null;
		ResultSet rset = null;
		int result =0;
		String query ="select count(*) from question";
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				result = rset.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return result;
  }
  

	public int managerDeleteMember(Connection conn, String delId) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update member set user_delete = 'y' where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);				
			pstmt.setString(1, delId);
			
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	} 

	public ArrayList<TipBoard> selectReadCountTBTop5(Connection conn) {
		ArrayList<TipBoard> tlist = new ArrayList<> ();
		Statement pstat = null;
		ResultSet rSet = null;
		
		StringBuffer query = new StringBuffer();
		query.append("select rownum, tipboard_no, tipboard_title, tipboard_views ")
			 .append("from tipboard where rownum >= 1 and rownum <= 5 and tipboard_delete = 'n'")
			 .append("order by tipboard_date desc");
		
		try {
			pstat = conn.createStatement();
			rSet = pstat.executeQuery(query.toString());
			
			while(rSet.next()) {
				TipBoard board = new TipBoard();
				
				board.setTipBoardNo(rSet.getInt("tipboard_no"));
				board.setTipBoardTitle(rSet.getString("tipboard_title"));
				board.setTipBoardViews(rSet.getInt("tipboard_views"));
				
				tlist.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rSet);
			close(pstat);

		}
		return tlist;
	}

	public ArrayList<Notice> searchNoticeList(Connection conn, HashMap<String, Object> listOpt) {
		ArrayList<Notice> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String opt = (String)listOpt.get("opt");
		String inputdata = (String)listOpt.get("inputdata");
		int startRow = (Integer)listOpt.get("startRow");
		
		
		if(opt == null){
			
			String query = "SELECT * " + 
						   "FROM (SELECT ROWNUM RNUM, NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, " + 
						   "NOTICE_ORIGINFILE, NOTICE_VIEWS, MANAGER_ID, NOTICE_DELETE, NOTICE_REFILE " + 
						   "FROM (SELECT * FROM NOTICE " + 
						   "ORDER BY NOTICE_NO ASC)) " + 
						   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, startRow+9);
				
				rset = pstmt.executeQuery();
							
				while(rset.next()) {
					
					Notice notice = new Notice();
					
					notice.setNoticeNo(rset.getInt("NOTICE_NO"));
					notice.setNoticeTitle(rset.getString("NOTICE_TITLE"));
					notice.setNoticeContent(rset.getString("NOTICE_CONTENT"));
					notice.setNoticeDate(rset.getDate("NOTICE_DATE"));
					notice.setNoticeOriginFile(rset.getString("NOTICE_ORIGINFILE"));
					notice.setNoticeViews(rset.getInt("NOTICE_VIEWS"));
					notice.setManagerId(rset.getString("MANAGER_ID"));
					notice.setNoticeDelete(rset.getString("NOTICE_DELETE"));
					notice.setNoticeReFile(rset.getString("NOTICE_REFILE"));
					
					list.add(notice);
					
					}
		
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}	
			
			
		}else if(opt.equals("0")) {
			
			String query = "SELECT * " + 
					   "FROM (SELECT ROWNUM RNUM, NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, " + 
					   "NOTICE_ORIGINFILE, NOTICE_VIEWS, MANAGER_ID, NOTICE_DELETE, NOTICE_REFILE " + 
					   "FROM (SELECT * FROM NOTICE WHERE NOTICE_TITLE = ? " + 
					   "ORDER BY NOTICE_NO ASC)) " + 
					   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
								
				rset = pstmt.executeQuery();
				
					while(rset.next()) {					
						Notice notice = new Notice();
						
						notice.setNoticeNo(rset.getInt("NOTICE_NO"));
						notice.setNoticeTitle(rset.getString("NOTICE_TITLE"));
						notice.setNoticeContent(rset.getString("NOTICE_CONTENT"));
						notice.setNoticeDate(rset.getDate("NOTICE_DATE"));
						notice.setNoticeOriginFile(rset.getString("NOTICE_ORIGINFILE"));
						notice.setNoticeViews(rset.getInt("NOTICE_VIEWS"));
						notice.setManagerId(rset.getString("MANAGER_ID"));
						notice.setNoticeDelete(rset.getString("NOTICE_DELETE"));
						notice.setNoticeReFile(rset.getString("NOTICE_REFILE"));
						
						list.add(notice);
						}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
			
			
			
		}else if(opt.equals("1")) {
			
			String query = "SELECT * " + 
					   "FROM (SELECT ROWNUM RNUM, NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, " + 
					   "NOTICE_ORIGINFILE, NOTICE_VIEWS, MANAGER_ID, NOTICE_DELETE, NOTICE_REFILE " + 
					   "FROM (SELECT * FROM NOTICE WHERE NOTICE_CONTENT = ? " + 
					   "ORDER BY NOTICE_NO ASC)) " + 
					   "WHERE RNUM >= ? AND RNUM <= ?";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, "%" + inputdata + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, startRow+9);
				
				
				rset = pstmt.executeQuery();
				
					while(rset.next()) {
						Notice notice = new Notice();
						
						notice.setNoticeNo(rset.getInt("NOTICE_NO"));
						notice.setNoticeTitle(rset.getString("NOTICE_TITLE"));
						notice.setNoticeContent(rset.getString("NOTICE_CONTENT"));
						notice.setNoticeDate(rset.getDate("NOTICE_DATE"));
						notice.setNoticeOriginFile(rset.getString("NOTICE_ORIGINFILE"));
						notice.setNoticeViews(rset.getInt("NOTICE_VIEWS"));
						notice.setManagerId(rset.getString("MANAGER_ID"));
						notice.setNoticeDelete(rset.getString("NOTICE_DELETE"));
						notice.setNoticeReFile(rset.getString("NOTICE_REFILE"));
						
						list.add(notice);
						}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(rset);
				close(pstmt);
			}
		}
		return list;
		
		
	}

	
	public int getNoticeListCount(Connection conn, HashMap<String, Object> listOpt) {
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
			
			String query = "select count(*) from notice where notice_title = ?";
			
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
			
			String query = "select count(*) from notice where notice_content = ?";
			
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
	}
		return listCount;
	}

	public int addReadCount(Connection conn, int noticeNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update notice "
				+ "set notice_views = notice_views + 1 "
				+ "where notice_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public Notice selectNotice(Connection conn, int noticeNo) {
		Notice notice = new Notice();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice where notice_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				notice = new Notice();
				
				notice.setNoticeNo(rset.getInt("NOTICE_NO"));
				notice.setNoticeTitle(rset.getString("NOTICE_TITLE"));
				notice.setNoticeContent(rset.getString("NOTICE_CONTENT"));
				notice.setNoticeDate(rset.getDate("NOTICE_DATE"));
				notice.setNoticeOriginFile(rset.getString("NOTICE_ORIGINFILE"));
				notice.setNoticeViews(rset.getInt("NOTICE_VIEWS"));
				notice.setManagerId(rset.getString("MANAGER_ID"));
				notice.setNoticeDelete(rset.getString("NOTICE_DELETE"));
				notice.setNoticeReFile(rset.getString("NOTICE_REFILE"));	
			}		
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
	
		return notice;
	}
	
}
