<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<%@ page import='manager.model.vo.Manager' %>
<%
	Manager loginManager = (Manager)session.getAttribute("loginmanager"); 
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
<body>
<% if(loginManager == null) { %>
<h1 id='h11'>ADMIN LOGIN</h1>
<div class='inputinfo'>
	<div class='superout'>
		<div class='lncon'>
			<div class='lncon-2'>
			<form action='/doggybeta/dhMLogin' class='lnform'>
				<input type='text' class='inputid-1' name='managerid' required placeholder='ID'/>
				<input type='password' class='inputid-1' name='managerpwd' required placeholder='PASSWORD'/>
				<a href='/doggybeta/dhMLogin'>
				<input type="submit" name="Login" value="Login" class="login-submit" id='btnLogin' /></a><br>
			</form>
			</div>
		</div>
	</div>
</div>
<% 
	} else {
		 response.sendRedirect("/doggybeta/views/manager/managerLogin.jsp");
	}
%>
</body>
</html>