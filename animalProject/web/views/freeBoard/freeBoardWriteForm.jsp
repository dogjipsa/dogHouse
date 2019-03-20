<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="boardError.jsp" %>
<%@ page import="member.model.vo.Member" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/doggybeta/SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
$(function(){

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "smart", //textarea에서 지정한 name과 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "/doggybeta/SE2/SmartEditor2Skin.html", 
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              }

          fCreator: "createSEditor2"
          
      }); 

	$("#writbtn").click(function(){
		
		oEditors.getElementById["smart"].exec("UPDATE_CONTENTS_FIELD", []);
		
		$("#write_form").submit();
		
	});
});
</script>

</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center">게시글 쓰기</h2>
<br>
<br>
<form action="/doggybeta/finsert" id="write_form" method="post" enctype="multipart/form-data">
<table align="center">
<tr><td>제목</td><td><input type="text" name="btitle"></td></tr>
<tr><td>작성자</td><td><input type="text" name="bwriter" readonly></td></tr>
<tr><td>첨부파일</td>
<td><input type="file" name="bupfile"></td></tr>
<tr><td>내용</td>
<td><textarea name="smart" cols="80" rows="15"></textarea></td></tr>
<tr><td colspan="2" align="center">
	<input type="button" id="writebtn" name="writebtn" value="등록하기"> &nbsp; 
	<input type="reset" value="입력취소"> &nbsp; 
	<a href="/doggybeta/blist?page=1">[목록]</a>
</td></tr>
</table>
</form>
	</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>

</body>


<!-- <script type="text/javascript">
window.onload = function() {
	var btn = document.getElementById("writebtn");
	btn.onclick = function(){
		submitContents(btn);
	}
}
	

</script>

<script type="text/javascript">
function submitContents(elClickedObj){
	oEditors.getById["smart"].exec("UPDATE_CONTENTS_FILED", []);
 
	try {
		elClickedObj.form.submit();
	} catch (e) {
		
	}
	
} -->
</html>






