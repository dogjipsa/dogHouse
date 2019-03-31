<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="questionError.jsp" %>
<%@ page import="member.model.vo.Member, question.model.vo.Question, java.util.ArrayList" %>
<%
	ArrayList<Question> list = (ArrayList<Question>)request.getAttribute("list");
	
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	function showWriteForm(){
		location.href = "/doggtbeta/views/question/questionWtiteForm.jsp";
	}
	
	$(function(){
		showDiv();
		
		$("input[name=item]").on("change", function(){
			showDiv();
		});
	});
</script>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">
	<h2 align="center">나의 문의내역</h2>
	<hr style="clear:both;">
<br>
<table align="center" width="700" cellspacing="1" border="3">
	<tr>
		<!-- <th>번호</th> -->
		<th>제목</th>	
		<th>날짜</th>
		<th>답변유무</th>			
	</tr>
<% 
	for(Question question : list){
%>
	<tr>		
		<td><% if(question.getQuestionReplyLev() == 1){ %>
				&nbsp; &nbsp;
			<% }else if(question.getQuestionReplyLev() == 2){ %>
				&nbsp; &nbsp; &nbsp; &nbsp;
			<% } %>
			
			<% if(loginUser != null){ %>
				<a href="/doggybeta/qdetail?no=<%= question.getQuestionNo() %>"><%= question.getQuestionTitle() %></a>
			<% }else{ %>
				<%= question.getQuestionTitle() %>
			<% } %></td>
		<td align="center"><%= question.getQuestionDate() %></td>
		<td align="center"><%= question.getQuestionReplyYn() %></td>
	</tr>
</div></div>
<% } %>
</table>
<br>
<div style="text-align:center;">
<% if(currentPage <= 1){ %>
	[맨처음] &nbsp;
<% }else{ %>
	<a href="/doggybeta/qlist?page=1">[맨처음]</a> &nbsp;
<% } %>
<% for(int p = startPage; p <= endPage; p++){
		if(p == currentPage){
%>
	<font color="cyan" size="4"><b>[<%= p %>]</b></font>
	<a href="/dogybeta/qlist?page=<%= p %>"><%= p %></a>
<% }} %>
<% if(currentPage >= maxPage){ %>
	[맨끝]
<% }else{ %>
	<a href="/doggybeta/qlist?page=<%= maxPage %>">[맨끝]</a>
<% } %>
</div>			
<%-- <div id="footer"><%@ include file="../common/footer.jsp"%></div> --%>
</body>
</html>