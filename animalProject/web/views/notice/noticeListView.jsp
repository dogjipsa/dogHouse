<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="notice.model.vo.Notice, java.util.*, member.model.vo.Member" errorPage='noticeError.jsp'%>
<%
   ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("nlist");
	
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 

	String opt = null;
	String search = null;

	if(request.getAttribute("opt") != null){
		opt = request.getAttribute("opt").toString();
		
		if(request.getAttribute("search") != null){
			search = request.getAttribute("search").toString();	 
		}}

%>  
<html id="fbhtml">
<head>
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300,500,700&amp;subset=korean" rel="stylesheet" type="text/css">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function showWriteForm(){
   location.href="/doggybeta/views/notice/noticeWriteForm.jsp"
}

</script>
<style type="text/css">

#fbhtml {
	font-family: 'Sunflower', 'sans-serif';
}
	
	#searchT{ 
	text-align:center;	
	}
	
	.icon-left-open 
	{ *zoom: expression( this.runtimeStyle['zoom'] = '1',
	 this.innerHTML = '&#xe800;&nbsp;'); }
	 
h2{
   position: relative;
   top: 20px;
   left : 0px;
   width: 70%;
   padding: 2rem 0px;
}
.fboard { 
font-size: 15pt;
   position: relative;
   left : 150px;
   width: 60%;
   top: -50px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed;   
}

.fboard tr{
	line-height : 2em;

}

.fboard thead th{ 
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;}


.fboard tbody tr:hover{
	background-color : #f3f6f7;
}

.fboard tbody td a{
	text-decoration: none;
	color: black;
}

.fsearch{
   position: relative;
   left : 100px;
   width: 60%;
   top: -150px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed;  
}

.fpage{
	position: relative;
   left : 100px;
   width: 60%;
   top: -150px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed; 
}

.fbutton{
   position: relative;
   left : 650px;
   width: 60%;
   top: -150px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed;  

}

#wrap{
	left: 200px;
	margin: 0 auto;
}
	 
	 
</style>
</head>

<body>
<%@ include file="../common/menu.jsp"%>
	<div id="wrap">
		  <div id="content">

<h2 align="center">공지사항 게시판</h2>
<br><br><br>
<!-- 테이블 시작 -->
   <table class="fboard">
      <thead>
         <tr>
            <th width="50">번호</th>
            <th width="200">제목</th>
            <th width="100">작성자</th>
            <th width="130">작성일</th>
            <th width="70">조회수</th>
            <th width="100">첨부파일</th>
            
         </tr>   
      </thead>
      <tbody>      
       <%   for(Notice notice : list){ %>
   <tr>
   <td><%= notice.getNoticeNo() %></td>
   
   <td>
   <%if(loginUser != null){ %>
   <a href="/doggybeta/ndetail?no=<%= notice.getNoticeNo()%>"><%= notice.getNoticeTitle() %></a>
   <% }else{ %>
   <%= notice.getNoticeTitle() %>
   <% } %>
   </td>
   <td><%= notice.getManagerId() %></td>
   <td><%= notice.getNoticeDate() %></td>
   <td>&nbsp;&nbsp;&nbsp;<%= notice.getNoticeViews() %></td>
   <td>&nbsp;&nbsp;&nbsp;
   <%if(notice.getNoticeOriginFile() != null) {%>
   <img src="/doggybeta/resources/images/paw.png" width="20px;" align="center;">
   <% }else{ %>
   &nbsp;
   <%} %>
   </td>
   </tr>   
   <% } %>     
   </tbody>   
</table>
<br> <br><br><br><br><br><br>        
<!-- 테이블 종료 -->

<div class="fsearch" align="center" id="searchT">
 <form action="/doggybeta/nlist" method="post" name="form1">
	<select name="opt"> <!-- 검색 컬럼 -->
		<option value="0">제목만</option>
		<option value="1">제목 + 내용</option>
	</select>
	<input type="text" size="20" name="search">
	<input type="submit" value="검색">
	
</form>
</div>


	<%-- 페이지징 처리 --%>
<div class="fpage"  style=" align:center; text-align:center;">
<% if(currentPage <= 1){ %>
	◀◀&nbsp;
<% }else{ %>
	<a href="/doggybeta/nlist?page=1">◀◀</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/nlist?page=<%= startPage - 1 %>">◀</a>
<% }else{ %>
	◀
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<% if(opt == null){ %>
	<a href="/doggybeta/nlist?page=<%= p %>"><%= p %></a>
	<% }else{ %>
	<a href="/doggybeta/nlist?opt=<%= opt %>&serach=<%= search%>&page=<%= p %>"><%= p %></a>
<% }} %> &nbsp;

<!-- 다음 -->
<% if(endPage < maxPage){ %>
<% if(opt == null){ %>
	<a href="/doggybeta/nlist?page=<%= endPage + 1 %>">▶</a>
<% }else{ %>
	<a href="/doggybeta/nlist?isearch=<%= search %>&search=<%= endPage + 1 %>&opt=<%= opt %>">▶</a>&nbsp;
<% } %>
<% }else{ %>
	▶&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	▶▶
<% }else{ %>
<% if(opt == null){ %>
	<a href="/doggybeta/nlist?page=<%= maxPage %>">▶▶</a>
<% }else{ %>
	<a href="/doggybeta/nlist?search=<%= search %> %>page=<%= maxPage %>&opt=<%= opt %>">▶▶</a>
<%  } %>
<% } %>
</div> 	  


</div>
		
</div>
</body>
</html>