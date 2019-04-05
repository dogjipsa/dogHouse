<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, booking.model.vo.Booking, pet.model.vo.Pet" %>

<% 
Booking booking = (Booking)request.getAttribute("booking");
Member member = (Member)request.getAttribute("member");
Pet pet = (Pet)request.getAttribute("pet");
Member petSitter = (Member)request.getAttribute("petSitter");
String priceSum = (String)(request.getAttribute("priceSum"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon-32x32.png">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<style>
h3{
	padding-left:30px;
	margin:0;
}
.board { 
   position: relative;
   left : 30px;
   width: 100%;
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


<%@ include file="..//common/menu.jsp" %>
	<div id="wrap">
		  <div id="content">
			<!-- 내용작성  -->
			<div style="height:400px; width:800px;">
			<h3>test</h3>
			<table class="board">			
			<thead>
				<tr>
					<th>예약정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=booking %></td>
				</tr>
			</tbody>
			</table>
			</div>
			<table class="board">
			<thead>
				<tr>
					<th>회원정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=member %></td>
				</tr>
				<tr>
					<td><%=pet %></td>
				</tr>
			</tbody>
			</table>
			<table class="board">
			<thead>
				<tr>
					<th>펫시터 정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=petSitter %></td>
				</tr>
			</tbody>
			</table>
			<div style="height:400px; width:800px;">
			<h3>test</h3>
			<table class="board">			
			<thead>
				<tr>
					<th>예약정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>체크인 : <%=booking.getCheckInDate() %> <br>
					  체크아웃 : <%=booking.getCheckOutDate() %>
					</td>
				
					 
				</tr>
			</tbody>
			</table>
			</div>
			
			<div style="height:400px; width:800px;">
			<h3>예약정보</h3>
			<table class="board">			
			<thead>
				<tr>
					<th width="50">체크인</th>
					<th width="50">체크아웃</th>
					<th width="50">가격</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=booking.getCheckInDate() %> </td>
       				<td><%=booking.getCheckOutDate() %></td>
					<td><%=priceSum %> 원</td>
					 
				</tr>
			</tbody>
			</table>
			</div>
			<input type="submit" value="결제하기">
		</div>
		
	</div>

</body>
</html>