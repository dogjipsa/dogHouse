package faq.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import faq.model.vo.Faq;

public class FaqDao {

	public ArrayList<Faq> selectList(Connection conn, int currentPage, int limit) {
		// TODO Auto-generated method stub
		return null;
	}

	public Faq selectFaq(Connection conn, int faqNo) {
		// TODO Auto-generated method stub
		return null;
	}

	public int insertFaq(Connection conn, Faq faq) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteFaq(Connection conn, int faqNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateFaq(Connection conn, Faq faq) {
		// TODO Auto-generated method stub
		return 0;
	}

	public ArrayList<Faq> selectTitleList(Connection conn, String title, int currentPage, int limit) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getListCount(Connection conn) {
		// TODO Auto-generated method stub
		return 0;
	}


}
