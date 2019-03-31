<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<%@page 
import='freeboard.model.vo.FreeBoard, java.util.ArrayList, faq.model.vo.Faq,
		tipboard.model.vo.TipBoard' 

%>

<%
	ArrayList<Faq> faqlist = (ArrayList<Faq>)request.getAttribute("faqList");
	
	int listCount = ((Integer)request.getAttribute("listCount"));
	int startPage = ((Integer)request.getAttribute("startPage"));
	int endPage = ((Integer)request.getAttribute("endPage"));
	int currentPage = ((Integer)request.getAttribute("currentPage"));
	int totalPage = ((Integer)request.getAttribute("totalPage"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link href="/doggybeta/resources/css/manager/managerBoardList.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body id='mBoardListBody'>
<%@ include file="../../../managerMainPage.jsp" %>
<section>
<div class="mcontainer">
	<h3>게시판 관리</h3>
	<div id="tab-1" class="row current">
		<table class='t' style="text-align:center; border:1px solid #dddddd"> 
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">선택</th>
					<th style="background-color: #eeeeee; text-align: center;">분류</th>
					<th style="background-color: #eeeeee; text-align: center;">글번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					<th style="background-color: #eeeeee; text-align: center;">삭제여부</th>
				</tr>
			</thead>
			<% for(Faq faq : faqlist) { %>
			<tbody>
				<tr>
					<td class='firstTd'><input type='checkbox'/>삭제</td>
					<td>자유</td>
					<td><%= faq.getFaqNo() %></td>
					<td class='fourthTd'><a href='/doggybeta/manbdetail?bnum=<%= faq.getFaqNo() %>&page=<%= currentPage %>'><%= faq.getFaqTitle() %></a></td>
					<td><%= faq.getManagerId() %></td>
					<td><%= faq.getFaqDate() %></td>
					<td><%= faq.getFaqType() %></td>
				</tr>
			</tbody>
			<% } %> <%-- for each --%>
		</table>
		<%-- 페이징 --%>
		<div style='text-align: center;'>
		<% if(startPage > 1) { %>
			<a href='/doggybeta/manboard?page=1'>[HOME]</a><br>
		<% } else if(startPage == 1) { %>
			[HOME]
		<% } %>
		<% if(currentPage > 1) { %>
			<a href='/doggybeta/manboard?page=<%= currentPage - 1 %>'>[prev]</a>
		<% } 
		   for(int i = startPage; i <= endPage; i ++) {
			   if(i == currentPage) {
		%>
			<b><%= i %></b>
		<% 
			   } else if(currentPage <= listCount && currentPage >= startPage) {
		%>
			
			&nbsp;<a href='/doggybeta/manboard?page=<%= i %>'><%= i %></a> &nbsp;
		<%
			   }
		   } 
		   if(currentPage < totalPage) {
		%>
			<a href='/doggybeta/manboard?page=<%= currentPage + 1 %>'>[NEXT]</a>
		<% 
			} 
		   if(endPage < totalPage) {
		%>
			<a href='/doggybeta/manboard?page=<%= totalPage %>'>[END]</a>
		<% } %>
		</div>
		<a href = "write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		<a href = "#" >전체 삭제</a>
	</div>
</div>
</section>
</body>
</html>