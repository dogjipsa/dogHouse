<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="tipboard.model.vo.TipBoard, member.model.vo.Member, java.sql.Date" %>
<%@ page import="tipboardreply.model.vo.TipBoardReply" %>
<%
	TipBoard tboard = (TipBoard)request.getAttribute("tboard");
	int currentPage = (Integer)request.getAttribute("currentPage");
	/* Member loginUser = (Member)session.getAttribute("loginUser"); */
	TipBoardReply trboard = (TipBoardReply)request.getAttribute("trboard");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팁게시판</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">



<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function writeCmt()
{
	var form = document.getElementById("writeCommentForm");
	
	var board = form.comment_board.value
	var id = form.comment_id.value
	var content = form.comment_content.value;
	
	if(!content)
	{
		alert("내용을 입력하세요.");
		return false;
	}
	else
	{	
		var param="comment_board="+board+"&comment_id="+id+"&comment_content="+content;
			
		httpRequest = getXMLHttpRequest();
		httpRequest.onreadystatechange = checkFunc;
		httpRequest.open("POST", "CommentWriteAction.co", true);	
		httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded;charset=EUC-KR'); 
		httpRequest.send(param);
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
</head>
<body>
<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
			<!-- 내용작성  -->
			<h2 align="center"><%= tboard.getTipBoardNo() %>번 글 상세조회</h2>
<br>
<table align="center" cellpadding="10" cellspacing="0" border="1" width="500">
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
		<table border="1" bordercolor="lightgray">
	<!-- 댓글 목록 -->	
<%-- 	<c:if test="${requestScope.commentList != null}">
		<c:forEach var="comment" items="${requestScope.commentList}"> --%>
		
			<tr>
				<!-- 아이디, 작성날짜 -->
				<td width="150">
					<div>
						${comment.comment_id}<br>
						<font size="2" color="lightgray">${comment.comment_date}</font>
					</div>
				</td>
				<!-- 본문내용 -->
				<td width="550">
					<div class="text_wrapper">
						${comment.comment_content}
					</div>
				</td>
				<!-- 버튼 -->
				<td width="100">
					<div id="btn" style="text-align:center;">
						<a href="#">[답변]</a><br>
					<!-- 댓글 작성자만 수정, 삭제 가능하도록 -->	
					<%-- <c:if test="${comment.comment_id == sessionScope.sessionID}"> --%>
						<a href="#">[수정]</a><br>	
						<a href="#">[삭제]</a>
					<!-- </c:if>	 -->	
					</div>
				</td>
			</tr>
			
		<!-- </c:forEach>
	</c:if> -->
			
			<!-- 로그인 했을 경우만 댓글 작성가능 -->
			<%-- <c:if test="${sessionScope.sessionID !=null}"> --%>
			<tr bgcolor="#F5F5F5">
			<form id="writeCommentForm" action="/doggybeta/trinsert">
				<input type="hidden" name="tipBoard_no" value="<%-- ${board.board_num} --%>">
				<input type="hidden" name="tipReply_id" value="<%=loginUser.getUserId() %><%-- ${sessionScope.sessionID} --%>">
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
						<textarea name="tipReply_content" rows="4" cols="70" ></textarea>
					</div>
				</td>
				<!-- 댓글 등록 버튼 -->
				<td width="100">
					<div id="btn" style="text-align:center;">
						<p><a href="#" onclick="writeCmt()">[댓글등록]</a></p>	
					</div>
				</td>
			</form>
			</tr>
			<!-- </c:if> -->
	
		</table>
	</div>

		</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
</body>
</html>