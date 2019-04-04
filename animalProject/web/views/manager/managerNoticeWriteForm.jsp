<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert title here</title>
<script type="text/javascript" src="/doggybeta/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js">
</script>
<link href="/doggybeta/resources/css/board.css" rel="stylesheet" type="text/css"></link>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css"></link>
 <style type="text/css">

#fbhtml {
	font-family: 'Sunflower', 'sans-serif';
}

h2{
   position: relative;
   top: 20px;
   left : 150px;
   width: 70%;
   padding: 2rem 0px;
}

.fboard { 
   font-size: 12pt;
   position: relative;
   width: 100%;
   line-height: 1.5;
   align: center;
   margin-left : 300px;
   top: 10px;
  
}


.fboard th{
	width: 70px;
}



#searchT{ 
	text-align:center;	
	}

#wrap{
    background-color: rgba(246, 229, 141,0.5);

}


</style> 
</head>

<body>
<%@ include file="../../views/common/managerMenu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center">공지글 쓰기</h2>

<form action="/doggybeta/mninsert" id="writeform" method="post" enctype="multipart/form-data">
<table class="fboard" width="100%">
<tr><th>제목</th><td><input type="text" name="mntitle" style="width:766px"></td></tr>
<tr><th>작성자</th><td><input type="text" name="mnwriter" style="width:766px" readonly value="관리자"></td></tr>
<tr><th>첨부파일</th><td><input type="file" name="mnupfile"></td></tr>
		<tr><th>내용</th>
		<td><textarea name="ir1" id="ir1" rows="10" cols="100" style="width:766px; height:412px;"></textarea></td></tr>
		<tr><th colspan="2" align="center" id="save" >
		<input type="button" value="등록하기" />
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