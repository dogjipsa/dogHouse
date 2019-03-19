package member.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberHostUpdateServlet
 */
@WebServlet("/hostup")
public class MemberHostUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberHostUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!ServletFileUpload.isMultipartContent(request)) {
			// request에서 멀티파트 방식으로 전송이 안되었다면
			System.out.println("not multipart");
		}
		
		// 업로드할 파일의 용량 제한 : 10Mb로 제한한다면
		int maxSize = 1024* 1024 * 10;
		
		// 파일이 저장될 폴더 지정 : content directory 안에 파일저장폴더를 정한 경우
		// 현재 웹 컨테이너에서 구동중인 웹 어플리케이션의 루트폴더에 대한 경로 알아냄
		String root = request.getSession().getServletContext().getRealPath("/");
		// 업로드 되는 파일의 저장 폴더를 루트와 연결함
		String savePath = root + "files/profile";
		
		// request를 MultipartRequest 객체로 변환함
		MultipartRequest mrequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		Member m = new Member();
		m.setUserId(mrequest.getParameter("userid"));
		m.setUserName(mrequest.getParameter("username"));
		m.setPhone(mrequest.getParameter("phone"));
		m.setAddress(mrequest.getParameter("addr"));
		m.setPrice(Integer.parseInt(mrequest.getParameter("price")));
		String originFileName = mrequest.getFilesystemName("pic");
		if(originFileName != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String renameFileName = sdf.format(new Date(System.currentTimeMillis()))+"."+ originFileName.substring(originFileName.lastIndexOf(".")+1);
			File originFile = new File(savePath+"\\"+originFileName);
			File renameFile = new File(savePath+"\\"+renameFileName);
			
			if(!originFile.renameTo(renameFile)) {
				// 파일명 직접 바꾸기
				// 원본 파일이 내용 읽어서, 리네임 파일에 복사 기록하기
				// 원본 파일 삭제
				int read = -1;
				byte[] buf = new byte[1024];
				
				FileInputStream fin = new FileInputStream(originFile);
				FileOutputStream fout = new FileOutputStream(renameFile);
				
				while((read = fin.read(buf, 0 , buf.length)) != -1) {
					fout.write(buf, 0, read);
				}
				
				fin.close();
				fout.close();
				originFile.delete();
			}
			m.setUseroriginfile(originFileName);
			m.setUserrefile(renameFileName);
		}
		System.out.println(m);
		
		
		int result = new MemberService().updateHost(m);
		if(result > 0) {
			System.out.println("성공");
		} else {
			System.out.println("실패");
		}
		
		
	}

	/**
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}