<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage='questionError.jsp'%>
<%@ page import="member.model.vo.Member" %>
<%
	int questionNo = Integer.parseInt(request.getParameter("qno"));
	int currentPage = Integer.parseInt(request.getParameter("page"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doghouse</title>
</head>
<body>
<hr style="clear:both;">
<h2 align="center"><%= questionNo %>번 문의글 댓글달기</h2>
<form action="/doggybeta/qreply" method="post">
<input type="hidden" name="qno" value="<%= questionNo %>">
<input type="hidden" name="page" value="<%= currentPage %>">
<table align="center">
<tr><th>제목</th><td><input type="text" name="qtitle"></td></tr>
<tr><th>작성자</th><td><input type="text" name="qwriter" readonly></td></tr>
<tr><th>내용</th><td><textarea cols="50" rows="5" name="qcontent"></textarea></td></tr>
<tr><th colspan="2">
	<input type="submit" value="댓글등록"> &nbsp;
	<a href="javascript:history.go(-1)">[이전 페이지로 이동]</a>
	<a href="/doggybeta/qlist?page=<%= currentPage %>">[목록]</a>
</th></tr>	
</table>
</form>
<hr>
</body>
</html>