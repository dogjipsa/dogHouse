<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="memberError.jsp"%>
 <%@ page import="member.model.vo.Member, freeboard.model.vo.FreeBoard" %>
 <%
 	
 	FreeBoard freeboard = (FreeBoard)request.getAttribute("freeboard");
 
 %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="rfhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>doggybeta</title>
<style type="text/css">

#rfhtml {
	font-family: 'Sunflower', 'sans-serif';
	font-size: 13pt;
}

.h2{
	position: relative;
	left: 220px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;

}
</style> 


<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css"></link>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 class="h2">신고게시글 쓰기</h2>

<form action="/doggybeta/rfinsert" id="writeform" method="post">
<table align="center" width="100%">
<!-- <tr><td>신고번호</td><td><input type="text" name="ftitle" style="width:766px"></td></tr> -->
<tr><td>신고자</td><td><input type="text" style="width:766px" readonly value="<%= loginUser.getUserId()%>"></td></tr>
<tr><td>신고게시물 등록자</td><td><input type="text" name="rfwriter" style="width:766px" readonly value="<%= freeboard.getUserId() %>"></td></tr>
<tr><td>신고종류</td><td><input type="text" name="rfcategory" style="width:766px" placeholder="비방/욕설/광고"></td></tr>
<tr><td>게시판 종류</td><td><input type="text" style="width:766px" readonly value="자유게시판 <%= freeboard.getFreeboardNo() %>번 게시글"></td></tr>
<input type="hidden" name="rfboard" value="<%= freeboard.getFreeboardNo() %>"></input>
<tr><th>신고내용</th>
<td><textarea name="rfcontent" id="" rows="10" cols="100" style="width:766px; height:412px;"></textarea></td></tr>
		<tr><th colspan="2" align="center">
		<input type="submit" id="save" value="등록하기" />
		<a href="/doggybeta/flist">[목록]</a>
		</th>
	</tr>
</table>
</form>
</div>

<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>