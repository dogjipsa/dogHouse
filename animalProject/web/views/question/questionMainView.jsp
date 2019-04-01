<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="questionError.jsp" %>
<%@ page import="question.model.vo.*, java.util.*, question.model.vo.Question" %>
<% 
	ArrayList<Question> list = (ArrayList<Question>)request.getAttribute("list");	
%>
 <!DOCTYPE html>
<html>
<head>
<title>Dog House</title>
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	function moveWritePage(){
		location.href="/doggybeta/views/question/questionWriteForm.jsp";
	}
	
	function moveListPage(){
		location.href="/doggybeta/qlist";
	}
	
	function moveFAQPage(){
		location.href="/doggybeta/faqlist";
	}
</script>
</head>
<body>

<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">

<h2 align="center">1:1 문의</h2>
<hr style="clear:both;">
<div style="background-color:lightblue; width:550px; border:1px solid black;">
<h3>문의하시기 전에 FAQ에서 궁금하신 사항을 확인해보세요!</h3> &nbsp;
<button onclick="moveFAQPage();">FAQ 게시판으로 이동</button>
<br><br>
</div>
<br>
<div style="background-color:lightblue; width:850px; border:1px solid black;">
<h3>로그인 후 문의하시면 상세한 답변이 제공되며,답변 내용을 보다 편리하게 확인하실 수 있습니다.</h3> &nbsp;

<% if(loginUser == null ) { %>
	<!-- <input type='checkbox' id='menu_state' checked />	 -->
	<!-- <a class='btn btn-1 btn-sign'>로그인</a>
	<button class='btn btn-1 btn-sign'>로그인</button> -->
	<input class='btn btn-1 btn-sign' type='button' id='menu_state' value='로그인'/>
		<!-- <span class='btn btn-1 btn-sign'>로그인</span> -->
<% } %>
<% if(loginUser != null){ %>
<%-- <a href=">문의내역 확인</a>&nbsp; &nbsp; --%>
<button onclick="moveListPage();">문의내역 확인</button>&nbsp; &nbsp;
<button onclick="moveWritePage();">문의하기</button><br><br>
<%-- <% }else{ %>
<a href="/doggybeta/jipsalogin"></a> --%>
</div></div>
<% } %>

<div id="footer"><%@ include file="../common/footer.jsp"%></div>
</body>
</html>