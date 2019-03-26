<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 펫시터 신청 버튼 클릭시 생성 보여지는 HTML 부분. 로그인 부분 구현시 인풋에 세션으로 값 넣어놓고 readonly 처리할 것  -->
		
			<form class="ps_reg_form" action="/doggybeta/changeinfo" method="POST" enctype="multipart/form-data">
			<span class="close">x</span>
				<div class="section1">
					<p>아이디</p>
					<input name="userid" value="받아오는 값"  class="ps_input input_id" autocomplete="off" readonly>
					<p>이름</p>
					<input name="username" value="받아오는 값"  class="ps_input input_name" autocomplete="off" >
					<p>연락처</p>
					<input name="phone" value="<%=loginUser.getPhone() %>" class="ps_input input_phone" autocomplete="off" >
					<p>이메일</p>
					<input name="email" value="<%=loginUser.getEmail() %>" class="ps_input input_email" autocomplete="off" >
				</div>
				<div class="section2">
					<p>주소</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>희망 일급(원)</p>
					<input type="number" name="price" placeholder="가격 입력" class="ps_input input_price" min="100">
				</div>
				<div class="section2-1">
					<p>반려견 이름</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>반려견 견종</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>반려견 생년월일</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>반려견 사이즈</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>중성화 여부</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
					<p>특이사항</p>
					<input name="addr" placeholder="장소/위치 입력" class="ps_input input_addr" autocomplete="off" >
				</div>
				<div class="section3">
					<div class="image_box">
						<img class="image_box_pic" />				
						<input type="file" id="real-file" name="pic" hidden="hidden" />
						<span>
							<button type="button" id="fake-file-btn" class="normal_btn">Choose a File</button>&nbsp;
							<span id="file-text"></span>
						</span>
					</div>
					<div class="map_box"></div>
					<span><button id="submit-btn">정보 수정하기</button></span>
				</div>
				
				<div class="ps_reg_form_popup_box">
					<p>펫시터 등록 신청이 완료되었습니다. </p>
					<button type="submit">확인</button>
				</div>
			</form>

		<script type="text/javascript"src="/doggybeta/resources/js/petSitting.js"></script>
</body>
</html>