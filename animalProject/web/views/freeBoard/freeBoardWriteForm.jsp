<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="boardError.jsp" %>
<%@ page import="member.model.vo.Member" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<hr style="clear:both;">
<h2 align="center">게시글 쓰기</h2>
<form action="/doggybeta/finsert" method="post" enctype="multipart/form-data">
<table align="center">
<tr><td>제목</td><td><input type="text" name="btitle"></td></tr>
<tr><td>작성자</td><td><input type="text" name="bwriter" readonly></td></tr>
<tr><td>첨부파일</td>
<td><input type="file" name="bupfile"></td></tr>
<tr><td>내용</td>
<td><textarea cols="50" rows="7" name="bcontent"></textarea></td></tr>
<tr><td colspan="2" align="center">
	<input type="submit" value="등록하기"> &nbsp; 
	<input type="reset" value="입력취소"> &nbsp; 
	<a href="/doggybeta/blist?page=1">[목록]</a>
</td></tr>
</table>
</form>


</body>
</html>






