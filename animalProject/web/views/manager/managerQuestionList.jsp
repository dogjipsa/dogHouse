<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="questionError.jsp" %>
<%@ page import="member.model.vo.Member, question.model.vo.Question, answer.model.vo.Answer, java.util.ArrayList" %>
<%
	ArrayList<Question> list = (ArrayList<Question>)request.getAttribute("list");	
	
	Answer answer = (Answer)request.getAttribute("answer");

	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
%>	    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doghouse</title>
<link href="/doggybeta/resources/css/manager/managerQuestionList.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<%@ include file="../../../managerMainPage.jsp" %>
<h1 align="center" style="color:white;">유저 문의내역  답변 시스템</h1>
<hr style="width:600px">
<br>
<div align="center">
	<table style="text-align:center; border:1px; solid #dddddd">
		<thead>
		<tr>
			<th style="background-color:#eeeee; text-align:center; color:white;">제목</th>
			<th style="background-color:#eeeee; text-align:center; color:white;">날짜 </th>
			<th style="background-color:#eeeee; text-align:center; color:white;">답변유무</th>		
		</tr>
		</thead>
<% 
	for(Question question : list){
%>
<input type="hidden" name="qnum" id="qnum" value="<%= question.getQuestionNo() %>"> 
	<tr>
		<td align="left"><a href="/doggybeta/qdetail?no=<%= question.getQuestionNo() %>"><%= question.getQuestionTitle() %></a>
		<td align="center"><%= question.getQuestionDate() %>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td align="center"> <%-- <% if(answer.getAnswerContent() != null){ %>
									답변완료
								<% }else{ %>
									답변대기중..
								<% } %> - --%>
							<%= question.getQuestionReplyYn() %>
								</td>
	</tr>
	<% } %>
</table>	
</div>
<br>
<%-- 페이징 처리 --%>
<div style="text-align:center;">
	<% if(currentPage <= 1){ %>
		[처음]&nbsp;&nbsp;
	<% }else{ %>
		<a href="/doggybeta/mansquestion?page=1">[처음]</a>&nbsp;
	<% } %>
	<% if((currentPage - 10) < startPage && (currentPage - 10) > 1){ %>
		<a href="/doggybeta/mansquestion?page=<%= startPage - 10 %>">[이전]</a>
	<% }else{ %>
		[이전]
	<% } %>
	<% for(int p = startPage; p <= endPage; p++){ 
			if(p == currentPage){
	%>
		<font color="grey" size="4"><b>[<%= p %>]</b></font>
		<% }else{ %>
		<a href="/doggybeta/mansquestion?page=<%= p %>"><%= p %></a>
	<% }} %>&nbsp;&nbsp;
	<% if((currentPage + 10) > endPage && (currentPage + 10) < maxPage){ %>
		<a href="/doggybeta/mansquestion?page=<%= endPage + 10 %>">[다음]</a>&nbsp;
	<% }else{ %>
		[다음]&nbsp;
	<% } %>
	<% if(currentPage >= maxPage){ %>
		[마지막]
	<% }else{ %>
		<a href="/doggybeta/mansquestion?page=<%= maxPage %>">[마지막]</a>
	<% } %>
</div>	
</body>
</html>