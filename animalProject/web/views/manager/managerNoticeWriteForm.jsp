<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/doggybeta/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js">
</script>
<link href="/doggybeta/resources/css/board.css" rel="stylesheet" type="text/css"></link>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css"></link>
</head>
<body>
<%@ include file="../../views/common/managerMenu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center">공지글 쓰기</h2>

<form action="/doggybeta/mninsert" id="writeform" method="post" enctype="multipart/form-data">
<table class="fboard" align="center" width="100%">
<tr><td>제목</td><td><input type="text" name="mntitle" style="width:766px"></td></tr>
<tr><td>작성자</td><td><input type="text" name="mnwriter" style="width:766px" readonly value="관리자"></td></tr>
<tr><td>첨부파일</td><td><input type="file" name="mnupfile"></td></tr>
		<tr><th>내용</th>
		<td><textarea name="ir1" id="ir1" rows="10" cols="100" style="width:766px; height:412px;"></textarea></td></tr>
		<tr><th colspan="2" align="center">
		<input type="button" id="save" value="등록하기" />
		<a href="/doggybeta/mannotice">[목록]</a>
		</th>
	</tr>
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