<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<hr style="clear:both;">
<h2 align="center"><%= answer.get%>번 1:1문의 글 답변 수정페이지</h2>
<br>
<form action="/doggybeta/qoriginup" method="post" enctype="multipart/form-data">
<!-- enctype="multipart/form-data" -->
<%-- <input type="hidden" name="no" value="<%= question.getQuestionNo() %>"> --%>
<table align="center" width="650">	
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" value="<%= answer.get %>"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="5" cols="50" name="content"><%= question.getQuestionContent() %></textarea></td>
	</tr>		
	<tr>
		<th colspan="2">
		<button onclick="history.go(-1); return false;">뒤로가기</button>&nbsp;
		<input type="submit" value="수정하기">
		</th>		
	</tr>
</table>
</form>
<br>
</body>
</html>