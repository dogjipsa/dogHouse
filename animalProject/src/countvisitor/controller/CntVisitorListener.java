package countvisitor.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import countvisitor.model.dao.CountVisitorDao;
import countvisitor.model.service.CountService;
import countvisitor.model.vo.CountVisitor;

/**
 * Application Lifecycle Listener implementation class CntVisitorListener
 *
 */
@WebListener
public class CntVisitorListener implements HttpSessionListener {

    /**
     * Default constructor. 
     */
    public CntVisitorListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    public static int count;
    
    public static int getCount() {
        return count;
    }
    @Override
    public void sessionCreated(HttpSessionEvent event)  { 
         // 세션으로 방문자 수 및 현재 접속자 수 처리용 컨트롤러
    	System.out.println("세션 생성!");
    	Date today = new Date();
    	java.sql.Date sqlDate = new java.sql.Date(today.getTime());
    	
    	System.out.println(sqlDate);
    	int result = 0;
    	CountService cntService = new CountService();
    	if(cntService.isToday(sqlDate)) {
    		//오늘 방문자 수는 오늘 날짜에 업데이트
    		result = cntService.updateCount(sqlDate);
    	} else {
    		CountVisitor cntVisitor = new CountVisitor();
    		cntVisitor.setVisitDate(sqlDate);
    		cntVisitor.setCountVisitor(1);
    		result = cntService.insertCount(cntVisitor);
    	}
    	
    	if(result > 0) {
    		HttpSession session = event.getSession(); //request에서 얻는 session과 동일한 객체
            session.setMaxInactiveInterval(60*20);
             
            count++;
            System.out.println(count);
            //동접자 수
            session.getServletContext().log(session.getId() + " 세션생성 " + ", 접속자수 : " + count);
    	}
    	
    }

	/**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    @Override
    public void sessionDestroyed(HttpSessionEvent event)  { 
    	/*count--;*/
        /*if(count<0)
            count=0;*/
         
        /*HttpSession session = event.getSession();*/
        /*session.getServletContext().log(session.getId() + " 세션소멸 " + ", 접속자수 : " + count);*/
    }
	
}
