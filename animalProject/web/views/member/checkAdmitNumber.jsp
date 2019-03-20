<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="memberError.jsp"%>
<%
	String keycode = (String)session.getAttribute("keycode");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
	section form table th {
		background: orange;
		color: navy;
		font-weight: bold;
	}
</style>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	function checkid() {
		//서버로 입력된 아이디값을 전송해서 이미 있는 아이디인지 확인 요청. 이후 결과를 받아 사용여부 처리함.
		//jQuery.ajax() 사용
		var id=$('#userid').val();
		var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
		
		if(!id) {
			alert('아이디를 입력해주세요.');
			$('#userid').focus();
			return false;
		}
		else if(!getCheck.test($('#userid').val())){
	        alert("영어 소문자와 숫자만 사용할 수 있습니다.");
	        $("#userid").val("");
	        $("#userid").focus();
	        return false;
	    }
		
		$.ajax({
			url: '/doggybeta/memberidchk',
			type: 'post',
			data: {userid: $('#userid').val()}, 
			success: function(data) {
				console.log("success"+data);
				
				if(data=="ok"){
					alert('사용할 수 있는 아이디입니다.');
					$('#username').focus();
				} else {
					alert('이미 사용중인 아이디입니다.\n'+'다른 아이디를 입력해주세요');
					$('#userid').select();
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log("error : "+jqXHR+","+textStatus+","+errorThrown);
			}
		});
		
		return false; //클릭 이벤트 전달받음
	}
	function admit() {
		var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		var e = $('#email').val();
		if(!e) {
			alert('이메일을 입력해주세요');
			$('#email').val();
		}
		else {
			if(!filter.test(e)) {
				alert('올바른 이메일형식을 입력해주세요.');
				return false;
			} 
			alert('인증번호 전송이 완료되었습니다.')
				var n = $('#number').val();
			$.ajax({
				url: '/doggybeta/admitmember',
				type: 'post',
				data: {email: $('#email').val() },
				succeess: function(data) {
					
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log("error : "+jqXHR+","+textStatus+","+errorThrown);
				}
			});
			
			
			
			
			/* $("#toplist").html($("#toplist").html() + values); */
			
			return false;
		}
		return false;
	}


/* 	location.reload(); */
    var code = '<%= keycode %>';
    
/* 	$('sendbtn').hide(); */
	function confirmNum() {
		var nn = $('#number').val();
			if(code == nn) {
				alert('인증에 성공하였습니다.');
				$('#signupbtn').show();
				session.invalidate();
				
			} else {
				alert("새로고침 후\n인증번호를 다시 입력해주세요.");
				$('#signupbtn').hide();
			}
		return false;
	}
	
	$(function() {
		//암호 확인입력상자의 focus가 사라졌을 때
		$('#userpwd2').blur(function() {
			console.log('포커스사라짐');
			var pwd1=$('#userpwd1').val();
			var pwd2=$('#userpwd2').val();
			
			if(pwd1!=pwd2) {
				alert('암호가 일치하지 않습니다.\n'+'다시 입력하세요');
				$('#userpwd1').select();
			}
			
			
		});
		
	});
	
	$(function() {
 		$('#signupbtn').hide();
	});
</script>
</head>
<body>
<section>
<h2 align="center">회원가입페이지</h2><br>
	<h5 align="center">* 표시 항목은 필수입력 항목입니다.</h5>
	<form action="/doggybeta/resistenroll" method="post" >
	<table width="650" align="center" id='tb'>
	<tr height="40">
		<th width="150">*아이디</th>
		<td><input type="text" name="userid" id="userid" required/>
		&nbsp; <button onclick="return checkid();">중복확인</button></td>
	</tr>
	<tr height="40">
		<th width="150">*이름</th>
		<td><input type="text" name="username" required id='username'/></td>
	</tr>
	<tr height="40">
		<th width="150">이메일</th>
		<td><input type='email' name='email' id='email'/>
		</td>
	</tr>
	<tr height="40">
		<th width="150">인증번호 입력</th>
		<td><input type='text' name='number' id='number'/>
		<input type='button' id='sendbtn' onclick='admit();' value='전송'/>
		<input type='button' id='btnok' onclick='return confirmNum();' value='확인'/>
		</td>
	</tr>
	<tr height="40">
		<th width="150">*암호</th>
		<td><input type="password" name="userpwd" id="userpwd1"/></td>
	</tr>
	<tr height="40">
		<th width="150">*암호확인</th>
		<td><input type="password" id="userpwd2" required/></td>
	</tr>
	<tr height="40">
		<th width="150">전화번호</th>
		<td><input type='tel' name='phone'/></td>
	</tr>
	<tr height="40">
		<th colspan="2">가입하기
		<input type="submit" value="가입하기" id='signupbtn'/>&nbsp;
		<input type="reset" value="작성취소"/>&nbsp;
		<a href="/doggybeta/index.jsp">시작페이지로 이동</a>
		</th>
	</tr>
	</table>
	<!-- <div id='confirm-num' >
		<input type='text' id='con-number' name='connumber'/>&nbsp;
		<input type='button' id='con-button' name='conbtn' value='확인'/>
	</div> -->
	</form>
</section>
</body>
</html>