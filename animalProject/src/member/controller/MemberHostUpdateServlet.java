package member.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

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
import member.model.vo.SitterImage;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int maxSize = 1024 * 1024 * 10;

		String root = request.getSession().getServletContext().getRealPath("/");
		String savePath = root + "files/profile";

		MultipartRequest mrequest = new MultipartRequest(request, savePath, maxSize, "UTF-8",
				new DefaultFileRenamePolicy());
		Member m = new Member();
		String userid = mrequest.getParameter("userid");
		m.setUserId(userid);
		m.setUserName(mrequest.getParameter("username"));
		m.setPhone(mrequest.getParameter("phone"));
		String fullAddr = mrequest.getParameter("addr") + ", " + mrequest.getParameter("extra") + " "
				+ mrequest.getParameter("daddr") + " (" + mrequest.getParameter("postcode") + ")";
		m.setAddress(fullAddr);
		m.setPrice(Integer.parseInt(mrequest.getParameter("price")));
		m.setEmail(mrequest.getParameter("email"));
		m.setpContent(mrequest.getParameter("myinfo").replaceAll("\r\n","<br>"));
		String originFileName = mrequest.getFilesystemName("pic");
		String renameFileName = renameFile(originFileName, savePath);
		m.setUseroriginfile(originFileName);
		m.setUserrefile(renameFileName);

		String fileList = mrequest.getParameter("fileList");
		String[] listArr = fileList.split("/");
		ArrayList<SitterImage> list = new ArrayList<>();
		for (String e : listArr) {
			String rname = renameFile(e, savePath);
			SitterImage si = new SitterImage();
			si.setOriginFile(e);
			si.setRenameFile(rname);
			si.setUserId(userid);

			list.add(si);
		}

		ArrayList<SitterImage> dlist = new MemberService().handleOldImages(userid);
		if(dlist.size() > 0) {
			for(SitterImage e : dlist) {
				File file = new File(savePath+"/"+e.getRenameFile());
				if(file.exists()) file.delete();
			}
		}
		int result = new MemberService().updateHost(m);
		int result2 = new MemberService().insertSitterImages(list);
		if (result > 0 && result2 > 0) {
			PrintWriter out = response.getWriter();
			out.append("ok");
			out.flush();
			out.close();
		}



	}

	private String renameFile(String originFileName, String savePath) throws IOException {
		if (originFileName != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "."
					+ originFileName.substring(originFileName.lastIndexOf(".") + 1);
			File originFile = new File(savePath + "\\" + originFileName);
			File renameFile = new File(savePath + "\\" + renameFileName);
			
			if(originFile.exists()) {
				originFile.renameTo(renameFile);
			} else {
				String newOriginFileName = null;
				while(true) {
				int count = 0;
				count++;
				newOriginFileName = originFileName.substring(0, originFileName.lastIndexOf(".")) + (count) + originFileName.substring(originFileName.lastIndexOf("."));
				File newOriginFile = new File(savePath + "\\"+ newOriginFileName);
				if(newOriginFile.exists()) {
					newOriginFile.delete();
					break;
				}
				}
			}
			
			return renameFileName;
		}
		return "";
	}

	/**
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
