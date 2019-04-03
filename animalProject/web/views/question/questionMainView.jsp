<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="questionError.jsp" %>
<%@ page import="question.model.vo.*, java.util.*, question.model.vo.Question" %>
<% 
	ArrayList<Question> list = (ArrayList<Question>)request.getAttribute("list");	
	Member loginUser2 = (Member)session.getAttribute("loginUser");
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
<body background="/doggybeta/resources/images/puppies_1.1.jpg">


<%@ include file="../common/menu.jsp" %>
<div id="wrap">
<div id="cotent">

<h1 align="left" style="color:ghostwhite;">&nbsp;&nbsp;1:1 문의 </h1>
<hr align="left" style="width:880px"><br><br>
<div style="border:2px solid white; width:600px; height:100%; align=center	;">
	<h3 style="color:Cornsilk;">&nbsp; 문의하시기 전에 FAQ에서 궁금하신 사항을 확인해보세요!</h3> &nbsp;
	<button onclick="moveFAQPage();">FAQ 게시판으로 이동</button><br><br>
</div><br><br>

<% if(loginUser != null ) { %>
<div style="border:2px solid white; width:600px; height:100%;">
	<h3 style="color:Cornsilk;">&nbsp; 이용 및 처리절차</h3>
	<li style="color:Aquamarine;">1. <a href="/doggybeta/views/question/questionWriteForm.jsp" target="_blank">문의글</a>작성</li>
    <li style="color:Aquamarine;">2. 담당자 확인 및 답변 등록</li>
    <li style="color:Aquamarine;">3. 마이페이지 및 <a href="/doggybeta/views/question/questionWriteForm.jsp" target="_blank">문의내역</a>에서 내용 확인</li>
    <br>
</div>    
<% }else{ %>
<div style="border:2px solid white; width:600px; height:100%;">
	<h3 style="color:Cornsilk;">&nbsp; 이용 및 처리절차</h3>
	<li style="color:Aquamarine;">1. 문의글작성</li>
    <li style="color:Aquamarine;">2. 담당자 확인 및 답변 등록</li>
    <li style="color:Aquamarine;">3. 마이페이지 및 문의내역에서 내용 확인</li>
    <br>
</div>
<% } %><br><br>

<div style="border:2px solid white; width:860px; height:100%;">
	<h3 style="color:Cornsilk;">&nbsp;  로그인 후 문의하시면 상세한 답변이 제공되며, 답변 내용을 보다 편리하게 확인하실 수 있습니다.</h3> &nbsp;
	<% if(loginUser == null ) { %>
	<button class='btn btn-1 btn-sign'>로그인</button><br><br>	
	<ul>
		<li style="color:yellow;">&nbsp;아직도 도그집사의 회원이 아니신가요? 회원가입을 하시면 보다 편리한 정보 이용이 가능합니다.<button class='btn btn-1 btn-sign'>회원가입하기</button></li>
		<li style="color:yellow;">&nbsp;아이디와 비밀번호를 잊으셨나요? <a href="/doggybeta/views/member/findPassword.jsp" class="login-forgot-pass">아이디/비밀번호 찾기</a></li>
	</ul>
	<% } %>
	<% if(loginUser != null){ %>
	<button onclick="moveListPage();">문의내역 확인</button>&nbsp;
	<button onclick="moveWritePage();">문의하기</button><br><br><br><br>
	<h6 align="left" style="color:Aquamarine;">&nbsp;&nbsp;&nbsp;1:1문의내역 메뉴에서 문의 내역을 확인하실 수 있습니다.</h6>
	<h6 align="left" style="color:Aquamarine;">&nbsp;&nbsp;&nbsp;고객님의 상담내역은 자주 묻는 질문에 내용이 등록될 수 있습니다.</h6>
</div>
<% } %><br><br><br><br><br><br><br>
</div>
<hr>


<div id="footer"><%@ include file="../common/footer.jsp"%></div>

</div>

</body>
</html>