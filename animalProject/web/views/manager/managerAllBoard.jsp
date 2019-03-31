<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<%@page 
import='freeboard.model.vo.FreeBoard, java.util.ArrayList, faq.model.vo.Faq,
		tipboard.model.vo.TipBoard' 

%>

<%
	ArrayList<FreeBoard> list = (ArrayList<FreeBoard>)request.getAttribute("flist");
	int listCount = ((Integer)request.getAttribute("listCount"));
	int startPage = ((Integer)request.getAttribute("startPage"));
	int endPage = ((Integer)request.getAttribute("endPage"));
	int currentPage = ((Integer)request.getAttribute("currentPage"));
	int totalPage = ((Integer)request.getAttribute("totalPage"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link href="/doggybeta/resources/css/manager/managerBoardList.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.row').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
		console.log();
	}); //click function
}); //ready
/* $(function() {
	$(".row").hide();
    $(".row:first").show();
    
    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#333");
        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
        $(this).addClass("active").css("color", "darkred");
        $(".row").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
}); */
/*$(function() {
	$.ajax({
		url: '/doggybeta/manboard',
		type: 'post',
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
	/*	$.each(data.managerList, function(index) {
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
		} */
	/*});//ajax
});//ready 
*/
</script>
</head>
<body id='mBoardListBody'>
<%@ include file="../../../managerMainPage.jsp" %>
<section>
<div class="mcontainer">
	<h3>게시판 관리</h3>
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">자유게시판</li>
		<li class="tab-link" data-tab="tab-2">팁 게시판</li>
		<li class="tab-link" data-tab="tab-3">FAQ</li>
		<li class="tab-link" data-tab="tab-4">Tab Four</li>
	</ul>
	<!-- <div class='tabs'>
		<button class="tab-link current" data-tab="tab-1">자유</button>
		<button class="tl" data-tab="tab-2">자유</button>
		<button class="tab-link" data-tab="tab-4">자유</button>
	</div> -->
	<div id="tab-1" class="row current">
		<table class='t' style="text-align:center; border:1px solid #dddddd"> 
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">선택</th>
					<th style="background-color: #eeeeee; text-align: center;">분류</th>
					<th style="background-color: #eeeeee; text-align: center;">글번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					<th style="background-color: #eeeeee; text-align: center;">삭제여부</th>
				</tr>
			</thead>
			<% for(FreeBoard fb : list) { %>
			<tbody>
				<tr>
					<td class='firstTd'><input type='checkbox'/>삭제</td>
					<td>자유</td>
					<td><%= fb.getFreeboardNo() %></td>
					<td class='fourthTd'><a href='/doggybeta/manbdetail?bnum=<%= fb.getFreeboardNo() %>&page=<%= currentPage %>'><%= fb.getFreeboardTitle() %></a></td>
					<td><%= fb.getUserId() %></td>
					<td><%= fb.getFreeboardDate() %></td>
					<td><%= fb.getFreeboardDelete() %></td>
				</tr>
			</tbody>
			<% } %> <%-- for each --%>
		</table>
		<%-- 페이징 --%>
		<div style='text-align: center;'>
		<% if(startPage > 1) { %>
			<a href='/doggybeta/manboard?page=1'>[HOME]</a><br>
		<% } else if(startPage == 1) { %>
			[HOME]
		<% } %>
		<% if(currentPage > 1) { %>
			<a href='/doggybeta/manboard?page=<%= currentPage - 1 %>'>[prev]</a>
		<% } 
		   for(int i = startPage; i <= endPage; i ++) {
			   if(i == currentPage) {
		%>
			<b><%= i %></b>
		<% 
			   } else if(currentPage <= listCount && currentPage >= startPage) {
		%>
			
			&nbsp;<a href='/doggybeta/manboard?page=<%= i %>'><%= i %></a> &nbsp;
		<%
			   }
		   } 
		   if(currentPage < totalPage) {
		%>
			<a href='/doggybeta/manboard?page=<%= currentPage + 1 %>'>[NEXT]</a>
		<% 
			} 
		   if(endPage < totalPage) {
		%>
			<a href='/doggybeta/manboard?page=<%= totalPage %>'>[END]</a>
		<% } %>
		</div>
		<a href = "write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		<a href = "#" >전체 삭제</a>
	</div>
</div>

</section>
<%-- <% } else { %>
<% pageContext.forward("/views/manager/managerLogin.jsp"); %>
<% } %> --%>
</body>
</html>