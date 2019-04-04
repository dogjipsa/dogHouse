package pet.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.sun.org.apache.xml.internal.resolver.helpers.Debug;

import pet.model.service.PetService;
import pet.model.vo.Pet;

/**
 * Servlet implementation class UpdatePetServlet
 */
@WebServlet("/pups")
public class UpdatePetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePetServlet() {
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
			Pet pet = new Pet();
			pet.setPetNo(Integer.parseInt(mrequest.getParameter("pno")));
			pet.setUserId(mrequest.getParameter("userid"));
			pet.setPetName(mrequest.getParameter("pname"));
			pet.setBreeds(mrequest.getParameter("breeds"));
			pet.setPetDate(Date.valueOf(mrequest.getParameter("birth")));
			pet.setPetSize(mrequest.getParameter("size"));
			pet.setPetGender(mrequest.getParameter("gender"));
			String neutral = "N";
			if(!(pet.getPetGender().equals("M")|| pet.getPetGender().equals("F")))
				neutral = "Y";
			pet.setPetNeutralize(neutral);
			pet.setPetCharater(mrequest.getParameter("etc"));
			if(mrequest.getFilesystemName("ppic") != null) {
				String originFileName = mrequest.getFilesystemName("ppic");
				System.out.println(originFileName);
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
				pet.setOriginFileName(originFileName);
				pet.setRenameFileName(renameFileName);
				
			} else {
				String originFileName = mrequest.getFilesystemName("ppic2");
				String renameFileName = null;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				renameFileName = sdf.format(new Date(System.currentTimeMillis()))+"."+originFileName.substring(originFileName.lastIndexOf(".")+1);
				pet.setOriginFileName(originFileName);
				pet.setRenameFileName(renameFileName);
			}
			int result = new PetService().updatePet(pet);
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			if(result > 0) 
				out.write("ok");
			 else 
				out.write("no");
			out.flush();
			out.close();
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
