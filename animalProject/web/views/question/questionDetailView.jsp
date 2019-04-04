<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage='questionError.jsp'%>
<%@ page import="member.model.vo.Member, question.model.vo.Question, answer.model.vo.Answer, java.sql.Date" %>
<%
	Question question = (Question)request.getAttribute("question");
	Answer answer = (Answer)request.getAttribute("answer");
	int currentPage = ((Integer)request.getAttribute("currentPage"));	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>doggybeta</title>
<script type="text/javascript">
function moveUpdatePage(){
	location.href = "/doggybeta/qupdate?no=" + <%= question.getQuestionNo() %>;	
}

function deleteQuestion(){	
	if (confirm('정말 삭제하시겠습니까?')){ 
		location.href = "/doggybeta/qdelete?no=" + <%= question.getQuestionNo() %>;
		alert('삭제되었습니다');
	}else{
		alert('취소');
	}
}
</script>
</head>
<body background="/doggybeta/resources/images/puppies_1.2.jpg">
<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">
<br><br>
<h1 align="center" style="color:white;">해당글 상세보기</h1>
<hr align="center" style="width:600px">
<br><br>
<table align="center" cellpadding="10" cellspacing="0" border="1" width="600" bgcolor=oldlace>
	<tr>
		<th>제목</th>
		<td><%=question.getQuestionTitle() %></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>
			<% if(question.getQuestionOriginalFileName() != null){ %>
				<a href="/doggybeta/qfdown?ofile=<%=question.getQuestionOriginalFileName()%>&rfile<%=question.getQuestionRenameFileName() %>"><%=question.getQuestionOriginalFileName() %></a>	
			<% }else{ %>
				첨부파일 없음
			<% } %>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><%=question.getQuestionContent() %></td>
    </tr>
   	<tr>
    	<th colspan="2">    	    			
    		<button onclick="moveUpdatePage();">수정</button>&nbsp;
    		<input type="button" value="삭제하기" onclick="deleteQuestion();">&nbsp;&nbsp;&nbsp;
    		<button onclick="location.href='/doggybeta/qlist'; return false;">뒤로가기</button>    		
    	</th>    	
    </tr>
</table>
<br><br>
<% if(answer.getAnswerContent() != null){ %>
<%-- <% if(question.getQuestionReplyYn() != null){ %> --%>
<h1 align="center" style=color:ghostwhite>운영자 답변</h1>
<hr align="center" style="width:600px">
<br><br>
<table align="center" border=1 width=600 height=100 bgcolor=oldlace>
	<tr>
		<th>답변내용</th>
		<td><%= answer.getAnswerContent() %></td>
    </tr>   	
    </div></div>	
</table>
<% } %>
</div>
</div>

<br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br>
<div align="center" id="footer"><%@ include file="../common/footer.jsp"%></div></div>
</body>
</html>