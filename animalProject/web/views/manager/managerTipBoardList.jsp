<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
<%@page import='java.util.ArrayList, tipboard.model.vo.TipBoard'%>
<%
	ArrayList<TipBoard> tlist = (ArrayList<TipBoard>)request.getAttribute("tlist");
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도그하우스</title>
<link href="/doggybeta/resources/css/manager/managerBoardList.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
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
    			url: '/doggybeta/mantbdel',
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
<section>
<%@ include file="../../views/common/managerMenu.jsp" %>
<div class="mcontainer">
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">팁게시판 관리</li>
	</ul>
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
			<% for(TipBoard tb : tlist) { %>
			<tbody>
				<tr>
					<td class='firstTd'><input type='checkbox' class='checkDel' value='<%= tb.getTipBoardNo() %>' name='delNo'/>삭제</td>
					<td>자유</td>
					<td><%= tb.getTipBoardNo() %></td>
					<td class='fourthTd'><a href='/doggybeta/mantbdetail?fnum=<%= tb.getTipBoardNo() %>&page=<%= currentPage %>'><%= tb.getTipBoardTitle() %></a></td>
					<td><%= tb.getUserId() %></td>
					<td><%= tb.getTipBoardDate() %></td>
					<td class='yorn'><%= tb.getTipBoardDelete() %></td>
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
			<a href='/doggybeta/mantb?page=1'>◁</a><br>
			<% } else { %>
			<a href='/doggybeta/mantb?word=<%= keyword %>&page=1&option=<%= search %>'>[HOME]</a>
			
			<% } %>
		<% } %>
		<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1) { %>
			<% if(search == null) { %>
			<a href='/doggybeta/mantb?page=<%= startPage - 1%>'>◁</a><br>
			<% } else { %>
			<a href='/doggybeta/mantb?word=<%= keyword %>&page=<%= startPage - 1%>&option=<%= search %>'>[HOME]</a>
			
			<% } %>
		<% } else { %>
		◁
		<% } %>
		<% for(int p = startPage; p <= endPage; p ++) {
			if(p == currentPage) { %>
				<font color='skyblue' size='4'><b><%= p %></b></font>
			<% } else { %>
				<% if(search == null) { %>
					<a href='/doggybeta/mantb?page=<%= p %>'><%= p %></a>
				<% } else { %>
					<a href='/doggybeta/mantb?word=<%= keyword %>&page<%= p %>&option=<%= search%>'><%= p %></a>
				<% } %>
			<% } %>
		<% } //for문 %>&nbsp;
		<% if(endPage < totalPage) { %>
		<!-- ◁◁ -->
			<% if(search == null) { %>
				<a href='/doggybeta/mantb?page=<%= totalPage %>'>▷▷</a>
			<% } else { %>
				<a href='/doggybeta/mantb?word=<%= keyword %>&page=<%= totalPage %>&option<%= search %>'>▷▷</a>
			<% } %>
		<% } else { %>
			▷&nbsp;
		<% } %>
		<% if(currentPage >= totalPage) { %>
		▷▷
		<% }  else {%>
		<% if(search == null) { %>
			<a href='/doggybeta/mantb?page=<%= totalPage %>'>▷▷</a>
		<% } else { %>
			<a href='/doggybeta/mantb?word=<%= keyword %>&page=<%= totalPage %>&option=<%= search %>'>▷▷</a>
		<% } } %>
	</div>
	<input type="checkbox" id="checkAll" class='styled-checkbox'/>전체선택
	<input type='button' id='del' value='선택삭제'/>
	<div>
	<div class="fsearch" align="center" id="searchT">
 	<form name="form1" method="post" action="/doggybeta/mantb">
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
</body>
</html>