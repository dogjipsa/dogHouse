<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<% String message = (String)request.getAttribute("message"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link href="/doggybeta/resources/css/svErrorStyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<% if(exception != null) { %>
	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h3>:(</h3>
			</div>
			<h2>!!</h2>
			<p><%= exception.getMessage() %></p>
			<a href="/doggybeta/index.jsp">home page</a>
		</div>
	</div>
<% } else { %>
<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h1>:(</h1>
			</div>
			<h2>!!</h2>
			<p><%= message %></p>
			<a href="/doggybeta/index.jsp">home page</a>
		</div>
	</div>
<% } %>
</body>
</html>