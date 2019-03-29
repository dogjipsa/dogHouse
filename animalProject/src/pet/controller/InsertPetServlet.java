package pet.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pet.model.service.PetService;
import pet.model.vo.Pet;

/**
 * Servlet implementation class InsertPetServlet
 */
@WebServlet("/addpet")
public class InsertPetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertPetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 1024 * 1024 * 10;
			String root = request.getSession().getServletContext().getRealPath("/");
			String savePath = root+"files/pet";
			
			MultipartRequest mrequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy()); 
			String userid = mrequest.getParameter("userid");
			String pname = mrequest.getParameter("pname");
			String breeds = mrequest.getParameter("breeds");
			String birth = mrequest.getParameter("birth");
			Date pbirth = Date.valueOf(birth);
			String size = mrequest.getParameter("size");
			String gender = mrequest.getParameter("gender");
			String neutral = "N";
			if(!(gender.equals("M")|| gender.equals("F")))
				neutral = "Y";
			
			String etc = mrequest.getParameter("etc");
			String originFileName = mrequest.getFilesystemName("petpic");
			String renameFileName = null;
			if(originFileName != null) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				renameFileName = sdf.format(new Date(System.currentTimeMillis()))+"."+originFileName.substring(originFileName.lastIndexOf(".")+1);
				
				File originFile = new File(savePath+"\\"+originFileName);
				File renameFile = new File(savePath+"\\"+renameFileName);
				
				if(originFile.exists()) 
					originFile.renameTo(renameFile);
				
				if(originFile.exists()) {
					int read = -1;
					byte[] buf = new byte[1024];
					
					FileInputStream fis = new FileInputStream(originFile);
					FileOutputStream fos = new FileOutputStream(renameFile);
					
					while((read = fis.read(buf, 0, buf.length)) != -1) {
						fos.write(buf, 0, read);
					}
					fis.close();
					fos.close();
					originFile.delete();
				}
			}
			Pet pet = new Pet(0,pname,breeds,pbirth,size,gender,neutral,etc,userid,originFileName,renameFileName); 
			
			int result = new PetService().insertPet(pet);
			if(result > 0) {
				System.out.println("ok");
			} else {
				System.out.println("fail");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
