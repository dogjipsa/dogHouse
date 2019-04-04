<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="member.model.vo.Member, tipboardreply.model.vo.TipBoardReply" %>
 <%
 	
 	TipBoardReply tipReply = (TipBoardReply)request.getAttribute("tipReply");
 
 %> 
<!DOCTYPE html>
<html id="rtrhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>doggybeta</title>
<style type="text/css">

#rtrhtml {
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

<form action="/doggybeta/rtrinsert" id="writeform" method="post">
<table align="center" width="100%">
<input type="hidden" name="rtrboard" value="<%= tipReply.getTipNo() %>"></input>
<input type="hidden" name="rtrboardreply" value="<%= tipReply.getTipReplyNo() %>"></input>
<tr><td>신고자</td><td><input type="text" style="width:766px" readonly value="<%= loginUser.getUserId()%>"></td></tr>
<tr><td>신고댓글 등록자</td><td><input type="text" name="rtrwriter" style="width:766px" readonly value="<%= tipReply.getUserId()%>"></td></tr>
<tr><td>신고종류</td><td><input type="text" name="rtrcategory" style="width:766px" placeholder="비방/욕설/광고"></td></tr>
<tr><td>게시판 종류</td><td><input type="text" style="width:766px" readonly value="팁게시판 <%= tipReply.getTipNo() %>번 게시글, <%= tipReply.getTipReplyNo() %>번 댓글"></td></tr>

<tr><th>신고내용</th>
<td><textarea name="rfrcontent" id="" rows="10" cols="100" style="width:766px; height:412px;"></textarea></td></tr>
		<tr><th colspan="2" align="center">
		<input type="submit" id="save" value="등록하기" />
		<a href="/doggybeta/tlist">[목록]</a>
		</th>
	</tr>
</table>
</form>
</div>
	

</body>
</html>