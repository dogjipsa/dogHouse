<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon-32x32.png">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function deletebtn(){
	alert("확인");
	console.log("확인");
	 if(confirm('정말로 탈퇴하시겠습니까?')) {
	        $.ajax({
	            url: '/doggybeta/delmember',
	            type: "POST",
	            data: {
	                userid : $("#userid").val()
	            },
	            success: function (data) {
	               if(data == "ok")
	            	   alert("성공!");
	               else alert("실패!");
	            }
	        });
	    }
}

</script>
<style type="text/css">

/* 화면에 보여지는 글 목록 테이블 */

.board { 
   position: relative;
   left : 150px;
   top: 100px;
   border-collapse: collapse;   
   line-height: 1.5;
   table-layout:fixed; 
   
}
input[type="submit"]{
   position: relative;
   left : 200px;
   top: 150px;
   width: 100px;
   height: 40px
}

#title{
	text-align: left;
	font-weight: bold;
}

.board tr{ 
	padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
    }

/* list_table 에서 사용되는 tbody */
.board th{ 
	width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;   
    
}
#write input[type="text"], select{
	border: none;
	width: 150px;
    padding: 10px;
    text-align: left;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
.board #write:hover{
	background-color : #f3f6f7;
}
header{
		
	padding: 2rem 0px;
}


</style>
</head>

<body>
<%@ include file="../common/menu.jsp"%>
	<div id="wrap">
		  <div id="content">


<header>
회원정보수정
</header>

<input type="hidden" name="userid" id="userid" value="<%=loginUser.getUserId() %>">

<br>
<!-- 테이블 시작 -->
   <table class="board">
         <tr>
            <th id="title">ID</th>
            <th id="write">
            <% if(loginUser.getNaverCode() != null) { %>
            <input type="text" readonly value="<%=loginUser.getEmail() %>">
            <%}else{ %>
            <input type="text"  readonly value="<%=loginUser.getUserId() %>">
            <%} %>
            </th>
         </tr>   
         <tr>
            <th id="title">이름</th>
            <th id="write"><input type="text" readonly value="<%=loginUser.getUserName() %>"></th>
         </tr> 
         <tr>
            <th id="title">휴대폰번호</th>
            <th id="write"><input type="text" value="<%=loginUser.getPhone() %>"></th>
         </tr> 
         <tr>
            <th id="title">이메일</th>
            <th id="write">
             <% if(loginUser.getNaverCode() != null) { %>          
            <input type="text" readonly value="<%=loginUser.getEmail() %>">
            <%}else{ %>
            <input type="text" value="<%=loginUser.getEmail() %>">
            <%} %>
            </th>
         </tr> 
         <tr>
            <th id="title">주소</th>
            <th id="write">주소 api 활용</th>
         </tr> 
         <tr>
            <th id="title">직업</th>
            <th id="write">
            <select name="opt">
            	<OPTION VALUE=0 selected>선택하세요.</OPTION>
            	<OPTION VALUE=1>직장인</OPTION>
      			<OPTION VALUE=2>사업</OPTION>
        		<OPTION VALUE=3>프리랜서</OPTION>
        		<OPTION VALUE=5>학생</OPTION>
        		<OPTION VALUE=6>주부</OPTION>
        		<OPTION VALUE=7>기타</OPTION>
        		<OPTION VALUE=8>무직</OPTION>
            </select>
            </th>
         </tr> 
     
</table>
<br>         
<!-- 테이블 종료 -->
<input type="submit" value="정보수정하기">
<input type="button" id="deletebtn" value="탈퇴하기" onclick="deletebtn();">
<input type="submit" value="메인으로">

</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</div>

</body>
</html>