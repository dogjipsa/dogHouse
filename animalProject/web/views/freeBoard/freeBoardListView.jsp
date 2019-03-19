<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="freeboard.model.vo.FreeBoard, java.util.ArrayList" %>
   <%
   ArrayList<FreeBoard> list = (ArrayList<FreeBoard>)request.getAttribute("list");
   ArrayList<FreeBoard> slist = (ArrayList<FreeBoard>)request.getAttribute("slist"); 
   
//	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
//   FreeBoard fboard = (FreeBoard)(request.getAttribute("fboard"));
/* 	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); */
   
   %>
    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function showWriteForm(){
	location.href = "/doggybeta/views/freeBoard/freeBoardWriteForm.jsp";
}	

</script>
<style>
	th{ 
	background-color : #D09E88;
	}
	#search{ 
	text-align:center;	
	}
</style>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<hr style="clear:both;">
<h2 align="center">자유게시판</h2>
<%-- <h4 align="center">총 게시글 갯수 : <%= listCount %></h4> --%>

<table align="center"  border="0"  width=800 >
<%-- --%>
<tr>
	<th>번호</th><th>제목</th><th>작성자</th><th>날짜</th><th>조회수</th>
</tr>
<% for(FreeBoard f : list){ %>
	<tr>
	<td align="center"><a href="/doggybeta/fdetail?bnum=<%= f.getFreeboardNo() %>"><%= f.getFreeboardTitle() %></a></td>
	<%-- <td align="center"><%= f.getFreeboardNo() %></td> --%>
	<td align="center"><a href="/doggybeta/fdetail?bnum=<%= f.getFreeboardNo() %>"><%= f.getFreeboardTitle() %></a></td>
	<td align="center"><%= f.getUserId() %></td>
	<td align="center"><%= f.getFreeboardDate() %></td>
 	<td align="center"><%= f.getFreeboardViews() %></td>
	<td align="center">
 	<%-- <% if(f.getFreeboardOriginalFile() != null){ %>
		◎
	<% }else{ %>
		&nbsp;
	<% } %> --%>
	</td> 
</tr>
<% }  //for each %> 
</table>
<div style="align:center; text-align:center;">
	<button type="button" style="float:right;" onclick="showWriteForm()";>글쓰기</button></div>	
	
	<%-- 페이지 --%>
	  



	
	
	
	<%-- 검색기능 --%>
<br>
<div id="search">
 <form name="form1" method="post" action="/doggybeta/flist">
  <select name="opt">
  <option value="0" >제목</option>
  <option value="1" >작성자</option>
  <option value="2" >제목+내용</option>
   </select>
 <input type="text" size="20" name="inputdata" />&nbsp;
 <input type="submit" value ="검색"/>
</form>

</div>


<br>

</body>
</html>