<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<%@page import='freeboard.model.vo.FreeBoard, java.util.ArrayList, '%>

<%
	ArrayList<FreeBoard> list = (ArrayList<FreeBoard>)request.getAttribute("flist");
	int listCount = ((Integer)request.getAttribute("listCount"));
	int startPage = ((Integer)request.getAttribute("startPage"));
	int endPage = ((Integer)request.getAttribute("endPage"));
	int currentPage = ((Integer)request.getAttribute("currentPage"));
	int totalPage = ((Integer)request.getAttribute("totalPage"));
	
	String search = null;
	String keyword = null;
	if(request.getAttribute("search") != null) {
		search = request.getAttribute("search").toString();
		keyword = request.getAttribute("keyword").toString();
	}
	System.out.println("cp " + currentPage);
	System.out.println("sp " + startPage);
	System.out.println("ep " + endPage);
	System.out.println("tp " + totalPage);
	System.out.println("flist " + list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link href="/doggybeta/resources/css/manager/managerBoardList.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
/* $(function(){
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.row').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
		console.log();
	}); //click function
}); //ready */
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
$(function(){
    //최상단 체크박스 클릭
    $("#checkAll").click(function(){
        //클릭되었으면
        if($("#checkAll").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[class=checkDel]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
            $("input[class=checkDel]").prop("checked",false);
        }
    }); //전체선택 click fx
    
    var chkBoxArray = [];
    var cBox = $('.checkDel');
    
    $('#del').click(function() {
    	$('input[name=delNo]:checked').each(function(i){
    		chkBoxArray.push($(this).val());
    	});
    	
    	console.log(chkBoxArray);
    	alert(chkBoxArray);
    	if(confirm('정말 삭제하시겠습니까?')) {
    		$.ajax({
    			url: '/doggybeta/mandelete',
    			datatype: 'text',
    			data: { delNo: chkBoxArray },
    			type: 'post',
    			cache: false,
    			success: function(data) {
    				chageVal(data);
    				alert('변경이 완료되었습니다!');
    			} //success
    		});//ajax
        } //if confirm
    }); //delete click
    $('#days').click(function(){
    	$('#searchDate').show();
    	$('input[id=keyw]').hide();
    });
});
</script>
<style type="text/css">
	#formDialogDiv {
	display:none;}
</style>
</head>
<body id='mBoardListBody'>
<%@ include file="../../views/common/managerMenu.jsp" %>
<section>
<div class="mcontainer">
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">자유게시판 관리</li>
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
					<td class='firstTd'><input type='checkbox' class='checkDel' value='<%= fb.getFreeboardNo() %>' name='delNo'/>삭제</td>
					<td>자유</td>
					<td><%= fb.getFreeboardNo() %></td>
					<td class='fourthTd'><a href='/doggybeta/manbdetail?fnum=<%= fb.getFreeboardNo() %>&page=<%= currentPage %>'><%= fb.getFreeboardTitle() %></a></td>
					<td><%= fb.getUserId() %></td>
					<td><%= fb.getFreeboardDate() %></td>
					<td class='yorn'><%= fb.getFreeboardDelete() %></td>
				</tr>
			</tbody>
			<% } %> <%-- for each --%>
		</table>
		<%-- 페이징 --%>
		<div style='text-align: center;'>
		<% if(currentPage <= 1) { %>
		◁◁&nbsp;
		<% } else { %>
			<% if(search == null) { %>
			<a href='/doggybeta/manboard?page=1'>◁</a><br>
			<% } else { %>
			<a href='/doggybeta/manboard?word=<%= keyword %>&page=1&option=<%= search %>'>[HOME]</a>
			
			<% } %>
		<% } %>
		<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1) { %>
			<% if(search == null) { %>
			<a href='/doggybeta/manboard?page=<%= startPage - 1%>'>◁</a><br>
			<% } else { %>
			<a href='/doggybeta/manboard?word=<%= keyword %>&page=<%= startPage - 1%>&option=<%= search %>'>[HOME]</a>
			
			<% } %>
		<% } else { %>
		◁
		<% } %>
		<% for(int p = startPage; p <= endPage; p ++) {
			if(p == currentPage) { %>
				<font color='skyblue' size='4'><b><%= p %></b></font>
			<% } else { %>
				<% if(search == null) { %>
					<a href='/doggybeta/manboard?page=<%= p %>'><%= p %></a>
				<% } else { %>
					<a href='/doggybeta/manboard?word=<%= keyword %>&page<%= p %>&option=<%= search%>'><%= p %></a>
				<% } %>
			<% } %>
		<% } //for문 %>&nbsp;
		<% if(endPage < totalPage) { %>
		<!-- ◁◁ -->
			<% if(search == null) { %>
				<a href='/doggybeta/manboard?page=<%= totalPage %>'>▷▷</a>
			<% } else { %>
				<a href='/doggybeta/manboard?word=<%= keyword %>&page=<%= totalPage %>&option<%= search %>'>▷▷</a>
			<% } %>
		<% } else { %>
			▷&nbsp;
		<% } %>
		<% if(currentPage >= totalPage) { %>
		▷▷
		<% }  else {%>
		<% if(search == null) { %>
			<a href='/doggybeta/manboard?page=<%= totalPage %>'>▷▷</a>
		<% } else { %>
			<a href='/doggybeta/manboard?word=<%= keyword %>&page=<%= totalPage %>&option=<%= search %>'>▷▷</a>
		<% } } %>
		<%-- <% if(startPage > 1) { %>
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
		<!-- <a href = "#" >전체 삭제</a> -->
		--%>
	</div>
	<input type="checkbox" id="checkAll" class='styled-checkbox'/>전체선택
	<input type='button' id='del' value='선택삭제'/>
	<div>
	<div class="fsearch" align="center" id="searchT">
 	<form name="form1" method="post" action="/doggybeta/manboard">
  	<select name="option">
  		<option value="delyorn" >삭제여부</option>
  		<option value="writer" >작성자</option>
  		<option value="createDel" id='days'>날짜</option>
   	</select>
   		<input type='date' id='searchDate' name='keyword'/>
 		<input type="text" size="20" name="keyword" id='keyw'/>&nbsp;
 		<input type="submit" value ="검색"/>
	</form>
		</div>
		</div>
	</div>
</div>
</section>
<%-- <% } else { %>
<% pageContext.forward("/views/manager/managerLogin.jsp"); %>
<% } %> --%>
</body>
</html>