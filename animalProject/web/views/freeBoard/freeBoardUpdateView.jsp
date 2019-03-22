<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="freeboard.model.vo.FreeBoard" %>  
<%
	FreeBoard freeboard = (FreeBoard)request.getAttribute("freeboard");
//	int currentPage = ((Integer)request.getAttribute("page")).intValue();
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<script type="text/javascript" src="/doggybeta/SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>

<style type="text/css">
table{
	position: relative;
	left: 400px;
	border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;
}
h2{
	position: relative;
	left: 700px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;

}

</style>
</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="right"><%= freeboard.getFreeboardNo() %>번 게시글 수정페이지</h2>
<br>
<%-- <% if(board.getBoardReplyLev() == 0){ //원글 수정 %> --%>
<form action="/doggybeta/foriginup" method="post" enctype="multipart/form-data">
<%-- <input type="hidden" name="page" value="<%= currentPage %>"> --%>
<input type="hidden" name="fnum" value="<%= freeboard.getFreeboardNo() %>">
<input type="hidden" name="fofile" value="<%= freeboard.getFreeboardOriginalFile() %>">
<input type="hidden" name="frfile" value="<%= freeboard.getFreeboardRefile() %>">
<table align="right">
<tr><th>제목</th><td><input type="text" style="width:766px" name="ftitle" value="<%= freeboard.getFreeboardTitle() %>"></td></tr>
<tr><th>작성자</th><td><input type="text" style="width:766px" name="fwriter" readonly value="<%= freeboard.getUserId() %>"></td></tr>
<tr><th>첨부파일</th>
<td><% if(freeboard.getFreeboardOriginalFile() != null){ %>
	<%= freeboard.getFreeboardOriginalFile() %>
<% } %><br>
<input type="file" name="fupfile">
</td>
</tr>
<tr><th>내용</th>
<td><textarea id="ir1" rows="7" cols="50" name="fcontent" rows="10" cols="100" style="width:766px; height:412px"><%= freeboard.getFreeboardContent() %></textarea></td></tr>
<tr>
	<th colspan="2" align="center">
	<input type="button" onclick="submitContents(this);" value="수정하기" />
	<a href="/doggybeta/flist">[목록]</a>
</th></tr>
</table>
</form>
<%-- <% }else{ //댓글 수정 %>
<form action="/first/breplyup" method="post">
<input type="hidden" name="page" value="<%= currentPage %>">
<input type="hidden" name="bnum" value="<%= board.getBoardNum() %>">
<table align="center">
<tr><th>제목</th><td><input type="text" name="btitle" value="<%= board.getBoardTitle() %>"></td></tr>
<tr><th>작성자</th><td><input type="text" name="bwriter" readonly value="<%= board.getBoardWriter() %>"></td></tr>
<tr><th>내용</th>
<td><textarea rows="7" cols="50" name="bcontent"><%= board.getBoardContent() %></textarea></td></tr>
<tr><th colspan="2">
	<input type="submit" value="수정하기"> &nbsp;
	<a href="/first/blist?page=<%= currentPage %>">[목록]</a>
</th></tr>
</table></form> 
<% } %>--%>
<script type="text/javascript">
var oEditors = [];

var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR

// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "/doggybeta/SE2/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		},
		I18N_LOCALE : sLang
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["ir1"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	
	try {
		elClickedObj.form.submit();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>
<hr>
</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>





