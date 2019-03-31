<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%@ include file="../../../managerMainPage.jsp" %>
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
<%-- <table align='center' cellpadding='10' cellspacing='0' border='1' width='500'>
<!-- <input id='delBtn' type='button' value='삭제'/> -->
<tr>
	<td><%= fboard.getFreeboardNo() %>번글</td>
	<td><%= fboard.getFreeboardDate() %></td>	
</tr>
<tr>
	<th>제목</th>
	<td><%= fboard.getFreeboardTitle() %></td>	
</tr>
<tr>
	<th>작성자</th>
	<td><%= fboard.getUserId() %></td>	
</tr>
<tr>
	<th>첨부파일</th>
	<td>
		<% if(fboard.getFreeboardOriginalFile() != null) { %>
		<a href='/doggybeta/ffdown?ofile=<%= fboard.getFreeboardOriginalFile() %>&rfile=<%= fboard.getFreeboardRefile() %>'><%= fboard.getFreeboardOriginalFile() %></a>
		<% } else { %>
			-
		<% } %>
	</td>	
</tr>
<tr>
	<th>내용</th>
	<td><%= fboard.getFreeboardContent() %></td>
	<th>
	</th>	
</tr>

댓글
<tr>
<div id="comment">
	<table border="1" bordercolor="lightgray">	
		
	<% if(replyList != null){ //댓글이 있을 때 %>
		<% for(FreeBoardReply f : replyList){ %>
			<tr>
				<!-- 아이디, 작성날짜 -->
				<td width="150">
					<div>
						<%=f.getUserid() %><br>					
						<font size="2" color="lightgray"><%= f.getFreereplydate() %></font>
						<br>
					<div id="frnum">				
						<font size="2" color="lightgray"><%= f.getFreereply() %></font>
					</div>
					</div>
				</td>			
				<!-- 본문내용 -->
				<td width="550">
					<div class="text_wrapper">
						<%=f.getFreereplycontent() %>
					</div>
				</td>
			</tr>
			<%}//댓글 리스트 조회 for each 문 끝 %>
		<%}//if문 끝 %>
		</table> 
		</div>
</tr>
</table> --%>
</body>
</html>