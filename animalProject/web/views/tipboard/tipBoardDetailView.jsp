<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="tipboard.model.vo.TipBoard, member.model.vo.Member, java.sql.Date" %>
<%
	TipBoard tboard = (TipBoard)request.getAttribute("tboard");
	int currentPage = (Integer)request.getAttribute("currentPage");
	/* Member loginUser = (Member)session.getAttribute("loginUser"); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팁게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
			<!-- 내용작성  -->
			<h2 align="center"><%= tboard.getTipBoardNo() %>번 글 상세조회</h2>
<br>
<table align="center" cellpadding="10" cellspacing="0" border="1" width="500">
<tr>
	<th>제목</th>
	<td><%=tboard.getTipBoardTitle() %></td>
</tr>
<tr>
	<th>작성자</th>
	<td><%=tboard.getUserId() %></td>
</tr>
<tr>
	<th>첨부파일</th>
	<td>
		<% if(tboard.getTipBoardOriginFile() != null){ %>
			<a href="/doggybeta/bfdown?tofile=<%= tboard.getTipBoardOriginFile()%>&trfile=<%= tboard.getTipBoardReFile() %>"><%= tboard.getTipBoardOriginFile() %></a>
		<% }else{ %>
			첨부파일 없음
		<% } %>
	</td>
</tr>
<tr>
	<th>내용</th>
	<td><%=tboard.getTipBoardContent() %></td>
</tr>
<tr>
	<th colspan="2">
	<%-- <% if(loginUser != null && board.getBoardReplyLev() < 2){ %>
		<a href="/first/views/board/boardReplyForm.jsp?bnum=<%=board.getBoardNum()%>&page=<%=currentPage%>">[댓글달기]</a>
		<!-- jsp파일에서 jsp파일로 전송할 수 있음 boardreplyform.jsp에서 getparameter로 값을 꺼냄 -->
	<% } %> --%>
	&nbsp; &nbsp;
	<%-- <% if(loginUser.getUserId().equals(board.getBoardWriter())){ %> --%>
		<a href="/doggybeta/tupview?tnum=<%=tboard.getTipBoardNo()%>&page=<%=currentPage%>">[수정페이지로 이동]</a>
		&nbsp; &nbsp;
		<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="/doggybeta/tdelete?tnum=<%=tboard.getTipBoardNo()%>">[글삭제]</a>
	<%-- <% } %> --%>
	&nbsp; &nbsp;
	<a href="/doggybeta/tlist?page=<%= currentPage%>">[목록]</a>
	</th>
</tr>
</table>
		
		</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>