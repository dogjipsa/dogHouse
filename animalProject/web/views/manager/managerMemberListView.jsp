<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.Member ,java.util.ArrayList"%>
<%
   ArrayList<Member> memberList = (ArrayList<Member>)request.getAttribute("memberList"); 
	
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int reportCount = ((Integer)request.getAttribute("reportCount")).intValue();
   
	String opt = null;
	String inputdata = null;
	
		if(request.getAttribute("opt") != null){
			opt = request.getAttribute("opt").toString();
			
			if(request.getAttribute("inputdata") != null){
				inputdata = request.getAttribute("inputdata").toString();	 
			}}
		
		 
   %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="/doggybeta/resources/css/manager/managerBoardList.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

$(function(){
		$.ajax({
			url: "/doggybeta/mmsearch",
			data: {userid : $("#userid").val()}, 
			type: "post",
			success: function(data){
				
			}
		});  //ajax
});

</script>
</head>
<body>
<%@ include file="../../../managerMainPage.jsp" %>
<section>
<div class="mcontainer">
	<h3>일반회원 관리</h3>
	<div id="tab-1" class="row current">
		<table class='t' style="text-align:center; border:1px solid #dddddd"> 
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">추방</th>
					<th style="background-color: #eeeeee; text-align: center;">신고당한횟수</th>
					<th style="background-color: #eeeeee; text-align: center;">아이디</th>
					<th style="background-color: #eeeeee; text-align: center;">이메일</th>
					<th style="background-color: #eeeeee; text-align: center;">성명</th>
					<th style="background-color: #eeeeee; text-align: center;">연락처</th>
					<th style="background-color: #eeeeee; text-align: center;">주소</th>
					<th style="background-color: #eeeeee; text-align: center;">직업</th>
					<th style="background-color: #eeeeee; text-align: center;">가입날짜</th>
					<th style="background-color: #eeeeee; text-align: center;">첨부파일</th>
					<th style="background-color: #eeeeee; text-align: center;">강퇴여부</th>
				</tr>
			</thead>
			<% for(Member m : memberList) { %>
			<tbody>
				<tr>
					<td class='ban'><input type='checkbox'/>삭제</td>
					<td><%= reportCount %></td>
					<td><%= m.getUserId() %></td>
					<input type="hidden" name="userid" value="<%= m.getUserId() %>">
					<td><%= m.getEmail() %></td>
					<td><%= m.getUserName() %></td>
					<td><%= m.getPhone() %></td>
					<td><%= m.getAddress() %></td>
					<td><%= m.getJob() %></td>
					<td><%= m.getUserDate() %></td>
					<td><%= m.getUseroriginfile() %></td>			
					<td><%= m.getUserDelete() %></td>
				</tr>
			</tbody>
			<% } %> <%-- for each --%>
		</table>

<%-- 검색기능 --%>
<div class="mmsearch" align="center" id="searchT">
 <form name="mmsearch" method="post" action="/doggybeta/mmsearch">
  <select name="opt">
  <option value="0" >아이디</option>
  <option value="1" >성명</option>
   </select>
 <input type="text" size="20" name="inputdata" />&nbsp;
 <input type="submit" value ="검색"/>
</form>
</div>

 <%-- 페이징처리 --%>
<div class="fpage" style="text-align:center;">
<% if(currentPage <= 1){ %>
	◀◀&nbsp;
<% }else{ %>
	<a href="/doggybeta/mmsearch?page=1">◀◀</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/mmsearch?page=<%= startPage - 1 %>">◀</a>
<% }else{ %>
	◀
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<% if(opt == null){ %>
	<a href="/doggybeta/mmsearch?page=<%= p %>"><%= p %></a>
	<% }else{ %>
	<a href="/doggybeta/mmsearch?opt=<%= opt %>&inputdata=<%= inputdata %>&page=<%= p %>"><%= p %></a>
<% }} %> &nbsp;

<!-- 다음 -->
<% if(endPage < maxPage){ %>
<% if(opt == null){ %>
	<a href="/doggybeta/mmsearch?page=<%= endPage + 1 %>">▶</a>
<% }else{ %>
	<a href="/doggybeta/mmsearch?inputdata=<%= inputdata %>&page=<%= endPage + 1 %>&opt=<%= opt %>">▶</a>&nbsp;
<% } %>
<% }else{ %>
	▶&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	▶▶
<% }else{ %>
<% if(opt == null){ %>
	<a href="/doggybeta/mmsearch?page=<%= maxPage %>">▶▶</a>
<% }else{ %>
	<a href="/doggybeta/mmsearch?inputdata=<%= inputdata %> %>page=<%= maxPage %>&opt=<%= opt %>">▶▶</a>
<%  } %>
<% } %>
</div> 	  

<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</body>
</html>