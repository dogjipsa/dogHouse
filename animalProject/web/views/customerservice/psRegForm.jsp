<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>psRegForm</title>
<link rel="stylesheet" href="/doggybeta/resources/css/psForm.css">
</head>
<body>
	<!-- 펫시터 신청 버튼 클릭시 생성 보여지는 HTML 부분. 로그인 부분 구현시 인풋에 세션으로 값 넣어놓고 readonly 처리할 것  -->
		<div class="ps_reg_form" >
			<span class="close">x</span>
				<div class="section1">
					<p>아이디</p>
					<input name="userid" placeholder="아이디 입력"  class="ps_input input_id" autocomplete="off">
					<p>이름</p>
					<input name="username" placeholder="이름 입력"  class="ps_input input_name" autocomplete="off">
					<p>회원 약관</p>
					<button class="normal_btn">내용보기</button>
					<p>개인 정보 수집</p>
					<button class="normal_btn">내용보기</button>
					<p>제 3자 개인 정보 제공</p>
					<button class="normal_btn">내용보기</button>
					<p>전체 동의 여부</p>
					<span><label>
					<input type="radio" name="agree" value="agree" checked> 동의
					</label><label>
					<input type="radio" name="agree" value="disagree"> 동의하지않음
					</label></span>
				</div>
				<div class="section2">
					<p>연락처</p>
					<input name="phone" placeholder="핸드폰 번호 입력" class="ps_input input_phone" autocomplete="off">
					<p>이메일</p>
					<input name="email" placeholder="이메일 입력" class="ps_input input_email" autocomplete="off">
					<p>펫시팅 장소</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>희망 시급(원)</p>
					<input type="number" name="price" placeholder="가격 입력" class="ps_input input_price" min="100" step="100">
				</div>
				<div class="section3">
					<div class="image_box">
						<div class="image_box_pic"></div>				
						<input type="file" id="real-file" hidden="hidden" />
						<span>
							<button type="button" id="fake-file-btn" class="normal_btn">Choose a File</button>&nbsp;
							<span id="file-text"></span>
						</span>
					</div>
					<div class="map_box"></div>
					<span><button type="submit" id="submit-btn">펫시터 등록하기</button></span>
				</div>
			</div>
		<script type="text/javascript"src="/doggybeta/resources/js/petSitting.js"></script>
</body>
</html>