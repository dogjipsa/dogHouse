<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage='true'%>
<%
String message = (String)request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link href="/doggybeta/resources/css/svErrorStyle.css" rel="stylesheet" type="text/css">
</head>
<body id='erbody'>
<% if(exception != null) { %>
	<div class="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h1>:(</h1>
			</div>
			<h2>회원서비스에 문제가 발생하였습니다</h2>
			<p>error</p>
			<%-- <p><%= exception.getMessage() %></p> --%>
			<a href="/doggybeta/index.jsp">홈으로</a>
		</div>
	</div>
<% } else { %>
<div class="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h1>:(</h1>
			</div>
			<h2>회원서비스에 문제가 발생하였습니다</h2>
			<p>error</p>
			<%-- <p><%= message %></p> --%>
			<a href="/doggybeta/index.jsp">홈으로</a>
		</div>
	</div>
<% } %>
</body>
</html>