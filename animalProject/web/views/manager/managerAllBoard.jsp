<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<%@page import='freeboard.model.vo.FreeBoard, java.util.ArrayList' %>

<%
	ArrayList<FreeBoard> list = (ArrayList<FreeBoard>)request.getAttribute("managerList");
	String pageNumber = "1";
	if(request.getParameter("pageNumber") != null) {
		pageNumber = request.getParameter("pageNumber");
	}
	try {
		Integer.parseInt(pageNumber);
	} catch(Exception e) {
		/* 오류메세지부분 */
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link href="/doggybeta/resources/css/manager/managerBoardList.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function() {
	$.ajax({
		url: '/doggybeta/manboard',
		type: 'post',
		data: {no : $('#p5').val()},
		cache: false,
		datatype: 'json',
		success: function(data) {
			console.log('성공!');
			/* var jsonStr = JSON.stringify(data);
			var json = JSON.parse(jsonStr);
			
			var values = $('.row').html();
			for(var i in json.managerList) {
				values += json.managerList[i].freeno + json.managerList[i].freetitle +
					      json.managerList[i].freedate +
					      json.managerList[i].freeuserid + json.managerList[i].freedel
			}
			$('.row').html(values); */
			/* $('<tbody/>').appendTo('.row'); */
			/* var key = Object.keys(data["managerList"][0]);
			$('<tr>',{
				html: '<td>' + key[1] + '</td>' +
					  '<td>' + key[2] + '</td>' +
					  '<td>' + key[3] + '</td>' +
					  '<td>' + key[4] + '</td>' +
					  '<td>' + key[5] + '</td>'
					  
			}).appendTo('tbody'); */
			
			$.each(data.managerList, function(index) {
				var items = [];
				items.push("<td class='firstTd'><input type='checkbox'/></td>");
				items.push('<td>' + '자유' + '</td>');
				items.push('<td>' + data.managerList[index].freeno + '</td>');
				items.push("<td class='fourthTd'>" + decodeURIComponent(data.managerList[index].freetitle) + '</td>');
				items.push('<td>' + data.managerList[index].freeuserid + '</td>');
				items.push('<td>' + data.managerList[index].freedate + '</td>');
				$('<tr/>', {
					html: items
				}).appendTo('tbody');
			}); //each  
		},//success
		error : function(data) {
			alert('에러!');
		}
	});//ajax
});//ready */
</script>
</head>
<body id='mBoardListBody'>
<%@ include file="../../../managerMainPage.jsp" %>
<section>
<div class="mcontainer">
	<h3>게시판 관리</h3>
	<div class="row">
		<table id='t' class="table table-striped" style="text-align:center; border:1px solid #dddddd"> 
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">선택</th>
					<th style="background-color: #eeeeee; text-align: center;">분류</th>
					<th style="background-color: #eeeeee; text-align: center;">번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				</tr>
			</thead>
			<%-- <% for(int i=0; i<list.size(); i++) { %>
			<tbody>
				<tr>
					<td class='firstTd'><input type='checkbox'/>선택</td>
					<td>자유</td>
					<td><%= list.get(i).getFreeboardNo() %></td>
					<td class='fourthTd'><%= list.get(i).getFreeboardTitle() %></td>
					<td><%= list.get(i).getUserId() %></td>
					<td><%= list.get(i).getFreeboardDate() %></td>
				</tr>
			</tbody>
			<% } %> --%> <!-- each -->
			<tbody>
				<!-- <tr>
					<td class='firstTd'><input type='checkbox'/></td>
					<td>자유</td>
					<td>2</td>
					<td class='fourthTd'>안녕하세요</td>
					<td>홍길동</td>
					<td>2017-05-04</td>
				</tr> -->
			</tbody>
		</table>	
		<a href = "write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		<ul class='pagination' style='margin: 0 auto;'>
		<%
			/* if(!pageNumber.equals("1")) { */
			int startPage = (Integer.parseInt(pageNumber) / 10) *  10 + 1;
			if(Integer.parseInt(pageNumber) % 10 == 0) startPage -=10;
			int targetPage = new BoardDao().targetPage(pageNumber);
			if(startPage != 1) {
		%>
			<li><a href='managerAllBoard.jsp?pageNumber=<%= startPage -1 %>'>이전</a></li>
		<%
			} else {
		%>
			<li>불가</li>
		<%
			}
			for(int i = startPage; i < Integer.parseInt(pageNumber); i++) {
		%>
			<li><a href='managerAllBoard.jsp?pageNumber=<%= i %>'><%= i %></a></li>
		<%
			}
		%>
			<li><a href='managerAllBoard.jsp?pageNumber=<%= pageNumber %>'><%= pageNumber %></a></li>
		<%
			for(int i = Integer.parseInt(pageNumber) + 1; i <= targetPage + Integer.parseInt(pageNumber); i ++) {
				if(i < startPage + 10) {
		%>
			<li><a href='managerAllBoard.jsp?pageNumber=<%= i %>'>&nbsp;<%= i %></a></li>
		<%
				}
			}
				if(targetPage + Integer.parseInt(pageNumber) > startPage + 9) {
		%>
			<li><a href='managerAllBoard.jsp?pageNumber=<%= startPage + 10 %>'></a></li>
		<%
				} else {
		%>
			<li>불가</li>
		<%
				}
		%>
		</ul>
			<%-- <a href='managerAllBoard.jsp?pageNumber=<%= Integer.parseInt(pageNumber)-1 %>'>이전</a> --%>
			
		<%-- <%
			} if(new boardDao().nextPage(pageNumber)) {
		%>
			<a href='managerAllBoard.jsp?pageNumber=<%= Integer.parseInt(pageNumber)+1 %>'>다음</a>
		<% 
			}
		%> --%>
	</div>
</div>
</section>
<%-- <% } else { %>
<% pageContext.forward("/views/manager/managerLogin.jsp"); %>
<% } %> --%>
</body>
</html>