<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member" %>
<%-- <%@ page import="java.util.UUID"%> 
<%@ page import="java.io.File"%> 
<%@ page import="java.io.FileOutputStream"%> 
<%@ page import="java.io.InputStream"%> 
<%@ page import="java.io.OutputStream"%> 
<%@ page import="org.apache.commons.fileupload.FileItem"%> 
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%> 
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%> --%>

<%
	/* Member loginUser = (Member)session.getAttribute("loginUser"); */
%>
<%-- <% // 로컬경로에 파일 저장하기 ============================================ 
String sFileInfo = ""; // 파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴 
String name = request.getHeader("file-name"); // 확장자 
String ext = name.substring(name.lastIndexOf(".")+1); // 파일 기본경로 
String defaultPath = request.getServletContext().getRealPath("/"); // 파일 기본경로 _ 상세경로 
String path = defaultPath + "upload" + File.separator; 
File file = new File(path); 
if(!file.exists()) { 
	file.mkdirs(); 
} 
String realname = UUID.randomUUID().toString() + "." + ext; 
InputStream is = request.getInputStream(); 
OutputStream os = new FileOutputStream(path + realname); 
int numRead; // 파일쓰기 
byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))]; 
while((numRead = is.read(b,0,b.length)) != -1) { 
	os.write(b,0,numRead); 
} 
if(is != null) { 
	is.close(); 
} 
os.flush(); 
os.close(); 
System.out.println("path : "+path); 
System.out.println("realname : "+realname); // 파일 삭제 // File f1 = new File(path, realname); // if (!f1.isDirectory()) { // if(!f1.delete()) { // System.out.println("File 삭제 오류!"); // } // } 
sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/upload/"+realname; 
out.println(sFileInfo); 
// ./로컬경로에 파일 저장하기 ============================================
%> --%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팁게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script> 
<script type="text/javascript" src="/doggybeta/SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function() { var oEditors = []; // 개발되어 있는 소스에 맞추느라, 전역변수로 사용하였지만, 지역변수로 사용해도 전혀 무관 함. 
// Editor Setting 
nhn.husky.EZCreator.createInIFrame({ oAppRef : oEditors, // 전역변수 명과 동일해야 함. 
elPlaceHolder : "smarteditor", // 에디터가 그려질 textarea ID 값과 동일 해야 함. 
sSkinURI : "/doggybeta/SE2/SmartEditor2Skin.html", // Editor HTML 
fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X 
htParams : { 
	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
	bUseToolbar : true, 
	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
	bUseVerticalResizer : true, 
	// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
	bUseModeChanger : true, } 
}); 
// 전송버튼 클릭이벤트 
$("#savebutton").click(function(){ 
	//if(confirm("저장하시겠습니까?")) { 
		// id가 smarteditor인 textarea에 에디터에서 대입 
		oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []); 
		
		// 이부분에 에디터 validation 검증 
		if(validation()) { 
			$("#frm").submit(); 
		} 
	//} 
	}) 
}); 
// 필수값 Check 
function validation(){ 
	var contents = $.trim(oEditors[0].getContents()); 
	if(contents === '<p>&bnsp;</p>' || contents === ''){ // 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
		alert("내용을 입력하세요."); 
	oEditors.getById['smarteditor'].exec('FOCUS'); 
	return false; 
	} 
	return true; 
}


</script>

</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
			<form action="/doggybeta/tinsert" method="post" enctype="multipart/form-data" id="frm">
				<table align="center" width=766px;>
					<tr><td>제목</td><td><input type="text" name="ttitle"></td></tr>
					<tr><td>작성자</td><td><input type="text" name="twriter" readonly value="<%=loginUser.getUserId()%>"></td></tr>
					<tr><td>첨부파일</td>
					<td><input type="file" name="tupfile"></td></tr>
					<tr><td>내용</td>
					<!-- <td><textarea cols="50" rows="7" name="tcontent"></textarea></td></tr> -->
					<td>
					<textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width:766px; height:412px;"> </textarea>
					</td></tr>
					<tr><td colspan="2" align="center">
						<input type="submit" value="등록하기" id="savebutton"> &nbsp; 
						<input type="reset" value="입력취소"> &nbsp; 
						<a href="/doggybeta/tlist?page=1">[목록]</a>
					</td></tr>
				</table>
				
			</form>
		
		</div>
		  	<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>