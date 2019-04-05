<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="managerError.jsp"%>
 <%@page import='report.model.vo.Report, java.util.ArrayList'%>
<%
	ArrayList<Report> rlist = (ArrayList<Report>)request.getAttribute("rlist");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    	if(confirm('정말 삭제하시겠습니까?')) {
    		$.ajax({
    			url: '/doggybeta/manrdelete',
    			datatype: 'text',
    			data: { delNo: chkBoxArray },
    			type: 'post',
    			cache: false,
    			success: function(data) {
    				cBox.html(data);
    				/* chageVal(data); */
    				refreshMemList();
    				alert('삭제가 완료되었습니다!');  
    			} //success
    		});//ajax
    		/* document.location.reload(); */
        } //if confirm
    }); //delete click
    
});
function refreshMemList(){
	location.reload();
}
</script>
</head>
<body>
<%@ include file="../../views/common/managerMenu.jsp" %>

<div class="mcontainer">
	<h3>신고게시물 관리</h3>
	<div id="tab-1" class="row current">
		<table class='t' style="text-align:center; border:1px solid #dddddd"> 
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">삭제여부</th>
					<th style="background-color: #eeeeee; text-align: center;">신고받은아이디</th>
					<th style="background-color: #eeeeee; text-align: center;">신고내용</th>
					<th style="background-color: #eeeeee; text-align: center;">신고분류</th>
					<th style="background-color: #eeeeee; text-align: center;">게시판번호</th>
					<th style="background-color: #eeeeee; text-align: center;">신고번호</th>			
				</tr>
			</thead>
			<% for(Report r : rlist) { %>
			<tbody>
				<tr>
					<td class='firstTd'><input type='checkbox' class='checkDel' value='<%= r.getReportNo() %>' name='delNo'/>삭제</td>
					<td><%= r.getUserId() %></td>
					<td><%= r.getReportContent() %></td>
					<td><%= r.getReportCategory() %></td>
					<td><%= r.getBoardNo() %></td>
					<td><%= r.getReportNo() %></td>
					<% } %>								
				</tr>
			</tbody>
		</table>

<%-- 페이징처리 --%>
<div class="fpage" style="text-align:center;">
<% if(currentPage <= 1){ %>
	◀◀&nbsp;
<% }else{ %>
	<a href="/doggybeta/manrlist?page=1">◀◀</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/manrlist?page=<%= startPage - 1 %>">◀</a>
<% }else{ %>
	◀
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<a href="/doggybeta/manrlist?page=<%= p %>"><%= p %></a>
<% } %>

<!-- 다음 -->
<% if(endPage < maxPage){ %>
	<a href="/doggybeta/manrlist?page=<%= endPage + 1 %>">▶</a>
<% }else{ %>
	▶&nbsp;
<% } %>

<!-- 다다음 -->
<% if(currentPage >= maxPage){ %>
		▶▶
<% }else{ %>
	<a href="/doggybeta/manrlist?page=<%= maxPage %>">▶▶</a>
<%  } %>
</div> 	  
	
	<div>
		<input type="checkbox" id="checkAll" class='styled-checkbox'/>전체선택
		<input type='button' id='del' value='삭제하기'/>
	</div>

<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</body>
</html>