<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, freeboard.model.vo.FreeBoard, freeboardreply.model.vo.FreeBoardReply" %>    
<%
//	int freeBoardNo = Integer.parseInt(request.getParameter("fnum"));
//	int currentPage = Integer.parseInt(request.getParameter("page"));
	FreeBoardReply freeReply = (FreeBoardReply)request.getAttribute("freeReply");
	
	/* 
	Member loginUser = (Member)session.getAttribute("loginUser"); */
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon-32x32.png">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"></script>
<style type="text/css">
.table{
	position: relative;
	left: 400px;
	border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;
}
h2{
	position: relative;
	left: 700px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;

}

</style>
</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">

<%-- <input type="hidden" name="page" value="<%= currentPage %>"> --%>
<form action ="/doggybeta/freplyup" method="post">
<input type="hidden" name="fnum" value="<%= freeReply.getFreeboardno() %>">
<input type="hidden" name="frnum" value="<%= freeReply.getFreereply() %>">
<table class="table" align="center">
<tr><th>작성자</th><td><input type="text" id="frwriter" name="frwriter" style="width:766px" readonly value="<%= freeReply.getUserid() %>"></td></tr>
	<tr><th>내용</th><td><textarea cols="50" rows="4" id="frcontent" name="frcontent" style="width:766px"><%= freeReply.getFreereplycontent() %></textarea></td></tr>
<tr><th colspan="2">
<div align="center">
	<input type="submit" value="수정하기"> &nbsp;
	<a href="/doggybeta/fdetail">[목록]</a>
</div>
</th></tr>
</table>
</form>

</div>
</body>
</html>





