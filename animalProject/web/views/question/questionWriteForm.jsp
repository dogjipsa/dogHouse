<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="questionError.jsp" import="member.model.vo.Member" %>
<%@ page import="question.model.vo.*, java.util.*, question.model.vo.Question" %>
<% 	
	ArrayList<Question> list = (ArrayList<Question>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">

<h2 align="center">1:1 문의 상세정보 입력</h2>
<hr style="clear:both;">
<h3>문의 정보</h3>
<br>
<form action="/doggybeta/qinsert" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<th>제목</th>
		<td><input type="text" name="qtitle" size="60"></td>
	</tr>	
 	<tr>
		<th>아이디</th>
		<td><input type="text" name="quserid" value="<%= loginUser.getUserId() %>" readonly></td>
	</tr>  
	<tr>
		<th>첨부파일</th>
		<td><input type="file" name="qupfile"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="5" cols="50" name="qcontent"></textarea></td>
	</tr>
	<<!-- tr>
		<th>내용</th>
		<td><textarea name="ir1" id="ir1" rows="10" cols="100" style="width:766px; height:412px;"></textarea></td>
	</tr> -->
<tr>
	<th colspan="2">
	 <input type="button" value="뒤로가기" onclick="history.go(-1)">
	 <input type="submit" value="전송하기" onclick="alert('등록되었습니다')">&nbsp; 	 
	</th>
</tr>	
</table>
</form>

<!-- <script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "ir1", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "/doggybeta/SE2/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,      
              bSkipXssFilter : true,
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["ir1"].exec("PASTE_HTML",[""]);
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#save").click(function(){
          oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#writeform").submit();
      });    
}); -->


</script>

<br>

</div></div>

<div id="footer"><%@ include file="../common/footer.jsp"%></div>

</body>

</html>