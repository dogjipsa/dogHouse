<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
 <%@page import='freeboard.model.vo.FreeBoard, freeboardreply.model.vo.FreeBoardReply, java.util.ArrayList' %>   
 <%
   int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
 FreeBoard fboard = (FreeBoard)request.getAttribute("fboard");
 ArrayList<FreeBoardReply> replyList = (ArrayList<FreeBoardReply>)request.getAttribute("replyList"); 
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
<%@ include file="../../views/common/managerMenu.jsp" %>
<br>
<section>
<div id='mainSet'>
<table id='mdetailtable'>
	<thead>
		<tr>
		<th><h2><%= fboard.getFreeboardTitle() %></h2></th>
		<th>
			<em>no.<%= fboard.getFreeboardNo() %></em>
			</th>
		</tr>
	</thead>
	<tbody>
		<tr>
		<th><p>작성일 <%= fboard.getFreeboardDate() %></p>[글쓴이:<%= fboard.getUserId() %>] 첨부파일
		<% if(fboard.getFreeboardOriginalFile() != null) { %>
		<a href='/doggybeta/ffdown?ofile=<%= fboard.getFreeboardOriginalFile() %>&rfile=<%= fboard.getFreeboardRefile() %>'><%= fboard.getFreeboardOriginalFile() %></a>
		<% } else { %>
			-
		<% } %>
		</th>		
		</tr>
		<tr>
			<td><%= fboard.getFreeboardContent() %></td>
		</tr>
	</tbody>
</table>
</div>
</section>
</body>
</html>