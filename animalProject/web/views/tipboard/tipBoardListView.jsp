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
		System.out.print(search);
		System.out.print(keyword);
	}
	
		//}
	/* Member loginUsers = (Member) session.getAttribute("loginUser"); */
%>
<!DOCTYPE html>
<html>
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
	$(function() {
		showDiv();
		$("input[name=item]").on("change", function() {
			showDiv();
		});
	});
	function showDiv() {
		if ($("input[name=item]").eq(0).is(":checked")) {
			$("#titleDiv").css("display", "block");
			$("#writerDiv").css("display", "none");
			$("#dateDiv").css("display", "none");
		}
		if ($("input[name=item]").eq(1).is(":checked")) {
			$("#titleDiv").css("display", "none");
			$("#writerDiv").css("display", "block");
			$("#dateDiv").css("display", "none");
		}
		if ($("input[name=item]").eq(2).is(":checked")) {
			$("#titleDiv").css("display", "none");
			$("#writerDiv").css("display", "none");
			$("#dateDiv").css("display", "block");
		}
	}
</script>
</head>
<body>
	<%@ include file="..//common/menu.jsp"%>


	<div id="wrap">
		<div id="content">
			<!-- 내용작성  -->

			<h2 align="center">게시글 목록</h2>
			<h4 align="center">
				총 게시글 갯수 :
				<%=listCount%></h4>
			<%
				if (loginUser != null) {
			%>
			<div style="align: center; text-align: center;">
				<button onclick="showWriteForm();">글쓰기</button>
			</div>
			<%
				}
			%>
			<br>
			<%-- 검색기능 --%>
			
			<br>
			<table align="center" border="1" cellspacing="0" width="700">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
					<th>첨부파일</th>
				</tr>
				<%
					for (TipBoard t : list) {
				%>
				<tr>
					<td align="center"><%=t.getTipBoardNo()%></td>
					<td><!-- 로그인 상태일 때만 상세보기 링크 설정함 --> <%
						if (loginUser != null) { 
					%> <a href="/doggybeta/tdetail?tnum=<%=t.getTipBoardNo()%>&page=<%=currentPage%>"><%=t.getTipBoardTitle()%></a>
						<%	} else {
						%> <%=t.getTipBoardTitle()%> <%
 						}%> 
					</td>
					<td align="center"><%=t.getUserId()%></td>
					<td align="center"><%=t.getTipBoardDate()%></td>
					<td align="center"><%=t.getTipBoardViews()%></td>
					<td align="center">
						<%
							if (t.getTipBoardOriginFile() != null) {
						%> ◎ <%
							} else {
						%> &nbsp; <%
							 }
						 %>
					</td>
				</tr>
				<%
					} //for each
				%>
			</table>
			<br>
			<%-- 페이징 처리  search가 null일 때 처리를 잘 못해서 모든 a태그 링크에 search가 null일 때와 null이 아닐 때 조건이 들어감--%>
			<div style="text-align: center;">
				<%
					if (currentPage <= 1) {
				%>
				[맨처음]&nbsp;
				<%
					} else {  
						%>
							<%-- <a href="/doggybeta/tlist?page=<%=1%>">[맨처음]</a>&nbsp; --%>
						<%-- <a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=1%>&option=<%=search%>">[prev]</a> --%>
						<%		if(search == null){//검색 조건을 유지한 채 [맨처음] 페이징 처리
								%>
								<a href="/doggybeta/tlist?page=<%=1%>">[맨처음]</a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=1%>&option=<%=search%>">[맨처음]</a>
								<%} %>
				<%	}%>
				
				<%
					if ((currentPage - 10) <= startPage && (currentPage - 10) >= 1) {//조건식에 =을 붙여줘야 11,21,31....페이지 일 때 링크가 뜸
						%>
						<%-- <a href="/doggybeta/tlist?page=<%=startPage - 1%>">[prev]</a> --%>
						<%-- <a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=startPage - 10%>&option=<%=search%>">[prev]</a> --%>
						<%		if(search == null){//이전 페이지는 1x페이지 일때 10페이지로 이동, 2x페이지일 때 20페이지로 이동
								%>
								<a href="/doggybeta/tlist?page=<%=startPage - 1%>">[prev]</a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=startPage - 1%>&option=<%=search%>">[prev]</a>
								<%} %>
					
				<%
					} else {
				%>
				[prev]
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
								System.out.println("뷰에서 keyword확인 : " + keyword);
								System.out.println("뷰에서 search 확인 : " + search);
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
					if ((currentPage + 10) > endPage /* && (currentPage + 10) < maxPage */) {
				%>
				<%-- <a href="/doggybeta/tlist?page=<%=endPage + 1%>">[next]</a>&nbsp; --%>
				<%		if(search == null){
								%>
								<a href="/doggybeta/tlist?page=<%=endPage + 1%>">[next]</a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=endPage + 1%>&option=<%=search%>">[next]</a>
								<%} %>
				
				<%
					} else {
				%>
				[next]&nbsp;
				<%
					}
				%>
				<%
					if (currentPage >= maxPage) {
				%>
				[맨끝]
				<%
					} else {
				%>
				<%-- <a href="/doggybeta/tlist?page=<%=maxPage%>">[맨끝]</a> --%>
					<%if(search == null){ %>
								<a href="/doggybeta/tlist?page=<%=maxPage%>">[맨끝]</a>
								<% }else{ %>
								<a href="/doggybeta/tlist?word=<%=keyword%>&page=<%=maxPage%>&option=<%=search%>">[맨끝]</a>
								<%} %>
				<%
					}
				%>

			</div>
			<br>
			<div id="searchForm" style="text-align:center;">
				<form method="post" action="/doggybeta/tlist">
					<select name="option">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="title_content">제목+내용</option>
						<option value="writer">글쓴이</option>
					</select>
					<input type="text" size="20" name="word">
					<input type="submit" value="검색">
				</form>
				<!-- <div>
					<h2>검색할 항목을 선택하시오.</h2>
					<input type="radio" name="item" value="title" checked> 제목
					&nbsp; &nbsp; &nbsp; <input type="radio" name="item" value="writer">
					작성자 &nbsp; &nbsp; &nbsp; <input type="radio" name="item"
						value="date"> 날짜
				</div>
				<div id="titleDiv">
					<form action="/first/tsearcht" method="post">
						<label>검색할 제목을 입력하시오 : <input type="text" name="keyword"></label>
						<input type="submit" value="검색">
					</form>
				</div>
				<div id="writerDiv">
					<form action="/doggybeta/tsearchw" method="post">
						<label>검색할 작성자 아이디를 입력하시오 : <input type="text"
							name="keyword"></label> <input type="submit" value="검색">
					</form>
				</div>
				<div id="dateDiv">
					<form action="/doggybeta/tsearchd" method="post">
						<label>검색할 날짜를 선택하시오 : <input type="date" name="begin">
							~ <input type="date" name="end"></label> <input type="submit"
							value="검색">
					</form>
				</div> -->
			</center>
			<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
		</div>
</body>
</html>






