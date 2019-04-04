<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="memberError.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dog House</title>
<link rel="shortcut icon" href="/doggybeta/resources/images/favicon-32x32.png">
<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$.ajax({
		url : "/doggybeta/reconfirm",
		data : {userid : $("#userid").val()}, //dao로 넘길 값
		type : "post",
		dataType : "json",
		success : function(data){
			console.log("성공");
			console.log(data);
			$("#userpwd").val(data.pwd); //db에서 받아서 json에 넘긴 password
			
		}
	}); //ajax 종료
});
function clickbtn(){
	var userpwd = $("#userpwd").val(); //dao에서 받은 password
	var password = $("#password").val(); //입력한 password
	
	if(userpwd == password){
		alert("비밀번호가 확인되었습니다.");
		$("#clickbtn").prop("disabled", false);
	}else{
		alert("다시 입력 해주세요.");
		
		$("#clickbtn").prop("disabled", true);
	}
	
}
</script>
<body>
<%@ include file="../common/menu.jsp"%>
	<div id="wrap">
		  <div id="content">
<header>
<h2>회원정보변경</h2>
</header>
<br>
<br>
<br>
<br>
<style>
#id{
background-color:#f3f6f7;
padding: 30px 30px;
font-size: 16px;
font: bold;
height: auto;
width: 500px;
}
</style>
<div id="id">
아이디 : <%=loginUser.getUserId() %>
<br>
<br>
<div id="pwd">
비밀번호 
<input type="password" name="password" id="password">
<input type="hidden" name="userpwd" id="userpwd" value="<%=loginUser.getUserPwd()%>">
<input type="hidden" name="userid" id="userid" value="<%=loginUser.getUserId() %>">
<input type="submit" onclick="return clickbtn();" value="확인">
<input type="submit" id="clickbtn" value="정보수정하러가기" onclick="location.href='/doggybeta/views/member/changeInformation.jsp'">
</div>
<br>
<hr>
<div class="bottom" style="font-size: 12px;">
회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 확인합니다.
</div>

</div>
</div>



</div>
		<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
</div>

</body>
</html>