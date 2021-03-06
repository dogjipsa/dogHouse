<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="faq.model.vo.Faq, java.util.*" errorPage='faqError.jsp'%>
<%
   ArrayList<Faq> list = (ArrayList<Faq>)request.getAttribute("list");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	
	String search = null, keyword = null;

	if(request.getAttribute("search") != null){
		search = request.getAttribute("search").toString();	
		keyword = request.getAttribute("keyword").toString();
	}

%>  
<html>
<head>
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon-32x32.png">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script type="text/javascript">
function showWriteForm(){
   location.href="/doggybeta/views/faq/faqWriteForm.jsp"
}
$(function(){
	$(".plusIcon").on("click",function(){
		  var obj = $(this);
		  if( obj.hasClass("glyphicon-plus") ){
		    obj.hide();
		    obj.next().show();            
		    obj.parent().parent().next().show();
		  }else{
		     obj.hide();
		     obj.prev().show();
		     obj.parent().parent().next().hide();
		  }
		});
});
</script>
<style type="text/css">
body{
	font-family: 'Sunflower', 'sans-serif';
}

#search{ 
	text-align:center;	
	}
	
h1{
   position: relative;
   top: 20px;
   left : 0px;
   width: 70%;
   padding: 2rem 0px;
}
.board { 
  position: relative;
   left : 150px;
   width: 60%;
   top: -50px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed;
   font-size: 15pt;   
}
.board tr{
	line-height : 2em;

}

/* list_table 에서 사용되는 thead */
.board thead th{ 
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;}

.button{
   position: relative;
   left : 650px;
   width: 60%;
   top: -150px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed;   
}



/* list_table 에서 사용되는 tbody * /
.board tbody td { 
	width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;  
}

#faqpage{
	position: relative;
   left : 100px;
   width: 60%;
   top: -150px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed;
}

.search{
position: relative;
   left : 100px;
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

<h1 align="center">FAQ</h1>
<br><br><br>
<!-- 테이블 시작 -->
   <table class="board">
      <thead>
         <tr>
            <th width="50">구분</th>
            <th width="200">제목</th>
         </tr>   
      </thead>
      <tbody>
   <% for(Faq faq : list){ %>      
   <tr>
   <td><%= faq.getFaqType()%></td>
   <td>
   <%if(loginUser != null){ %>
   <span class="glyphicon glyphicon-plus plusIcon"></span>
   <span class="glyphicon glyphicon-minus plusIcon" style="display:none"></span><%= faq.getFaqTitle() %></td>
   </tr>
   <tr style="display:none" >
   <td colspan="2" align="left" style="word-break:break-all;">   
   <%= faq.getFaqContent() %>
   <br>
   <br>
   <br>
   <%if(loginUser.getUserId() != null){ %>
   <button onclick="location.href='/doggybeta/faqupview?fnum=<%= faq.getFaqNo()%>&page=<%= currentPage%>'">수정</button>
   &nbsp;
   <button onclick="location.href='/doggybeta/faqdel?fnum=<%= faq.getFaqNo()%>'">삭제</button>
   <%}}else{ %>
   <%= faq.getFaqTitle() %>
   <%} %>
   
   </td>
   </tr>    
      
   </tbody>   
   <% } %>
</table>
<br><br><br><br><br><br>   
<!-- 테이블 종료 -->

<div class="search" align="center" id="search">
	<form action="/doggybeta/faqsearch" method="post">
	<input type="hidden" name="search" value="title">
	<label style="background-color : "><input type="text" name="keyword"></label>
	<input type="submit" value="검색">
	<% if(loginUser != null){ %>
	<input type="button" onclick="showWriteForm();" value="글쓰기">
<%} %>
	</form>
	

</div>



<%-- 페이징 처리 --%>
<br><br><br>
<br><br><br>
<div id="faqPage" style="text-align:center;">
<% if(currentPage <= 1){ %>
	[맨처음]&nbsp;
<% }else{ %>
	<a href="/doggybeta/faqlist?page=1">[맨처음]</a>&nbsp;
<% } %>
<% if((currentPage - 10) < startPage && (currentPage - 10) > 1){ %>
	<a href="/doggybeta/faqlist?page=<%= startPage - 10 %>">[prev]</a>
<% }else{ %>
	[prev]
<% } %>
<%-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 --%>
<% for(int p = startPage; p <= endPage; p++){ 
		if(p == currentPage){
%>
	<font color="red" size="4"><b>[<%= p %>]</b></font>
	<% }else{ 
		if(search != null && search.equals("title")){%>
		<a href="/doggybeta/fsearchtkeyword=<%= keyword %>&page=<%= p %>"><%= p %></a>		
		<%}%>
	<a href="/doggybeta/faqlist?page=<%= p %>"><%= p %></a>
<% }} %>&nbsp;
<% if((currentPage + 10) > endPage && (currentPage + 10) < maxPage){ %>
	<a href="/doggybeta/faqlist?page=<%= endPage + 10 %>">[next]</a>&nbsp;
<% }else{ %>
	[next]&nbsp;
<% } %>
<% if(currentPage >= maxPage){ %>
	[맨끝]
<% }else{ %>
	<a href="/doggybeta/faqlist?page=<%= maxPage %>">[맨끝]</a>
<% } %>
</div>
</div>

</div>
		
</div>
</body>
</html>