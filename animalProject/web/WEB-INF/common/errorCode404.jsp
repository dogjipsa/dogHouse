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
  <h1>Error <span class="errorcode">404</span></h1>
  <p class="output">PAGE NOT FOUND</ü>
  <p class="output">이 페이지를 찾을 수 없습니다.<br> 
   찾으시려는 페이지의 이름이 변경되었거나  혹은 일시적으로 사용하실 수 없습니다.
    입력하신 페이지 주소가 정확한 지 다시 한 번 확인해주시기 바랍니다.</ü>
  <p class="output">로그인 화면으로 돌아가기 <a href="/doggybeta/index.jsp">링크 1</a> 또는 <a href="../doggybeta/index.jsp">링크 2</a></p>
  <br>
  <p class="output">기타 문의 사항은 dogjipsa@kh.or 로 문의해주시기 바랍니다.</p>
</div>
</body>
</html>