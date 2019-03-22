<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="freeBoardError.jsp" %>
<%@ page import="member.model.vo.Member" %>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>doggybeta</title>
<script type="text/javascript" src="/doggybeta/SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js">




</script>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css"></link>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center">게시글 쓰기</h2>

<form action="/doggybeta/finsert" id="writeform" method="post" enctype="multipart/form-data">
<table align="center" width="100%">
<tr><td>제목</td><td><input type="text" name="ftitle" style="width:766px"></td></tr>
<tr><td>작성자</td><td><input type="text" name="fwriter" style="width:766px" readonly></td></tr>
<tr><td>첨부파일</td><td><input type="file" name="fupfile"></td></tr>
	<tr>
		<td></td>
		<td><textarea name="ir1" id="ir1" rows="10" cols="100" style="width:766px; height:412px;"></textarea></td>
		<td colspan="2" align="left">
		<input type="button" onclick="submitContents(this);" value="서버로 내용 전송" />
		
		</td>
	</tr>
</table>
</form>
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


	</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>

</body>
</html>






