<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, freeboard.model.vo.FreeBoard, java.sql.Date, freeboardreply.model.vo.FreeBoardReply,
				  java.util.*"%>
<%
	FreeBoard freeboard = (FreeBoard)request.getAttribute("freeboard");
//	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	ArrayList<FreeBoardReply> replyList = (ArrayList<FreeBoardReply>)request.getAttribute("replyList"); 
	
	
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#save").click(function(){
		$.ajax({
			url: "/doggybeta/freply",
			data: {fnum : $("#fnum").val(), fwriter : $("#fwriter").val(), fcontent : $("#fcontent").val()},
			type: "post",
			dataType: "json",
			success: function(data){
				/* console.log("성공!");
				var jsonStr = JSON.stringify(data);
				console.log("성공2");
				var json = JSON.parse(jsonStr);
				console.log(jsonStr);
				console.log(json);
				var values = $("#p5").html() + "<br>";
				for(var i in json.list){
					values += json.list[i].replyDate + ", " 
						+ json.list[i].replyNo + ", " 
						+ json.list[i].replyUser + ", "
						+ json.list[i].replyBoardNo + ", "
						+ json.list[i].replyDelete + ", "
						+ decodeURIComponent(json.list[i].replyContent) + ", "
						+ json.list[i].replyUser + "<br>"; 
				} //for in	*/
			}
		});  //ajax
		document.location.reload();
	});  //click

}); //ready

</script>


<style type="text/css">

table{
	position: relative;
	left: 400px;
	border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;
}
h2{
	position: relative;
	left: 700px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;

}
#t11 {
	resize: none;
}
p{
		position: relative;
	left: 400px;
	border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    margin: 20px 10px;

}



</style> 
</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">

<%-- 상세보기  --%>	
<h2><%= freeboard.getFreeboardNo() %>번 게시글 상세보기</h2>
<br>
<table id="t" align="center"  width="800">
<tr>
	<th>제목</th>
	<td align="center"><%= freeboard.getFreeboardTitle() %></td>
</tr>

<tr>
	<th>작성자</th>
	<td align="center"><%= freeboard.getUserId() %></td>
</tr>
<tr>
	<th>첨부파일</th>
	<td align="center">
	 		<% if(freeboard.getFreeboardOriginalFile() != null){ %>
			<a href="/doggybeta/ffdown?ofile=<%= freeboard.getFreeboardOriginalFile() %>&rfile=<%= freeboard.getFreeboardRefile() %>"><%= freeboard.getFreeboardOriginalFile()%></a>
		<% }else{ %>
			첨부파일없음
		<% } %> 
	</td>
</tr> 
<tr>
	<th>내용</th>
	<td align="center"><%= freeboard.getFreeboardContent() %></td>
</tr>
<tr>
	<th colspan="2" align="center">
<% if(loginUser.getUserId().equals(freeboard.getUserId())){ %> 
		<a href="/doggybeta/fupview?fnum=<%= freeboard.getFreeboardNo() %>">[수정페이지로 이동]</a> 
		&nbsp; &nbsp;
		<a href="/doggybeta/fdelete?fnum=<%= freeboard.getFreeboardNo() %>">[글삭제]</a>
	 <% } %> 
	&nbsp; &nbsp;
	 <a href="/doggybeta/flist">[목록]</a> 
	</th>	
</tr>
</table>


<%-- <p><%= replyList  %></p> --%>

<%-- 댓글 보이기 --%>
	<div id="comment">
	<table border="1" bordercolor="lightgray">	
		
	<% if(replyList != null){ //댓글이 있을 때 %>
		<% for(FreeBoardReply f : replyList){ %>
			<tr>
				<!-- 아이디, 작성날짜 -->
				<td width="150">
					<div>
						<%=f.getUserid() %><br>					
						<font size="2" color="lightgray"><%= f.getFreereplydate() %></font>
					</div>
				</td>
				<!-- 본문내용 -->
				<td width="550">
					<div class="text_wrapper">
						<%=f.getFreereplycontent() %>
					</div>
				</td>
				<!-- 버튼 -->
				<td width="100">
					<div id="btn" style="text-align:center;">
						<a href="#">[답변]</a><br>
					<!-- 댓글 작성자만 수정, 삭제 가능하도록 -->	
					<%if(loginUser.getUserId().equals(f.getUserid())){ %>
						<a href="#">[수정]</a><br>	
						<a href="#">[삭제]</a>	
					<%} %>
					
					</div>
				</td>
			</tr>
			<%}//댓글 리스트 조회 for each 문 끝 %>
		<%}//if문 끝 %>
		</table> 
		</div>

<%-- 댓글등록 --%>
<div>
<% if(loginUser != null){ %>	
		<input type="hidden" id="fnum" name="fnum" value="<%= freeboard.getFreeboardNo() %>">
		<input type="hidden" name="page" value="">
	<table align="center">
	<tr><th>작성자</th><td><input type="text" id="fwriter" name="fwriter" style="width:766px" readonly value="<%= loginUser.getUserId() %>"></td></tr>
	<tr><th>내용</th><td><textarea cols="50" rows="4" id="fcontent" name="fcontent" style="width:766px"></textarea></td></tr>
	<tr><th colspan="2" align="center">
	<button id="save">댓글등록</button> 
	<!-- <input type="button" id="save" value="댓글등록"> -->  &nbsp; 
	<a href="/doggybeta/flist">[목록]</a>
	</th></tr>
	</table>
<% } %> 
</div>

<hr>

<%-- 페이지징 처리 --%>
<div style="text-align:center;">
<% if(currentPage <= 1){ %>
	[맨처음]&nbsp;
<% }else{ %>
	<a href="/doggybeta/fdetail?page=1&fnum=<%= freeboard.getFreeboardNo() %>">[맨처음]</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/fdetail?page=<%= startPage - 1 %>&fnum=<%= freeboard.getFreeboardNo() %>"></a>
<% }else{ %>
	[prev]
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<a href="/doggybeta/fdetail?page=<%= p %>&fnum=<%= freeboard.getFreeboardNo() %>"><%= p %></a>
<% } %> &nbsp;

<!-- 다음 -->
<% if((currentPage + 10) > endPage && currentPage != 1){ %>
	<a href="/doggybeta/fdetail?page=<%= endPage + 1 %>&fnum=<%= freeboard.getFreeboardNo() %>">[next]</a>&nbsp;
<% }else{ %>
	[next]&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	[맨끝]
<% }else{ %>
	<a href="/doggybeta/fdetail?page=<%= maxPage %>&fnum=<%= freeboard.getFreeboardNo() %>">[맨끝]</a>
<% } %>
</div> 	  


		<div id="footer" align="right">
			<%@ include file="..//common/footer.jsp"%></div>
	</div>
	</div>
</body>
</html>	





