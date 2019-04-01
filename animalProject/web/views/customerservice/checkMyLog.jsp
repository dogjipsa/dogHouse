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
	<div class="wrap_content modal">
		<!-- section1 - 변경 버튼's -->
		<div class="section1">
			<input type="hidden" name="userid" value="<%=loginUser.getUserId() %>">
			<input type="hidden" name="username" value="<%= loginUser.getUserName()%>">
			<input type="hidden" name="phone" value="<%= loginUser.getPhone()%>">
			<input type="hidden" name="addr" value="<%= loginUser.getAddress()%>">
			<input type="hidden" name="email" value="<%= loginUser.getEmail()%>">
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
						등록 / 수정</span></li>
			</ul><span class="icon__emoji">
		</div>
		<div class="section2"></div>
		<div class="section3"></div>
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
						<th>리뷰</th>
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
					<div class="showbox">
						<img id="showbox_img">
						<div class="showbox_info">						
							<p>PET NAME</p>
							<input type="text" name="pname" readonly>
							<p>AGE</p>
							<input type="text" name="age" readonly>
							<p>PHONE</p>
							<input type="text" name="phone" readonly>
							<p>BREEDS</p>
							<input type="text" name="breeds" readonly>
						</div>
					</div>
				</div>
			</div>
			<div id="add_pet">
				<div class="pet_insert">
					<form id="pet_reg_form">
						<ul id="progressbar">
							<li class="active">Pet Setup</li>
							<li>Add Profiles</li>
							<li>Details</li>
						</ul>
						<fieldset>
							<h2 class="pi-title">Pet Setup</h2>
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
							<input type="radio" name="size" id="cml_medium" value="중형">
							<input type="radio" name="size" id="cml_big" value="대형">
							<div class="radio-box">
								<label for="cml_small">
									<div class="btn-radio size">소형</div>
								</label>
								<label for="cml_medium">
									<div class="btn-radio size">중형</div>
								</label>
								<label for="cml_big">
									<div class="btn-radio size">대형</div>
								</label>
							</div>
							<hr>
							<input type="radio" name="gender" id="cml_male" value="M" checked>
							<input type="radio" name="gender" id="cml_female" value="F">
							<input type="radio" name="gender" id="cml_neutral" value="N">
							<div class="radio-box">
								<label for="cml_male">
									<div class="btn-radio gender">수컷</div>
								</label>
								<label for="cml_female">
									<div class="btn-radio gender">암컷</div>
								</label>
								<label for="cml_neutral">
									<div class="btn-radio gender">중성화</div>
								</label>
							</div>
							<hr>
							<textarea name="etc" id="p_etc" cols="30" rows="10"
								placeholder="강아지의 특이사항을 입력해주세요"></textarea>
							<input type="button" name="previous" class="previous action-button" value="Previous" />
							<input type="submit" id="p-submit" class="submit action-button" value="Submit" />
						</fieldset>
					</form>
				</div>
				<div class="pet_list">
				</div>
				<div class="pet_list_pagination"></div>
				<div class="pet_update">
					<form id="pet_up_form">
						<input type="hidden" name="pno">
						<input type="hidden" name="userid">
						<input type="hidden" name="origin">
						<p>Name</p>
						<input type="text" name="pname">
						<span class="flex__box fbox1">
							<div>
								<p>Breeds</p>
								<input type="text" name="breeds">
							</div>
							<div>
								<p>Birth</p>
								<input type="date" name="birth">
							</div>
						</span>

						<span class="flex__box radio-toolbar">
							<div>
								<p>Gender</p>
								<section>
									<input type="radio" name="gender" id="cml_he" value="M">
									<label for="cml_he">He</label>
									<input type="radio" name="gender" id="cml_she" value="F">
									<label for="cml_she">She</label>
									<input type="radio" name="gender" id="cml_neut" value="N">
									<label for="cml_neut">Neutral</label>
								</section>
							</div>
							<div>
								<p>Size</p>
								<section>
									<input type="radio" name="size" id="cml_s" value="소형">
									<label for="cml_s">Small</label>
									<input type="radio" name="size" id="cml_m" value="중형">
									<label for="cml_m">Medium</label>
									<input type="radio" name="size" id="cml_b" value="대형">
									<label for="cml_b">Huge</label>
								</section>
							</div>
						</span>
						<p>Character</p>
						<textarea name="etc" cols="18" rows="4"></textarea>
						<p>Profile</p>
						<img src="" alt="" class="pet__img__update">
						<input type="file" name="ppic" id="up_ppic">
						<div class="updel__btns">
							<button id="pet_up__btn">수정하기</button>
							<button id="pet_del__btn">삭제하기</button>
						</div>
					</form>

				</div>
			</div>
		</div>
		<div class="section5">
			<div class="pagination"></div>
		</div>
		<div class="modal-content animate">
			<span class="m-close xBtn" title="Close Modal">&times;</span>
			<div class="modal-container">
				<img src="/doggybeta/resources/images/modal.gif" id="modal-img">
				<h4 id="modal-text"></h4>
				<button type="button" class="m-close cancelbtn">확인</button>
			</div>
		</div>
	</div>
	<script src="/doggybeta/resources/js/checkMyLog.js"></script>
	<script src="/doggybeta/resources/js/hmap.js"></script>
	<script src="https://cdn.bootpay.co.kr/js/bootpay-3.0.0.min.js" type="application/javascript"></script>
	<script src="/doggybeta/resources/js/npay.js"></script>
</body>

</html>