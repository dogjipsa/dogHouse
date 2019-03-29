<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="tipboard.model.vo.TipBoard, member.model.vo.Member, java.sql.Date" %>
<%@ page import="tipboardreply.model.vo.TipBoardReply" %>
<%@ page import="java.util.ArrayList" %>
<%
	TipBoard tboard = (TipBoard)request.getAttribute("tboard");
	System.out.println((Integer)request.getAttribute("currentPage"));
	int currentPage = (Integer)request.getAttribute("currentPage"); 
	TipBoardReply trboard = (TipBoardReply)request.getAttribute("trboard");
	ArrayList<TipBoardReply> replyList = (ArrayList<TipBoardReply>)request.getAttribute("replyList");
	int listCount = ((Integer) request.getAttribute("listCount")).intValue();
	int startPage = ((Integer) request.getAttribute("startPage")).intValue();
	int endPage = ((Integer) request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
	int trcurrentPage = ((Integer) request.getAttribute("trcurrentPage")).intValue();
 	System.out.println("리스트카운트 : "+listCount);
	System.out.println("스타트페이지 : "+startPage);
	System.out.println("endPage : "+endPage);
	System.out.println("maxPage : "+maxPage);
	System.out.println("trcurrnetPage : "+trcurrentPage);
	System.out.println(tboard);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팁게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">



<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
/* 댓글작성 ajax 부분   */
 
/* $(function(){
	$.ajax({
		url: "/doggybeta/trinsert",
		data: {no : $("#no").val() },
		type: "get",
		dataType: "json",
		success: function(data){
			$("#p4").html($("#p4").text() + "<br>" +data.no + ", " + data.userid + ", " + data.userpwd + ", " + decodeURIComponent(data.username) + ", " + data.age + ", " + data.email + ", " + data.phone);
		}
	});
}); */

			
 function writeCmt()
{
	<%-- var tnum = <%((TipBoard)request.getAttribute("tboard")).getTipBoardNo();%>;
	var trpage = <%((Integer) request.getAttribute("endPage")).intValue();%>; --%>
	var tnum = '<%=((TipBoard)request.getAttribute("tboard")).getTipBoardNo()%>';
	var trpage = '<%=request.getAttribute("endPage")%>';
		
	if(!("#tipReply_content").val())
	{
		alert("내용을 입력하세요.");
		return false;
	}
	else
	{	
		$(function(){
			$.ajax({
				url: "/doggybeta/trinsert",
				data: {tipBoard_no : $("#tipBoard_no").val() ,
					   tipReply_id : $("#tipReply_id").val(),
					   tipReply_content : $("#tipReply_content").val()},
				type: "post"
				
			});
			document.location.reload(); 
			location.href="/doggybeta/tdetail?tnum="+tnum+"&trpage="+trpage;			
		});
	}
} 

 function checkFunc(){
	if(httpRequest.readyState == 4){
		// 결과값을 가져온다.
		var resultText = httpRequest.responseText;
		if(resultText == 1){ 
			document.location.reload(); // 상세보기 창 새로고침
		}
	}
}   
 
</script>

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


.ttable{
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


.ttable th{
	background:#f3f6f7;
	width: 100px;
	padding: 7px 13px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
	
}
.ttable td {   
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
.buttons{
	position: relative;
	left: 700px;
	
	
}

</style>

</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
			<!-- 내용작성  -->
			
			<h2 align="center"><%= tboard.getTipBoardNo() %>번 글 상세조회</h2>
			
<br>
<table class="ttable" align="center" cellpadding="10" cellspacing="0" border="1" width="500">
<tr>
	<th>제목</th>
	<td><%=tboard.getTipBoardTitle() %></td>
</tr>
<tr>
	<th>작성자</th>
	<td><%=tboard.getUserId() %></td>
</tr>
<tr>
	<th>첨부파일</th>
	<td>
		<% if(tboard.getTipBoardOriginFile() != null){ %>
			<a href="/doggybeta/tfdown?tofile=<%= tboard.getTipBoardOriginFile()%>&trfile=<%= tboard.getTipBoardReFile() %>"><%= tboard.getTipBoardOriginFile() %></a>
		<% }else{ %>
			첨부파일 없음
		<% } %>
	</td>
</tr>
<tr>
	<th>내용</th>
	<td><%=tboard.getTipBoardContent() %></td>
</tr>
<tr>
	<th colspan="2">
	<%-- <% if(loginUser != null && board.getBoardReplyLev() < 2){ %>
		<a href="/first/views/board/boardReplyForm.jsp?bnum=<%=board.getBoardNum()%>&page=<%=currentPage%>">[댓글달기]</a>
		<!-- jsp파일에서 jsp파일로 전송할 수 있음 boardreplyform.jsp에서 getparameter로 값을 꺼냄 -->
	<% } %> --%>
	&nbsp; &nbsp;
	<% if(loginUser.getUserId().equals(tboard.getUserId())){ %>
		<a href="/doggybeta/tupview?tnum=<%=tboard.getTipBoardNo()%>&page=<%=currentPage%>">[수정페이지로 이동]</a>
		&nbsp; &nbsp;
		<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="/doggybeta/tdelete?tnum=<%=tboard.getTipBoardNo()%>">[글삭제]</a>
	<% } %>
	&nbsp; &nbsp;
	<a href="/doggybeta/tlist?page=<%= currentPage%>">[목록]</a>
	</th>
</tr>
<tr>
<td colspan="2">
<hr>
</td>
</tr>
</table>

<!-- 댓글 부분 -->
	<div id="comment">
		
		<table class="ttable" border="1" bordercolor="lightgray">
		
	<!-- 댓글 목록 -->	
		
	<% if(replyList != null){ //댓글이 있을 때 %>
		<% for(TipBoardReply t : replyList){ %>
			<tr>
				<!-- 아이디, 작성날짜 -->
				<td width="150">
					<div>
						<%=t.getUserId() %><br>					
						<font size="2" color="lightgray"><%= t.getTipReplyDate() %><%-- ${comment.comment_date} --%></font>
					</div>
				</td>
				<!-- 본문내용 -->
				<td width="550">
					<div class="text_wrapper">
						<%-- ${comment.comment_content} --%>
						<%=t.getTipReplyContent() %>
					</div>
				</td>
				<!-- 버튼 -->
				<td width="100">
					<!-- 댓글 작성자만 수정, 삭제 가능하도록 -->	
					<div>
					<%if(loginUser.getUserId().equals(t.getUserId())){ %>
						<a href="/doggybeta/trsearch?trnum=<%= t.getTipReplyNo() %>">[수정]</a><br>	
						<a href="/doggybeta/trdelete?trnum=<%= t.getTipReplyNo() %>&tnum=<%= t.getTipNo()%>">[삭제]</a>
					
					<%} %>
					
					</div>
				</td>
			</tr>
			<%}//댓글 리스트 조회 for each 문 끝 %>
		<%}//if문 끝 %>
		
	
			
			<!-- 로그인 했을 경우만 댓글 작성가능 -->
			<% if(loginUser != null){ //로그인 시 댓글 작성 가능%>
			<tr bgcolor="#F5F5F5">
				<input type="hidden" name="tipBoard_no" id="tipBoard_no" value="<%=tboard.getTipBoardNo() %><%-- ${board.board_num} --%>">
				<input type="hidden" name="tipReply_id" id="tipReply_id" value="<%=loginUser.getUserId() %><%-- ${sessionScope.sessionID} --%>">
				<!-- 아이디-->
				<td width="150">
					<div>
						<%-- ${sessionScope.sessionID} --%>
						<%=loginUser.getUserId() %>
					</div>
				</td>
				<!-- 본문 작성-->
				<td width="550">
					<div>
						<textarea name="tipReply_content" id="tipReply_content" rows="4" cols="70" ></textarea>
					</div>
				</td>
				<!-- 댓글 등록 버튼 -->
				<td width="100">
					<div id="btn" style="text-align:center; width:500;">
						<p><a href="#" onclick="writeCmt()">[댓글등록]</a></p>											
					</div>
				</td>
			</tr>
			<% } //로그인 여부 if 문 종료 %>
	
		</table>
		
		<%--댓글 페이징 처리 --%>
		<div style="text-align: center;">
				<%
					if (trcurrentPage <= 1) {
				%>
				[맨처음]&nbsp;
				<%
					} else {  
						%>
							<a href="/doggybeta/tdetail?tnum=<%=tboard.getTipBoardNo()%>&trpage=<%=1%>">[맨처음]</a>
								
				<%	}%>
				
				<%
					if ((trcurrentPage - 10) <= startPage && (trcurrentPage - 10) >= 1) {//조건식에 =을 붙여줘야 11,21,31....페이지 일 때 링크가 뜸
						%>
							<a href="/doggybeta/tdetail?tnum=<%=tboard.getTipBoardNo()%>&trpage=<%=startPage - 1%>">[prev]</a>
				<%
					} else {
				%>
				[prev]
				<%
					}
				%>
				<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
					<%
					if(endPage <= maxPage){
					for (int p = startPage; p <= endPage; p++) {
						if (p == trcurrentPage) {	%>
							<font color="red" size="4"><b>[<%=p%>]
							</b></font>
							<%
						} else {//페이지 이동 시 옵션과 키워드를 유지한 채 페이징 처리
								%>
								<a href="/doggybeta/tdetail?tnum=<%=tboard.getTipBoardNo()%>&trpage=<%=p%>"><%=p%></a>							
						<%}
					}
					}else{
						for (int p = startPage; p <= maxPage; p++) {
						if (p == trcurrentPage) {	%>
							<font color="red" size="4"><b>[<%=p%>]
							</b></font>
							<%
						} else {//페이지 이동 시 옵션과 키워드를 유지한 채 페이징 처리
								%>
								<a href="/doggybeta/tdetail?tnum=<%=tboard.getTipBoardNo()%>&trpage=<%=p%>"><%=p%></a>							
						<%}
					}
					}
				%>&nbsp;
				<%
					if (endPage < maxPage ) {
				%>
						<a href="/doggybeta/tdetail?tnum=<%=tboard.getTipBoardNo()%>&trpage=<%=endPage + 1%>">[next]</a>
				<%
					} else {
				%>
				[next]&nbsp;
				<%
					}
				%>
				<%
					if (trcurrentPage >= maxPage) {
				%>
				[맨끝]
				<%
					} else {
				%>
						<a href="/doggybeta/tdetail?tnum=<%=tboard.getTipBoardNo()%>&trpage=<%=maxPage%>">[맨끝]</a>	
				<%
					}
				%>

			</div>
	</div>

		</div>
		<%-- <div id="footer"><%@ include file="..//common/footer.jsp"%></div> --%>
	</div>
</body>
</html>