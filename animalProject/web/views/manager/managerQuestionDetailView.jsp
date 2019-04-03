<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<%@page import='question.model.vo.Question, java.util.ArrayList' %>   
<%
   /* int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); */
   Question qboard = (Question)request.getAttribute("question");
   int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
   Manager managerLogin = (Manager)session.getAttribute("loginmanager");
   System.out.println("detail Question : "+ qboard);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doghouse</title>
<link href="/doggybeta/resources/css/manager/managerQuestionDetail.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<% 
	if(managerLogin == null) {
		response.sendRedirect("/doggybeta/views/manager/managerLogin.jsp");
	}
%>
<%@ include file="../../views/common/managerMenu.jsp" %>
<br>
<h1 align="center" style="color:white;">해당글 상세보기</h1>
<hr align="center" style="width:600px">
<br><br><br>

<table align="center" cellpadding="10" cellspacing="0" border="1" width="600" bgcolor=oldlace>
	<tr>
		<th>작성자</th>
		<td><%= qboard.getUserId() %></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><%=qboard.getQuestionTitle() %></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><%=qboard.getQuestionContent() %></td>
    </tr>
</table>
<br><br>
<br><br><br><br><br><br><br><br><br><br>
<hr>
<div id="footer"><%@ include file="../common/footer.jsp"%></div>
</body>
</html>