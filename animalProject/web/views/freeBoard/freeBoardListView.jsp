<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="freeboard.model.vo.FreeBoard, java.util.ArrayList"%>
  
   <%
   
   ArrayList<FreeBoard> slist = (ArrayList<FreeBoard>)request.getAttribute("slist"); 
   
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
   
	String opt = null;
	String inputdata = null;
	
		if(request.getAttribute("opt") != null){
			opt = request.getAttribute("opt").toString();
			
			if(request.getAttribute("inputdata") != null){
				inputdata = request.getAttribute("inputdata").toString();	 
			}}
		
   %>
  
<!DOCTYPE html>
<html id='fbhtml'>
<head>
<meta charset="UTF-8">
<title></title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300,500,700&amp;subset=korean" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function showWriteForm(){
	location.href = "/doggybeta/views/freeBoard/freeBoardWriteForm.jsp";
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
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center">자유게시판</h2>
<br><br><br>

<table class="fboard">
	<thead>
         <tr>
            <th align="center" width="50">번호</th>
            <th align="center" width="100">작성자</th>
            <th align="center" width="200">제목</th>
            <th align="center" width="130">작성일</th>
            <th align="center" width="70">조회수</th>
            <th align="center" width="100">첨부파일</th>
            
         </tr>   
   </thead>
<% for(FreeBoard f : slist){ %>
	<tr><td align="center"><%= f.getFreeboardNo() %></td>
		<td align="center"><%= f.getUserId() %></td>
	<% if(loginUser != null){ %>
	<td align="center"><a href="/doggybeta/fdetail?fnum=<%= f.getFreeboardNo() %>"><%= f.getFreeboardTitle() %></a></td>
	<% }else{ %>
	<td align="center"><%= f.getFreeboardTitle() %></td>
	<% } %>	
	<td align="center"><%= f.getFreeboardDate() %></td>
 	<td align="center"><%= f.getFreeboardViews() %></td>
	<td align="center">
	<% if(f.getFreeboardOriginalFile() != null){ %>
		<img src="/doggybeta/resources/images/paw.png" width="20px;" align="center;">
	<% }else{ %>
		&nbsp;
	<% } %>
	</td>
	</tr>
	<% } %>
	</tobody>
	
</table>
<br><br><br><br><br><br>
<%-- 글쓰기 --%>
<% if(loginUser != null){ %>
	<div class="fbutton" style="align:right; text-align:center;">
	<button type="button"  onclick="showWriteForm()";>글쓰기</button>
	</div>
<% } %> 

<%-- 검색기능 --%>
<div class="fsearch" align="center" id="searchT">
 <form name="form1" method="post" action="/doggybeta/flist">
  <select name="opt" id="opt">
  <option value="0" >제목</option>
  <option value="1" >작성자</option>
  <option value="2" >제목 + 내용</option>
   </select>
 <input type="text" size="20" name="inputdata" />&nbsp;
 <input type="submit" value ="검색"/>
</form>
</div>
	
	<%-- 페이지징 처리 --%>
<div class="fpage" style="text-align:center;">
<% if(currentPage <= 1){ %>
	◀◀&nbsp;
<% }else{ %>
	<a href="/doggybeta/flist?page=1">◀◀</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/flist?page=<%= startPage - 1 %>">◀</a>
<% }else{ %>
	◀
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<% if(opt == null){ %>
	<a href="/doggybeta/flist?page=<%= p %>"><%= p %></a>
	<% }else{ %>
	<a href="/doggybeta/flist?opt=<%= opt %>&inputdata=<%= inputdata %>&page=<%= p %>"><%= p %></a>
<% }} %> &nbsp;

<!-- 다음 -->
<% if(endPage < maxPage){ %>
<% if(opt == null){ %>
	<a href="/doggybeta/flist?page=<%= endPage + 1 %>">▶</a>
<% }else{ %>
	<a href="/doggybeta/flist?inputdata=<%= inputdata %>&page=<%= endPage + 1 %>&opt=<%= opt %>">▶</a>&nbsp;
<% } %>
<% }else{ %>
	▶&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	▶▶
<% }else{ %>
<% if(opt == null){ %>
	<a href="/doggybeta/flist?page=<%= maxPage %>">▶▶</a>
<% }else{ %>
	<a href="/doggybeta/flist?inputdata=<%= inputdata %> %>page=<%= maxPage %>&opt=<%= opt %>">▶▶</a>
<%  } %>
<% } %>
</div> 	  
	
		</div>
		
	</div>

<br>

</body>
</html>