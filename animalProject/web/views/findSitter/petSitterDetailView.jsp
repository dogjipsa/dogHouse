<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member" %>
<%
	Member petSitter = (Member)request.getAttribute("petSitter");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon.ico">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="/doggybeta/resources/css/findingpetsitter.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>

<style type="text/css">

/* 화면에 보여지는 글 목록 테이블 */
h2{
   position: relative;
   top: 20px;
   left : 200px;
   width: 70%;
   padding: 2rem 0px;
}
.board { 
   position: relative;
   left : 150px;
   top: 100px;
   width: 60%;
   border-collapse: collapse;
   text-align: left;
   line-height: 1.5;
   table-layout:fixed; 
   
}
.button{
   position: relative;
   left : 200px;
   top: 50px;
}

/* list_table 에서 사용되는 thead */
.board thead th{ 
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;}

/* list_table 에서 사용되는 tbody */
.board tbody td { 
	width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;   
    
}

.board tbody tr:hover{
	background-color : #f3f6f7;
}
header{
	text-align:center;	
	padding: 2rem 0px;
}

.board tbody td a{
	text-decoration: none;
	color: black;
}
.search{
	display: flex;
	justify-content: center;
}
.insert{
	padding: 0 2rem;
}
#wrap{
	left: 200px;
	border: 1px solid red;
	margin: 0 auto;
}
</style>
</head>
<body>
<div>
<%@ include file="..//common/menu.jsp" %>
<div id="wrap" >
<div id="content">
<table class="board">
<thead><tr><th>인적사항</th></tr></thead>
<tbody><tr><td rowspan=3><img src="/doggybeta/files/profile/<%=petSitter.getUserrefile()%>" width=100></td><td>이름 : <%=petSitter.getUserName() %></td></tr>
<tr><td>나이 : <%=petSitter.getUserDate() %></td><td></td></tr>
<tr><td>평점 : </td><td></td></tr></tbody>
</table>
<br>
<table class="board">

<thead><tr><th>세부조건</th></tr></thead>
<tr><td>돌봄 가능한 강아지 크기&나이 :  </td><td></td></tr>
<tr><td>하루(1박) : <%=petSitter.getPrice() %> </td><td></td></tr>
<tr><td>당일(체크인/체크아웃 시간 내) : <%=(int)((petSitter.getPrice() * 0.8 *1000)) /1000%> </td><td></td></tr>
</table>
<br>
<table class="board">

<thead><tr><th>상세내용</th></tr></thead>
<tr><td>내용 받아와야 함.(오라클에 컬럼 추가 요망)  </td><td></td></tr>
</table>
<br>
<table class="board">
<thead><tr><th>돌봄환경</th></tr></thead>
<tr><td>정기예약 :   </td><td></td></tr>
</table>
<br>
</div> 
</div>
		
<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</div>
</body>
</html>