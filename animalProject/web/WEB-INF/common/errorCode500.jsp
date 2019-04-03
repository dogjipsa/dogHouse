<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage='true' %>
<%
response.setStatus(200);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link rel="stylesheet" href="/doggybeta/resources/css/error404.css">
</head>
<body>
<div class="overlay"></div>
<div class="terminal">
  <h1>Error <span class="errorcode">페이지를 표시할 수 없습니다. </span></h1>
  <p class="output">
    서비스 이용에 불편을 끼쳐드려서 대단히 죄송합니다. 요청하신 서비스가 정상처리 되지 않았습니다. <br>
   이용자분들께 보다 나은 서비스를 제공할 수 있도록 최선을 다하겠습니다.</ü>
  <p class="output">로그인 화면으로 돌아가기 <a href="/doggybeta/index.jsp">링크 1</a> or <a href="../doggybeta/index.jsp">링크 2</a></p>
  <br>
  <p class="output">기타 문의 사항은 dogjipsa@kh.org 로 문의해주시기 바랍니다.</p>
</div>
</body>
</html>