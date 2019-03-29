<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import='freeboard.model.vo.FreeBoard, freeboardreply.model.vo.FreeBoardReply, java.util.ArrayList' %>   
 <%
   int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
 FreeBoard fboard = (FreeBoard)request.getAttribute("fboard");
 ArrayList<FreeBoardReply> replyList = (ArrayList<FreeBoardReply>)request.getAttribute("replyList"); 
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<%@ include file="../../../managerMainPage.jsp" %>
<h1>게시글 상세보기</h1>
<hr style='clear: both;'>
<h3 align='center'><%= fboard.getFreeboardNo() %>번 게시글 상세 보기 페이지</h3>
<br>
<table align='center' cellpadding='10' cellspacing='0' border='1' width='500'>
<!-- <input id='delBtn' type='button' value='삭제'/> -->
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

<%-- 댓글 --%>
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
</table>
</body>
</html>