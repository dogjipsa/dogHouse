<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member" %>


<!DOCTYPE html>
<html id="fbhtml">
<head>
<meta charset="UTF-8">
<title>팁게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script> 
<script type="text/javascript" src="/doggybeta/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "smarteditor", //textarea에서 지정한 id와 일치해야 합니다. 
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
              oEditors.getById["smarteditor"].exec("PASTE_HTML",[""]);
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#savebutton").click(function(){
          oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });    
});

</script>
<style type="text/css">

#fbhtml {
	font-family: 'Sunflower', 'sans-serif';
}

h2{
   position: relative;
   top: 20px;
   left : 300px;
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
<h2 align="center">팁게시판 게시글쓰기</h2>
	<div id="wrap">
		  <div id="content">
			<form action="/doggybeta/tinsert" method="post" enctype="multipart/form-data" id="frm">
				<table class="fboard" align="center">
					<tr><td>제목</td><td><input type="text" name="ttitle" style="width:766px"></td></tr>
					<tr><td>작성자</td><td><input type="text" name="twriter" style="width:766px" readonly value="<%=loginUser.getUserId()%>"></td></tr>
					<tr><td>첨부파일</td>
					<td><input type="file" name="tupfile"></td></tr>
					<tr><td>내용</td>
					<!-- <td><textarea cols="50" rows="7" name="tcontent"></textarea></td></tr> -->
					<td>
					<textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width:766px; height:412px;"> </textarea>
					</td></tr>
					<tr><td colspan="2" align="center">
						<input type="submit" value="등록하기" id="savebutton"> &nbsp; 
						<a href="/doggybeta/tlist?page=1">[목록]</a>
					</td></tr>
				</table>
				
			</form>
		
		</div>
		  	<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>