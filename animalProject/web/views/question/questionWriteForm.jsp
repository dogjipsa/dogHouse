<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="memberError.jsp" import="member.model.vo.Member" %>
<%@ page import="question.model.vo.*, java.util.*, question.model.vo.Question" %>
<% 	
	ArrayList<Question> list = (ArrayList<Question>)request.getAttribute("list");
%>

 <!DOCTYPE html PUBLIC "-//W3C/DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>doggybeta</title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>

<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css"></link>
</head>
<body background="/doggybeta/resources/images/puppies_1.2.jpg">

<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">

<div align="center">
<br><br>
<h1 align="center" style="color:ghostwhite;">1:1문의 상세정보 입력 </h1>
<hr align="center" style="width:600px">
<br><br>
<form action="/doggybeta/qinsert" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>&nbsp;</td>
			<td align="center" style=color:aquamarine;>제목</td>
			<td><input type="text" name="qtitle" size="65" maxlength="65"></td>
			<td>&nbsp;</td>
		</tr>	
		<tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
	 	<tr>
	 		<td>&nbsp;</td>
			<td align="center" style=color:aquamarine;>아이디</td>
			<td><input type="text" name="quserid" size="10" maxlength="60" value="<%= loginUser.getUserId() %>" readonly></td>
			<td>&nbsp;</td>		
		</tr>  
		<tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
		<tr>
			<td>&nbsp;</td>
			<td align="center" style=color:aquamarine;>첨부파일</td>
			<td><input type="file" size="60" maxlength="60" name="qupfile"></td>
			<td>&nbsp;</td>
		</tr>
		<tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
		<tr>
			<td>&nbsp;</td>
			<td align="center" style=color:aquamarine;>내용</td>
			<td><textarea cols="70" rows="13" name="qcontent"></textarea></td>
			<td>&nbsp;</td>
		</tr>	
	<tr align="right">
		<td>&nbsp;</td>
		<th colspan="2">
		 <input type="button" value="뒤로가기" onclick="history.go(-1)">
		 <input type="submit" value="전송하기" onclick="alert('등록되었습니다')">&nbsp; 	 
		</th>
	
		<td>&nbsp;</td>
	</tr>	
	</table>
</div>
</form>
<br>
</div></div>


</body>
</html>