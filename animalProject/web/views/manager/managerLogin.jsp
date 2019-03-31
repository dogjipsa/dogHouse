<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<%@ page import='manager.model.vo.Manager' %>
<%

%>
<!DOCTYPE html>
<html id='loginPageCss'>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link rel="stylesheet" href="/doggybeta/resources/css/manager/managerLoginPage.css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
</script>
</head>
<h1>로그인페이지</h1>
<body>
<div>
<form action='/doggybeta/dhMLogin'>
아이디 : <input type='text' name='managerid' required placeholder='ID'/>
비밀번호 : <input type='password' name='managerpwd' required placeholder='PASSWORD'/>
	<a href='/doggybeta/dhMLogin'>
	<input type="submit" name="Login" value="Login" class="login-submit" id='btnLogin' /></a><br>
</form>
</div>
</body>
</html>