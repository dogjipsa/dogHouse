<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="notice.model.vo.Notice, java.sql.Date, java.util.*"%>
    
<%

			Notice notice = (Notice)request.getAttribute("notice");

%>
<!DOCTYPE html>
<html  id='nhtml'>
<head>
<meta charset="UTF-8">
<title>notice</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300,500,700&amp;subset=korean" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"></script>
</head>
<style type="text/css">

#fbhtml {
	font-family: 'Sunflower', 'sans-serif';
	font-size: 13pt;
}

h2{
	position: relative;
	left: 600px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;

}
#t11 {
	resize: none;
}


.fdtable{
	position: relative;
	left: 220px;
	border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    width : 900px;
    margin: 20px 10px;
}


.fdtable th{
	background:#f3f6f7;
	width: 100px;
	padding: 7px 13px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
	
}
.fdtable td {   
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
.buttons{
	position: relative;
	left: 700px;
	
	
}

</style> 
<body>
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">

<%-- 상세보기  --%>	
<h2><%= notice.getNoticeNo() %>번 게시글 상세보기</h2>
<br>
<table class="fdtable" id="t" align="center"  width="800">
<tr>
	<th>제목</th>
	<td><%= notice.getNoticeTitle() %></td>
</tr>

<tr>
	<th>작성자</th>
	<td><%= notice.getManagerId() %></td>
</tr>
<tr>
	<th>첨부파일</th>
	<td>
	 		<% if(notice.getNoticeOriginFile() != null){ %>
			<a href="/doggybeta/mndown?nofile=<%= notice.getNoticeOriginFile() %>&nrfile=<%= notice.getNoticeReFile() %>"><%= notice.getNoticeOriginFile()%></a>
			
		<% }else{ %>
			첨부파일없음
		<% } %> 
	</td> 
</tr> 
<tr>
	<th>내용</th>
	<td><%= notice.getNoticeContent() %></td>
</tr>
<tr>
	<th colspan="2" align="center">
<% if(loginUser.getUserId().equals(notice.getManagerId())){ %> 
		<a href="/doggybeta/nupview?nnum=<%= notice.getNoticeNo() %>">[수정페이지로 이동]</a> 
		&nbsp; &nbsp;
		<a href="/doggybeta/ndelete?nnum=<%= notice.getNoticeNo() %>">[글삭제]</a>
	 <% } %>  
	&nbsp; &nbsp;
	 <a href="/doggybeta/mannNotice">[목록]</a> 
	</th>	
</tr>
</table>

</body>
</html>