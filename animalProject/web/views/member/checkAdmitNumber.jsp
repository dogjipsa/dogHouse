<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="memberError.jsp"%>
<%
	String keycode = (String)session.getAttribute("keycode");
%>
<!DOCTYPE html>
<html id='admitbody'>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/doggybeta/resources/css/member/enroll.css">
</head>
<script type="text/javascript" src="/doggybeta/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	function checkid() {
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
		}); //ajax
		
		return false; //클릭 이벤트 전달받음
	} // 아이디 중복 확인 함수 close;
	function admit() {
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var e = $('#email').val();
		
		if(!e || !regExp.test(e)) {
			alert('올바른 형식의 이메일주소를 입력해주세요.');
			$('#email').select();
		}
		else {
			alert('인증번호 전송이 완료되었습니다.');
				
			$.ajax({
				url: '/doggybeta/admitmember',
				type: 'post',
				dataType: 'json',
				data: {email: $('#email').val()},
				success: function(data) {
					var obj = JSON.parse(data.keycode);
					$('#number2').val(obj);
					/* console.log("data : " + obj); */ //데이터 잘 넘어오는지 확인
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log("error : "+jqXHR+","+textStatus+","+errorThrown);
				}
			}); //ajax
		} //else
		return false;
	} // 인증번호 전송 클릭함수
	
	function confirmNum() {
		var n2 = $('#number2').val();
		var n1 = $('#number').val();
			if(n1==n2 && n1!='' && n2!='') {
				alert('인증에 성공하였습니다!');
				$('#signupbtn').prop('disabled', false).css("background-color", "");
			} else if(!n1) {
				alert('인증번호를 입력해주세요');
				$('#signupbtn').prop('disabled', true).css('background-color','gray');
			} else {
				alert('인증번호를 다시 입력해주세요!');
				$('#signupbtn').prop('disabled', true).css('background-color','gray');
			 }
			return false;
	}; //인증번호 일치여부 확인하는 함수
	
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

	}); //암호 함수
	
	$(function(){
	    $("#phone").on('keydown', function(e){
	       // 숫자만 입력받기
	    var trans_num = $('#phone').val().replace(/-/gi,'');
		var k = e.keyCode;
					
		if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687) || k==32 || k==229 || (k>=45032 && k<=55203)))
		{
	  	    e.preventDefault();
		}
		//function(e) 시작
	    }).on('blur', function() { // 포커스를 잃었을때 
	        if($('#phone').val() == '') return;
	        // 기존 번호에서 - 를 삭제
	        var trans_num = $('#phone').val().replace(/-/gi,'');
	      
	        // 입력값이 있을때만 실행
	        if(trans_num != null && trans_num != '') {
	            // 총 핸드폰 자리수는 11글자이거나, 10자
	            if(trans_num.length==11 || trans_num.length==10) {   
	                // 유효성 체크
	                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
	                if(regExp_ctn.test(trans_num)) {
	                    // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿈
	                    trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
	                    $('#phone').val(trans_num);
	                } else {
	                    alert("유효하지 않은 전화번호 입니다.");
	                    $('#phone').val("");
	                    $('#phone').focus();
	                    }
	            } else {
	                alert("유효하지 않은 전화번호 입니다.");
	                $('#phone').val("");
	                $('#phone').focus();
	            }
	      }
	  });  
	    return false;
	}); //phone 유효성 함수 close
</script>
</head>
<body>
<section id='bodystyle'>
<!-- <h2>회원가입페이지</h2><br> -->
	<div id='tb'>
	<h1 id='maintitle'>Create a new Account!</h1>
	<img id='doglogo' src='/doggybeta/resources/images/로고test2.png'>
	<form action="/doggybeta/resistenroll" method="post">
		<span class='first_span'>
			<input type="text" name="userid" class='mainInputForm inputForm' id="userid" required onclick='getValue();'/>
				<label class='inputLabel labelJeong' for='userid' data-content='*아 이 디'>
					<span class='input_span span_second_jeong'>*아 이 디</span>
				</label>
		</span>
		<input type='button' id='chkId' onclick="return checkid();" value='중복&#x00A;확인'>
		
		<span class='first_span'>
			<input type="text" name="username" class='mainInputForm inputForm' required id='username'/>
				<label class='inputLabel labelJeong' for='username' data-content='*이 름'>
					<span class='input_span span_second_jeong'>*이 름</span>
				</label>
		</span>
		<span class='first_span'>
			<input type='email' name='email' id='email' class='mainInputForm inputForm' required placeholder='이메일 입력후 전송버튼을 눌러주세요'/>

				<label class='inputLabel labelJeong' for='email' data-content='*이 메 일'>
					<span class='input_span span_second_jeong'>*이 메 일</span>
				</label>
		</span>
		<input type='submit' id='sendbtn' onclick='return admit();' value='전송'/>
		
		<span class='first_span'>
			<input type='text' name='number' id='number' class='mainInputForm inputForm' placeholder='인증번호를 입력해주세요'/>
			<input type='hidden' id='number2' class='mainInputForm inputForm'/>
				<label class='inputLabel labelJeong' for='number' data-content='*인 증 번 호 입 력'>
					<span class='input_span span_second_jeong'>* 인 증 번 호 입 력</span>
				</label>
		</span>
		<input type='button' id='btnok' onclick='return confirmNum();' value='확인'/>
		
		<span class='first_span'>
			<input type="password" name="userpwd" id="userpwd1" class='mainInputForm inputForm' required placeholder='비밀번호를 입력해주세요'/>
				<label class='inputLabel labelJeong' for='userpwd1' data-content='*비 밀 번 호'>
					<span class='input_span span_second_jeong'>*비 밀 번 호</span>
				</label>
		</span>
		<span class='first_span'>
			<input type="password" name="userpwd" id="userpwd2" class='mainInputForm inputForm' required/>
				<label class='inputLabel labelJeong' for='userpwd2' data-content='*비 밀 번 호 확 인'>
					<span class='input_span span_second_jeong'>*비 밀 번 호 확 인</span>
				</label>
		</span>
		<span class='first_span'>
			<input type='tel' name='phone' id='phone' class='mainInputForm inputForm'/>
				<label class='inputLabel labelJeong' for='phone' data-content='전 화 번 호'>
					<span class='input_span span_second_jeong'>전 화 번 호</span>
				</label>
		</span>
		<input type="submit" value="가입하기" id='signupbtn'/>
		<input type="reset" value="작성취소"/><br>
		<p id='nes'>* 표시 항목은 필수입력 항목입니다.</p>
		<a href="/doggybeta/index.jsp">시작 페이지로</a>
	</form>
	</div>
</section>
</body>
</html>