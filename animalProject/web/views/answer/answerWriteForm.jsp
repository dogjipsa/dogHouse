<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="questionError.jsp" import="member.model.vo.Member" %>
<%@ page import="answer.model.vo.*, java.util.*, answer.model.vo.Answer" %>
<% 	
	ArrayList<Answer> list = (ArrayList<Answer>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">

<h2 align="center">1:1 문의 답변 입력</h2>
<hr style="clear:both;">
<h3>답변 정보</h3>
<br>
<form action="/doggybeta/qinsert" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<th>제목</th>
		<td><input type="text" name="anstitle" size="60"></td>
	</tr>	 	
	<tr>
		<th>내용</th>
		<td><textarea rows="5" cols="50" name="anscontent"></textarea></td>
	</tr>
<tr><th colspan="2">
	 <input type="button" value="뒤로가기" onclick="history.go(-1)">
	 <input type="submit" value="전송하기" onclick="alert('등록되었습니다')">&nbsp; 
	 
</th></tr>	
</table>
</form>
<br>

</div></div>

<div id="footer"><%@ include file="../common/footer.jsp"%></div>
</body>
</html>