<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.Member ,java.util.ArrayList"%>
<%
   ArrayList<Member> petsitterList = (ArrayList<Member>)request.getAttribute("petsitterList"); 
	
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
<title>Petsitter</title>
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
    	$('input[name=delId]:checked').each(function(i){
    		chkBoxArray.push($(this).val());
    	});
    	if(confirm('정말 강퇴하시겠습니까?')) {
    		$.ajax({
    			url: '/doggybeta/manpdelete',
    			datatype: 'text',
    			data: { delId: chkBoxArray },
    			type: 'post',
    			cache: false,
    			success: function(data) {
    				cBox.html(data);
    				/* chageVal(data); */
    				refreshMemList();
    				alert('강퇴가 완료되었습니다!'); 				
    			} //success
    		});//ajax
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
<section>
<div class="mcontainer">
	<h3>펫시터회원 관리</h3>
	<div id="tab-1" class="row current">
		<table class='t' style="text-align:center; border:1px solid #dddddd"> 
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">강퇴</th>
					<th style="background-color: #eeeeee; text-align: center;">신고받은횟수</th>
					<th style="background-color: #eeeeee; text-align: center;">아이디</th>
					<th style="background-color: #eeeeee; text-align: center;">이메일</th>
					<th style="background-color: #eeeeee; text-align: center;">성명</th>
					<th style="background-color: #eeeeee; text-align: center;">연락처</th>
					<th style="background-color: #eeeeee; text-align: center;">주소</th>
					<th style="background-color: #eeeeee; text-align: center;">직업</th>
					<th style="background-color: #eeeeee; text-align: center;">가입날짜</th>
					<th style="background-color: #eeeeee; text-align: center;">첨부파일</th>
					<th style="background-color: #eeeeee; text-align: center;">추방여부</th>
					<th style="background-color: #eeeeee; text-align: center;">펫시터승인여부</th>
				</tr>
			</thead>
			<% for(Member m : petsitterList) { %>
			<tbody>
				<tr>
					<td class='firstTd'><input type='checkbox' class='checkDel' value='<%= m.getUserId() %>' name='delId'/>강퇴</td>
					<td><%= m.getReportAdd() %></td>
					<td><%= m.getUserId() %></td>
					<td><%= m.getEmail() %></td>
					<td><%= m.getUserName() %></td>
					<td><%= m.getPhone() %></td>
					<td><%= m.getAddress() %></td>
					<td><%= m.getJob() %></td>
					<td><%= m.getUserDate() %></td>
					<td><%= m.getUseroriginfile() %></td>
					<td><%= m.getUserDelete() %></td>
					<td>
					<% if(m.getPetSitter().equals("2")){ %>
					 <b>승인완료</b>
					<% }else{ %>
					 <a href="/doggybeta/mpupdate?userid=<%= m.getUserId() %>"><button>승인하기</button></a>
					<% } %>			
					</td>
				</tr>
			</tbody>
			<% } %> <%-- for each --%>
		</table>

<%-- 검색기능 --%>
<div class="mpsearch" align="center" id="searchT">
 <form name="mpsearch" method="post" action="/doggybeta/mpsearch">
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
	<a href="/doggybeta/mpsearch?page=1">◀◀</a>&nbsp;
<% } %> 
<!-- 이전 -->
<% if((currentPage - 10) <= startPage && (currentPage - 10) >= 1){ %>
	<a href="/doggybeta/mpsearch?page=<%= startPage - 1 %>">◀</a>
<% }else{ %>
	◀
<% } %>

<!-- 현재 페이지가 포함된 페이지 그룹 숫자 출력 처리 -->
<% for(int p = startPage; p <= endPage; p++){ %>
	<% if(opt == null){ %>
	<a href="/doggybeta/mpsearch?page=<%= p %>"><%= p %></a>
	<% }else{ %>
	<a href="/doggybeta/mpsearch?opt=<%= opt %>&inputdata=<%= inputdata %>&page=<%= p %>"><%= p %></a>
<% }} %> &nbsp;

<!-- 다음 -->
<% if(endPage < maxPage){ %>
<% if(opt == null){ %>
	<a href="/doggybeta/mpsearch?page=<%= endPage + 1 %>">▶</a>
<% }else{ %>
	<a href="/doggybeta/mpsearch?inputdata=<%= inputdata %>&page=<%= endPage + 1 %>&opt=<%= opt %>">▶</a>&nbsp;
<% } %>
<% }else{ %>
	▶&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	▶▶
<% }else{ %>
<% if(opt == null){ %>
	<a href="/doggybeta/mpsearch?page=<%= maxPage %>">▶▶</a>
<% }else{ %>
	<a href="/doggybeta/mpsearch?inputdata=<%= inputdata %> %>page=<%= maxPage %>&opt=<%= opt %>">▶▶</a>
<%  } %>
<% } %>
</div> 	  
	
	<div>
		<input type="checkbox" id="checkAll" class='styled-checkbox'/>전체선택
		<input type='button' id='del' value='강퇴하기'/>
	</div>

<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</body>
</html>