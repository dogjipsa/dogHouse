<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>이용내역/예약 확인</title>
	<link href="/doggybeta/resources/css/footer.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/doggybeta/resources/css/checkMyLog.css">
</head>

<body>
	<%@ include file="..//common/menu.jsp" %>
	<input type="hidden" name="userid" value="<%=loginUser.getUserId() %>">
	<div class="wrap_content">
		<!-- section1 - 변경 버튼's -->
		<div class="section1">
			<input type="radio" name="item" id="cml_booking" value="booking" checked>
			<input type="radio" name="item" id="cml_host" value="host">
			<input type="radio" name="item" id="cml_addpet" value="addpet">

			<ul class="navigation__list">
				<li class="navigation__item"><label for="cml_booking" class="item__icon"><span class="icon__emoji"><img
								src="/doggybeta/resources/images/dog.png"></span></label><span
						class="item__text">예약/결제내역</span></li>
				<li class="navigation__item"><label for="cml_host" class="item__icon"><span class="icon__emoji"><img
								src="/doggybeta/resources/images/dog2.png"></span></label><span class="item__text">
						호스트 서비스</span></li>
				<li class="navigation__item"><label for="cml_addpet" class="item__icon"><span class="icon__emoji"><img
								src="/doggybeta/resources/images/dog3.png"></span></label><span class="item__text">펫
						등록/수정</span></li>
			</ul><span class="icon__emoji">
		</div>
		<div class="section2">section2 - 페이지 내용 헤더</div>
		<div class="section3">section3 - 알람 정보</div>
		<!-- section4 - 예약/결제내역/내정보 수정 등의 메인 섹션 -->
		<div class="section4">
			<table id="reserv_table">
				<thead>
					<tr>
						<th>예약번호</th>
						<th>서비스 종류</th>
						<th>강아지 이름</th>
						<th>주소</th>
						<th>가격</th>
						<th>펫시터</th>
						<th>이용날짜</th>
						<th>진행상황</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			<div class="host_main">
				<div class="host_table">
					<table>
						<thead>
							<tr>
								<th>예약번호</th>
								<th>서비스 종류</th>
								<th>이름</th>
								<th>요구사항/특징</th>
								<th>이용날짜</th>
								<th>총 가격</th>
								<th>진행 상황</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<div class="host_side1">
					<div class="host_map" id="host_map"></div>
					<p id="addr_text"></p>
				</div>
				<div class="host_side2">
					<%if(loginUser.getPetSitter().equals("1")){ // 승인 대기중인 회원 페이지 %>
					<span>
						<p><%= loginUser.getUserName()%>님의 승인 신청이 완료되었습니다.</p>
						<p>현재 승인 대기 상태이며, 24시간 이내에 승인여부를 확인하실 수 있습니다.</p>
					</span>
					<%} else if (loginUser.getPetSitter().equals("2")){ // 호스트인 회원 페이지 %>
					<span>
						<p><%= loginUser.getUserName() %> 호스트님 환영합니다.</p>
						<p>귀여운 강아지들이 <%= loginUser.getUserName() %>님을 기다리고 있습니다!</p>
					</span>
					<%} else { // 일반 회원 페이지%>
					<span>
						<p><%=loginUser.getUserName()%>님 안녕하세요</p>
						<p>호스트 신청을하여 귀여운 강아지들을 만나보세요!</p>
						<button>펫시터 신청</button>
					</span>
					<%} %>
				</div>
			</div>
			<div id="add_pet">
				<div class="pet_insert">
					<form id="pet_reg_form">
						<ul id="progressbar">
							<li class="active">Account Setup</li>
							<li>Add Profiles</li>
							<li>Details</li>
						</ul>
						<fieldset>
							<h2 class="pi-title">Account Setup</h2>
							<h3 class="pi-subtitle">아이디 / 이름 / 견종 / 생년월일</h3>
							<input name="userid" value="<%= loginUser.getUserId()%>" readonly>
							<input name="pname" placeholder="강아지 이름" required>
							<input name="breeds" placeholder="견종 입력" />
							<input type="date" name="birth" id="puppybirth">
							<input type="button" name="next" class="next action-button" value="Next" />
						</fieldset>
						<fieldset>
							<h2 class="pi-title">Add Profiles</h2>
							<h3 class="pi-subtitle">강아지 프로필 사진 등록</h3>
							<img id="pet-img-preview" />
							<input type="file" name="petpic" id="petpic" hidden="hidden">
							<button id="petpic-btn">Add a profile</button>
							<hr>
							<input type="button" name="previous" class="previous action-button" value="Previous" />
							<input type="button" name="next" class="next action-button" value="Next" />
						</fieldset>
						<fieldset>
							<h2 class="pi-title">Details</h2>
							<h3 class="pi-subtitle">크기 / 성별 / 중성화여부 / 특이사항</h3>
							<input type="radio" name="size" id="cml_small" value="소형" checked>
							<input type="radio" name="size" id="cml_medium" value="중형" >
							<input type="radio" name="size" id="cml_big" value="대형" >
							<div class="radio-box">
								<label for="cml_small"><div class="btn-radio size">소형</div></label>
								<label for="cml_medium"><div class="btn-radio size">중형</div></label>
								<label for="cml_big"><div class="btn-radio size">대형</div></label>
							</div><hr>
							<input type="radio" name="gender" id="cml_male" value="M" checked>
							<input type="radio" name="gender" id="cml_female" value="F" >
							<input type="radio" name="gender" id="cml_neutral" value="N" >
							<div class="radio-box">
								<label for="cml_male"><div class="btn-radio gender">수컷</div></label>
								<label for="cml_female"><div class="btn-radio gender">암컷</div></label>
								<label for="cml_neutral"><div class="btn-radio gender">중성화</div></label>
							</div><hr>
							<textarea name="etc" id="p_etc" cols="30" rows="10" placeholder="강아지의 특이사항을 입력해주세요"></textarea>
							<input type="button" name="previous" class="previous action-button" value="Previous" />
							<input type="submit" id="p-submit" class="submit action-button" value="Submit" />
						</fieldset>
					</form>
				</div>
				<div class="pet_list"></div>
				<div class="pet_update"></div>
			</div>
		</div>
		<div class="section5">
			<div class="pagination"></div>
		</div>
	</div>
	<div id="footer"><%@ include file="..//common/footer.jsp"%></div>
	<script src="/doggybeta/resources/js/checkMyLog.js"></script>
	<script src="/doggybeta/resources/js/hmap.js"></script>
</body>

</html>