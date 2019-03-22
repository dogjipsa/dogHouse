<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="freeboard.model.vo.FreeBoard, java.util.ArrayList" %>
   <%
   ArrayList<FreeBoard> slist = (ArrayList<FreeBoard>)request.getAttribute("slist"); 
   
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
     FreeBoard fboard = (FreeBoard)(request.getAttribute("fboard"));
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
//	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
   
   %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function showWriteForm(){
	location.href = "/doggybeta/views/freeBoard/freeBoardWriteForm.jsp";
}	

</script>
<style type="text/css">
	th{ 
	background-color : #D09E88;
	}
	#searchT{ 
	text-align:center;	
	}
</style>

</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
<h2 align="center">자유게시판</h2>
<%-- <h4 align="center">총 게시글 갯수 : <%= listCount %></h4> --%>
<br><br><br>
<table align="center"  border="0"  width=800 >
<%-- --%>
<tr>
	<th>글번호</th><th>제목</th><th>작성자</th><th>내 용</th><th>날짜</th><th>조회수</th><th>첨부파일</th>
</tr>
<% for(FreeBoard f : slist){ %>
<tr><td align="center"><%= f.getFreeboardNo() %></a></td>
	<% if(loginUser != null){ %>
	<td><a href="/doggybeta/fdetail?fnum=<%= f.getFreeboardNo() %>"><%= f.getFreeboardTitle() %></a></td>
<%-- <a href="/doggybeta/fdetail?fnum=<%= f.getFreeboardNo() %>"><%= f.getFreeboardContent() %></a> --%>
	<% }else{ %>
		<%= f.getFreeboardTitle() %>
	<% } %>	
	<td align="center"><%= f.getUserId() %></td>
	<td align="center"><a href="/doggybeta/fdetail?fnum=<%= f.getFreeboardNo() %>"><%= f.getFreeboardContent() %></a></td>
	<td align="center"><%= f.getFreeboardDate() %></td>
 	<td align="center"><%= f.getFreeboardViews() %></td>
	<td align="center">
	<% if(f.getFreeboardOriginalFile() != null){ %>
		◎
	<% }else{ %>
		
	<% } %>
	</td>
	</tr>
<% } %>
</table>
<div style="align:center; text-align:center;">
	<button type="button" style="float:right;" onclick="showWriteForm()";>글쓰기</button></div>	
	
	<%-- 페이지 --%>
	  



	
	
	
	<%-- 검색기능 --%>
<br>
<div id="searchT">
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

		</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>

<br>

</body>
</html>