<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="notice.model.vo.Notice ,java.util.ArrayList"%>
<%
   ArrayList<Notice> noticeList = (ArrayList<Notice>)request.getAttribute("noticeList"); 
	
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
   
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
    	
    	console.log(chkBoxArray);
    	alert(chkBoxArray);
    	if(confirm('정말 강퇴하시겠습니까?')) {
    		$.ajax({
    			url: '/doggybeta/manmdelete',
    			datatype: 'text',
    			data: { delNo: chkBoxArray },
    			type: 'post',
    			cache: false,
    			success: function(data) {
    				chageVal(data);
    				alert('강퇴하였습니다!');
    			} //success
    		});//ajax
    		/* document.location.reload(); */
        } //if confirm
    }); //delete click
    
});
</script>
<body>
<%@ include file="../../views/common/managerMenu.jsp" %>
<section>
<div class="mcontainer">
	<h3>공지사항 관리</h3>
	<div id="tab-1" class="row current">
		<table class='t' style="text-align:center; border:1px solid #dddddd"> 
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">삭제여부</th>
					<th style="background-color: #eeeeee; text-align: center;">글번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					<th style="background-color: #eeeeee; text-align: center;">첨부파일</th>
					<th style="background-color: #eeeeee; text-align: center;">조회수</th>
				</tr>
			</thead>
			<% for(Notice n : noticeList) { %>
			
			<tbody>
				<tr>
					<td class='firstTd'><input type='checkbox' class='checkDel' value='<%= n.getNoticeNo() %>' name='delNo'/>강퇴</td>
					<td><%= n.getNoticeNo() %>
					<td><a href="/doggybeta/manndetail?nnum=<%= n.getNoticeNo() %>"><%= n.getNoticeTitle() %></a></td>
					<td><%= n.getNoticeDate() %></td>
					<td><%= n.getNoticeOriginFile() %></td>
					<td><%= n.getNoticeViews() %></td>
				</tr>
			</tbody>
			<% } %> <%-- for each --%>
		</table>

<%-- 검색기능 --%>
<div class="mannotice" align="center" id="searchT">
 <form name="mannotice" method="post" action="/doggybeta/mannotice">
  <select name="opt">
  <option value="0" >제목</option>
  <option value="1" >내용</option>
   </select>
 <input type="text" size="20" name="inputdata" />&nbsp;
 <input type="submit" value ="검색"/>
</form>
</div>

<%-- 페이징처리 --%>
<div class="mnpage" style="text-align:center;">
<% if(currentPage <= 1){ %>
	◀◀&nbsp;
<% }else{ %>
	<a href="/doggybeta/mannotice?page=1">◀◀</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/mannotice?page=<%= startPage - 1 %>">◀</a>
<% }else{ %>
	◀
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<% if(opt == null){ %>
	<a href="/doggybeta/mannotice?page=<%= p %>"><%= p %></a>
	<% }else{ %>
	<a href="/doggybeta/mannotice?opt=<%= opt %>&inputdata=<%= inputdata %>&page=<%= p %>"><%= p %></a>
<% }} %> &nbsp;

<!-- 다음 -->
<% if(endPage < maxPage){ %>
<% if(opt == null){ %>
	<a href="/doggybeta/mannotice?page=<%= endPage + 1 %>">▶</a>
<% }else{ %>
	<a href="/doggybeta/mannotice?inputdata=<%= inputdata %>&page=<%= endPage + 1 %>&opt=<%= opt %>">▶</a>&nbsp;
<% } %>
<% }else{ %>
	▶&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	▶▶
<% }else{ %>
<% if(opt == null){ %>
	<a href="/doggybeta/mannotice?page=<%= maxPage %>">▶▶</a>
<% }else{ %>
	<a href="/doggybeta/mannotice?inputdata=<%= inputdata %> %>page=<%= maxPage %>&opt=<%= opt %>">▶▶</a>
<%  } %>
<% } %>
</div> 	  

	<div>
		<input type="checkbox" id="checkAll" class='styled-checkbox'/>전체선택
		<input type='button' id='del' value='삭제하기'/></div>
	</div>

</body>
</html>