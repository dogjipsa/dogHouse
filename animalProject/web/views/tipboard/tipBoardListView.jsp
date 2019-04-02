<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="member.model.vo.Member, tipboard.model.vo.TipBoard, java.util.ArrayList"%>

<%
	ArrayList<TipBoard> list = (ArrayList<TipBoard>) request.getAttribute("list");
	int listCount = ((Integer) request.getAttribute("listCount")).intValue();
	int startPage = ((Integer) request.getAttribute("startPage")).intValue();
	int endPage = ((Integer) request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer) request.getAttribute("currentPage")).intValue();
	//String search = null, keyword = null;
	//java.sql.Date begin = null, end = null;
	String search = null;
	String keyword = null;
	if (request.getAttribute("search") != null) {
		search = request.getAttribute("search").toString();
		/* if (search.equals("date")) {
			begin = (java.sql.Date) request.getAttribute("begin");
			end = (java.sql.Date) request.getAttribute("end");
		} else { */
		keyword = request.getAttribute("keyword").toString();
	}
	
		//}
	/* Member loginUsers = (Member) session.getAttribute("loginUser"); */
%>
<!DOCTYPE html>
<html id ='tbhtml'>
<head>
<meta charset="UTF-8">
<title>팁게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	function showWriteForm() {
		location.href = "/doggybeta/views/tipboard/tipBoardWriteForm.jsp";
	}
</script>
<style type="text/css">

#tbhtml {
	font-family: 'Sunflower', 'sans-serif';
	font-size: 15pt;
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
.tboard { 
   position: relative;
   left : 150px;
   width: 60%;
   top: -50px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed;   
}

.tboard tr{
	line-height : 2em;

}

.tboard thead th{ 
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;}


.tboard tbody tr:hover{
	background-color : #f3f6f7;
}

.board tbody td a{
	text-decoration: none;
	color: black;
}

.tsearch{
   position: relative;
   left : 100px;
   width: 60%;
   top: 0px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed;  
}

.tpage{
	position: relative;
   left : 100px;
   width: 60%;
   top: 0px;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed; 
}

