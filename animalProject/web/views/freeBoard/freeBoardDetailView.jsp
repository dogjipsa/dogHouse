<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, freeboard.model.vo.FreeBoard, java.sql.Date" %>
<%
	FreeBoard freeboard = (FreeBoard)request.getAttribute("freeboard");
//	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	
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
	left: 530px;
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
		  
<h2><%= freeboard.getFreeboardNo() %>번 게시글 상세보기</h2>
<br>
<table id="t" align="right" cellpadding="10" cellspacing="0" border="1" width="500">
<tr>
	<th>제목</th>
	<td><%= freeboard.getFreeboardTitle() %></td>
</tr>
<tr>
	<th>작성자</th>
	<td><%= freeboard.getUserId() %></td>
</tr>
<tr>
	<th>첨부파일</th>
	<td>
< 		<% if(freeboard.getFreeboardOriginalFile() != null){ %>
			<a href="/doggybeta/ffdown?ofile=<%= freeboard.getFreeboardOriginalFile() %>&rfile=<%= freeboard.getFreeboardRefile() %>"><%= freeboard.getFreeboardOriginalFile()%></a>
		<% }else{ %>
			첨부파일없음
		<% } %> 
	</td>
</tr> 
<tr>
	<th>내용</th>
	<td><%= freeboard.getFreeboardContent() %></td>
</tr>
<tr>
	 <th colspan="2">
	<%-- <<% if(loginUser != null){ %>
		<a href="/doggybeta/views/freeboard/freeBoardReplyForm.jsp?fnum=<%= freeboard.getFreeboardNo() %>">[댓글달기]</a>
	<% } %>
	&nbsp; &nbsp;  --%> 
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

</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>	





