<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, freeboard.model.vo.FreeBoard, java.sql.Date, freeboardreply.model.vo.FreeBoardReply" %>
<%
	FreeBoard freeboard = (FreeBoard)request.getAttribute("freeboard");
//	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	FreeBoardReply reply = (FreeBoardReply)request.getAttribute("reply");
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"></script>
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
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
		  
<%-- 상세보기  --%>		  
<h2><%= freeboard.getFreeboardNo() %>번 게시글 상세보기</h2>
<br>
<table id="t" align="right" cellpadding="10" cellspacing="0" border="1" width="800">
<tr>
	<th>제목</th>
	<td align="center"><%= freeboard.getFreeboardTitle() %></td>
</tr>
<tr>
	<th>작성자</th>
	<td align="center"><%= freeboard.getUserId() %></td>
</tr>
<tr>
	<th>첨부파일</th>
	<td align="center">
	 		<% if(freeboard.getFreeboardOriginalFile() != null){ %>
			<a href="/doggybeta/ffdown?ofile=<%= freeboard.getFreeboardOriginalFile() %>&rfile=<%= freeboard.getFreeboardRefile() %>"><%= freeboard.getFreeboardOriginalFile()%></a>
		<% }else{ %>
			첨부파일없음
		<% } %> 
	</td>
</tr> 
<tr>
	<th>내용</th>
	<td align="center"><%= freeboard.getFreeboardContent() %></td>
</tr>
<tr>
	<th colspan="2" align="center">
<% if(loginUser.getUserId().equals(freeboard.getUserId())){ %> 
		<a href="/doggybeta/fupview?fnum=<%= freeboard.getFreeboardNo() %>">[수정페이지로 이동]</a> 
		&nbsp; &nbsp;
		<a href="/doggybeta/fdelete?fnum=<%= freeboard.getFreeboardNo() %>">[글삭제]</a>
	 <% } %> 
	&nbsp; &nbsp;
	 <a href="/doggybeta/flist">[목록]</a> 
	</th>	
</tr>

</table>

<%-- 댓글 보이기 --%>
<table>
<!-- 	<tr><th>댓글번호</th><td><textarea cols="3" rows="3" name="frnum" style="width:766px"></textarea></td></tr> -->
	<% if(reply != null){ %>
	<tr><th>작성자</th><td><input type="text" name="fwriter" style="width:100px" readonly value="<%= loginUser.getUserId() %>"></td></tr>
	<tr><th>내용</th><td><textarea cols="50" rows="4" name="fcontent" style="width:766px"><%= reply.getFreereplycontent() %></textarea></td></tr>
	<% } %>
</table>

<%-- 댓글등록 --%>
<table>
<% if(loginUser != null){ %>
	<hr>
	<form action="/doggybeta/freply" method="post">		
		<input type="hidden" name="fnum" value="<%= freeboard.getFreeboardNo() %>">
		<input type="hidden" name="page" value="">
		<table align="center">
<!-- 	<tr><th>제목</th><td><input type="text" name="btitle" style="width:766px"></td></tr> -->
	<tr><th>작성자</th><td><input type="text" name="fwriter" style="width:766px" readonly value="<%= loginUser.getUserId() %>"></td></tr>
	<tr><th>내용</th><td><textarea cols="50" rows="4" name="fcontent" style="width:766px"></textarea></td></tr>
	<tr><th colspan="2" align="center">
	<input type="submit" value="댓글등록"> &nbsp; 
	<a href="/doggybeta/flist">[목록]</a>
	</th></tr>
</table>
</form>
<% } %>
	
</table>
</div>
<hr>


		<div id="footer" align="right">
			<%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>	