.tbutton{
   position: relative;
   left : 650px;
   width: 60%;
   top: 0px;
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
	<%@ include file="..//common/menu.jsp"%>
	<div id="wrap">
		<div id="content">
			<!-- 내용작성  -->

			<h2 align="center">게시글 목록</h2>
			<a href="/doggybeta/sitterdetail">디테일로 고고</a>
			<h4 align="center">
				총 게시글 갯수 :<%=listCount%></h4>
			
			<br>
			<%-- 검색기능 --%>
			
			<br>
			<table class="tboard">
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
				<%
					for (TipBoard t : list) {
				%>
				<tr>
					<td align="center"><%=t.getTipBoardNo()%></td>
					<td align="center"><%=t.getUserId() %></td>
					<%	if (loginUser != null) { %> 
					<td align="center"><a href="/doggybeta/tdetail?tnum=<%=t.getTipBoardNo()%>&page=<%=currentPage%>"><%=t.getTipBoardTitle()%></a>
						<%	} else{ %> 
						<%=t.getTipBoardTitle() %> 
						<% } %> 
					</td>
					<td align="center"><%=t.getTipBoardDate()%></td>
					<td align="center"><%=t.getTipBoardViews()%></td>
					<td align="center">
						<%
							if (t.getTipBoardOriginFile() != null) {%> 
							<img src="/doggybeta/resources/images/paw.png" width="20px;" align="center;">
					    <% } else {
						%> &nbsp; <%
							 }
						 %>
					</td>
				</tr>
				<%
					} //for each
				%>
			</table>
			
			
			<%	if (loginUser != null) {  %>
			<div class="button" style="align:right; text-align: center;">
				<button onclick="showWriteForm();">글쓰기</button>
			</div>
			<%	}  %>
			
			
			
			<br>
			<%-- 페이징 처리  search가 null일 때 처리를 잘 못해서 모든 a태그 링크에 search가 null일 때와 null이 아닐 때 조건이 들어감--%>
			<div class="tpage" style="text-align: center;">
				<%
					if (currentPage <= 1) {
				%>
				◀◀&nbsp;
				<%
					} else {  
						%>
							<%-- <a href="/doggybeta/tlist?page=<%=1%>">[맨처음]</a>&nbsp; --%>
						<%-- <a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=1%>&option=<%=search%>">[prev]</a> --%>
						<%		if(search == null){//검색 조건을 유지한 채 [맨처음] 페이징 처리
								%>
								<a href="/doggybeta/tlist?page=<%=1%>">◀◀</a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=1%>&option=<%=search%>">◀◀</a>
								<%} %>
				<%	}%>
				
				<%
					if ((currentPage - 10) <= startPage && (currentPage - 10) >= 1) {//조건식에 =을 붙여줘야 11,21,31....페이지 일 때 링크가 뜸
						%>
						<%-- <a href="/doggybeta/tlist?page=<%=startPage - 1%>">[prev]</a> --%>
						<%-- <a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=startPage - 10%>&option=<%=search%>">[prev]</a> --%>
						<%		if(search == null){//이전 페이지는 1x페이지 일때 10페이지로 이동, 2x페이지일 때 20페이지로 이동
								%>
								<a href="/doggybeta/tlist?page=<%=startPage - 1%>">◀</a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=startPage - 1%>&option=<%=search%>">◀</a>
								<%} %>
					
				<%
					} else {
				%>
				◀
				<%
					}
				%>
				<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
					<%
					for (int p = startPage; p <= endPage; p++) {
						if (p == currentPage) {	%>
							<font color="red" size="4"><b>[<%=p%>]
							</b></font>
							<%
						} else {//페이지 이동 시 옵션과 키워드를 유지한 채 페이징 처리
							/* if (search != null && search.equals("title")) { */
								
								if(search == null){
								%>
								<a href="/doggybeta/tlist?page=<%=p%>"><%=p%></a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=p%>&option=<%=search%>"><%=p%></a>
								<%} %>
								
						<%}
					}
				%>&nbsp;
				<%
					if (endPage < maxPage) {
				%>
				<%-- <a href="/doggybeta/tlist?page=<%=endPage + 1%>">[next]</a>&nbsp; --%>
				<%		if(search == null){
								%>
								<a href="/doggybeta/tlist?page=<%=endPage + 1%>">▶</a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=endPage + 1%>&option=<%=search%>">▶</a>
								<%} %>
				
				<%
					} else {
				%>
				▶&nbsp;
				<%
					}
				%>
				<%
					if (currentPage >= maxPage) {
				%>
				▶▶
				<%
					} else {
				%>
				<%-- <a href="/doggybeta/tlist?page=<%=maxPage%>">[맨끝]</a> --%>
					<%if(search == null){ %>
								<a href="/doggybeta/tlist?page=<%=maxPage%>">▶▶</a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=maxPage%>&option=<%=search%>">▶▶</a>
								<%} %>
				<%
					}
				%>

			</div>
			<br>
			<div class="tsearch" id="searchForm" style="text-align:center;">
				<form method="post" action="/doggybeta/tlist">
					<select name="option" id="option">
						<%--페이지 넘어갈 시 검색한 내용에 대한 option selected 처리
						차후 c:if로 처리 가능 --%>
						<%if(search==null){ //option이 null일 때 처리(처리 안하면 nullpointException발생)%>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="title_content">제목+내용</option>
						<option value="writer">글쓴이</option>
						<%}else{ %>
						<option value="title">제목</option>
						<%if(search.equals("content")){ %>
						<option value="content" selected>내용</option>
						<%}else{ %>
						<option value="content">내용</option>
						<%} %>
						<%if(search.equals("title_content")){ %>
						<option value="title_content" selected>제목+내용</option>
						<%}else{ %>
						<option value="title_content">제목+내용</option>
						<%} %>
						<%if(search.equals("writer")){ %>
						<option value="writer" selected>글쓴이</option>
						<%}else{ %>
						<option value="writer">글쓴이</option>
						<%} %>
						<%} %>						
					</select>
					<%-- 검색한 keyword를 페이지 이동해도 input에 남김 --%>
					<%if(keyword==null){ %>
					<input type="text" size="20" name="word" value="">
					<%} else{%>
					<input type="text" size="20" name="word" value="<%=keyword%>">
					<%} %>
					<input type="submit" value="검색">
				</form>
				</div>
				</div>
			
			<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
		</div>
</body>
</html>






