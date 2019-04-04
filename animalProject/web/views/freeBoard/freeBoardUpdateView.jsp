<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeboard.model.vo.FreeBoard" %>  
<%
	FreeBoard freeboard = (FreeBoard)request.getAttribute("freeboard");
//	int currentPage = ((Integer)request.getAttribute("page")).intValue();
%>  
<!DOCTYPE html>
<html id="fbhtml">
<head>
<meta charset="UTF-8">
<title>first</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>

<style type="text/css">

#fbhtml {
	font-family: 'Sunflower', 'sans-serif';
}

h2{
   position: relative;
   top: 20px;
   left : 180px;
   width: 70%;
   padding: 2rem 0px;
}

.fboard { 
   font-size: 12pt;
   position: relative;
   width: 60%;
   top: -50px
   line-height: 1.5;
  
}

.fboard tr{
	line-height : 2em;

}

#searchT{ 
	text-align:center;	
	}

</style>
</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center"><%= freeboard.getFreeboardNo() %>번 자유게시판 게시글 수정페이지</h2>
<br>
<%-- <% if(board.getBoardReplyLev() == 0){ //원글 수정 %> --%>
<form action="/doggybeta/foriginup" id="writeform" name="writeform" method="post" enctype="multipart/form-data">
<%-- <input type="hidden" name="page" value="<%= currentPage %>"> --%>
<input type="hidden" name="fnum" value="<%= freeboard.getFreeboardNo() %>">
<input type="hidden" name="fofile" value="<%= freeboard.getFreeboardOriginalFile() %>">
<input type="hidden" name="frfile" value="<%= freeboard.getFreeboardRefile() %>">
<table class="fboard" align="center">
<tr><th>제목</th><td><input type="text" style="width:766px" id="ftitle" name="ftitle" value="<%= freeboard.getFreeboardTitle() %>"></td></tr>
<tr><th>작성자</th><td><input type="text" style="width:766px" id="fwriter" name="fwriter" readonly value="<%= freeboard.getUserId() %>"></td></tr>
<tr><th>첨부파일</th>
<td><% if(freeboard.getFreeboardOriginalFile() != null){ %>
	<%= freeboard.getFreeboardOriginalFile() %>
<% } %><br>
<input type="file" name="fupfile">
</td>
</tr>
<tr><th>내용</th>
<td><textarea id="ir1" name="ir1" rows="7" cols="50" rows="10" cols="100" style="width:766px; height:412px"><%= freeboard.getFreeboardContent() %></textarea></td></tr>
<tr>
	<th colspan="2" align="center">
	<input type="button" id="save" value="수정하기" />
	<a href="/doggybeta/flist">[목록]</a>
</th></tr>
</table>
</form>

<script type="text/javascript">
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
});


</script>
</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>





