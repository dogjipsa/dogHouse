<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<% String message = (String)request.getAttribute("message"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
</head>
<body>
<% if(exception != null) { %>
JSP예외발생 : <%= exception.getMessage() %> <br>
<% } else { %>
서블릿이 전달한 메세지 : <%= message %>    <br>
<% } %>
</body>
</html>