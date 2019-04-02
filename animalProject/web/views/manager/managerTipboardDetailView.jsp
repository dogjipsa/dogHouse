<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import='tipboard.model.vo.TipBoard, freeboardreply.model.vo.FreeBoardReply, java.util.ArrayList, manager.model.vo.Manager' %>   
 <%
    int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
 	TipBoard tboard = (TipBoard)request.getAttribute("tboard");
 	Manager managerLogin = (Manager)session.getAttribute("loginmanager");
 %>
<!DOCTYPE html>
<html id='mdetailHtml'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/doggybeta/resources/css/manager/managerBoardDetail.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<% 
	if(managerLogin == null) {
		response.sendRedirect("/doggybeta/views/manager/managerLogin.jsp");
	}
%>
<%@ include file="../../views/common/managerMenu.jsp" %>
<br>
<section>
<div id='mainSet'>
<table id='mdetailtable'>
	<thead>
		<tr>
		<th><h2><%= tboard.getTipBoardTitle() %></h2></th>
		<th>
			<em>no.<%= tboard.getTipBoardNo() %></em>
			</th>
		</tr>
	</thead>
	<tbody>
		<tr>
		<th><p>작성일 <%= tboard.getTipBoardDate() %></p>[글쓴이:<%= tboard.getUserId() %>] 첨부파일
		<% if(tboard.getTipBoardOriginFile() != null) { %>
		<a href='/doggybeta/ffdown?ofile=<%= tboard.getTipBoardOriginFile() %>&rfile=<%= tboard.getTipBoardReFile() %>'><%= tboard.getTipBoardOriginFile() %></a>
		<% } else { %>
			-
		<% } %>
		</th>		
		</tr>
		<tr>
			<td><%= tboard.getTipBoardContent() %></td>
		</tr>
	</tbody>
</table>
</div>
</section>
</body>
</html>