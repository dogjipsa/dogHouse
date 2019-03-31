<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<body>
<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">

<h2 align="center">해당글 상세보기</h2>
<hr style="clear:both;">

<br><br><br>
<table align="center" cellpadding="10" cellspacing="0" border="1" width="600">
	<tr>
		<th>제목</th>
		<td><%=question.getQuestionTitle() %></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>
			<% if(question.getQuestionOriginalFileName() != null){ %>
				<a href="/doggybeta/qfdown?qfile=<%=question.getQuestionOriginalFileName()%>&rfile<%=question.getQuestionRenameFileName() %>"><%=question.getQuestionRenameFileName()%></a>	
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
<br><br><br>


<h2 align="center">운영자 답변</h2>
<table align="center" cellpadding="10" cellspacing="0" border="1" width="600">	
	<tr>
		<th>답변내용</th>
		<td><%= answer.getAnswerContent() %></td>
    </tr>   	
    </div></div>	
</table>
<br><br><br><br><br><br><br><br><br><br>

<hr>
<div id="footer"><%@ include file="../common/footer.jsp"%></div>
</body>
</html>