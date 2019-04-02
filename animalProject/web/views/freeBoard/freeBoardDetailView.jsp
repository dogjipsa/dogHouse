<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, freeboard.model.vo.FreeBoard, java.sql.Date, freeboardreply.model.vo.FreeBoardReply,
				  java.util.*"%>
<%
	FreeBoard freeboard = (FreeBoard)request.getAttribute("freeboard");
	ArrayList<FreeBoardReply> replyList = (ArrayList<FreeBoardReply>)request.getAttribute("replyList"); 
	
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	
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
var fnum = '<%=((FreeBoard)request.getAttribute("freeboard")).getFreeboardNo()%>';
var page = '<%=request.getAttribute("maxPage")%>';
$(function(){
	$("#save").click(function(){
		$.ajax({
			url: "/doggybeta/freply",
			data: {fnum : $("#fnum").val(), fwriter : $("#fwriter").val(), fcontent : $("#fcontent").val(), frnum : $("frnum").val()},
			type: "post",
			dataType: "json",
			success: function(data){
				
			}
		});  //ajax
		document.location.reload();
		location.href="/doggybeta/fdetail?fnum="+fnum+"&page="+page;
	});  //click

}); //ready

$(function(){
	$("#replyUpdate").click(function(){
		$.ajax({
			url: "/doggybeta/freplyup",
			data: {fnum : $("#fnum").val(), 
				   frnum : $("#frnum").val()},
			type: "post",
			dataType: "json",
			success: function(data){
				
			}
		});  //ajax
	});  //click
	
});
	
$(function(){
	$("#frnum").hide();
});
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


.fdtable{
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


.fdtable th{
	background:#f3f6f7;
	width: 100px;
	padding: 7px 13px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
	
}
.fdtable td {   
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
<%@ include file="../common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">

<%-- 상세보기  --%>	
<h2><%= freeboard.getFreeboardNo() %>번 게시글 상세보기</h2>
<br>
<table class="fdtable" id="t" align="center"  width="800">
<tr>
	<th>제목</th>
	<td><%= freeboard.getFreeboardTitle() %></td>
</tr>

<tr>
	<th>작성자</th>
	<td><%= freeboard.getUserId() %></td>
</tr>
<tr>
	<th>첨부파일</th>
	<td>
	 		<% if(freeboard.getFreeboardOriginalFile() != null){ %>
			<a href="/doggybeta/ffdown?fofile=<%= freeboard.getFreeboardOriginalFile() %>&frfile=<%= freeboard.getFreeboardRefile() %>"><%= freeboard.getFreeboardOriginalFile()%></a>
		<% }else{ %>
			첨부파일없음
		<% } %> 
	</td>
</tr> 
<tr>
	<th>내용</th>
	<td><%= freeboard.getFreeboardContent() %></td>
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
	 <a href="/doggybeta/rfselect?reportFreeBoardNo=<%= freeboard.getFreeboardNo()%>">[신고하기]</a>
	</th>	
</tr>
</table>


<%-- <p><%= replyList  %></p> --%>

<%-- 댓글 보이기 --%>
	<div id="comment">
	<table class="fdtable" border="1" bordercolor="lightgray">	
		
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
				<div>
				<td width="100">
					<%if(loginUser.getUserId().equals(f.getUserid())){ %>
					<a href="/doggybeta/frsearch?frnum=<%= f.getFreereply()%>">[수정]</a>
					<a href="/doggybeta/frdelete?frnum=<%= f.getFreereply()%>&fnum=<%= f.getFreeboardno()%>">[삭제]</a>
					<a href="/doggybeta/rfrselect?frnum=<%= f.getFreereply()%>">[신고하기]</a>	
					<%} %>
				</div>
				</td>
			</tr>
			<%}//댓글 리스트 조회 for each 문 끝 %>
		<%}//if문 끝 %>
		</table> 
		</div>

<%-- 댓글등록 --%>
<div class="fdtable">
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


<%-- 페이지징 처리 --%>
<div style="text-align:center;">
<% if(currentPage <= 1){ %>
	◀◀&nbsp;
<% }else{ %>
	<a href="/doggybeta/fdetail?page=1&fnum=<%= freeboard.getFreeboardNo() %>">◀◀</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/fdetail?page=<%= startPage - 1 %>&fnum=<%= freeboard.getFreeboardNo() %>">◀</a>
<% }else{ %>
	◀
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<a href="/doggybeta/fdetail?page=<%= p %>&fnum=<%= freeboard.getFreeboardNo() %>"><%= p %></a>
<% } %> &nbsp;

<!-- 다음 -->
<% if(endPage < maxPage){ %>
	<a href="/doggybeta/fdetail?page=<%= endPage + 1 %>&fnum=<%= freeboard.getFreeboardNo() %>">▶</a>&nbsp;
<% }else{ %>
	▶&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	▶▶
<% }else{ %>
	<a href="/doggybeta/fdetail?page=<%= maxPage %>&fnum=<%= freeboard.getFreeboardNo() %>">▶▶</a>
<% } %>
</div>  	 

<br>
 


		</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	</div>
	<br>
</body>
</html>	





